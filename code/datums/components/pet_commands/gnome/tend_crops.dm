/datum/pet_command/gnome/tend_crops
	command_name = "Tend Crops"
	command_desc = "Automatically tend to crops in the area - water, harvest, plant, and deweed"
	radial_icon_state = "tend"
	speech_commands = list("tend", "farm", "crops", "garden", "agriculture")

/datum/pet_command/gnome/tend_crops/execute_action(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn

	// Set crop mode regardless of having sources - gnome will look for them dynamically
	controller.set_blackboard_key(BB_GNOME_CROP_MODE, TRUE)

	// Try to find initial sources but don't require them
	var/obj/item/reagent_containers/water_source = find_water_source(controller)
	var/obj/item/storage/seed_storage = find_seed_source(controller)
	var/obj/structure/composter/composter_source = find_composter_source(controller)

	if(water_source)
		controller.set_blackboard_key(BB_GNOME_WATER_SOURCE, water_source)
	if(seed_storage)
		controller.set_blackboard_key(BB_GNOME_SEED_SOURCE, seed_storage)
	if(composter_source)
		controller.set_blackboard_key(BB_GNOME_COMPOST_SOURCE, composter_source)

	pawn.visible_message(span_notice("[pawn] looks around and begins tending to the crops!"))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/tend_crops/proc/find_water_source(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/item/reagent_containers/container in oview(7, pawn))
		if(container.anchored) // Wells
			if(container.reagents?.has_reagent(/datum/reagent/water, 15))
				return container
		else if(istype(container, /obj/item/reagent_containers/glass))
			if(container.reagents?.has_reagent(/datum/reagent/water, 15))
				return container
	return null

/datum/pet_command/gnome/tend_crops/proc/find_seed_source(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/closet/container in oview(7, pawn))
		for(var/obj/item/neuFarm/seed/seed in container.contents)
			return container
	return null

/datum/pet_command/gnome/tend_crops/proc/find_composter_source(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/composter/comp in oview(7, pawn))
		if(comp.ready_compost >= 100)
			return comp
	return null

/datum/pet_command/gnome/stop_tending
	command_name = "Stop Tending"
	command_desc = "Stop tending to crops"
	radial_icon_state = "tend-stop"
	speech_commands = list("stop tending", "stop farming", "halt farming")

/datum/pet_command/gnome/stop_tending/execute_action(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	controller.set_blackboard_key(BB_GNOME_CROP_MODE, FALSE)
	controller.clear_blackboard_key(BB_GNOME_WATER_SOURCE)
	controller.clear_blackboard_key(BB_GNOME_SEED_SOURCE)
	controller.clear_blackboard_key(BB_GNOME_COMPOST_SOURCE)
	pawn.visible_message(span_notice("[pawn] stops tending crops and returns to normal behavior."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/ai_behavior/gnome_crop_tending
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/gnome_crop_tending/setup(datum/ai_controller/controller)
	. = ..()

	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	// If carrying water, find soil that needs watering
	if(carried_item && is_water_container(carried_item))
		var/obj/structure/soil/target_soil = find_soil_needing_water(controller)
		if(target_soil)
			set_movement_target(controller, target_soil)
			return TRUE

	// If carrying seed, find empty soil
	else if(carried_item && (istype(carried_item, /obj/item/neuFarm/seed)))
		var/obj/structure/soil/target_soil = find_empty_soil(controller)
		if(target_soil)
			set_movement_target(controller, target_soil)
			return TRUE

	// If carrying compost, find hungry soil
	else if (carried_item && istype(carried_item, /obj/item/fertilizer/compost))
		var/obj/structure/soil/fert_soil = find_soil_needing_fertilizer(controller)
		if (fert_soil)
			set_movement_target(controller, fert_soil)
			return TRUE

	// If not carrying anything, find tasks by priority
	else if(!carried_item)
		// PRIORITY 1: Harvest ready crops
		var/obj/structure/soil/harvest_soil = find_soil_ready_for_harvest(controller)
		if(harvest_soil)
			set_movement_target(controller, harvest_soil)
			return TRUE

		// PRIORITY 2: Deweed crops
		var/obj/structure/soil/weedy_soil = find_soil_needing_deweed(controller)
		if(weedy_soil)
			set_movement_target(controller, weedy_soil)
			return TRUE

		// PRIORITY 3: Water thirsty plants
		var/obj/structure/soil/thirsty_soil = find_soil_needing_water(controller)
		if(thirsty_soil)
			// Try to find water source dynamically if we don't have one set
			var/obj/item/reagent_containers/water_source = controller.blackboard[BB_GNOME_WATER_SOURCE]
			if(!water_source)
				water_source = find_water_source_dynamic(controller)
				if(water_source)
					controller.set_blackboard_key(BB_GNOME_WATER_SOURCE, water_source)

			if(water_source)
				set_movement_target(controller, water_source)
				return TRUE

		// PRIORITY 4: Plant seeds in empty soil
		var/obj/structure/soil/empty_soil = find_empty_soil(controller)
		if(empty_soil)
			// Try to find seed source dynamically if we don't have one set
			var/obj/item/storage/seed_source = controller.blackboard[BB_GNOME_SEED_SOURCE]
			if(!seed_source)
				seed_source = find_seed_source_dynamic(controller)
				if(seed_source)
					controller.set_blackboard_key(BB_GNOME_SEED_SOURCE, seed_source)

			if(seed_source)
				set_movement_target(controller, seed_source)
				return TRUE

		// PRIORITY 5: Fertilizes hungry soil
		var/obj/structure/soil/fert_soil = find_soil_needing_fertilizer(controller)
		if(fert_soil)
			var/obj/structure/composter/composter_source = controller.blackboard[BB_GNOME_COMPOST_SOURCE]
			if(!composter_source)
				composter_source = find_composter_source(controller)
				if(composter_source)
					controller.set_blackboard_key(BB_GNOME_COMPOST_SOURCE, composter_source)
			if(composter_source)
				set_movement_target(controller, composter_source)
				return TRUE
	return FALSE

/datum/ai_behavior/gnome_crop_tending/perform(delta_time, datum/ai_controller/controller)
	. = ..()

	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/mob/living/pawn = controller.pawn
	var/atom/current_target = controller.current_movement_target

	if(!current_target || get_dist(pawn, current_target) > 1)
		finish_action(controller, FALSE)
		return

	// Water soil with carried water container
	if(carried_item && is_water_container(carried_item) && istype(current_target, /obj/structure/soil))
		var/obj/structure/soil/soil = current_target
		if(soil.water < 150 * 0.8)
			water_soil(controller, soil, carried_item)
			finish_action(controller, TRUE)
			return

	// Plant seed in soil
	else if(carried_item && (istype(carried_item, /obj/item/neuFarm/seed)) && istype(current_target, /obj/structure/soil))
		var/obj/structure/soil/soil = current_target
		if(!soil.plant)
			plant_seed(controller, soil, carried_item)
			finish_action(controller, TRUE)
			return

	// fertilizes soil with compost
	else if(carried_item && istype(carried_item, /obj/item/fertilizer/compost) && istype(current_target, /obj/structure/soil))
		var/obj/structure/soil/soil = current_target
		fertilize_soil(controller, soil, carried_item)
		finish_action(controller, TRUE)
		return

	// Pick up water container
	else if(!carried_item && istype(current_target, /obj/item/reagent_containers))
		var/obj/item/reagent_containers/container = current_target
		if(container.reagents?.has_reagent(/datum/reagent/water, 15))
			if(container.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, container)
				pawn.visible_message(span_notice("[pawn] picks up [container] for watering."))
				finish_action(controller, TRUE)
				return

	// Take seed from storage
	else if(!carried_item && istype(current_target, /obj/structure/closet))
		var/obj/structure/closet/storage = current_target
		var/obj/item/neuFarm/seed = find_seed_in_storage(storage)
		if(seed)
			SEND_SIGNAL(storage, COMSIG_TRY_STORAGE_TAKE, seed, get_turf(pawn), TRUE)
			if(seed.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, seed)
				pawn.visible_message(span_notice("[pawn] takes [seed] for planting."))
				finish_action(controller, TRUE)
				return

	// Take compost from composter
	else if(!carried_item && istype(current_target, /obj/structure/composter))
		var/obj/structure/composter/comp = current_target
		if(comp.ready_compost >= 100)
			var/obj/item/fertilizer/compost/new_compost = comp.take_out_compost()
			if(new_compost && new_compost.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, new_compost)
				pawn.visible_message(span_notice("[pawn] takes compost from [comp]."))
				finish_action(controller, TRUE)
				return

	// Harvest ready crops
	else if(!carried_item && istype(current_target, /obj/structure/soil))
		var/obj/structure/soil/soil = current_target
		if(soil.produce_ready)
			harvest_soil(controller, soil)
			finish_action(controller, TRUE)
			return
		else if(soil.plant && soil.weeds > 0)
			deweed_soil(controller, soil)
			finish_action(controller, TRUE)
			return

	finish_action(controller, FALSE)

// Existing helper procs
/datum/ai_behavior/gnome_crop_tending/proc/find_soil_ready_for_harvest(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/soil/soil in oview(7, pawn))
		if(soil.produce_ready)
			return soil
	return null

/datum/ai_behavior/gnome_crop_tending/proc/find_soil_needing_water(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/soil/soil in oview(7, pawn))
		if(soil.plant && !soil.plant_dead && soil.water < 150 * 0.3)
			return soil
	return null

/datum/ai_behavior/gnome_crop_tending/proc/find_soil_needing_fertilizer(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/soil/soil in oview(7, pawn))
		if(soil.plant && !soil.plant_dead && soil.can_accept_fertilizer())
			return soil
	return null

/datum/ai_behavior/gnome_crop_tending/proc/find_empty_soil(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/soil/soil in oview(7, pawn))
		if(!soil.plant)
			return soil
	return null

// Find soil that needs deweeding
/datum/ai_behavior/gnome_crop_tending/proc/find_soil_needing_deweed(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/soil/soil in oview(7, pawn))
		if(soil.plant && soil.weeds > 25)
			return soil
	return null

// Dynamic source finding
/datum/ai_behavior/gnome_crop_tending/proc/find_water_source_dynamic(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/item/reagent_containers/container in oview(7, pawn))
		if(container.anchored) // Wells
			if(container.reagents?.has_reagent(/datum/reagent/water, 15))
				return container
		else if(istype(container, /obj/item/reagent_containers/glass))
			if(container.reagents?.has_reagent(/datum/reagent/water, 15))
				return container
	return null

/datum/ai_behavior/gnome_crop_tending/proc/find_seed_source_dynamic(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/closet/container in oview(7, pawn))
		for(var/obj/item/neuFarm/seed/seed in container.contents)
			return container
	return null

/datum/ai_behavior/gnome_crop_tending/proc/find_composter_source(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	for(var/obj/structure/composter/comp in oview(7, pawn))
		if(comp.ready_compost >= 100)
			return comp
	return null

/datum/ai_behavior/gnome_crop_tending/proc/is_water_container(obj/item/item)
	if(!istype(item, /obj/item/reagent_containers))
		return FALSE
	var/obj/item/reagent_containers/container = item
	return container.reagents?.has_reagent(/datum/reagent/water, 15)

/datum/ai_behavior/gnome_crop_tending/proc/find_seed_in_storage(obj/structure/closet/storage)
	for(var/obj/item/neuFarm/seed/seed in (storage.contents + storage.loc.contents))
		return seed
	return null

/datum/ai_behavior/gnome_crop_tending/proc/water_soil(datum/ai_controller/controller, obj/structure/soil/soil, obj/item/reagent_containers/water_container)
	var/mob/living/pawn = controller.pawn

	if(water_container.reagents.has_reagent(/datum/reagent/water, 15))
		soil.adjust_water(150)
		pawn.visible_message(span_notice("[pawn] waters [soil]."))
		var/list/wash = list('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg')
		playsound(pawn, pick(wash), 100, FALSE)

		pawn.dropItemToGround(water_container)
		controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)

/datum/ai_behavior/gnome_crop_tending/proc/fertilize_soil(datum/ai_controller/controller, obj/structure/soil/soil, obj/item/fertilizer)
	var/mob/living/pawn = controller.pawn
	if(soil.can_accept_fertilizer() && (istype(fertilizer, /obj/item/fertilizer) || istype(fertilizer, /obj/item/natural/poo)))
		if(soil.try_handle_fertilizing(fertilizer, pawn, null))
			controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
			pawn.visible_message(span_notice("[pawn] fertilizes [soil] with [fertilizer.name]."))
			playsound(soil, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)

/datum/ai_behavior/gnome_crop_tending/proc/plant_seed(datum/ai_controller/controller, obj/structure/soil/soil, obj/item/seed)
	var/mob/living/pawn = controller.pawn

	if(istype(seed, /obj/item/neuFarm/seed))
		var/obj/item/neuFarm/seed/farm_seed = seed
		farm_seed.try_plant_seed(pawn, soil)

	controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
	pawn.visible_message(span_notice("[pawn] plants [seed] in [soil]."))
	playsound(soil, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)

/datum/ai_behavior/gnome_crop_tending/proc/harvest_soil(datum/ai_controller/controller, obj/structure/soil/soil)
	var/mob/living/pawn = controller.pawn

	soil.user_harvests(pawn) // this means they can become master farmers lol
	pawn.visible_message(span_notice("[pawn] harvests [soil]."))
	playsound(soil, 'sound/items/seed.ogg', 100, FALSE)

/datum/ai_behavior/gnome_crop_tending/proc/deweed_soil(datum/ai_controller/controller, obj/structure/soil/soil)
	var/mob/living/pawn = controller.pawn

	if(soil.weeds > 0)
		soil.weeds = max(0, soil.weeds - 25) // Reduce weeds by 25
		pawn.visible_message(span_notice("[pawn] carefully removes weeds from [soil]."))
		playsound(soil, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 100, TRUE)

/datum/ai_behavior/gnome_crop_tending/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
