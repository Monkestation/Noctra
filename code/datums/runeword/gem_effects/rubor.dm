/datum/gem_effect/rubor
	possible_cuts = list(
		/datum/gem_cut/inferno,
		/datum/gem_cut/flame,
	)
/datum/gem_effect/rubor/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/damage/fire, "data_template" = list(1, list(2, 4), 0)),
		list("type" = /datum/rune_effect/status/ignite, "data_template" = list(list(6, 10), 1)),
		list("type" = /datum/rune_effect/stat/force, "data_template" = list(list(1, 3)))
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/resistance/fire, "data_template" = list(list(4, 8))),
		list("type" = /datum/rune_effect/stat/rarity, "data_template" = list(list(1, 2)))
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/resistance/fire, "data_template" = list(list(4, 8), list(1, 3)))
	)

	. = ..()
