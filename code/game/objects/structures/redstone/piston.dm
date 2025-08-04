/obj/structure/redstone/piston
	name = "redstone piston"
	desc = "A mechanical device that can push blocks when powered."
	icon_state = "piston"
	var/extended = FALSE
	var/direction = NORTH // Direction the piston faces
	var/can_pull = FALSE // TRUE for sticky pistons
	var/obj/structure/piston_head/head
	var/extending = FALSE // Prevent spam
	can_connect_wires = TRUE

/obj/structure/redstone/piston/Initialize()
	. = ..()
	direction = dir
	update_icon()
	create_piston_head()

/obj/structure/redstone/piston/Destroy()
	. = ..()
	if(head)
		qdel(head)

/obj/structure/redstone/piston/proc/set_direction(new_dir)
	direction = new_dir
	update_icon()

/obj/structure/redstone/piston/proc/create_piston_head()
	// Create head at piston location (retracted position)
	head = new /obj/structure/piston_head(get_turf(src))
	head.parent_piston = src
	head.set_direction(direction)
	head.layer = layer - 0.1 // Layer it under the piston

/obj/structure/redstone/piston/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	var/should_extend = (incoming_power > 0)
	if(should_extend != extended && !extending)
		if(should_extend)
			extend_piston(user)
		else
			retract_piston(user)

/obj/structure/redstone/piston/proc/extend_piston(mob/user)
	if(extended || extending)
		return
	extending = TRUE
	var/turf/target_turf = get_step(src, direction)
	if(!can_extend_to(target_turf))
		extending = FALSE
		return
	push_objects(target_turf, user)
	extended = TRUE
	if(head)
		head.forceMove(target_turf)
	update_icon()
	//playsound(src, 'sound/machines/piston_extend.ogg', 50)
	spawn(5) // Slightly longer delay for glide
		extending = FALSE

/obj/structure/redstone/piston/proc/retract_piston(mob/user)
	if(!extended || extending)
		return
	extending = TRUE
	if(can_pull && head)
		pull_objects(user)
	extended = FALSE
	if(head)
		head.forceMove(get_turf(src))
	update_icon()
	//playsound(src, 'sound/machines/piston_retract.ogg', 50)
	spawn(5) // Slightly longer delay for glide
		extending = FALSE

/obj/structure/redstone/piston/proc/can_extend_to(turf/target_turf)
	if(!target_turf)
		return FALSE
	// Check for immovable objects
	for(var/obj/structure/S in target_turf)
		if(S.density && S.anchored)
			return FALSE
	return TRUE

/obj/structure/redstone/piston/proc/push_objects(turf/target_turf, mob/user)
	var/turf/push_target = get_step(target_turf, direction)
	if(!push_target)
		return // Can't push beyond map edge

	for(var/obj/O in target_turf)
		if(O.density && !O.anchored)
			O.forceMove(push_target)
	for(var/mob/M in target_turf)
		M.forceMove(push_target)
		to_chat(M, "<span class='warning'>You are pushed by the piston!</span>")

/obj/structure/redstone/piston/proc/pull_objects(mob/user)
	if(!head)
		return
	var/turf/pull_source = get_step(head, direction)
	var/turf/pull_target = head.loc
	if(!pull_source)
		return // Can't pull from beyond map edge

	for(var/obj/O in pull_source)
		if(O.density && !O.anchored)
			O.forceMove(pull_target)
	for(var/mob/M in pull_source)
		M.forceMove(pull_target)
		to_chat(M, "<span class='warning'>You are pulled by the sticky piston!</span>")

/obj/structure/redstone/piston/update_icon()
	. = ..()
	var/base_state = can_pull ? "sticky_piston" : "piston"

	if(extended)
		base_state += "_extended"

	icon_state = base_state
	dir = direction

/obj/structure/redstone/piston/can_connect_to(obj/structure/redstone/other, dir)
	// Pistons don't connect on their face
	return (dir != direction)

/obj/structure/redstone/piston/proc/rotate_piston(new_direction)
	if(extended)
		return FALSE // Can't rotate while extended
	direction = new_direction
	if(head)
		head.set_direction(direction)
	update_icon()
	return TRUE

/obj/structure/redstone/piston/AltClick(mob/user)
	if(!Adjacent(user))
		return

	// Can't rotate while extended
	if(extended)
		to_chat(user, "<span class='warning'>You cannot rotate the [name] while it is extended!</span>")
		return

	// Rotate the piston
	direction = turn(direction, 90)
	if(head)
		head.set_direction(direction)
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(direction)].</span>")
	update_icon()

/obj/structure/redstone/piston/proc/dir2text_readable(dir)
	switch(dir)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

/obj/structure/redstone/piston/examine(mob/user)
	. = ..()
	. += "It is facing [dir2text_readable(direction)]."
	. += "Alt-click to rotate."
	if(extended)
		. += "It is currently extended."
	else
		. += "It is currently retracted."

/obj/structure/redstone/piston/sticky
	name = "sticky redstone piston"
	desc = "A piston that can pull blocks back when retracting."
	icon_state = "sticky_piston"
	can_pull = TRUE

/obj/structure/piston_head
	name = "piston head"
	icon = 'icons/obj/redstone.dmi'
	icon_state = "piston_head"
	density = TRUE
	layer = BELOW_OBJ_LAYER - 0.01
	anchored = TRUE
	var/obj/structure/redstone/piston/parent_piston
	var/direction = NORTH

/obj/structure/piston_head/proc/set_direction(new_dir)
	direction = new_dir
	dir = direction

/obj/structure/piston_head/Destroy()
	. = ..()
	if(parent_piston)
		parent_piston.head = null
