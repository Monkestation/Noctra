/obj/structure/redstone/repeater
	name = "redstone repeater"
	desc = "Amplifies and delays redstone signals. Right-click to adjust delay, alt-click to rotate."
	icon_state = "repeater"
	var/delay_ticks = 2 // Default delay (1-4 ticks)
	var/input_power = 0
	var/output_power = 0
	var/processing_signal = FALSE
	var/obj/structure/redstone/current_input_source
	var/facing_dir = NORTH // Direction the repeater is facing (output direction)
	can_connect_wires = TRUE
	send_wall_power = TRUE

/obj/structure/redstone/repeater/Initialize()
	. = ..()
	facing_dir = dir
	update_directional_connections()

/obj/structure/redstone/repeater/proc/update_directional_connections()
	wire_connections = list("2" = 0, "1" = 0, "8" = 0, "4" = 0)
	connected_components = list()

	var/input_dir = turn(facing_dir, 180) // Opposite of facing direction
	var/output_dir = facing_dir

	// Connect to input (back) and output (front)
	var/turf/input_turf = get_step(src, input_dir)
	var/turf/output_turf = get_step(src, output_dir)

	// Check input side
	for(var/obj/structure/redstone/component in input_turf)
		if(component.can_connect_wires && component.can_connect_to(src, turn(input_dir, 180)))
			wire_connections[dir2text(input_dir)] = 1
			connected_components += component

	// Check output side
	for(var/obj/structure/redstone/component in output_turf)
		if(component.can_connect_wires && component.can_connect_to(src, turn(output_dir, 180)))
			wire_connections[dir2text(output_dir)] = 1
			connected_components += component

	// Update icon to show direction
	update_icon()

/obj/structure/redstone/repeater/proc/dir2text(direction)
	switch(direction)
		if(NORTH) return "1"
		if(SOUTH) return "2"
		if(EAST) return "4"
		if(WEST) return "8"
		else return "1"

/obj/structure/redstone/repeater/proc/text2dir(text)
	switch(text)
		if("1") return NORTH
		if("2") return SOUTH
		if("4") return EAST
		if("8") return WEST
		else return NORTH

/obj/structure/redstone/repeater/get_input_directions()
	return list(turn(facing_dir, 180))

/obj/structure/redstone/repeater/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	var/source_dir = get_dir(src, source)
	if(!(source_dir in get_input_directions())) // Not from input side
		return

	if(processing_signal)
		return

	input_power = incoming_power
	current_input_source = source

	if(input_power > 0)
		processing_signal = TRUE
		spawn(delay_ticks)
			if(current_input_source && current_input_source.power_level > 0)
				output_power = 15
				set_power(output_power, user, null) // Don't pass source to prevent feedback
			processing_signal = FALSE
	else
		processing_signal = TRUE
		spawn(delay_ticks)
			// Double-check that the input is still off
			if(!current_input_source || current_input_source.power_level <= 0)
				output_power = 0
				set_power(0, user, null)
			processing_signal = FALSE

/obj/structure/redstone/repeater/can_connect_to(obj/structure/redstone/other, dir)
	// Only connect on input/output faces
	var/input_dir = turn(facing_dir, 180)
	return (dir == facing_dir || dir == input_dir)

/obj/structure/redstone/repeater/get_power_directions()
	// Repeaters only send power in their facing direction
	return list(facing_dir)

/obj/structure/redstone/repeater/update_overlays()
	. = ..()
	var/mutable_appearance/delay_overlay = mutable_appearance(icon, "delay_[delay_ticks]")
	overlays += delay_overlay

	var/mutable_appearance/direction_overlay = mutable_appearance(icon, "repeater_arrow")
	direction_overlay.dir = facing_dir
	overlays += direction_overlay

	if(powered)
		var/mutable_appearance/power_overlay = mutable_appearance(icon, "repeater_on")
		power_overlay.dir = facing_dir
		overlays += power_overlay

/obj/structure/redstone/repeater/update_icon()
	. = ..()
	icon_state = "repeater"
	dir = facing_dir

/obj/structure/redstone/repeater/AltClick(mob/user)
	if(!Adjacent(user))
		return

	facing_dir = turn(facing_dir, 90)
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(facing_dir)].</span>")
	update_directional_connections()

	for(var/obj/structure/redstone/component in connected_components)
		component.update_wire_connections()

/obj/structure/redstone/repeater/attack_hand(mob/user)
	if(!Adjacent(user))
		return

	delay_ticks++
	if(delay_ticks > 4)
		delay_ticks = 1

	to_chat(user, "<span class='notice'>You adjust the [name] delay to [delay_ticks] tick\s.</span>")
	update_overlays()

/obj/structure/redstone/repeater/proc/dir2text_readable(direction)
	switch(direction)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

/obj/structure/redstone/repeater/examine(mob/user)
	. = ..()
	. += "It is facing [dir2text_readable(facing_dir)] and has a delay of [delay_ticks] tick\s."
	. += "Right-click to adjust the delay, alt-click to rotate."
