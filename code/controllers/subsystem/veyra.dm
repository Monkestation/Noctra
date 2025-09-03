/datum/config_entry/string/verification_api_url
	name = "Veyra URL"
	config_entry_value = "http://localhost:3000"

/datum/config_entry/string/verification_username
	name = "Veyra User"
	config_entry_value = "admin"

/datum/config_entry/string/verification_password
	name = "Veyra Pass"
	config_entry_value = "admin123"

/datum/config_entry/number/verification_rate_limit
	name = "Rate Limit"
	config_entry_value = 1 SECONDS

/datum/config_entry/number/verification_bulk_size
	name = "Bulk Size"
	config_entry_value = 100

// Verification datum to store player verification data
/datum/verification_data
	var/discord_id
	var/ckey
	var/veyra_flags = NONE  // Bitflag field
	var/verification_method
	var/verified_by
	var/created_at
	var/updated_at

/datum/verification_data/New(discord_id, ckey, verified_flags, verification_method, verified_by, created_at, updated_at)
	src.discord_id = discord_id
	src.ckey = ckey
	src.verification_method = verification_method
	src.verified_by = verified_by
	src.created_at = created_at
	src.updated_at = updated_at

	// Convert verified_flags to bitflag
	parse_verified_flags(verified_flags)

/datum/verification_data/proc/parse_verified_flags(list/flags)
	veyra_flags = 0
	if(flags["byond_verified"])
		veyra_flags |= VERIFIED_BYOND
	if(flags["discord_verified"])
		veyra_flags |= VERIFIED_DISCORD
	if(flags["id_verified"])
		veyra_flags |= VERIFIED_ID
	if(flags["debug"])
		veyra_flags |= VERIFIED_DEBUG


/datum/verification_data/proc/has_verification(verification_type)
	return (veyra_flags & verification_type) ? TRUE : FALSE

/datum/verification_data/proc/is_verified()
	return veyra_flags ? TRUE : FALSE

SUBSYSTEM_DEF(verifications)
	name = "Veyra Cache"
	flags = SS_NO_FIRE | SS_NO_INIT
	init_order = INIT_ORDER_VERIFICATIONS

	// Authentication
	var/api_token = ""
	var/token_expires = 0
	var/authenticated = FALSE

	// Cache of verification data - keyed by discord_id
	var/list/verification_cache = list()
	// Secondary index by ckey for faster lookups
	var/list/ckey_to_discord = list()

	// Rate limiting
	var/last_request_time = 0

	// Bulk request queue
	var/list/pending_requests = list()
	var/bulk_request_timer = 0

/datum/controller/subsystem/verifications/Initialize(start_timeofday)
	authenticate()
	return ..()

/datum/controller/subsystem/verifications/proc/get_api_base_url()
	return CONFIG_GET(string/verification_api_url)

/datum/controller/subsystem/verifications/proc/get_rate_limit()
	return CONFIG_GET(number/verification_rate_limit)

/datum/controller/subsystem/verifications/proc/get_bulk_size()
	return CONFIG_GET(number/verification_bulk_size)

/datum/controller/subsystem/verifications/proc/authenticate()
	var/username = CONFIG_GET(string/verification_username)
	var/password = CONFIG_GET(string/verification_password)

	if(!username || !password)
		log_admin("Verification API: Missing username or password in config")
		return FALSE

	var/url = "[get_api_base_url()]/api/auth/login"
	var/list/headers = list("Content-Type" = "application/json")
	var/body = json_encode(list("username" = username, "password" = password))

	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_POST, url, body, headers)
	request.begin_async()

	UNTIL(request.is_complete())

	var/datum/http_response/response = request.into_response()

	if(response.status_code == 200)
		var/list/data = json_decode(response.body)
		if(data && data["token"])
			api_token = data["token"]
			authenticated = TRUE
			token_expires = world.time + (3600 * 10)
			log_admin("Verification API: Authentication successful")
			return TRUE

	log_admin("Verification API: Authentication failed - Status: [response.status_code]")
	authenticated = FALSE
	return FALSE

/datum/controller/subsystem/verifications/proc/ensure_authenticated()
	if(!authenticated || (world.time > token_expires - 5 MINUTES))
		return authenticate()
	return TRUE

/datum/controller/subsystem/verifications/proc/make_authenticated_request(method, endpoint, body = "", extra_headers = null)
	if(!ensure_authenticated())
		return null

	if(world.time - last_request_time < get_rate_limit())
		return null

	var/url = "[get_api_base_url()]/api/v1/verify[endpoint]"
	var/list/headers = list("Authorization" = "Bearer [api_token]")

	if(body)
		headers["Content-Type"] = "application/json"

	if(extra_headers)
		for(var/key in extra_headers)
			headers[key] = extra_headers[key]

	var/datum/http_request/request = new()
	request.prepare(method, url, body, headers)
	request.begin_async()

	UNTIL(request.is_complete())

	last_request_time = world.time
	return request.into_response()

/datum/controller/subsystem/verifications/proc/bulk_fetch_verifications(list/identifiers, by_ckey = FALSE)
	if(!length(identifiers))
		return list()

	var/list/results = list()
	var/bulk_size = get_bulk_size()

	for(var/i = 1; i <= length(identifiers); i += bulk_size)
		var/end_index = min(i + bulk_size - 1, length(identifiers))
		var/list/chunk = identifiers.Copy(i, end_index + 1)

		var/list/chunk_results = fetch_verification_chunk(chunk, by_ckey)
		if(chunk_results)
			results += chunk_results
		if(i + bulk_size <= length(identifiers))
			sleep(0.5 SECONDS)

	return results

/datum/controller/subsystem/verifications/proc/fetch_verification_chunk(list/identifiers, by_ckey = FALSE)
	if(by_ckey)
		var/list/results = list()
		for(var/ckey in identifiers)
			var/result = search_verification_by_ckey(ckey)
			if(result)
				results[ckey] = result
			sleep(0.1 SECONDS)
		return results
	else
		var/list/results = list()
		for(var/discord_id in identifiers)
			var/result = get_verification_by_discord_id_direct(discord_id)
			if(result)
				results[discord_id] = result
			sleep(1)
		return results

/datum/controller/subsystem/verifications/proc/get_verification_by_discord_id_direct(discord_id)
	var/datum/http_response/response = make_authenticated_request(RUSTG_HTTP_METHOD_GET, "/[discord_id]")

	if(!response)
		return null

	if(response.status_code == 200)
		var/list/data = json_decode(response.body)
		if(data)
			var/datum/verification_data/verification = new(
				data["discord_id"],
				data["ckey"],
				data["verified_flags"],
				data["verification_method"],
				data["verified_by"],
				data["created_at"],
				data["updated_at"]
			)

			verification_cache[discord_id] = verification
			ckey_to_discord[verification.ckey] = discord_id

			return verification
	else if(response.status_code == 404)
		verification_cache[discord_id] = null
		return null

	return null

/datum/controller/subsystem/verifications/proc/get_verification_by_discord_id(discord_id, force_refresh = FALSE)
	if(!force_refresh && verification_cache[discord_id])
		var/datum/verification_data/cached = verification_cache[discord_id]
		if(cached)
			return cached
		else if(!cached)
			return null

	return get_verification_by_discord_id_direct(discord_id)

/datum/controller/subsystem/verifications/proc/get_verification_by_ckey(ckey, force_refresh = FALSE)
	var/discord_id = ckey_to_discord[ckey]
	if(discord_id && !force_refresh)
		var/datum/verification_data/cached = verification_cache[discord_id]
		if(cached)
			return cached
	return get_verification_by_ckey_direct(ckey)

/datum/controller/subsystem/verifications/proc/get_verification_by_ckey_direct(ckey)
	var/datum/http_response/response = make_authenticated_request(RUSTG_HTTP_METHOD_GET, "/ckey/[ckey]")

	if(!response)
		return null

	if(response.status_code == 200)
		var/list/data = json_decode(response.body)
		if(data)
			var/datum/verification_data/verification = new(
				data["discord_id"],
				data["ckey"],
				data["verified_flags"],
				data["verification_method"],
				data["verified_by"],
				data["created_at"],
				data["updated_at"]
			)

			verification_cache[data["discord_id"]] = verification
			ckey_to_discord[data["ckey"]] = data["discord_id"]

			return verification
	else if(response.status_code == 404)
		return null

	return null

/datum/controller/subsystem/verifications/proc/search_verification_by_ckey(ckey)
	var/datum/http_response/response = make_authenticated_request(RUSTG_HTTP_METHOD_GET, "?search=[ckey]&limit=1")

	if(!response)
		return null

	if(response.status_code == 200)
		var/list/data = json_decode(response.body)
		if(data && data["verifications"] && length(data["verifications"]))
			var/list/verification_data = data["verifications"][1]
			if(verification_data["ckey"] == ckey)  // Ensure exact match
				var/datum/verification_data/verification = new(
					verification_data["discord_id"],
					verification_data["ckey"],
					verification_data["verified_flags"],
					verification_data["verification_method"],
					verification_data["verified_by"],
					verification_data["created_at"],
					verification_data["updated_at"]
				)

				verification_cache[verification_data["discord_id"]] = verification
				ckey_to_discord[ckey] = verification_data["discord_id"]

				return verification

	return null

/datum/controller/subsystem/verifications/proc/bulk_verify_ckeys(list/ckeys)
	var/list/results = list()
	var/list/uncached = list()

	for(var/ckey in ckeys)
		var/discord_id = ckey_to_discord[ckey]
		if(discord_id && verification_cache[discord_id])
			var/datum/verification_data/cached = verification_cache[discord_id]
			if(cached)
				results[ckey] = cached
			else
				uncached += ckey
		else
			uncached += ckey

	if(length(uncached))
		var/list/fetched = bulk_fetch_verifications(uncached, TRUE)
		for(var/ckey in fetched)
			results[ckey] = fetched[ckey]

	return results

/datum/controller/subsystem/verifications/proc/is_discord_id_verified(discord_id, verification_type = 0)
	var/datum/verification_data/verification = get_verification_by_discord_id(discord_id)
	if(!verification)
		return FALSE

	if(verification_type)
		return verification.has_verification(verification_type)
	else
		return verification.is_verified()

/datum/controller/subsystem/verifications/proc/is_ckey_verified(ckey, verification_type = 0)
	var/datum/verification_data/verification = get_verification_by_ckey(ckey)
	if(!verification)
		return FALSE

	if(verification_type)
		return verification.has_verification(verification_type)
	else
		return verification.is_verified()

/datum/controller/subsystem/verifications/proc/clear_cache(discord_id)
	var/datum/verification_data/verification = verification_cache[discord_id]
	if(verification)
		ckey_to_discord.Remove(verification.ckey)
	verification_cache.Remove(discord_id)

/datum/controller/subsystem/verifications/proc/clear_all_cache()
	verification_cache.Cut()
	ckey_to_discord.Cut()
