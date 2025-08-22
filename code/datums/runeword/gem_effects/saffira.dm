/datum/gem_effect/saffira
	possible_cuts = list(
		/datum/gem_cut/arcane,
		/datum/gem_cut/wisdom,
		/datum/gem_cut/glacier,
	)

/datum/gem_effect/saffira/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/damage/cold, "data_template" = list(1, list(2, 4), 0)),
		list("type" = /datum/rune_effect/mana_drain, "data_template" = list(list(3, 6), 1)),
		list("type" = /datum/rune_effect/player_stat/intelligence, "data_template" = list(list(1, 3)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/resistance/cold, "data_template" = list(list(4, 7))),
		list("type" = /datum/rune_effect/player_stat/intelligence, "data_template" = list(list(1, 3))),
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/resistance/cold, "data_template" = list(list(4, 8), list(1, 3))),
	)

	..()
