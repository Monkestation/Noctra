/datum/rune_effect/mana_drain
	ranged = TRUE
	var/stealing_amount = 0

/datum/rune_effect/mana_drain/get_description()
	return "Steals [stealing_amount] mana per hit."

/datum/rune_effect/mana_drain/get_group_key()
	return "mana"

/datum/rune_effect/mana_drain/get_combined_description(list/effects)
	var/total_min = 0
	for(var/datum/rune_effect/mana_drain/effect in effects)
		total_min += effect.stealing_amount
	return "Steals [total_min] mana per hit."

/datum/rune_effect/mana_drain/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		stealing_amount = effects[1]

/datum/rune_effect/mana_drain/apply_combat_effect(mob/living/target, mob/living/carbon/user, damage_dealt)
	if(isliving(user) && isliving(target))
		if(target.stat != DEAD)
			user.safe_adjust_personal_mana(stealing_amount)
