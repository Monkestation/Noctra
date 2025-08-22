/datum/gem_cut/verdant
	name = "verdant"

/datum/gem_cut/verdant/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/life_steal
	weapon_effect_data = list(multiplier * 6)
	armor_effect_type = /datum/rune_effect/player_stat/constitution
	armor_effect_data = list(multiplier * 2)
	shield_effect_type = /datum/rune_effect/all_resistance
	shield_effect_data = list(multiplier * 4)
