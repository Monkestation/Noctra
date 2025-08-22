/obj/effect/landmark/house_spot
	var/rent_cost = 1
	///this is the id we check inside of a players save data for them
	var/house_id = ""
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
