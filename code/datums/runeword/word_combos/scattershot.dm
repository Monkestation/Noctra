/datum/runeword/scattershot
	name = "Scattershot"
	runes = list("eld", "nef", "eth")
	sockets_required = 3
	allowed_items = list(/obj/item/gun)
	combat_effects = list()
	stat_bonuses = list(
		/datum/rune_effect/projectile/extra_projectiles = list(2, 4),
		/datum/rune_effect/projectile/damage_modifier = list(0.5),
		/datum/rune_effect/projectile/random_targeting = list(180),
		/datum/rune_effect/projectile/bounce = list(2),
		/datum/rune_effect/projectile/fork = list(2, 10),
	)
