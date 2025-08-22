/datum/gem_cut/storm
	name = "storm"

/datum/gem_cut/storm/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/damage/lightning
	weapon_effect_data = list(multiplier * 2, multiplier * 5, 0)
	armor_effect_type = /datum/rune_effect/stat/rarity
	armor_effect_data = list(multiplier * 4)
	shield_effect_type = /datum/rune_effect/resistance/lightning
	shield_effect_data = list(multiplier * 8, multiplier * 3)

