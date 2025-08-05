/obj/structure/redstone/pressure_plate
	name = "redstone pressure plate"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "pressureplate"
	var/active = FALSE
	var/list/current_occupants = list()
	var/activation_weight = 1 // Minimum number of objects needed to activate

/obj/structure/redstone/pressure_plate/Initialize()
	. = ..()
	RegisterSignal(loc, COMSIG_ATOM_ENTERED, PROC_REF(on_entered))
	RegisterSignal(loc, COMSIG_TURF_EXITED, PROC_REF(on_exited))
	check_activation()

/obj/structure/redstone/pressure_plate/Destroy()
	UnregisterSignal(loc, list(COMSIG_ATOM_ENTERED, COMSIG_TURF_EXITED))
	return ..()

/obj/structure/redstone/pressure_plate/proc/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER
	if(should_count_object(arrived))
		current_occupants[arrived] = TRUE
		check_activation()

/obj/structure/redstone/pressure_plate/proc/on_exited(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER
	if(gone in current_occupants)
		current_occupants -= gone
		check_activation()

/obj/structure/redstone/pressure_plate/proc/should_count_object(atom/movable/AM)
	if(ismob(AM))
		var/mob/M = AM
		return M.stat != DEAD // Only count living mobs
	if(isitem(AM))
		var/obj/item/I = AM
		return I.w_class >= WEIGHT_CLASS_NORMAL // Only count items of normal or higher weight
	return FALSE

/obj/structure/redstone/pressure_plate/proc/check_activation()
	// Clean up the occupants list by removing any objects that shouldn't be counted
	var/list/valid_occupants = list()
	for(var/atom/movable/AM in current_occupants)
		if(should_count_object(AM) && AM.loc == loc)
			valid_occupants[AM] = TRUE
	current_occupants = valid_occupants

	// Check if activation state should change
	var/should_activate = (length(current_occupants) >= activation_weight)
	if(should_activate != active)
		active = should_activate
		if(active)
			icon_state = "pressureplate"
			playsound(src, 'sound/misc/pressurepad_down.ogg', 65, extrarange = 2)
			set_power(15, null, null)
			if(length(current_occupants) > 0)
				var/atom/movable/first_occupant = current_occupants[1]
				if(ismob(first_occupant))
					visible_message("[src] clicks as [first_occupant] steps on it.")
				else
					visible_message("[src] clicks as something is placed on it.")
		else
			icon_state = "pressureplate"
			playsound(src, 'sound/misc/pressurepad_up.ogg', 65, extrarange = 2)
			clear_power_source(null)
			visible_message("[src] clicks as the pressure is released.")

/obj/structure/redstone/pressure_plate/examine(mob/user)
	. = ..()
	. += "The pressure plate is currently [active ? "pressed down" : "ready"]."
	if(length(current_occupants) > 0)
		. += "There [length(current_occupants) == 1 ? "is" : "are"] [length(current_occupants)] object[length(current_occupants) > 1 ? "s" : ""] on it."
