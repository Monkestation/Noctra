/datum/round_event_control/zizo_defilement
	name = "Zizo's Defilement"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/zizo_defilement
	weight = 8
	earliest_start = 20 MINUTES
	max_occurrences = 2
	min_players = 30
	allowed_storytellers = list(/datum/storyteller/zizo)

/datum/round_event/zizo_defilement/start()
	SSmapping.add_world_trait(/datum/world_trait/zizo_defilement, 15 MINUTES)

	if(is_ascendant(ZIZO))
		for(var/mob/living/carbon/human/potential_zombie as anything in GLOB.human_list)
			if(potential_zombie.stat != DEAD)
				continue
			if(potential_zombie.mind?.has_antag_datum(/datum/antagonist/zombie))
				continue
			var/datum/antagonist/zombie/zombie_datum = potential_zombie.zombie_check()
			if(!zombie_datum)
				continue
			zombie_datum.wake_zombie()
			to_chat(potential_zombie, span_danger("An overwhelming power of Zizo commands you! RISE AND RAVAGE!"))
