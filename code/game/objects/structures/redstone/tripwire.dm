/obj/structure/redstone/tripwire_hook
	name = "tripwire hook"
	desc = "Creates an invisible tripwire that detects movement."
	icon_state = "tripwire_hook"
	var/obj/structure/redstone/tripwire_hook/connected_hook
	var/list/tripwire_turfs = list()
	var/max_distance = 10
	can_connect_wires = TRUE

/obj/structure/redstone/tripwire_hook/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/redstone/tripwire_hook/LateInitialize()
	. = ..()
	find_connection()

/obj/structure/redstone/tripwire_hook/proc/find_connection()
	var/direction = dir // Use the hook's facing direction

	for(var/i = 1 to max_distance)
		var/turf/check_turf = get_step(src, direction)
		if(!check_turf)
			break

		for(var/obj/structure/redstone/tripwire_hook/hook in check_turf)
			if(hook != src && !hook.connected_hook)
				establish_connection(hook)
				return

		tripwire_turfs += check_turf

/obj/structure/redstone/tripwire_hook/proc/establish_connection(obj/structure/redstone/tripwire_hook/other_hook)
	connected_hook = other_hook
	other_hook.connected_hook = src

	// Set up tripwire monitoring
	for(var/turf/T in tripwire_turfs)
		RegisterSignal(T, COMSIG_ATOM_ENTERED, PROC_REF(on_tripwire_crossed))

/obj/structure/redstone/tripwire_hook/proc/on_tripwire_crossed(datum/source, atom/movable/crossed)
	if(isliving(crossed))
		// Trigger both hooks
		set_power(15, null)
		if(connected_hook)
			connected_hook.set_power(15, null)

		spawn(5)
			set_power(0, null)
			if(connected_hook)
				connected_hook.set_power(0, null)
