/obj/structure/redstone/observer
	name = "redstone observer"
	desc = "Detects changes in the block it's observing and emits a redstone pulse."
	icon_state = "observer"
	var/direction = NORTH // Direction the observer faces
	var/turf/observing_turf
	var/last_observed_state
	var/pulse_length = 2 // How long the pulse lasts
	var/pulsing = FALSE
	can_connect_wires = TRUE

/obj/structure/redstone/observer/Initialize()
	. = ..()
	direction = dir
	update_observing_turf()
	last_observed_state = get_turf_state(observing_turf)
	register_observation_signals()
	update_icon()

/obj/structure/redstone/observer/Destroy()
	. = ..()
	unregister_observation_signals()

/obj/structure/redstone/observer/proc/set_direction(new_dir)
	direction = new_dir
	update_observing_turf()
	register_observation_signals()
	update_icon()

/obj/structure/redstone/observer/proc/update_observing_turf()
	// Unregister from old turf if it exists
	unregister_observation_signals()

	// Get new turf to observe
	observing_turf = get_step(src, direction)

	// Update last observed state
	last_observed_state = get_turf_state(observing_turf)

/obj/structure/redstone/observer/proc/register_observation_signals()
	if(!observing_turf)
		return

	// Register for changes in the observed turf
	RegisterSignal(observing_turf, COMSIG_TURF_CHANGE, PROC_REF(on_observed_change))
	// Also monitor for objects being added/removed
	RegisterSignal(observing_turf, COMSIG_ATOM_ENTERED, PROC_REF(on_observed_change))
	RegisterSignal(observing_turf, COMSIG_TURF_EXITED, PROC_REF(on_observed_change))
	RegisterSignal(observing_turf, COMSIG_OBSERVABLE_CHANGE, PROC_REF(on_observed_change))

/obj/structure/redstone/observer/proc/unregister_observation_signals()
	if(!observing_turf)
		return

	UnregisterSignal(observing_turf, list(COMSIG_TURF_CHANGE, COMSIG_ATOM_ENTERED, COMSIG_TURF_EXITED, COMSIG_OBSERVABLE_CHANGE))

/obj/structure/redstone/observer/proc/get_turf_state(turf/T)
	if(!T)
		return null
	// Create a "fingerprint" of the turf's current state
	var/list/state = list()
	state["turf_type"] = T.type
	state["objects"] = list()
	for(var/obj/O in T)
		state["objects"] += O.type
	return state

/obj/structure/redstone/observer/proc/on_observed_change()
	if(pulsing)
		return
	var/current_state = get_turf_state(observing_turf)

	if(!compare_states(last_observed_state, current_state))
		emit_pulse()
		last_observed_state = current_state

/obj/structure/redstone/observer/proc/compare_states(list/state1, list/state2)
	if(!state1 || !state2)
		return FALSE
	if(state1["turf_type"] != state2["turf_type"])
		return FALSE
	if(length(state1["objects"]) != length(state2["objects"]))
		return FALSE

	for(var/obj_type in state1["objects"])
		if(!(obj_type in state2["objects"]))
			return FALSE
	return TRUE

/obj/structure/redstone/observer/proc/emit_pulse()
	if(pulsing)
		return

	pulsing = TRUE
	set_power(15, null, null)
	update_icon()
	spawn(pulse_length * 10)
		set_power(0, null, null)
		pulsing = FALSE
		update_icon()

/obj/structure/redstone/observer/update_icon()
	. = ..()
	var/base_state = "observer"

	if(pulsing)
		base_state += "_pulse"

	icon_state = base_state
	dir = direction

/obj/structure/redstone/observer/can_connect_to(obj/structure/redstone/other, dir)
	// Observers only output from their back
	return (dir == turn(direction, 180))

// Method to handle rotation/direction setting during placement
/obj/structure/redstone/observer/proc/rotate_observer(new_direction)
	direction = new_direction
	update_observing_turf()
	register_observation_signals()
	update_icon()
	return TRUE

// Alt-click rotation functionality like piston
/obj/structure/redstone/observer/AltClick(mob/user)
	if(!Adjacent(user))
		return

	// Rotate the observer
	direction = turn(direction, 90)
	update_observing_turf()
	register_observation_signals()
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(direction)].</span>")
	update_icon()

/obj/structure/redstone/observer/proc/dir2text_readable(dir)
	switch(dir)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

/obj/structure/redstone/observer/examine(mob/user)
	. = ..()
	. += "It is facing [dir2text_readable(direction)] and observing the [dir2text_readable(direction)] tile."
	. += "It outputs redstone power from its back ([dir2text_readable(turn(direction, 180))] side)."
	. += "Alt-click to rotate."
	if(pulsing)
		. += "It is currently pulsing!"
