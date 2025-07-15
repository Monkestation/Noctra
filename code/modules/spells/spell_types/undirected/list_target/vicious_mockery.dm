/datum/action/cooldown/spell/undirected/list_target/vicious_mockery
	name = "Vicious Mockery"
	desc = "Make a fool of a target and enrage them."
	button_icon_state = "tragedy"
	sound = 'sound/magic/mockery.ogg'

	associated_skill = /datum/skill/misc/music

	spell_type = SPELL_NONE
	cooldown_time = 30 SECONDS

	choose_target_message = "Choose who to mock."

/datum/action/cooldown/spell/undirected/list_target/vicious_mockery/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/undirected/list_target/vicious_mockery/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	var/message

	if(owner.cmode && ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(H.dna?.species)
			message = pick_list_replacements("bard.json", "[H.dna.species.id]_mockery")
	else
		message = browser_input_text(owner, "How will I mock this fool?", "XYLIX")
		if(QDELETED(src) || QDELETED(owner) || QDELETED(cast_on) || !can_cast_spell())
			return . | SPELL_CANCEL_CAST

	if(!message)
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

	invocation = message

/datum/action/cooldown/spell/undirected/list_target/vicious_mockery/cast(mob/living/cast_on)
	. = ..()
	if(cast_on.can_hear())
		SEND_SIGNAL(owner, COMSIG_VICIOUSLY_MOCKED, cast_on)
		cast_on.apply_status_effect(/datum/status_effect/debuff/viciousmockery)
		GLOB.vanderlin_round_stats[STATS_PEOPLE_MOCKED]++
