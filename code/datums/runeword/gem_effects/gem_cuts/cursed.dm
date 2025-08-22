/datum/gem_cut/cursed
	name = "cursed"

/datum/gem_cut/cursed/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/life_steal
	weapon_effect_data = list(multiplier * 12)
	armor_effect_type = /datum/rune_effect/all_resistance
	armor_effect_data = list(multiplier * 5)
	shield_effect_type = /datum/rune_effect/fear_aura
	shield_effect_data = list(multiplier * 10)
