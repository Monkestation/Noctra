/obj/effect/landmark/house_spot
	var/rent_cost = 1
	///this is the id we check inside of a players save data for them
	var/house_id = ""
	var/link_id
	var/datum/map_template/default_template
	var/owner_ckey

	var/template_x
	var/template_y
	var/template_z

/obj/effect/landmark/house_spot/New(loc, ...)
	. = ..()
	SShousing.properties |= src

SUBSYSTEM_DEF(housing)
	name = "Housing"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_HOUSING

	var/list/properties = list() // List of all property landmarks
	var/list/property_owners = list()
	var/list/owned_properties = list()
	var/list/property_controllers = list()
	var/rent_collection_enabled = TRUE

/datum/controller/subsystem/housing/Initialize()
	populate_property_owners()
	return ..()

/datum/controller/subsystem/housing/proc/populate_property_owners()
	if(fexists("data/property_owners.json"))
		var/list/unlocated_properties = properties.Copy()
		var/list/owners = json_decode(file2text("data/property_owners.json"))
		for(var/owner as anything in owners)
			var/property_id = owners[owner]
			var/obj/effect/landmark/house_spot/spot
			for(var/obj/effect/landmark/house_spot/potential as anything in unlocated_properties)
				if(property_id != potential.house_id)
					continue
				spot = potential
				break
			if(!spot)
				continue
			var/datum/save_manager/SM = get_save_manager(owner)
			var/current_balance = SM.get_data("banking", "persistent_balance", 0)
			if(current_balance < spot.rent_cost)
				owners -= owner
				continue
			SM.set_data("banking", "persistent_balance", max(0, current_balance - spot.rent_cost))
			load_property_from_data(owner, get_turf(spot))
			unlocated_properties -= spot
			spot.owner_ckey = owner
			var/datum/property_controller/new_controller = new(spot)
			property_controllers |= new_controller
			owned_properties |= spot
		if(length(unlocated_properties))
			for(var/obj/effect/landmark/house_spot/property as anything in unlocated_properties)
				if(property.link_id)
					continue
				var/datum/map_template/template = new property.default_template
				template.load(get_turf(property))
				var/list/turfs = template.get_affected_turfs(get_turf(property))

				for(var/turf/turf as anything in turfs)
					for(var/obj/structure/sign/property_for_sale/sale in turf.contents)
						sale.linked_property = property
				var/datum/property_controller/new_controller = new(property)
				property_controllers |= new_controller


/datum/controller/subsystem/housing/proc/save_properties()
	for(var/obj/effect/landmark/house_spot/property as anything in owned_properties)
		save_property_to_data(property.owner_ckey, property)

/datum/controller/subsystem/housing/proc/save_property_to_data(ckey, obj/effect/landmark/house_spot/property)
	if(!property)
		return FALSE

	var/turf/start_turf = get_turf(property)
	if(!start_turf)
		return FALSE

	// Calculate the area to save based on the template dimensions
	var/minx = start_turf.x
	var/miny = start_turf.y
	var/minz = start_turf.z
	var/maxx = minx + property.template_x - 1
	var/maxy = miny + property.template_y - 1
	var/maxz = minz + property.template_z - 1

	// Generate the map data (save objects and turfs, but not mobs)
	var/save_flags = SAVE_OBJECTS | SAVE_TURFS | SAVE_AREAS | SAVE_OBJECT_PROPERTIES | SAVE_UUID_STASIS
	var/map_data = write_map(minx, miny, minz, maxx, maxy, maxz, save_flags, SAVE_SHUTTLEAREA_DONTCARE)

	if(!map_data)
		log_admin("Property Save: Failed to generate map data for [ckey]'s property [property.house_id]")
		return FALSE

	// Create the property file path
	var/property_file = "data/properties/[ckey]_[property.house_id].dmm"
	if(fexists(property_file))
		fdel(property_file)
	// Save using file handle method (same as auto save)
	var/file_handle = file(property_file)
	file_handle << map_data

	log_admin("Property Save: Successfully saved property [property.house_id] for [ckey] ([length(map_data)] characters)")
	return TRUE

/datum/controller/subsystem/housing/proc/load_property_from_data(ckey, turf/template_spot)
	var/obj/effect/landmark/house_spot/property

	// Find the property landmark at this location
	for(var/obj/effect/landmark/house_spot/spot as anything in properties)
		if(get_turf(spot) == template_spot)
			property = spot
			break

	if(!property)
		return FALSE

	// Check if we have saved property data
	var/property_file = "data/properties/[ckey]_[property.house_id].dmm"
	if(fexists(property_file))
		// Load from saved data
		var/datum/map_template/saved_template = new /datum/map_template(property_file, "[ckey]_[property.house_id]", TRUE)
		if(saved_template.cached_map)
			saved_template.load(template_spot)
			property_owners[ckey] = property.house_id
			return TRUE

	// Fallback to default template if no saved data exists
	if(property.default_template)
		var/datum/map_template/template = new property.default_template
		template.load(template_spot)
		var/list/turfs = template.get_affected_turfs(template_spot)

		for(var/turf/turf as anything in turfs)
			for(var/obj/structure/sign/property_for_sale/sale in turf.contents)
				sale.linked_property = property

		property_owners[ckey] = property.house_id
		return TRUE

	return FALSE

/datum/controller/subsystem/housing/proc/check_access(ckey)
	for(var/datum/property_controller/controller as anything in property_controllers)
		if(controller.check_access(ckey))
			return TRUE
	return FALSE

/datum/controller/subsystem/housing/proc/save_property_owners()
	var/json_data = json_encode(property_owners)
	rustg_file_write(json_data, "data/property_owners.json")

/obj/structure/sign/property_for_sale
	name = "Property For Sale"
	desc = "Click to purchase this property. Rent will be automatically deducted from your bank account."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "questnoti" // Adjust icon state as needed

	var/sold = FALSE
	var/obj/effect/landmark/house_spot/linked_property

/obj/structure/sign/property_for_sale/attack_hand(mob/user)
	. = ..()
	if(!user.client)
		return

	if(sold)
		to_chat(user, "<span class='warning'>This property has already been sold!</span>")
		return

	if(!linked_property)
		to_chat(user, "<span class='warning'>No property found linked to this sign!</span>")
		return

	// Check if user already owns this property
	if(SShousing.property_owners[user.ckey] == linked_property.house_id)
		to_chat(user, "<span class='notice'>You already own this property!</span>")
		return

	// Check if someone else owns this property
	for(var/owner_ckey in SShousing.property_owners)
		if(SShousing.property_owners[owner_ckey] == linked_property.house_id)
			to_chat(user, "<span class='warning'>This property is already owned by someone else!</span>")
			return

	var/datum/save_manager/SM = get_save_manager(user.ckey)
	var/current_balance = SM.get_data("banking", "persistent_balance", 0)

	if(current_balance < linked_property.rent_cost)
		to_chat(user, "<span class='warning'>You don't have enough money! You need [linked_property.rent_cost] credits, but only have [current_balance].</span>")
		return

	var/confirm = alert(user, "Purchase this property for [linked_property.rent_cost] credits?\n\nRent will be automatically deducted each round.", "Property Purchase", "Yes", "No")
	if(confirm != "Yes")
		return

	// Double-check balance in case it changed
	current_balance = SM.get_data("banking", "persistent_balance", 0)
	if(current_balance < linked_property.rent_cost)
		to_chat(user, "<span class='warning'>Transaction failed - insufficient funds!</span>")
		return

	// Purchase the property
	SM.set_data("banking", "persistent_balance", current_balance - linked_property.rent_cost)
	SShousing.property_owners[user.ckey] = linked_property.house_id
	SShousing.owned_properties |= linked_property
	SShousing.save_property_owners()
	linked_property.owner_ckey = user.client.key

	to_chat(user, "<span class='notice'>Congratulations! You have successfully purchased this property for [linked_property.rent_cost] credits.</span>")

	// Remove the for sale sign
	sold = TRUE
	qdel(src)

/datum/map_template/basic_house
	name = "Roguetest House"
	mappath = "_maps/templates/delver/basic_house.dmm"
	width = 15
	height = 17

/datum/map_template/basic_nine
	name = "Basic 9x9 House"
	mappath = "_maps/templates/delver/9x9.dmm"
	width = 9
	height = 9

/datum/property_controller
	var/obj/effect/landmark/house_spot/linked_property
	var/list/allowed_list = list()
	var/property_bounds_minx
	var/property_bounds_miny
	var/property_bounds_maxx
	var/property_bounds_maxy
	var/property_bounds_z
	var/property_bounds_zmax

/datum/property_controller/New(obj/effect/landmark/house_spot/property)
	linked_property = property
	if(!property)
		return

	var/turf/start_turf = get_turf(property)
	if(!start_turf)
		return

	property_bounds_minx = start_turf.x
	property_bounds_miny = start_turf.y
	property_bounds_maxx = start_turf.x + property.template_x - 1
	property_bounds_maxy = start_turf.y + property.template_y - 1
	property_bounds_z = start_turf.z
	property_bounds_zmax = start_turf.z + property.template_z - 1

/datum/property_controller/proc/check_access(mob/user)
	if(!linked_property)
		return TRUE

	if(!user || !user.client)
		return FALSE

	// Owner always has access
	if(user.ckey == linked_property.owner_ckey)
		return TRUE

	// Check allow list
	if(user.ckey in allowed_list)
		return TRUE

	return FALSE

/datum/property_controller/proc/is_in_property_bounds(atom/A)
	if(!linked_property)
		return FALSE

	var/turf/T = get_turf(A)
	if(!T)
		return FALSE

	// Fallback to coordinate checking
	return (T.x >= property_bounds_minx && T.x <= property_bounds_maxx && T.y >= property_bounds_miny && T.y <= property_bounds_maxy && T.z >= property_bounds_z && T.z <= property_bounds_zmax)

/obj/structure/sign/property_claim
	name = "Property Claim"
	desc = "Click to claim this property. If you have a saved design, it will be loaded."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "questnoti"

	var/claimed = FALSE
	var/obj/effect/landmark/house_spot/linked_property
	var/claiming_ckey = null
	var/link_id

/obj/structure/sign/property_claim/Initialize()
	. = ..()
	for(var/obj/effect/landmark/house_spot/spot as anything in SShousing.properties)
		if(!spot.link_id)
			continue
		if(spot.link_id != link_id)
			continue
		linked_property = spot

/obj/structure/sign/property_claim/attack_hand(mob/user)
	. = ..()
	if(!user.client)
		return

	if(!linked_property)
		to_chat(user, "<span class='warning'>No property found linked to this sign!</span>")
		return

	if(claimed && claiming_ckey == user.ckey)
		save_claimed_property(user)
		return

	if(claimed && claiming_ckey != user.ckey)
		to_chat(user, "<span class='warning'>This property is already claimed by someone else this round!</span>")
		return

	if(check_for_other_mobs(user))
		to_chat(user, "<span class='warning'>You cannot claim this property while other people are present in the area!</span>")
		return

	var/confirm = alert(user, "Claim this property?", "Property Claim", "Yes", "No")
	if(confirm != "Yes")
		return

	if(check_for_other_mobs(user))
		to_chat(user, "<span class='warning'>Someone entered the area! Claiming cancelled.</span>")
		return

	claim_property(user)

/obj/structure/sign/property_claim/proc/check_for_other_mobs(mob/claiming_user)
	if(!linked_property)
		return FALSE

	var/turf/start_turf = get_turf(linked_property)
	if(!start_turf)
		return FALSE

	var/minx = start_turf.x
	var/miny = start_turf.y
	var/minz = start_turf.z
	var/maxx = minx + linked_property.template_x - 1
	var/maxy = miny + linked_property.template_y - 1
	var/maxz = minz + linked_property.template_z - 1

	for(var/turf/T in block(locate(minx, miny, minz), locate(maxx, maxy, maxz)))
		for(var/mob/M in T.contents)
			if(M == claiming_user)
				continue
			if(M.client)
				return TRUE
	return FALSE

/obj/structure/sign/property_claim/proc/claim_property(mob/user)
	claimed = TRUE
	claiming_ckey = user.ckey
	linked_property.owner_ckey = user.ckey


	var/property_file = "data/properties/[user.ckey]_[linked_property.house_id].dmm"
	if(fexists(property_file))
		clear_property_area()
		var/success = SShousing.load_property_from_data(user.ckey, get_turf(linked_property), TRUE)

		if(success)
			to_chat(user, "<span class='notice'>Loaded your saved design!</span>")
		else
			to_chat(user, "<span class='notice'>No saved design found - area claimed as-is.</span>")

	name = "Claimed Property"
	desc = "This property has been claimed by you. Click to save your current design."

	var/datum/property_controller/new_controller = new(linked_property)
	SShousing.property_controllers |= new_controller

/obj/structure/sign/property_claim/proc/save_claimed_property(mob/user)
	if(!linked_property || claiming_ckey != user.ckey)
		to_chat(user, "<span class='warning'>You cannot save this property!</span>")
		return

	var/confirm = alert(user, "Save the current state of your claimed property?", "Save Property", "Yes", "No")
	if(confirm != "Yes")
		return

	var/success = SShousing.save_property_to_data(user.ckey, linked_property)

	if(success)
		to_chat(user, "<span class='notice'>Property saved successfully!</span>")
	else
		to_chat(user, "<span class='warning'>Failed to save property!</span>")

/obj/structure/sign/property_claim/proc/clear_property_area()
	if(!linked_property)
		return

	var/turf/start_turf = get_turf(linked_property)
	if(!start_turf)
		return

	// Calculate property bounds
	var/minx = start_turf.x
	var/miny = start_turf.y
	var/minz = start_turf.z
	var/maxx = minx + linked_property.template_x - 1
	var/maxy = miny + linked_property.template_y - 1
	var/maxz = minz + linked_property.template_z - 1

	// Clear all objects and reset turfs in the property area
	for(var/turf/T in block(locate(minx, miny, minz), locate(maxx, maxy, maxz)))
		// Delete all objects on the turf
		for(var/obj/structure/O in T.contents)
			if(O == src) // Don't delete the sign itself
				continue
			if(O == linked_property)
				continue
			qdel(O)

		// Reset turf to basic floor or whatever default turf type
		T.ScrapeAway()
