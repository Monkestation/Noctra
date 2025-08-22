/datum/runeword/flamebrand
	name = "Flamebrand"
	runes = list("tir", "ral")
	sockets_required = 2
	allowed_items = list(/obj/item/weapon)
	stat_bonuses = list(
		/datum/rune_effect/stat/force = list(5),
		/datum/rune_effect/stat/throw_force = list(3),
		/datum/rune_effect/melee_orbital = list(3)
	)
	combat_effects = list(
		/datum/rune_effect/damage/fire = list(3, 8)
	)
	spell_actions = list(/datum/action/cooldown/spell/projectile/fireball)
