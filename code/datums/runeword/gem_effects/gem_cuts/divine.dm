/datum/gem_cut/divine
	name = "divine"

/datum/gem_cut/divine/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/holy
	weapon_effect_data = list(multiplier, multiplier * 4, 0)
	armor_effect_type = /datum/rune_effect/all_resistance
	armor_effect_data = list(multiplier * 4)
	shield_effect_type = /datum/rune_effect/all_resistance
	shield_effect_data = list(multiplier * 5)
