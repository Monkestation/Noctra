/datum/gem_cut/shadow
	name = "shadow"

/datum/gem_cut/shadow/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/necrotic
	weapon_effect_data = list(multiplier * 1, multiplier * 4)
	armor_effect_type = /datum/rune_effect/all_resistance
	armor_effect_data = list(multiplier * 5)
	shield_effect_type = /datum/rune_effect/fear_aura
	shield_effect_data = list(multiplier * 8)
