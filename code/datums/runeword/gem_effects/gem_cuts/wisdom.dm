/datum/gem_cut/wisdom
	name = "wisdom"

/datum/gem_cut/wisdom/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/player_stat/intelligence
	weapon_effect_data = list(multiplier * 4)
	armor_effect_type = /datum/rune_effect/player_stat/intelligence
	armor_effect_data = list(multiplier * 2)
	shield_effect_type = /datum/rune_effect/resistance/cold
	shield_effect_data = list(multiplier * 8, multiplier * 2)
