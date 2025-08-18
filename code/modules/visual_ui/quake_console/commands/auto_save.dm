/datum/console_command/auto_save
	command_key = "auto_save"
	required_args = 0

/datum/console_command/auto_save/help_information(obj/abstract/visual_ui_element/scrollable/console_output/output)
	output.add_line("auto_save {interval} - Sets up automatic world saving.")
	output.add_line("  interval: Time in minutes between saves (default: 30, min: 5, max: 180)")
	output.add_line("  Use 'auto_save stop' to disable auto-saving")
	output.add_line("  Use 'auto_save status' to check current auto-save status")

/datum/console_command/auto_save/execute(obj/abstract/visual_ui_element/scrollable/console_output/output, list/arg_list)
	. = ..()
	var/mob/current = output.parent.get_user()
	if(!current)
		output.add_line("Error: Unable to determine current user.")
		return

	// Handle status check
	if(length(arg_list) >= 1 && arg_list[1] == "status")
		if(GLOB.auto_save_timer)
			var/time_left = (GLOB.auto_save_next_time - world.time) / 10 // Convert to seconds
			output.add_line("Auto-save is ENABLED")
			output.add_line("Interval: [GLOB.auto_save_interval] minutes")
			output.add_line("Next save in: [round(time_left/60)] minutes ([round(time_left)] seconds)")
		else
			output.add_line("Auto-save is DISABLED")
		return

	// Handle stopping auto-save
	if(length(arg_list) >= 1 && arg_list[1] == "stop")
		if(GLOB.auto_save_timer)
			deltimer(GLOB.auto_save_timer)
			GLOB.auto_save_timer = null
			GLOB.auto_save_interval = 0
			output.add_line("Auto-save has been DISABLED")
			log_admin("Auto-Save: [key_name(current)] disabled auto-save")
		else
			output.add_line("Auto-save is already disabled")
		return

	// Parse interval argument
	var/interval = 30 // Default 30 minutes
	if(length(arg_list) >= 1)
		interval = text2num(arg_list[1])
		if(!interval)
			output.add_line("Error: Invalid interval specified. Must be a number.")
			return

	// Validate interval bounds
	if(interval < 5)
		output.add_line("Error: Minimum interval is 5 minutes.")
		return
	if(interval > 180)
		output.add_line("Error: Maximum interval is 180 minutes (3 hours).")
		return

	// Stop existing timer if running
	if(GLOB.auto_save_timer)
		deltimer(GLOB.auto_save_timer)
		output.add_line("Stopped existing auto-save timer")

	// Set up new auto-save
	GLOB.auto_save_interval = interval
	var/timer_interval = interval * 60 * 10 // Convert minutes to deciseconds
	GLOB.auto_save_next_time = world.time + timer_interval
	GLOB.auto_save_timer = addtimer(CALLBACK(src, PROC_REF(perform_auto_save), current.z), timer_interval, TIMER_STOPPABLE | TIMER_LOOP)

	output.add_line("Auto-save ENABLED")
	output.add_line("Interval: [interval] minutes")
	output.add_line("First save will occur in [interval] minutes")
	output.add_line("Use 'auto_save stop' to disable")

	log_admin("Auto-Save: [key_name(current)] enabled auto-save with [interval] minute interval")

/datum/console_command/auto_save/proc/perform_auto_save(mob_z)
	// Update next save time
	GLOB.auto_save_next_time = world.time + (GLOB.auto_save_interval * 60 * 10)

	// Find the bottom and top of the Z-level stack
	var/bottom_z = find_bottom_z_level(mob_z)
	var/top_z = find_top_z_level(mob_z)
	var/start_x = 1
	var/start_y = 1
	var/end_x = world.maxx
	var/end_y = world.maxy
	var/map_name = SSmapping.config?.map_name || "unknown_map"
	var/save_dir = "data/saves/[map_name]/"
	var/round_id = GLOB.rogue_round_id || "unknown_round"
	var/timestamp = time2text(world.realtime, "YYYY-MM-DD_hh-mm-ss")
	var/file_name = "[round_id]_auto_[timestamp].dmm"
	var/full_path = "[save_dir][file_name]"

	// Create directory if it doesn't exist
	if(!fexists(save_dir))
		log_admin("Auto-Save: Creating save directory: [save_dir]")

	// Generate and save map data
	var/map_text = write_map(start_x, start_y, bottom_z, end_x, end_y, top_z)
	if(!map_text)
		log_admin("Auto-Save: Failed to generate map data")
		// Broadcast failure to all admins
		for(var/client/C in GLOB.admins)
			to_chat(C, "<span class='boldannounce'>AUTO-SAVE FAILED: Could not generate map data</span>")
		return

	var/file_handle = file(full_path)
	file_handle << map_text

	// Log success and notify admins
	log_admin("Auto-Save: Successfully saved world as '[file_name]' (Z[bottom_z] to Z[top_z], [length(map_text)] characters)")
	message_admins("<span class='boldnotice'>AUTO-SAVE: World saved as '[file_name]'</span>")

/datum/console_command/auto_save/proc/find_bottom_z_level(start_z)
	var/current_z = start_z
	while(current_z > 1)
		// Check if this Z level has a down connection
		if(!SSmapping.multiz_levels[current_z] || !SSmapping.multiz_levels[current_z][Z_LEVEL_DOWN])
			break
		current_z--
		if(current_z < 1)
			break
	return current_z

/datum/console_command/auto_save/proc/find_top_z_level(start_z)
	var/current_z = start_z
	while(current_z < world.maxz)
		// Check if this Z level has an up connection
		if(!SSmapping.multiz_levels[current_z] || !SSmapping.multiz_levels[current_z][Z_LEVEL_UP])
			break
		current_z++
		if(current_z > world.maxz)
			break
	return current_z

GLOBAL_VAR(auto_save_timer)
GLOBAL_VAR(auto_save_interval)
GLOBAL_VAR(auto_save_next_time)
