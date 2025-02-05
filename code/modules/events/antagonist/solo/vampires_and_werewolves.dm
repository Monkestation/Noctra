/datum/round_event_control/antagonist/solo/vampires_and_werewolves
	name = "Vampires and Verevolves"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_NBEAST
	shared_occurence_type = SHARED_HIGH_THREAT

	base_antags = 2
	maximum_antags = 4

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/vampires_and_werewolves

	restricted_roles = list(
		"Monarch",
		"Consort",
		"Dungeoneer",
		"Inquisitor",
		"Men-at-arms",
		"Merchant",
		"Priest",
		"Acolyte",
		"Adepts",
		"Templar",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Feldsher",
		"Town Elder",
		"Captain",
		"Archivist",
		"Merchant",
		"Royal Knight",
		"Garrison Guard",
		"Jailor",
		"Court Magician",
		"Forest Warden",
		"Inquisitor",
		"Adepts",
		"Forest Guard",
		"Squire",
		"Veteran",
		"Apothecary"
	)


/datum/round_event/antagonist/solo/vampires_and_werewolves/start()
	var/vampire = FALSE
	for(var/datum/mind/antag_mind as anything in setup_minds)
		if(vampire)
			add_vampire(antag_mind)
		else
			add_werewolf(antag_mind, antag_mind.current)
		vampire = !vampire

/datum/round_event/antagonist/solo/proc/add_vampire(datum/mind/antag_mind)
	antag_mind.add_antag_datum(/datum/antagonist/werewolf)
	antag_mind.special_role = "werewolf"
	antag_mind.assigned_role = "werewolf"

/datum/round_event/antagonist/solo/proc/add_werewolf(datum/mind/antag_mind)
	antag_mind.add_antag_datum(/datum/antagonist/vampirelord)
	antag_mind.special_role = "vampire"
	antag_mind.assigned_role = "vampire"
