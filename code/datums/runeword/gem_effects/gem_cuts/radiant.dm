/datum/gem_cut/radiant
	name = "radiant"

/datum/gem_cut/radiant/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/holy
	weapon_effect_data = list(multiplier * 2, multiplier * 7, multiplier)
	armor_effect_type = /datum/rune_effect/player_stat/constitution
	armor_effect_data = list(multiplier * 2)
	shield_effect_type = /datum/rune_effect/stat/lightweight
	shield_effect_data = list(multiplier * 5)
