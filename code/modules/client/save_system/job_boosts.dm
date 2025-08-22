/datum/job_priority_boost
	var/name = "Job Priority Boost"
	var/desc = "Increases job assignment priority"
	var/boost_amount = 1 // How many "virtual" entries this creates in job selection
	var/list/applicable_jobs = list() // Specific jobs this boost applies to. Empty = all jobs
	var/expiry_time = 0 // World time when this boost expires. 0 = never expires
	var/uses_remaining = -1 // Number of times this can be used. -1 = infinite
	var/boost_type = BOOST_TYPE_GENERAL // Type of boost for categorization


/datum/job_priority_boost/timed
	name = "Temporary Job Boost"
	desc = "Job boost that expires after a set time"
	boost_amount = 3

/datum/job_priority_boost/timed/New(duration_hours = 24)
	..()
	expiry_time = world.time + (duration_hours * 36000) // SS13 time conversion

/datum/job_priority_boost/minor
	name = "Minor Job Boost"
	desc = "Slightly increases job priority"
	boost_amount = 2

/datum/job_priority_boost/major
	name = "Major Job Boost"
	desc = "Significantly increases job priority"
	boost_amount = 5

/datum/job_priority_boost/premium
	name = "Premium Job Boost"
	desc = "Greatly increases job priority"
	boost_amount = 10

/datum/job_priority_boost/limited_use
	name = "Limited Job Boost"
	desc = "Job boost with limited uses"
	boost_amount = 5
	uses_remaining = 3

/datum/job_priority_boost/proc/is_valid()
	if(expiry_time > 0 && world.time > expiry_time)
		return FALSE
	if(uses_remaining == 0)
		return FALSE
	return TRUE

/datum/job_priority_boost/proc/can_boost_job(datum/job/job)
	if(!is_valid())
		return FALSE
	if(length(applicable_jobs) && !(job.title in applicable_jobs))
		return FALSE
	return TRUE

/datum/job_priority_boost/proc/use_boost()
	if(uses_remaining > 0)
		uses_remaining--
		// Trigger save when boost is used
		spawn(1)
			var/client/C = get_boost_owner()
			if(C)
				SSjob.save_player_boosts(C.ckey)

/datum/job_priority_boost/proc/get_boost_owner()
	for(var/ckey in GLOB.directory)
		var/client/C = GLOB.directory[ckey]
		if(C && islist(C.job_priority_boosts) && (src in C.job_priority_boosts))
			return C
	return null

/client/proc/cmd_view_job_boosts(target_ckey as text)
	set category = "Debug"
	set name = "View Job Boosts"
	set desc = "View a player's active job boosts"

	if(!check_rights(R_DEBUG))
		return

	if(!target_ckey)
		target_ckey = input("Enter target ckey:", "View Boosts") as text|null
		if(!target_ckey)
			return

	target_ckey = ckey(target_ckey)
	var/client/target_client = GLOB.directory[target_ckey]

	if(!target_client)
		to_chat(src, "<span class='warning'>Client '[target_ckey]' not found.</span>")
		return

	if(!islist(target_client.job_priority_boosts) || !length(target_client.job_priority_boosts))
		to_chat(src, "<span class='notice'>[target_ckey] has no active job boosts.</span>")
		return

	to_chat(src, "<span class='notice'>Job Boosts for [target_ckey]:</span>")
	for(var/datum/job_priority_boost/boost in target_client.job_priority_boosts)
		var/validity = boost.is_valid() ? "VALID" : "EXPIRED"
		var/expiry_info = boost.expiry_time > 0 ? " (expires: [boost.expiry_time])" : ""
		var/uses_info = boost.uses_remaining >= 0 ? " (uses left: [boost.uses_remaining])" : " (unlimited uses)"
		to_chat(src, "<span class='notice'>- [boost.name]: Amount [boost.boost_amount][expiry_info][uses_info] - [validity]</span>")

/client/proc/cmd_give_job_boost()
	set category = "Debug"
	set name = "Give Job Boost"
	set desc = "Give a job priority boost to a player"

	var/target_ckey
	var/boost_type
	var/boost_amount
	if(!check_rights(R_DEBUG))
		return

	if(!target_ckey)
		target_ckey = input("Enter target ckey:", "Job Boost") as text|null
		if(!target_ckey)
			return

	target_ckey = ckey(target_ckey)
	var/client/target_client = GLOB.directory[target_ckey]

	if(!target_client)
		to_chat(src, "<span class='warning'>Client '[target_ckey]' not found.</span>")
		return

	if(!boost_type)
		boost_type = input("Select boost type:", "Job Boost", "general") in list("general", "minor", "major", "premium", "timed", "limited")

	var/datum/job_priority_boost/boost

	switch(boost_type)
		if("general")
			boost = new /datum/job_priority_boost()
		if("minor")
			boost = new /datum/job_priority_boost/minor()
		if("major")
			boost = new /datum/job_priority_boost/major()
		if("premium")
			boost = new /datum/job_priority_boost/premium()
		if("timed")
			var/hours = input("Hours until expiry:", "Job Boost", 24) as num|null
			if(!hours)
				return
			boost = new /datum/job_priority_boost/timed(hours)
		if("limited")
			boost = new /datum/job_priority_boost/limited_use()
			var/uses = input("How many uses?:", "Job Boost", 1) as num|null
			if(uses)
				boost.uses_remaining = uses
		else
			to_chat(src, "<span class='warning'>Invalid boost type.</span>")
			return

	if(!boost)
		to_chat(src, "<span class='warning'>Failed to create boost.</span>")
		return

	// Allow customization of boost amount
	if(!boost_amount)
		boost_amount = input("Enter a boost amount") as num|null
	if(boost_amount != 0)
		boost.boost_amount = boost_amount

	if(SSjob.give_job_boost(target_client, boost))
		to_chat(src, "<span class='notice'>Successfully gave '[boost.name]' to '[target_ckey]'.</span>")
		log_admin("[key_name(src)] gave job boost '[boost.name]' (amount: [boost.boost_amount], uses: [boost.uses_remaining]) to [key_name(target_client)]")
	else
		to_chat(src, "<span class='warning'>Failed to give boost to '[target_ckey]'.</span>")
		qdel(boost)

/proc/give_player_job_boost(ckey, boost_type_path, boost_amount = 0, uses = -1, expiry_hours = 0, applicable_jobs = null)
	var/client/target_client = GLOB.directory[ckey(ckey)]
	if(!target_client)
		return FALSE

	var/datum/job_priority_boost/boost = new boost_type_path()
	if(!boost)
		return FALSE

	if(boost_amount > 0)
		boost.boost_amount = boost_amount
	if(uses >= 0)
		boost.uses_remaining = uses
	if(expiry_hours > 0)
		boost.expiry_time = world.time + (expiry_hours * 36000)
	if(applicable_jobs)
		boost.applicable_jobs = applicable_jobs

	return SSjob.give_job_boost(target_client, boost)
