
/datum/action_state/alchemy
	name = "alchemy"
	description = "Automated alchemy brewing"
	var/current_phase = "need_water"

/datum/action_state/alchemy/process_state(datum/ai_controller/controller, delta_time)
	if(!controller.blackboard[BB_GNOME_ALCHEMY_MODE])
		return ACTION_STATE_COMPLETE

	var/mob/living/pawn = controller.pawn
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	var/obj/structure/well/well = controller.blackboard[BB_GNOME_TARGET_WELL]

	if(!cauldron || !well)
		return ACTION_STATE_FAILED

	switch(current_phase)
		if("need_water")
			var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!carried || !is_water_container(carried))
				var/obj/item/water_container = find_water_container_nearby(controller)
				if(water_container)
					manager.set_movement_target(controller,water_container)
					current_phase = "getting_water_container"
				else
					return ACTION_STATE_FAILED
			else
				manager.set_movement_target(controller, well)
				current_phase = "filling_water"
			return ACTION_STATE_CONTINUE

		if("getting_water_container")
			var/obj/item/water_container = find_water_container_nearby(controller)
			if(!water_container)
				current_phase = "need_water"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, water_container) > 1)
				return ACTION_STATE_CONTINUE

			if(water_container.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, water_container)
				pawn.visible_message(span_notice("[pawn] picks up [water_container]."))
				current_phase = "filling_water"
				manager.set_movement_target(controller, well)

			return ACTION_STATE_CONTINUE

		if("filling_water")
			var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!carried || !is_water_container(carried))
				current_phase = "need_water"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, well) > 1)
				return ACTION_STATE_CONTINUE

			carried.reagents?.add_reagent(/datum/reagent/water, 50)
			pawn.visible_message(span_notice("[pawn] fills [carried] with water."))
			current_phase = "adding_water"
			manager.set_movement_target(controller, cauldron)
			return ACTION_STATE_CONTINUE

		if("adding_water")
			var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!carried || !is_water_container(carried))
				current_phase = "need_water"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, cauldron) > 1)
				return ACTION_STATE_CONTINUE

			carried.reagents.trans_to(cauldron, 30)
			pawn.visible_message(span_notice("[pawn] pours water into [cauldron]."))
			pawn.dropItemToGround(carried)
			controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
			current_phase = "need_essences"
			return ACTION_STATE_CONTINUE

		if("need_essences")
			var/needed_essence = find_needed_essence_type(controller)
			if(!needed_essence)
				current_phase = "waiting_brew"
				return ACTION_STATE_CONTINUE

			var/obj/item/essence_vial/vial = find_essence_vial_with_type(controller, needed_essence)
			if(vial)
				manager.set_movement_target(controller, vial)
				current_phase = "getting_essence_vial"
			else
				var/obj/machinery/essence/machinery = find_essence_machinery_with_type(controller, needed_essence)
				if(machinery)
					manager.set_movement_target(controller, machinery)
					current_phase = "getting_essence_from_machinery"
				else
					pawn.visible_message(span_warning("[pawn] looks confusedly - no [needed_essence] essence found!"))
					return ACTION_STATE_FAILED

			return ACTION_STATE_CONTINUE

		if("getting_essence_vial")
			var/needed_essence = find_needed_essence_type(controller)
			var/obj/item/essence_vial/vial = find_essence_vial_with_type(controller, needed_essence)

			if(!vial)
				current_phase = "need_essences"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, vial) > 1)
				return ACTION_STATE_CONTINUE

			if(vial.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, vial)
				pawn.visible_message(span_notice("[pawn] picks up [vial] containing [vial.contained_essence.name]."))
				current_phase = "adding_essence"
				manager.set_movement_target(controller, cauldron)

			return ACTION_STATE_CONTINUE


		if("getting_essence_from_machinery")
			var/needed_essence = find_needed_essence_type(controller)
			var/obj/machinery/essence/machinery = find_essence_machinery_with_type(controller, needed_essence)

			if(!machinery)
				current_phase = "need_essences"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, machinery) > 1)
				return ACTION_STATE_CONTINUE

			// Look for empty vial near the machinery
			var/obj/item/essence_vial/empty_vial = find_empty_vial_near_machinery(machinery)
			if(!empty_vial)
				pawn.visible_message(span_warning("[pawn] looks around - no empty vials found near the essence machinery!"))
				return ACTION_STATE_FAILED

			// Pick up the empty vial
			if(empty_vial.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, empty_vial)
				pawn.visible_message(span_notice("[pawn] picks up an empty vial."))
				current_phase = "extracting_essence"

			return ACTION_STATE_CONTINUE

		if("extracting_essence")
			var/obj/item/essence_vial/vial = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			var/needed_essence = find_needed_essence_type(controller)
			var/obj/machinery/essence/machinery = find_essence_machinery_with_type(controller, needed_essence)

			if(!istype(vial) || !machinery)
				current_phase = "need_essences"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, machinery) > 1)
				return ACTION_STATE_CONTINUE

			// Extract essence from machinery
			if(extract_essence_from_machinery(machinery, vial, needed_essence, pawn))
				pawn.visible_message(span_notice("[pawn] extracts [vial.contained_essence.name] from the essence machinery."))
				current_phase = "adding_essence"
				manager.set_movement_target(controller, controller.blackboard[BB_GNOME_TARGET_CAULDRON])
			else
				pawn.visible_message(span_warning("[pawn] failed to extract essence from the machinery!"))
				return ACTION_STATE_FAILED

			return ACTION_STATE_CONTINUE


		if("adding_essence")
			var/obj/item/essence_vial/vial = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!istype(vial))
				current_phase = "need_essences"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, cauldron) > 1)
				return ACTION_STATE_CONTINUE

			cauldron.attackby(vial, pawn)
			pawn.visible_message(span_notice("[pawn] adds essence to the cauldron."))
			vial.forceMove(get_turf(pawn))
			current_phase = "need_essences"
			return ACTION_STATE_CONTINUE

		if("waiting_brew")
			if(get_dist(pawn, cauldron) > 1)
				manager.set_movement_target(controller, cauldron)
				return ACTION_STATE_CONTINUE

			if(cauldron.brewing >= 21 && cauldron.reagents.total_volume > 0)
				current_phase = "need_bottles"
			else if(cauldron.brewing == 0)
				current_phase = "need_water"

			return ACTION_STATE_CONTINUE

		if("need_bottles")
			var/obj/item/bottle = find_suitable_bottle(controller)
			if(!bottle)
				return ACTION_STATE_CONTINUE

			manager.set_movement_target(controller, bottle)
			current_phase = "getting_bottle"
			return ACTION_STATE_CONTINUE

		if("getting_bottle")
			var/obj/item/bottle = find_suitable_bottle(controller)
			if(!bottle)
				current_phase = "need_bottles"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, bottle) > 1)
				return ACTION_STATE_CONTINUE

			if(bottle.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, bottle)
				pawn.visible_message(span_notice("[pawn] picks up [bottle]."))
				current_phase = "bottling"
				manager.set_movement_target(controller, cauldron)

			return ACTION_STATE_CONTINUE

		if("bottling")
			var/obj/item/bottle = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!bottle || !bottle.reagents)
				current_phase = "need_bottles"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, cauldron) > 1)
				return ACTION_STATE_CONTINUE

			cauldron.reagents.trans_to(bottle, bottle.reagents.maximum_volume - bottle.reagents.total_volume)
			pawn.visible_message(span_notice("[pawn] fills [bottle] with the finished potion."))

			var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]
			if(bottle_storage)
				bottle.forceMove(bottle_storage)
				pawn.visible_message(span_notice("[pawn] stores the finished potion."))
			else
				pawn.dropItemToGround(bottle)

			controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)

			if(cauldron.reagents && cauldron.reagents.total_volume > 10)
				current_phase = "need_bottles"
			else
				current_phase = "need_water"

			return ACTION_STATE_CONTINUE

	return ACTION_STATE_CONTINUE

/datum/action_state/alchemy/proc/is_water_container(obj/item/I)
	return (istype(I, /obj/item/reagent_containers) && I.reagents)

/datum/action_state/alchemy/proc/find_water_container_nearby(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	var/obj/structure/well/well = controller.blackboard[BB_GNOME_TARGET_WELL]

	for(var/obj/item/reagent_containers/I in range(3, well))
		if(I.reagents)
			return I

	for(var/obj/item/reagent_containers/I in range(5, pawn))
		if(I.reagents)
			return I

	return null

/datum/action_state/alchemy/proc/find_needed_essence_type(datum/ai_controller/controller)
	var/recipe_path = controller.blackboard[BB_GNOME_CURRENT_RECIPE]
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]

	if(!recipe_path || !cauldron)
		return null

	var/datum/alch_cauldron_recipe/recipe = new recipe_path

	for(var/essence_type in recipe.required_essences)
		var/required_amount = recipe.required_essences[essence_type]
		var/current_amount = cauldron.essence_contents[essence_type]

		if(!current_amount || current_amount < required_amount)
			qdel(recipe)
			return essence_type

	qdel(recipe)
	return null

/datum/action_state/alchemy/proc/find_essence_vial_with_type(datum/ai_controller/controller, essence_type)
	var/mob/living/pawn = controller.pawn

	for(var/obj/item/essence_vial/vial in range(10, pawn))
		if(vial.contained_essence && istype(vial.contained_essence, essence_type) && vial.essence_amount > 0)
			return vial

	return null

/datum/action_state/alchemy/proc/find_essence_machinery_with_type(datum/ai_controller/controller, essence_type)
	var/mob/living/pawn = controller.pawn

	for(var/obj/machinery/essence/machinery in view(20, pawn))
		if(essence_machinery_has_essence(machinery, essence_type))
			return machinery

	for(var/obj/machinery/essence/machinery in range(10, pawn))/// last resort
		if(essence_machinery_has_essence(machinery, essence_type))
			return machinery

	return null

/datum/action_state/alchemy/proc/essence_machinery_has_essence(obj/machinery/essence/machinery, essence_type)
	if(istype(machinery, /obj/machinery/essence/reservoir))
		var/obj/machinery/essence/reservoir/reservoir = machinery
		var/datum/essence_storage/storage = reservoir.return_storage()
		if(storage && storage.get_essence_amount(essence_type) > 0)
			return TRUE
	return FALSE

/datum/action_state/alchemy/proc/find_suitable_bottle(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]

	var/list/search_areas = list()
	if(bottle_storage)
		search_areas += bottle_storage
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	if(cauldron)
		search_areas += get_turf(cauldron)

	for(var/turf/area in search_areas)
		for(var/obj/item/reagent_containers/I in range(3, area))
			if(I.reagents && I.reagents.total_volume == 0)
				return I

	for(var/obj/machinery/essence/machinery in view(15, pawn))
		search_areas += get_turf(machinery)

	for(var/turf/area in search_areas) ///meh this forces the gnome to do work close and this as a fallback
		for(var/obj/item/reagent_containers/I in range(3, area))
			if(I.reagents && I.reagents.total_volume == 0)
				return I


	return null


/datum/action_state/alchemy/proc/find_empty_vial_near_machinery(obj/machinery/essence/target_machinery)
	for(var/obj/item/essence_vial/vial in range(3, target_machinery))
		if(!vial.contained_essence || vial.essence_amount <= 0)
			return vial

	for(var/obj/machinery/essence/machinery in view(15, target_machinery))
		if(machinery == target_machinery)
			continue
		for(var/obj/item/essence_vial/vial in range(3, machinery))
			if(!vial.contained_essence || vial.essence_amount <= 0)
				return vial

	return null

/datum/action_state/alchemy/proc/extract_essence_from_machinery(obj/machinery/essence/machinery, obj/item/essence_vial/vial, essence_type, mob/living/pawn)
	if(istype(machinery, /obj/machinery/essence/reservoir))
		return extract_from_reservoir(machinery, vial, essence_type, pawn)

	return FALSE

/datum/action_state/alchemy/proc/extract_from_reservoir(obj/machinery/essence/reservoir/reservoir, obj/item/essence_vial/vial, essence_type, mob/living/pawn)
	var/datum/essence_storage/storage = reservoir.return_storage()

	if(!storage || storage.get_essence_amount(essence_type) <= 0)
		return FALSE

	var/max_extract = min(storage.get_essence_amount(essence_type), vial.max_essence)
	if(max_extract <= 0)
		return FALSE

	var/extracted = storage.remove_essence(essence_type, max_extract)
	if(extracted > 0)
		vial.contained_essence = new essence_type
		vial.essence_amount = extracted
		vial.update_appearance(UPDATE_OVERLAYS)
		return TRUE

	return FALSE
