/datum/console_command/save_world
	command_key = "save_world"
	required_args = 0

/datum/console_command/save_world/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("save_world - Will force the world to save and store it in the servers save directory.")

/datum/console_command/save_world/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	. = ..()
	var/mob/current = output.parent.get_user()

	if(!current)
		output.add_line("Error: Unable to determine current user.")
		return

	var/mob_z = current.z
	if(!mob_z)
		output.add_line("Error: Unable to determine current Z level.")
		return

	// Find the bottom and top of the Z-level stack
	var/bottom_z = find_bottom_z_level(mob_z)
	var/top_z = find_top_z_level(mob_z)

	var/start_x = 1
	var/start_y = 1
	var/end_x = world.maxx
	var/end_y = world.maxy

	var/map_name = SSmapping.config?.map_name || "unknown_map"
	var/save_dir = "data/saves/[map_name]"
	var/round_id = GLOB.rogue_round_id || "unknown_round"
	var/file_name = "[round_id].dmm"
	var/full_path = "[save_dir][file_name]"

	output.add_line("Initiating world save...")
	output.add_line("Map: [map_name]")
	output.add_line("Round ID: [round_id]")
	output.add_line("Z-Level Range: [bottom_z] to [top_z]")
	output.add_line("Coordinates: ([start_x],[start_y]) to ([end_x],[end_y])")
	output.add_line("WARNING: This operation may cause significant lag!")

	if(!fexists(save_dir))
		output.add_line("Creating save directory: [save_dir]")

	var/map_text = write_map(start_x, start_y, bottom_z, end_x, end_y, top_z)

	if(!map_text)
		output.add_line("Error: Failed to generate map data.")
		return

	var/file_handle = file(full_path)
	file_handle << map_text

	output.add_line("World save completed successfully!")
	output.add_line("Saved to: [full_path]")
	output.add_line("File size: [length(map_text)] characters")

	log_admin("World Save: [key_name(current)] saved the world from Z[bottom_z] to Z[top_z] as '[file_name]'")

/datum/console_command/save_world/proc/find_bottom_z_level(start_z)
	var/current_z = start_z

	while(current_z > 1)
		// Check if this Z level has a down connection
		if(!SSmapping.multiz_levels[current_z] || !SSmapping.multiz_levels[current_z][Z_LEVEL_DOWN])
			break
		current_z--
		if(current_z < 1)
			break

	return current_z

/datum/console_command/save_world/proc/find_top_z_level(start_z)
	var/current_z = start_z

	while(current_z < world.maxz)
		// Check if this Z level has an up connection
		if(!SSmapping.multiz_levels[current_z] || !SSmapping.multiz_levels[current_z][Z_LEVEL_UP])
			break
		current_z++
		if(current_z > world.maxz)
			break

	return current_z
