/datum/rune_effect/life_steal
	ranged = TRUE
	var/stealing_amount = 0

/datum/rune_effect/life_steal/get_description()
	return "Steals [stealing_amount] life per hit."

/datum/rune_effect/life_steal/get_group_key()
	return "lifesteal"

/datum/rune_effect/life_steal/get_combined_description(list/effects)
	var/total_min = 0
	for(var/datum/rune_effect/life_steal/effect in effects)
		total_min += effect.stealing_amount
	return "Steals [total_min] life per hit."

/datum/rune_effect/life_steal/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		stealing_amount = effects[1]

/datum/rune_effect/life_steal/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	if(isliving(user) && isliving(target))
		if(target.stat != DEAD)
			user.heal_ordered_damage(stealing_amount, list(BRUTE, BURN, OXY))
