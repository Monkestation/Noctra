/datum/gem_cut/toxic
	name = "toxic"

/datum/gem_cut/toxic/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/status/poison
	weapon_effect_data = list(multiplier * 12, multiplier * 3)
	armor_effect_type = /datum/rune_effect/status_resistance/poison
	armor_effect_data = list(multiplier * 10)
	shield_effect_type = /datum/rune_effect/all_resistance
	shield_effect_data = list(multiplier * 6)
