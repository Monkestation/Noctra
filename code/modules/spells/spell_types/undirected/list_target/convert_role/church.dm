/datum/action/cooldown/spell/undirected/list_target/convert_role/templar
	name = "Recruit Templar"
	button_icon_state = "recruit_templar"

	new_role = "Templar"
	recruitment_faction = "Church"
	recruitment_message = "Serve the Ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."

/datum/action/cooldown/spell/undirected/list_target/convert_role/templar/on_conversion(mob/living/carbon/human/cast_on)
	. = ..()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(cast_on, cast_on.patron)
	C.grant_spells_templar(cast_on)
	cast_on.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)


/datum/action/cooldown/spell/undirected/list_target/convert_role/templar/cast(mob/living/carbon/human/cast_on)
	// Patron-specific checks happen here, AFTER priest picks the target
	var/mob/living/living_owner = owner

	if(cast_on.patron && (cast_on.patron.type in ALL_PROFANE_PATRONS))
		to_chat(owner, span_danger("The Ten glare upon you in fury. CHILD, [cast_on.real_name] serves the Inhumen, do not disgrace Our name."))
		living_owner.adjust_divine_fire_stacks(50) // Half of the damage that you get if you say a profane word, hurts alot.
		living_owner.IgniteMob()
		return // Stop the recruitment entirely

	if(cast_on.patron && (cast_on.patron.type == /datum/patron/psydon))
		to_chat(owner, span_info("The Ten glare upon you in sadness. CHILD, [cast_on.real_name] serves Psydon, he is dead, nobody can answer these prayers."))
		return // Stop recruitment

	return ..()



/datum/action/cooldown/spell/undirected/list_target/convert_role/acolyte
	name = "Recruit Acolyte"
	button_icon_state = "recruit_acolyte"

	new_role = "Acolyte"
	recruitment_faction = "Church"
	recruitment_message = "Serve the Ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."


/datum/action/cooldown/spell/undirected/list_target/convert_role/acolyte/cast(mob/living/carbon/human/cast_on)
	// Patron-specific checks happen here, AFTER priest picks the target
	var/mob/living/living_owner = owner

	if(cast_on.patron && (cast_on.patron.type in ALL_PROFANE_PATRONS))
		to_chat(owner, span_danger("The Ten glare upon you in fury. CHILD, [cast_on.real_name] serves the Inhumen, do not disgrace Our name."))
		living_owner.adjust_divine_fire_stacks(50) // Half of the damage that you get if you say a profane word, hurts alot.
		living_owner.IgniteMob()
		return // Stop the recruitment entirely

	if(cast_on.patron && (cast_on.patron.type == /datum/patron/psydon))
		to_chat(owner, span_info("The Ten glare upon you in sadness. CHILD, [cast_on.real_name] serves Psydon, he is dead, nobody can answer these prayers."))
		return // Stop recruitment

	return ..()


/datum/action/cooldown/spell/undirected/list_target/convert_role/acolyte/on_conversion(mob/living/carbon/human/cast_on)
	. = ..()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(cast_on, cast_on.patron)
	C.grant_spells(cast_on)
	cast_on.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/action/cooldown/spell/undirected/list_target/convert_role/churchling
	name = "Recruit Churchling"
	button_icon_state = "recruit_acolyte"

	new_role = "Churchling"
	recruitment_faction = "Church"
	recruitment_message = "Serve the Ten, %RECRUIT!"
	accept_message = "FOR THE TEN!"
	refuse_message = "I refuse."


/datum/action/cooldown/spell/undirected/list_target/convert_role/churchling/cast(mob/living/carbon/human/cast_on)
	// Patron-specific checks happen here, AFTER priest picks the target
	if(cast_on.patron && (cast_on.patron.type == /datum/patron/psydon))
		to_chat(owner, span_info("The Ten glare upon you in sadness. CHILD, [cast_on.real_name] serves Psydon, he is dead, nobody can answer these prayers."))
		return // Stop recruitment

	return ..()


/datum/action/cooldown/spell/undirected/list_target/convert_role/churchling/on_conversion(mob/living/carbon/human/cast_on)
	. = ..()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(cast_on, cast_on.patron)
	C.grant_spells_churchling(cast_on)
	cast_on.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

/datum/action/cooldown/spell/undirected/list_target/convert_role/churchling/can_convert(mob/living/carbon/human/cast_on)
	if(QDELETED(cast_on))
		return FALSE
	//need a mind
	if(!cast_on.mind)
		return FALSE
	//only orphans who aren't apprentices
	if(istype(cast_on.mind.assigned_role, /datum/job/orphan) && cast_on.is_apprentice())
		return FALSE
	if(cast_on.age != AGE_CHILD)
		return FALSE
	//need to see their damn face
	if(!cast_on.get_face_name(null))
		return FALSE
	return TRUE
