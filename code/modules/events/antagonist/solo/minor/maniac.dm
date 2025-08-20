/datum/round_event_control/antagonist/solo/maniac
	name = "Maniacs"
	tags = list(
		TAG_VILLIAN,
		TAG_HAUNTED
	)
	antag_datum = /datum/antagonist/maniac
	roundstart = TRUE
	antag_flag = ROLE_MANIAC
	shared_occurence_type = SHARED_MINOR_THREAT
	minor_roleset = TRUE

	restricted_roles = list(
		"Monarch",
		"Consort",
		"Priest",
		"Orphan",
		"Churchling",
		"Innkeepers Son",
		"Captain",
		"Hand",
		"Forest Warden",
		"Royal Knight",
		"Templar",
		"Bandit"
	)

	base_antags = 1
	maximum_antags = 2

	earliest_start = 0 SECONDS

	weight = 9

	typepath = /datum/round_event/antagonist/solo/maniac

/datum/round_event_control/antagonist/solo/maniac/canSpawnEvent(players_amt, gamemode, fake_check)
	if(GLOB.maniac_highlander) // Has a Maniac already TRIUMPHED?
		return FALSE
	. = ..()

/datum/round_event_control/antagonist/solo/maniac/midround
	name = "Maniacs Midround"
	roundstart = FALSE
	weight = 4
	base_antags = 1
	earliest_start = 1 HOURS
	maximum_antags = 2
	typepath = /datum/round_event/antagonist/solo/maniac/midround

/datum/round_event/antagonist/solo/maniac/midround

/datum/round_event_control/antagonist/solo/maniac/midround/get_candidates()
	. = ..()
	var/list/possible_candidates = . //typecasting
	var/list/weighted_list = list()
	var/list/final_candidates = list()

	for(var/mob/living/carbon/human/M in possible_candidates)
		var/stress = M.get_stress_amount()
		var/stressweight = 1
		if(stress >= STRESS_INSANE)
			stressweight = 10
		else if(stress >= STRESS_VBAD)
			stressweight = 5
		else if(stress >= STRESS_BAD)
			stressweight = 3
		weighted_list[M] = stressweight

	for(var/i in 1 to maximum_antags)
		var/M = pickweight(weighted_list)
		if(!length(weighted_list))
			break
		weighted_list -= M
		final_candidates += M
	return final_candidates
