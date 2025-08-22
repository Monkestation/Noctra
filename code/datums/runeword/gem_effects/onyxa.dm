/datum/gem_effect/onyxa
	possible_cuts = list(
		/datum/gem_cut/vampiric,
		/datum/gem_cut/shadow,
		/datum/gem_cut/cursed,
	)

/datum/gem_effect/onyxa/initialize_effects()
	possible_weapon_effects = list(
		list("type" = /datum/rune_effect/life_steal, "data_template" = list(list(5, 10))),
		list("type" = /datum/rune_effect/damage/necrotic, "data_template" = list(1, list(2, 4), 0)),
	)

	possible_armor_effects = list(
		list("type" = /datum/rune_effect/all_resistance, "data_template" = list(list(5, 10))),
	)

	possible_shield_effects = list(
		list("type" = /datum/rune_effect/fear_aura, "data_template" = list(list(3, 8))),
	)

	..()
