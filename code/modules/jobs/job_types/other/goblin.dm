/datum/job/goblin
	title = "Goblin"
	tutorial = ""
	//department_flag = PEASANTS
	job_flags = (JOB_EQUIP_RANK)
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0

	allowed_races = RACES_PLAYER_ALL
	spawn_type = /mob/living/carbon/human/species/goblin/cave
	outfit = /datum/outfit/job/npc/goblin
	give_bank_account = FALSE

/datum/job/goblin/after_spawn(mob/living/spawned, client/player_client)
	..()

	var/mob/living/carbon/human/H = spawned
	if(spawned.mind)
		spawned.mind.special_role = "goblin"
		spawned.mind.current.job = null
	if(H.charflaw)
		QDEL_NULL(H.charflaw)
	H.faction = list(FACTION_ORCS)
	H.name = "goblin"
	H.real_name = "goblin"
	ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	H.remove_all_languages()
	H.grant_language(/datum/language/hellspeak)
