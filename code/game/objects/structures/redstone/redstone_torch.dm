/obj/structure/redstone/torch
	name = "redstone torch"
	desc = "A torch that provides constant redstone power to adjacent sides. Can be inverted by powering the block it's attached to."
	icon_state = "torch"
	power_level = 15
	powered = TRUE
	var/attached_dir = SOUTH // Direction the torch is attached to (opposite of output)
	var/inverted = FALSE // Whether the torch is currently inverted (off due to input power)
	var/base_power = 15 // The power level when not inverted
	can_connect_wires = TRUE
	send_wall_power = FALSE // Torches don't send power through walls

/obj/structure/redstone/torch/Initialize()
	. = ..()
	attached_dir = dir // The direction the torch faces (attached to opposite wall)
	update_directional_connections()

	return INITIALIZE_HINT_LATELOAD

/obj/structure/redstone/torch/LateInitialize()
	. = ..()
	if(!inverted)
		set_power(base_power, null, null) // No source since this IS the source


/obj/structure/redstone/torch/proc/update_directional_connections()
	// Clear existing connections
	wire_connections = list("2" = 0, "1" = 0, "8" = 0, "4" = 0)
	connected_components = list()

	// Connect to all sides except the attached side
	var/list/output_dirs = list(NORTH, SOUTH, EAST, WEST)
	output_dirs -= attached_dir // Remove the attached direction

	for(var/check_dir in output_dirs)
		var/turf/check_turf = get_step(src, check_dir)

		// Check for redstone components
		for(var/obj/structure/redstone/component in check_turf)
			if(component.can_connect_wires && component.can_connect_to(src, turn(check_dir, 180)))
				wire_connections[dir2text(check_dir)] = 1
				connected_components += component

/obj/structure/redstone/torch/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	// Torches are inverted by power coming from the attached block
	// Check if the power is coming from the attached direction (through the wall)
	var/source_dir = get_dir(src, source)

	// For wall torches, we want to check if power is coming from the attached block
	// This could be from a repeater pushing power through the wall
	if(source_dir == attached_dir || source == src.loc) // Power from attached block or turf
		var/should_invert = (incoming_power > 0)

		if(should_invert != inverted)
			inverted = should_invert

			if(inverted)
				set_power(0, user, null)
				powered = FALSE
			else
				set_power(base_power, user, null)
				powered = TRUE

			update_overlays()

/obj/structure/redstone/torch/can_connect_to(obj/structure/redstone/other, dir)
	// Don't connect to the attached side
	return (dir != attached_dir)

/obj/structure/redstone/torch/get_power_directions()
	// Torches output to all sides except the attached side
	var/list/output_dirs = GLOB.cardinals.Copy()
	output_dirs -= attached_dir
	return output_dirs

/obj/structure/redstone/torch/update_overlays()
	. = ..()
	var/mutable_appearance/attachment_overlay = mutable_appearance(icon, "torch_attachment")
	attachment_overlay.dir = attached_dir
	overlays += attachment_overlay

	if(powered && !inverted)
		var/mutable_appearance/power_overlay = mutable_appearance(icon, "torch_on")
		overlays += power_overlay
	else if(inverted)
		var/mutable_appearance/inverted_overlay = mutable_appearance(icon, "torch_inverted")
		overlays += inverted_overlay

/obj/structure/redstone/torch/proc/dir2text(direction)
	switch(direction)
		if(NORTH) return "1"
		if(SOUTH) return "2"
		if(EAST) return "4"
		if(WEST) return "8"
		else return "1"

/obj/structure/redstone/torch/examine(mob/user)
	. = ..()
	. += "It is attached to the [dir2text_readable(attached_dir)] side."
	if(inverted)
		. += "The torch is currently inverted (off) due to input power."
	else
		. += "The torch is currently providing power to adjacent sides."

/obj/structure/redstone/torch/proc/dir2text_readable(direction)
	switch(direction)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

/obj/structure/redstone/torch/AltClick(mob/user)
	if(!Adjacent(user))
		return

	attached_dir = turn(attached_dir, 90)
	dir = attached_dir
	to_chat(user, "<span class='notice'>You rotate the [name] to attach to the [dir2text_readable(attached_dir)] side.</span>")
	update_directional_connections()

	for(var/obj/structure/redstone/component in connected_components)
		component.update_wire_connections()
