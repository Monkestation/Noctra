/datum/gem_cut/vampiric
	name = "vampiric"

/datum/gem_cut/vampiric/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/life_steal
	weapon_effect_data = list(multiplier * 12)
	armor_effect_type = /datum/rune_effect/all_resistance
	armor_effect_data = list(multiplier * 5)
	shield_effect_type = /datum/rune_effect/fear_aura
	shield_effect_data = list(multiplier * 15)
