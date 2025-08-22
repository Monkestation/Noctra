/datum/gem_cut/winter
	name = "winter"

/datum/gem_cut/winter/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/cold
	weapon_effect_data = list(multiplier * 2, multiplier * 5, 0)
	armor_effect_type = /datum/rune_effect/resistance/cold
	armor_effect_data = list(multiplier * 6)
	shield_effect_type = /datum/rune_effect/resistance/cold
	shield_effect_data = list(multiplier * 8, multiplier * 2)
