/datum/gem_effect/blortz
	possible_cuts = list(
		/datum/gem_cut/frost,
		/datum/gem_cut/winter
	)

/datum/gem_effect/blortz/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/status/chill, "data_template" = list(list(8, 12), 1)),
		list("type" = /datum/rune_effect/damage/cold, "data_template" = list(1, list(2, 4), 0)),
		list("type" = /datum/rune_effect/stat/force, "data_template" = list(list(1, 3)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/resistance/cold, "data_template" = list(list(3, 7))),
		list("type" = /datum/rune_effect/stat/force, "data_template" = list(list(1, 3)))
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/resistance/cold, "data_template" = list(list(4, 8), list(1, 3)))
	)

	. = ..()
