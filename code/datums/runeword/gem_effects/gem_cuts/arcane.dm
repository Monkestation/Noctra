/datum/gem_cut/arcane
	name = "arcane"

/datum/gem_cut/arcane/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/mana_drain
	weapon_effect_data = list(multiplier * 8, multiplier * 2)
	armor_effect_type = /datum/rune_effect/resistance/cold
	armor_effect_data = list(multiplier * 12)
	shield_effect_type = /datum/rune_effect/resistance/cold
	shield_effect_data = list(multiplier * 8, multiplier * 2)
