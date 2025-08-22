/datum/gem_cut/inferno
	name = "inferno"

/datum/gem_cut/inferno/setup_cut(multiplier)
	weapon_effect_type = /datum/rune_effect/status/ignite
	weapon_effect_data = list(multiplier * 12, multiplier * 2)
	armor_effect_type = /datum/rune_effect/resistance/fire
	armor_effect_data = list(multiplier * 6)
	shield_effect_type = /datum/rune_effect/resistance/fire
	shield_effect_data = list(multiplier * 8, multiplier * 2)
