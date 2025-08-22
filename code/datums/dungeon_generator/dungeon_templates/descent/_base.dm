
/datum/map_template/dungeon/descent
	name = "Dungeon Descent"
	abstract_type = /datum/map_template/dungeon/descent
	type_weight = 0

/datum/map_template/dungeon/descent/load(turf/T, centered)
	. = ..()
	if(!.)
		return FALSE

	// Find and configure any descent objects in the loaded template
	var/list/turfs = get_affected_turfs(T, centered)
	for(var/turf/turf in turfs)
		for(var/obj/structure/dungeon_descent/descent in turf.contents)
			var/delve_level = SSdungeon_generator.get_delve_level(turf.z)
			if(delve_level > 0)
				descent.current_delve_level = delve_level
				descent.target_delve_level = delve_level + 1

				// Register this descent
				if(!SSdungeon_generator.descent_objects["[delve_level]"])
					SSdungeon_generator.descent_objects["[delve_level]"] = list()
				SSdungeon_generator.descent_objects["[delve_level]"] += descent

			break // Only handle the first descent found
	return TRUE
