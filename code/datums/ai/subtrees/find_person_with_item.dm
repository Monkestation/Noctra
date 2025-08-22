/// Find the nearest thing which we assume is hostile and set it as the flee target
/datum/ai_planning_subtree/simple_find_nearest_target_to_flee_has_item

/datum/ai_planning_subtree/simple_find_nearest_target_to_flee_has_item/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(controller.blackboard[BB_BASIC_MOB_STOP_FLEEING])
		return
	controller.queue_behavior(/datum/ai_behavior/find_potential_targets_with_item, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION, BB_BASIC_MOB_SCARED_ITEM)

/datum/ai_behavior/find_potential_targets_with_item
	action_cooldown = 2 SECONDS
	/// How far can we see stuff?
	var/vision_range = 9
	/// Blackboard key for aggro range, uses vision range if not specified
	var/aggro_range_key = BB_AGGRO_RANGE

/datum/ai_behavior/find_potential_targets_with_item/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key, scared_item_key)
	. = ..()
	var/mob/living/living_mob = controller.pawn
	var/datum/targetting_datum/targeting_strategy = controller.blackboard[targeting_strategy_key]
	var/obj/item/scared_item_path = controller.blackboard[scared_item_key]

	if(!targeting_strategy)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/atom/current_target = controller.blackboard[target_key]
	if (targeting_strategy.can_attack(living_mob, current_target, vision_range))
		finish_action(controller, succeeded = FALSE)
		return

	var/aggro_range = controller.blackboard[aggro_range_key] || vision_range

	controller.clear_blackboard_key(target_key)
	var/list/potential_targets = hearers(aggro_range, controller.pawn) - living_mob //Remove self, so we don't suicide

	if(!potential_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	var/list/filtered_targets = list()

	for(var/atom/pot_target in potential_targets)
		if(targeting_strategy.can_attack(living_mob, pot_target))//Can we attack it?
			if(!ishuman(pot_target))
				continue

			var/mob/living/carbon/human/human = pot_target
			for(var/obj/item/item as anything in human.held_items)
				if(!item)
					continue
				if(!istype(item, scared_item_path))
					continue
				filtered_targets += pot_target
				break

			continue

	if(!filtered_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	var/atom/target = pick_final_target(controller, filtered_targets)
	controller.set_blackboard_key(target_key, target)

	var/atom/potential_hiding_location = targeting_strategy.find_hidden_mobs(living_mob, target)

	if(potential_hiding_location) //If they're hiding inside of something, we need to know so we can go for that instead initially.
		controller.set_blackboard_key(hiding_location_key, potential_hiding_location)

	finish_action(controller, succeeded = TRUE)

/datum/ai_behavior/find_potential_targets_with_item/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if (succeeded)
		controller.CancelActions() // On retarget cancel any further queued actions so that they will setup again with new target

/// Returns the desired final target from the filtered list of targets
/datum/ai_behavior/find_potential_targets_with_item/proc/pick_final_target(datum/ai_controller/controller, list/filtered_targets)
	return pick(filtered_targets)
