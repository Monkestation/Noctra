/datum/gem_effect/dorpel
	possible_cuts = list(
		/datum/gem_cut/radiant,
		/datum/gem_cut/sanctified,
		/datum/gem_cut/divine,
	)

/datum/gem_effect/dorpel/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/damage/holy, "data_template" = list(1, list(3, 5), 0)),
		list("type" = /datum/rune_effect/stat/force, "data_template" = list(list(2, 4)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/all_resistance, "data_template" = list(list(2, 5))),
		list("type" = /datum/rune_effect/player_stat/constitution, "data_template" = list(list(1, 2)))
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/all_resistance, "data_template" = list(list(3, 6))),
		list("type" = /datum/rune_effect/reflection, "data_template" = list(list(5, 15))),
		list("type" = /datum/rune_effect/stat/lightweight, "data_template" = list(list(2, 4)))
	)

	..()
