
/datum/action_state/splitter
	name = "splitter"
	description = "Processing items in splitter"
	var/current_task = "finding_item"

/datum/action_state/splitter/enter_state(datum/ai_controller/controller)
	current_task = "finding_item"

/datum/action_state/splitter/process_state(datum/ai_controller/controller, delta_time)
	if(!controller.blackboard[BB_GNOME_SPLITTER_MODE])
		return ACTION_STATE_COMPLETE

	var/mob/living/pawn = controller.pawn
	var/obj/machinery/essence/splitter/target_splitter = controller.blackboard[BB_GNOME_TARGET_SPLITTER]

	if(!target_splitter)
		return ACTION_STATE_FAILED

	switch(current_task)
		if("finding_item")
			var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(carried)
				current_task = "delivering"
				manager.set_movement_target(controller, target_splitter)
				return ACTION_STATE_CONTINUE

			var/obj/item/found_item = find_splitter_item(controller)
			if(!found_item)
				return ACTION_STATE_CONTINUE

			controller.set_blackboard_key(BB_GNOME_FOUND_ITEM, found_item)
			manager.set_movement_target(controller, found_item)
			current_task = "picking_up"
			return ACTION_STATE_CONTINUE

		if("picking_up")
			var/obj/item/found_item = controller.blackboard[BB_GNOME_FOUND_ITEM]
			if(!found_item)
				current_task = "finding_item"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, found_item) > 1)
				var/datum/action_state_manager/manager = controller.blackboard[BB_ACTION_STATE_MANAGER]
				manager.set_movement_target(controller, found_item)
				return ACTION_STATE_CONTINUE

			if(found_item.forceMove(pawn))
				controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, found_item)
				controller.clear_blackboard_key(BB_GNOME_FOUND_ITEM)
				pawn.visible_message(span_notice("[pawn] picks up [found_item]."))
				current_task = "delivering"
			else
				current_task = "finding_item"
			return ACTION_STATE_CONTINUE

		if("delivering")
			var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
			if(!carried)
				current_task = "finding_item"
				return ACTION_STATE_CONTINUE

			if(get_dist(pawn, target_splitter) > 1)
				var/datum/action_state_manager/manager = controller.blackboard[BB_ACTION_STATE_MANAGER]
				manager.set_movement_target(controller, target_splitter)
				return ACTION_STATE_CONTINUE

			if(target_splitter.processing)
				return ACTION_STATE_CONTINUE

			if(target_splitter.current_items.len >= target_splitter.max_items)
				return ACTION_STATE_CONTINUE

			var/datum/natural_precursor/precursor = get_precursor_data(carried)
			if(!precursor)
				pawn.dropItemToGround(carried)
				controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
				current_task = "finding_item"
				return ACTION_STATE_CONTINUE

			if(carried.forceMove(target_splitter))
				target_splitter.current_items += carried
				controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
				pawn.visible_message(span_notice("[pawn] carefully places [carried] into the splitter."))
				if(target_splitter.current_items.len >= target_splitter.max_items)
					target_splitter.begin_bulk_splitting(pawn)
				current_task = "finding_item"
			else
				current_task = "finding_item"
			return ACTION_STATE_CONTINUE

	return ACTION_STATE_CONTINUE

/datum/action_state/splitter/proc/find_splitter_item(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn
	var/turf/start = controller.blackboard[BB_GNOME_WAYPOINT_A]
	var/range = controller.blackboard[BB_GNOME_SEARCH_RANGE] || 1

	if(!start)
		return null

	for(var/turf/open/source in view(range, start))
		for(var/obj/item/I in source.contents)
			if(I.anchored)
				continue
			if(I.w_class > gnome.max_carry_size)
				continue
			if(!gnome.item_matches_filter(I))
				continue
			var/datum/natural_precursor/precursor = get_precursor_data(I)
			if(!precursor)
				continue
			return I
	return null
