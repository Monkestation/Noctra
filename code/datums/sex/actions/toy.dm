
/datum/sex_action/insert_toy
	name = "Insert Toy"
	requires_hole_storage = TRUE
	hole_id = "vagina"
	stored_item_type = /obj/item/toy
	continous = FALSE

/datum/sex_action/insert_toy/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return FALSE

	// Check if user has a toy in hand
	var/obj/item/held_item = user.get_active_held_item()
	if(!held_item || !istype(held_item, /obj/item/toy))
		return FALSE

	return TRUE

/datum/sex_action/insert_toy/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	. = ..()
	// Get the actual toy from user's hand instead of creating a new one
	var/obj/item/held_toy = user.get_active_held_item()
	if(!held_toy)
		return FALSE

	// Try to fit it in the hole
	var/success = SEND_SIGNAL(target, COMSIG_HOLE_TRY_FIT, held_toy, hole_id, user, FALSE)
	if(!success)
		to_chat(user, span_warning("[target]'s [hole_id] can't accommodate [held_toy.name]!"))
		return FALSE

	// Remove from user's hand since it's now in the hole
	user.dropItemToGround(held_toy, force = TRUE)
	return TRUE
