/datum/rune_effect/resistance
	var/resistance_type = FIRE_DAMAGE
	var/resistance_value = 0
	var/max_resistance_bonus = 0

/datum/rune_effect/resistance/get_description()
	return "+[resistance_value]% [name]"

/datum/rune_effect/resistance/get_combined_description(list/effects)
	var/total_resistance = 0
	for(var/datum/rune_effect/resistance/effect in effects)
		total_resistance += effect.resistance_value
	return "+[total_resistance]% [name]"

/datum/rune_effect/resistance/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		resistance_value = effects[1]
	if(effects.len >= 2)
		max_resistance_bonus = effects[2]

/datum/rune_effect/resistance/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	switch(resistance_type)
		if(FIRE_DAMAGE)
			source.fire_res += resistance_value
			source.max_fire_res += max_resistance_bonus
		if(COLD_DAMAGE)
			source.cold_res += resistance_value
			source.max_cold_res += max_resistance_bonus
		if(LIGHTNING_DAMAGE)
			source.lightning_res += resistance_value
			source.max_lightning_res += max_resistance_bonus

/datum/rune_effect/resistance/fire
	name = "fire resistance"
	resistance_type = FIRE_DAMAGE

/datum/rune_effect/resistance/cold
	name = "cold resistance"
	resistance_type = COLD_DAMAGE

/datum/rune_effect/resistance/lightning
	name = "lightning resistance"
	resistance_type = LIGHTNING_DAMAGE


/datum/rune_effect/all_resistance
	var/resistance_value = 0

/datum/rune_effect/all_resistance/get_combined_description(list/effects)
	var/total_resistance = 0
	for(var/datum/rune_effect/all_resistance/effect in effects)
		total_resistance += effect.resistance_value
	return "+[total_resistance]% all resistance"

/datum/rune_effect/all_resistance/get_description()
	return "+[resistance_value]% all resistance"

/datum/rune_effect/all_resistance/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		resistance_value = effects[1]

/datum/rune_effect/all_resistance/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	source.fire_res += resistance_value
	source.cold_res += resistance_value
	source.lightning_res += resistance_value
