/datum/action/cooldown/spell/conjure/raise_lesser_undead
	name = "Raise Lesser undead"
	desc = "Summons a temporary skeleton to aid you."
	button_icon_state = "animate"
	self_cast_possible = FALSE
	sound = 'sound/magic/magnet.ogg'

	charge_time = 2 SECONDS
	charge_drain = 1
	charge_slowdown = 1.3
	cooldown_time = 6 MINUTES
	spell_cost = 70
	summon_type = list(/mob/living/simple_animal/hostile/skeleton)
	summon_radius = 0
	summon_lifespan = 5 MINUTES
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

/datum/action/cooldown/spell/conjure/raise_lesser_undead/post_summon(atom/summoned_object, atom/cast_on)
	var/mob/living/skeleton = summoned_object
	skeleton.befriend(owner)

	if(isliving(cast_on))
		var/mob/living/L = cast_on
		if(L.stat != DEAD)
			skeleton.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, L)
		return
	for(var/mob/living/L in get_turf(cast_on))
		if(L.stat == DEAD)
			continue
		skeleton.ai_controller?.set_blackboard_key(BB_BASIC_MOB_PRIORITY_TARGETS, L)
		break
