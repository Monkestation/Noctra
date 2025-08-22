/datum/gem_cut/glacier
	name = "glacier"

/datum/gem_cut/glacier/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/cold
	weapon_effect_data = list(multiplier * 2, multiplier * 6, multiplier)
	armor_effect_type = /datum/rune_effect/resistance/cold
	armor_effect_data = list(multiplier * 10)
	shield_effect_type = /datum/rune_effect/resistance/cold
	shield_effect_data = list(multiplier * 12, multiplier * 4)

