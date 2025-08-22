/datum/gem_cut/sanctified
	name = "sanctified"

/datum/gem_cut/sanctified/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/holy
	weapon_effect_data = list(multiplier, multiplier * 4, 0)
	armor_effect_type = /datum/rune_effect/all_resistance
	armor_effect_data = list(multiplier * 6)
	shield_effect_type = /datum/rune_effect/reflection
	shield_effect_data = list(multiplier * 20)
