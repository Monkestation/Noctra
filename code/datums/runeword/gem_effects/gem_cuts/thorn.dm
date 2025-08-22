/datum/gem_cut/thorn
	name = "thorn"

/datum/gem_cut/thorn/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/status/bleed
	weapon_effect_data = list(multiplier * 10, multiplier * 2)
	armor_effect_type = /datum/rune_effect/player_stat/constitution
	armor_effect_data = list(multiplier * 2)
	shield_effect_type = /datum/rune_effect/reflection
	shield_effect_data = list(multiplier * 12)
