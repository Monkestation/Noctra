/obj/structure/redstone/comparator
	name = "redstone comparator"
	desc = "Compares redstone signal strengths and outputs accordingly. Can also detect storage contents."
	icon_state = "comparator"
	var/direction = NORTH // Direction the comparator faces
	var/mode = "compare" // "compare" or "subtract"
	var/input_power = 0
	var/side_power_left = 0
	var/side_power_right = 0
	var/output_power = 0
	var/list/input_sources = list() // Track input sources separately
	can_connect_wires = TRUE
	send_wall_power = TRUE // Comparators can send power through walls

/obj/structure/redstone/comparator/Initialize()
	. = ..()
	// Set direction based on placement or default
	direction = dir
	update_directional_connections()
	update_icon()
	START_PROCESSING(SSobj, src)

/obj/structure/redstone/comparator/get_input_directions()
	return GLOB.cardinals - direction

// Add method to set direction during construction/placement
/obj/structure/redstone/comparator/proc/set_direction(new_dir)
	direction = new_dir
	update_directional_connections()
	update_icon()

/obj/structure/redstone/comparator/proc/update_directional_connections()
	// Comparators have three inputs (back, left, right) and one output (front)
	connected_components = list()

	// Connect to all adjacent components
	for(var/check_direction in GLOB.cardinals)
		var/turf/target_turf = get_step(src, check_direction)
		for(var/obj/structure/redstone/component in target_turf)
			if(component.can_connect_wires)
				connected_components += component

	// Check for storage containers behind us for signal generation
	check_storage_input()

/obj/structure/redstone/comparator/proc/check_storage_input()
	// Check behind the comparator for storage containers
	var/turf/back_turf = get_step(src, turn(direction, 180))
	var/storage_signal = get_storage_signal(back_turf)

	if(storage_signal != input_power)
		input_power = storage_signal
		calculate_output()

/obj/structure/redstone/comparator/proc/get_storage_signal(turf/T)
	if(!T)
		return 0

	// Check all objects on the turf for storage components
	for(var/obj/O in T)
		var/storage_signal = get_object_storage_signal(O)
		if(storage_signal > 0)
			return storage_signal

	return 0

/obj/structure/redstone/comparator/proc/get_object_storage_signal(obj/O)
	if(!O)
		return 0

	// Check for storage component first (modern system)
	var/datum/component/storage/storage_comp = O.GetComponent(/datum/component/storage)
	if(storage_comp)
		return calculate_component_storage_fullness(storage_comp, O)

/obj/structure/redstone/comparator/proc/calculate_component_storage_fullness(datum/component/storage/storage_comp, obj/O)
	if(!storage_comp)
		return 0

	var/total_capacity = 0
	var/max_capacity = 0

	max_capacity = storage_comp.screen_max_rows * storage_comp.screen_max_columns

	if(max_capacity <= 0)
		return 0

	for(var/obj/item/item as anything in O.contents)
		total_capacity += (item.grid_width / 32) * (item.grid_height / 32)
	var/fullness_ratio = total_capacity / max_capacity
	return round(fullness_ratio * 15)

/obj/structure/redstone/comparator/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	if(!source)
		return

	// Determine which input this is based on source position relative to our direction
	var/source_dir = get_dir(src, source)
	var/source_key = "[ref(source)]"

	// Track power sources for each input separately
	if(incoming_power > 0)
		input_sources[source_key] = list("power" = incoming_power, "direction" = source_dir)
	else
		input_sources -= source_key

	// Recalculate input powers based on our facing direction
	var/back_dir = turn(direction, 180)
	var/left_dir = turn(direction, -90)
	var/right_dir = turn(direction, 90)

	input_power = 0
	side_power_left = 0
	side_power_right = 0

	for(var/key in input_sources)
		var/list/source_data = input_sources[key]
		///lmao Byond doesn't support non constant switch statements
		if(source_data["direction"] == back_dir) // Main input (back)
			input_power = max(input_power, source_data["power"])
		if(source_data["direction"] ==left_dir) // Left side input
			side_power_left = max(side_power_left, source_data["power"])
		if(source_data["direction"] == right_dir) // Right side input
			side_power_right = max(side_power_right, source_data["power"])

	// Also check for storage input
	var/storage_signal = get_storage_signal(get_step(src, back_dir))
	input_power = max(input_power, storage_signal)

	calculate_output(user)

/obj/structure/redstone/comparator/proc/calculate_output(mob/user)
	var/new_output = 0
	var/max_side_power = max(side_power_left, side_power_right)

	if(mode == "compare")
		// Output signal if main input >= side input
		if(input_power >= max_side_power)
			new_output = input_power
	else // subtract mode
		// Output difference between main and side inputs
		new_output = max(0, input_power - max_side_power)

	if(new_output != output_power)
		output_power = new_output
		set_power(output_power, user, null) // Comparator acts as its own source

// Override get_power_directions to only send power forward
/obj/structure/redstone/comparator/get_power_directions()
	// Comparators only send power in their facing direction
	return list(direction)

/obj/structure/redstone/comparator/attack_hand(mob/user)
	mode = (mode == "compare") ? "subtract" : "compare"
	to_chat(user, "<span class='notice'>Comparator set to [mode] mode.</span>")
	update_icon()
	calculate_output(user)

/obj/structure/redstone/comparator/update_icon()
	. = ..()
	var/base_state = "comparator"

	if(mode == "subtract")
		base_state += "_subtract"

	icon_state = base_state
	dir = direction

	// Add power overlay if outputting
	cut_overlays()
	if(output_power > 0)
		var/mutable_appearance/power_overlay = mutable_appearance(icon, "comparator_on")
		overlays += power_overlay

// Method to handle rotation/direction setting during placement
/obj/structure/redstone/comparator/proc/rotate_comparator(new_direction)
	direction = new_direction
	update_directional_connections()
	update_icon()
	return TRUE

// Alt-click rotation functionality
/obj/structure/redstone/comparator/AltClick(mob/user)
	if(!Adjacent(user))
		return

	// Rotate the comparator
	direction = turn(direction, 90)
	update_directional_connections()
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(direction)].</span>")
	update_icon()

	// Recalculate since inputs/outputs changed
	calculate_output(user)

/obj/structure/redstone/comparator/proc/dir2text_readable(dir)
	switch(dir)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

// Enhanced examine to show more storage details
/obj/structure/redstone/comparator/examine(mob/user)
	. = ..()
	. += "It is facing [dir2text_readable(direction)] and in [mode] mode."
	. += "Main input: [input_power], Left side: [side_power_left], Right side: [side_power_right]"
	. += "Output: [output_power]"
	. += "Click to toggle mode, Alt-click to rotate."

	// Check for storage behind it with detailed info
	var/turf/back_turf = get_step(src, turn(direction, 180))
	if(back_turf)
		for(var/obj/O in back_turf)
			var/datum/component/storage/storage_comp = O.GetComponent(/datum/component/storage)
			if(storage_comp)
				var/storage_signal = get_object_storage_signal(O)
				var/total_capacity = 0
				for(var/obj/item/item as anything in O.contents)
					total_capacity += (item.grid_width / 32) * (item.grid_height / 32)
				var/max_capacity = 0

				max_capacity = storage_comp.screen_max_rows * storage_comp.screen_max_columns
				. += "Detecting [O.name]: [total_capacity]/[max_capacity] items (signal: [storage_signal])"
				break

/obj/structure/redstone/comparator/proc/get_storage_type_capacity(datum/component/storage/storage_comp)
	// Handle specific storage types
	if(istype(storage_comp, /datum/component/storage/concrete/grid/coin_pouch))
		return 4 // 4 rows × 1 column as mentioned in your example

	return storage_comp.screen_max_rows * storage_comp.screen_max_columns

// Process storage changes periodically
/obj/structure/redstone/comparator/process()
	check_storage_input()

/obj/structure/redstone/comparator/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()
