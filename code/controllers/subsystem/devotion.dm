GLOBAL_LIST_EMPTY(excommunicated_players)
GLOBAL_LIST_EMPTY(heretical_players)

/// DEFINITIONS ///
#define CLERIC_T0 0
#define CLERIC_T1 1
#define CLERIC_T2 2
#define CLERIC_T3 3

#define CLERIC_REQ_1 80
#define CLERIC_REQ_2 160
#define CLERIC_REQ_3 240

// Cleric Holder Datums

/datum/devotion/cleric_holder
	var/mob/living/carbon/human/holder_mob = null
	var/datum/patron/patron = null
	var/devotion = 0
	var/max_devotion = 1000
	var/max_progression = 1000
	var/progression = 0
	var/level = CLERIC_T0
	/// How much devotion is gained per process call
	var/passive_devotion_gain = 0
	/// How much progression is gained per process call
	var/passive_progression_gain = 0
	/// How much devotion is gained per prayer cycle
	var/prayer_effectiveness = 2

/datum/devotion/cleric_holder/New(mob/living/carbon/human/holder, god)
	. = ..()
	holder_mob = holder
	holder.cleric = src
	patron = god
	if(patron.type == /datum/patron/inhumen/zizo || patron.type == /datum/patron/divine/necra)
		ADD_TRAIT(holder_mob, TRAIT_DEATHSIGHT, "devotion")

/datum/devotion/cleric_holder/Destroy(force)
	. = ..()
	if(patron.type == /datum/patron/inhumen/zizo || patron.type == /datum/patron/divine/necra)
		REMOVE_TRAIT(holder_mob, TRAIT_DEATHSIGHT, "devotion")
	holder_mob?.cleric = null
	holder_mob = null
	patron = null
	STOP_PROCESSING(SSprocessing, src)

/datum/devotion/cleric_holder/process()
	if(!passive_devotion_gain && !passive_progression_gain)
		return PROCESS_KILL
	if(holder_mob.stat >= DEAD)
		return
	update_devotion(passive_devotion_gain, passive_progression_gain)

/datum/devotion/cleric_holder/proc/check_devotion(req)
	if(abs(req) <= devotion)
		return TRUE
	else
		return FALSE

/datum/devotion/cleric_holder/proc/update_devotion(dev_amt, prog_amt)
	var/datum/patron/P = patron
	devotion += dev_amt
	SEND_SIGNAL(holder_mob, COMSIG_LIVING_DEVOTION_CHANGED, dev_amt)
	//Max devotion limit
	if(devotion > max_devotion)
		devotion = max_devotion
	if(!prog_amt) // no point in the rest if it's just an expenditure
		return
	progression += prog_amt
	if(progression > max_progression)
		progression = max_progression
	switch(level)
		if(CLERIC_T0)
			if(progression >= CLERIC_REQ_1)
				level = CLERIC_T1
				if(P.t1)
					holder_mob.add_spell(P.t1, silent = FALSE, source = src)
		if(CLERIC_T1)
			if(progression >= CLERIC_REQ_2)
				level = CLERIC_T2
				if(P.t2)
					holder_mob.add_spell(P.t2, silent = FALSE, source = src)
		if(CLERIC_T2)
			if(progression >= CLERIC_REQ_3)
				level = CLERIC_T3
				if(P.t3)
					holder_mob.add_spell(P.t3, silent = FALSE, source = src)

				to_chat(holder_mob, span_notice("All my Gods miracles are now open to me..."))

/datum/devotion/cleric_holder/proc/grant_spells_churchling(mob/living/carbon/human/H)
	if(!H || !H.mind || !patron)
		return

	if(!(H.patron.type in ALL_PROFANE_PATRONS))
		var/list/spells = list(
			/datum/action/cooldown/spell/undirected/touch/orison/lesser,
			/datum/action/cooldown/spell/healing,
			/datum/action/cooldown/spell/diagnose/holy,
		)

		for(var/datum/action/cooldown/spell/spell as anything in spells)
			H.add_spell(spell, source = src)
	else
		var/list/spells = list(
			/datum/action/cooldown/spell/undirected/touch/orison/lesser,
			/datum/action/cooldown/spell/inhumen_healing,
			/datum/action/cooldown/spell/diagnose/holy,
		)

		for(var/datum/action/cooldown/spell/spell as anything in spells)
			H.add_spell(spell, source = src)

	level = CLERIC_T0
	max_devotion = CLERIC_REQ_1 //Max devotion limit - Churchlings only get diagnose and lesser miracle.
	max_progression = CLERIC_REQ_1

// Priest Spell Spawner
/datum/devotion/cleric_holder/proc/grant_spells_priest(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spells = list(
		A.t0, A.t1, A.t2, A.t3,
		/datum/action/cooldown/spell/undirected/touch/orison,
		/datum/action/cooldown/spell/cure_rot,
	)

	for(var/datum/action/cooldown/spell/spell as anything in spells)
		H.add_spell(spell, source = src)

	level = CLERIC_T3
	passive_devotion_gain = 1 //1 devotion per second
	update_devotion(300, 900)
	START_PROCESSING(SSprocessing, src)

//Acolyte Spell Spawner
/datum/devotion/cleric_holder/proc/grant_spells(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	var/list/spells = list(A.t0, A.t1)

	if(istype(A, /datum/patron/divine/necra))
		spells += /datum/action/cooldown/spell/avert

	for(var/datum/action/cooldown/spell/spell as anything in spells)
		H.add_spell(spell, source = src)

	level = CLERIC_T1

//Cleric Spell Spawner
/datum/devotion/cleric_holder/proc/grant_spells_cleric(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron
	if(!(H.patron.type in ALL_PROFANE_PATRONS))
		var/list/spells = list(
			/datum/action/cooldown/spell/aoe/abrogation,
			A.t0, A.t1,
		)
		if(istype(A, /datum/patron/divine/necra))
			spells += /datum/action/cooldown/spell/avert

		for(var/datum/action/cooldown/spell/spell as anything in spells)
			H.add_spell(spell, source = src)
	else
		var/list/spells = list(
			A.t0,A.t1,/datum/action/cooldown/spell/inhumen_healing,
		)
		for(var/datum/action/cooldown/spell/spell as anything in spells)
			H.add_spell(spell, source = src)

	level = CLERIC_T1
	max_devotion = 250
	max_progression = 250
	update_devotion(50, 50)



//Templar Spell Spawner
/datum/devotion/cleric_holder/proc/grant_spells_templar(mob/living/carbon/human/H)
	if(!H || !H.mind)
		return

	var/datum/patron/A = H.patron

	if(!(H.patron.type in ALL_PROFANE_PATRONS))
		if(istype(A, /datum/patron/divine/necra))
			var/list/spells = list(
				/datum/action/cooldown/spell/aoe/churn_undead,
				/datum/action/cooldown/spell/healing,
			)
			for(var/datum/action/cooldown/spell/spell as anything in spells)
				H.add_spell(spell, source = src)
		else
			var/list/spells = list(
				/datum/action/cooldown/spell/aoe/abrogation,
				A.t0,
			)
			for(var/datum/action/cooldown/spell/spell as anything in spells)
				H.add_spell(spell, source = src)
	else
		var/list/spells = list(
			A.t0,/datum/action/cooldown/spell/inhumen_healing,
		)
		for(var/datum/action/cooldown/spell/spell as anything in spells)
			H.add_spell(spell, source = src)

	level = CLERIC_T0
	max_devotion = 230
	max_progression = 230
	update_devotion(50, 50)

/mob/living/carbon/human/proc/devotionreport()
	set name = "Check Devotion"
	set category = "Cleric"

	if(!ishuman(src))
		return
	var/datum/devotion/cleric_holder/C = src.cleric
	to_chat(src,"My devotion is [C.devotion].")

// Debug verb
/mob/living/carbon/human/proc/devotionchange()
	set name = "(DEBUG)Change Devotion"
	set category = "Special"

	var/datum/devotion/cleric_holder/C = src.cleric
	var/changeamt = input(src, "My devotion is [C.devotion]. How much to change?", "How much to change?") as null|num
	if(!changeamt)
		return
	C.update_devotion(changeamt)

// Generation Procs

/mob/living/carbon/human/proc/clericpray()
	set name = "Give Prayer"
	set category = "Cleric"

	if(!ishuman(src))
		return
	var/datum/devotion/cleric_holder/C = src.cleric
	if(!C || src.stat >= DEAD)
		return
	if(C.devotion >= C.max_devotion)
		to_chat(src, "<font color='red'>I have reached the limit of my devotion...</font>")
		return
	var/prayersesh = 0
	visible_message("[src] kneels their head in prayer.", "I kneel my head in prayer to [patron.name].")
	for(var/i in 1 to 50)
		if(do_after(src, 3 SECONDS, timed_action_flags = (IGNORE_USER_DIR_CHANGE), hidden = FALSE))
			if(C.devotion >= C.max_devotion)
				to_chat(src, "<font color='red'>I have reached the limit of my devotion...</font>")
				break
			var/devotion_multiplier = 1
			if(mind)
				devotion_multiplier += (get_skill_level(/datum/skill/magic/holy) / 4)
			C.update_devotion(floor(C.prayer_effectiveness * devotion_multiplier), floor(C.prayer_effectiveness * devotion_multiplier))
			prayersesh += floor(C.prayer_effectiveness * devotion_multiplier)
		else
			visible_message("[src] concludes their prayer.", "I conclude my prayer.")
			break
	to_chat(src, "<font color='purple'>I gained [prayersesh] devotion!</font>")

/datum/devotion/cleric_holder/proc/excommunicate()
	prayer_effectiveness = 0
	devotion = -1
	to_chat(holder_mob, span_userdanger("I have been excommunicated! The Ten no longer listen to my prayers nor my requests."))
	STOP_PROCESSING(SSprocessing, src)

/datum/devotion/cleric_holder/proc/recommunicate()
	prayer_effectiveness = initial(prayer_effectiveness)
	devotion = 0
	to_chat(holder_mob, span_boldnotice("I have been welcomed back into the folds of the Ten."))
	if(passive_devotion_gain || passive_progression_gain)
		START_PROCESSING(SSprocessing, src)

#undef CLERIC_T0
#undef CLERIC_T1
#undef CLERIC_T2
#undef CLERIC_T3

#undef CLERIC_REQ_1
#undef CLERIC_REQ_2
#undef CLERIC_REQ_3
