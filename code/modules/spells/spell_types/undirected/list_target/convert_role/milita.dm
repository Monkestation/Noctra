/datum/action/cooldown/spell/undirected/list_target/convert_role/militia
	name = "Recruit Militia"
	button_icon_state = "recruit_guard"

	new_role = "Town Militiaman"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Town Militia, %RECRUIT!"
	accept_message = "I swear fealty to protect the town!"

/datum/action/cooldown/spell/undirected/list_target/convert_role/militia/can_convert(mob/living/carbon/human/cast_on)
	. = ..()
	if(!.)
		return

	//only migrants and peasants
	if(!(cast_on.job in GLOB.peasant_positions))
		return FALSE

	return TRUE
