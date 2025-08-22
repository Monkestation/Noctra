/datum/gem_effect/gemerald
	possible_cuts = list(
		/datum/gem_cut/toxic,
		/datum/gem_cut/verdant,
		/datum/gem_cut/thorn,
	)

/datum/gem_effect/gemerald/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/status/poison, "data_template" = list(list(5, 9), 1)),
		list("type" = /datum/rune_effect/status/bleed, "data_template" = list(list(4, 8), 1)),
		list("type" = /datum/rune_effect/stat/force, "data_template" = list(list(1, 3)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/status_resistance/poison, "data_template" = list(list(4, 8))),
		list("type" = /datum/rune_effect/player_stat/constitution, "data_template" = list(list(1, 2)))
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/all_resistance, "data_template" = list(list(2, 4)))
	)

	..()
