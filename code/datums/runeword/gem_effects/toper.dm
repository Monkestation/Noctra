/datum/gem_effect/toper
	possible_cuts = list(
		/datum/gem_cut/storm,
	)

/datum/gem_effect/toper/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/damage/lightning, "data_template" = list(1, list(2, 4), 0)),
		list("type" = /datum/rune_effect/stat/rarity, "data_template" = list(list(1, 3)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/resistance/lightning, "data_template" = list(list(3, 6))),
		list("type" = /datum/rune_effect/stat/rarity, "data_template" = list(list(2, 4)))
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/resistance/lightning, "data_template" = list(list(3, 6), list(1, 2)))
	)

	..()
