/obj/structure/redstone/dispenser
	name = "redstone dispenser"
	desc = "Dispenses items when powered by redstone. Throws items or handles liquids from containers."
	icon_state = "dispenser"
	var/direction = NORTH
	var/dispensing = FALSE
	can_connect_wires = TRUE

/obj/structure/redstone/dispenser/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/bin)

/obj/structure/redstone/dispenser/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	if(incoming_power > 0 && !dispensing)
		dispense_item()

/obj/structure/redstone/dispenser/proc/dispense_item()
	if(dispensing || !length(contents))
		return

	dispensing = TRUE
	var/obj/item/dispensed = contents[rand(1, length(contents))]
	var/turf/target_turf = get_step(src, direction)

	// Check if it's a reagent container
	if(istype(dispensed, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = dispensed
		handle_reagent_container(container, target_turf)
	else
		// Regular item - throw it
		SEND_SIGNAL(src, COMSIG_TRY_STORAGE_TAKE, dispensed, get_turf(src), TRUE)
		var/turf/throw_target = get_step(target_turf, direction) // Throw one tile further
		dispensed.throw_at(throw_target, 3, 1) // Range 3, speed 1

	//playsound(src, 'sound/machines/click.ogg', 50)
	spawn(2)
		dispensing = FALSE

/obj/structure/redstone/dispenser/proc/handle_reagent_container(obj/item/reagent_containers/container, turf/target_turf)
	if(!container.reagents)
		return

	if(container.reagents.total_volume > 0)
		// Container has liquid - create a splash/pool
		splash_liquid(container, target_turf)
	else
		// Container is empty - try to pick up liquids from the ground
		pickup_liquid(container, target_turf)

/obj/structure/redstone/dispenser/proc/splash_liquid(obj/item/reagent_containers/container, turf/target_turf)
	if(!container.reagents || container.reagents.total_volume <= 0)
		return

	// Create a small splash effect using the existing chem_splash proc
	var/list/reactant_list = list(container.reagents)
	chem_splash(target_turf, affected_range = 1, reactants = reactant_list, adminlog = 0)

	// Clear the container's reagents since they've been splashed
	container.reagents.clear_reagents()

/obj/structure/redstone/dispenser/proc/pickup_liquid(obj/item/reagent_containers/container, turf/target_turf)
	if(!container.reagents)
		return

	// Check if the turf has any liquid pools
	if(!target_turf.liquids || !target_turf.liquids.liquid_group.total_reagent_volume)
		return

	// Try to pick up liquid from the largest pool
	var/datum/liquid_group/largest_pool
	var/largest_volume = 0

	if(target_turf.liquids?.liquid_group.total_reagent_volume > largest_volume)
		largest_volume = target_turf.liquids?.liquid_group.total_reagent_volume
		largest_pool = target_turf.liquids?.liquid_group

	if(!largest_pool || largest_volume <= 0)
		return

	// Calculate how much we can pick up
	var/pickup_amount = min(largest_volume, container.reagents.maximum_volume - container.reagents.total_volume)

	if(pickup_amount > 0)
		// Transfer liquid from pool to container
		largest_pool.transfer_to_atom(null, pickup_amount, container)

/obj/structure/redstone/dispenser/AltClick(mob/user)
	if(!Adjacent(user))
		return

	// Rotate the dispenser
	direction = turn(direction, 90)
	to_chat(user, "<span class='notice'>You rotate the [name] to face [dir2text_readable(direction)].</span>")
	update_icon()

/obj/structure/redstone/dispenser/proc/dir2text_readable(dir)
	switch(dir)
		if(NORTH) return "north"
		if(SOUTH) return "south"
		if(EAST) return "east"
		if(WEST) return "west"
		else return "north"

/obj/structure/redstone/dispenser/update_icon()
	. = ..()
	dir = direction

/obj/structure/redstone/dispenser/examine(mob/user)
	. = ..()
	. += "It is facing [dir2text_readable(direction)]."
	. += "Alt-click to rotate."
	if(length(contents))
		. += "It contains [length(contents)] item\s."
	else
		. += "It is empty."
