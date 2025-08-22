/datum/gem_cut/flame
	name = "flame"

/datum/gem_cut/flame/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/fire
	weapon_effect_data = list(multiplier * 2, multiplier * 6, 0)
	armor_effect_type = /datum/rune_effect/resistance/fire
	armor_effect_data = list(multiplier * 8)
	shield_effect_type = /datum/rune_effect/resistance/fire
	shield_effect_data = list(multiplier * 10, multiplier * 3)
