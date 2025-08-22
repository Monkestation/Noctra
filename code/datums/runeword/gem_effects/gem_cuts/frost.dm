/datum/gem_cut/frost
	name = "frost"

/datum/gem_cut/frost/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/status/chill
	weapon_effect_data = list(multiplier * 15, multiplier * 2)
	armor_effect_type = /datum/rune_effect/resistance/cold
	armor_effect_data = list(multiplier * 8)
	shield_effect_type = /datum/rune_effect/resistance/cold
	shield_effect_data = list(multiplier * 10, multiplier * 3)
