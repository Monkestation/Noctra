/datum/objective/hoard_mammons
	name = "Hoard Mammons"
	triumph_count = 2
	var/target_mammons = 400
	var/current_amount = 0
	var/check_cooldown = 20 SECONDS
	var/next_check = 0

/datum/objective/hoard_mammons/on_creation()
	. = ..()
	START_PROCESSING(SSprocessing, src)
	update_explanation_text()

/datum/objective/hoard_mammons/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/datum/objective/hoard_mammons/process()
	if(world.time < next_check || completed || !owner?.current)
		return

	next_check = world.time + check_cooldown
	check_mammons()

/datum/objective/hoard_mammons/proc/check_mammons()
	var/mob/living/user = owner.current
	if(!istype(user) || user.stat == DEAD)
		return

	var/mammon_count = get_mammons_in_atom(user)
	if(mammon_count >= target_mammons && !completed)
		to_chat(user, span_greentext("You have accumulated [mammon_count] mammons, completing Matthios' objective!"))
		user.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence(MATTHIOS, 15)
		escalate_objective()
		STOP_PROCESSING(SSprocessing, src)

/datum/objective/hoard_mammons/update_explanation_text()
	explanation_text = "Accumulate at least [target_mammons] mammons in your possession to demonstrate your greediness to Matthios."
