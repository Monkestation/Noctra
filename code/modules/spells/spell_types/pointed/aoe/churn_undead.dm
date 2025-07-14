/datum/action/cooldown/spell/aoe/churn_undead
	name = "Churn Undead"
	desc = ""
	button_icon_state = "necra"
	sound = 'sound/magic/churn.ogg'
	charge_sound = 'sound/magic/holycharging.ogg'

	cast_range = 5
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/necra)

	invocation = "The Undermaiden rebukes!"
	invocation_type = INVOCATION_SHOUT

	charge_required = FALSE
	cooldown_time = 35 SECONDS
	spell_cost = 60

	aoe_radius = 4

/datum/action/cooldown/spell/aoe/churn_undead/is_valid_target(atom/cast_on)
	return isliving(cast_on)

/datum/action/cooldown/spell/aoe/churn_undead/cast_on_thing_in_aoe(mob/living/victim, atom/caster)
	if(victim.stat == DEAD)
		return
	if(victim.mind)
		if(victim.mind.has_antag_datum(/datum/antagonist/vampire/lord))
			victim.visible_message(span_warning("[victim] overpowers being churned!"), span_greentext("I overpower being churned!"))
			to_chat(owner, span_userdanger("[victim] is too strong, I am churned!"))
			if(isliving(owner))
				var/mob/living/fool = owner
				fool.Stun(50)
			owner.throw_at(get_ranged_target_turf(owner, get_dir(owner, victim), 7), 7, 1, victim, spin = FALSE)
			return
	if((victim.mob_biotypes & MOB_UNDEAD))
		var/prob2explode = 10 * owner.get_skill_level(associated_skill)
		if(prob(prob2explode))
			victim.visible_message(span_warning("[victim] HAS BEEN CHURNED BY NECRA'S GRIP!"), span_userdanger("I'VE BEEN CHURNED BY NECRA'S GRIP!"))
			explosion(get_turf(victim), light_impact_range = 1, flash_range = 1, smoke = FALSE)
			victim.Stun(50)
		else
			victim.visible_message(span_warning("[victim] resists being churned!"), span_greentext("I resist being churned!"))
