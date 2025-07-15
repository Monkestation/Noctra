/datum/action/cooldown/spell/projectile/swordfish
	name = "Abyssor's Rage"
	desc = "Throw a swordfish from Abyssor's domain."
	button_icon_state = "curse2"
	sound = 'sound/magic/whiteflame.ogg'

	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy
	required_items = list(/obj/item/clothing/neck/psycross/silver/abyssor)

	invocation = "Feel Abyssor's rage!"
	invocation_type = INVOCATION_SHOUT

	charge_time = 2 SECONDS
	cooldown_time = 15 SECONDS
	spell_cost = 35

	projectile_type = /obj/projectile/magic/swordfish

//esssentially a magic throwing knife
/obj/projectile/magic/swordfish
	name = "swordfish"
	desc = "But one enactor of Abyssor's rage."
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "swordfish_proj"
	damage = DAMAGE_DAGGER * 2
	nodamage = FALSE
	damage_type = BRUTE
	range = 10
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 15
	armor_penetration = 10
	woundclass = BCLASS_STAB
	flag = "piercing"
	speed = 0.4
	impact_effect_type = null
	dropped = /obj/item/reagent_containers/food/snacks/fish/swordfish

/obj/item/reagent_containers/food/snacks/fish/swordfish
	name = "swordfish"
	desc = "But one enactor of Abyssor's rage."
	icon = 'icons/roguetown/misc/fish.dmi'
	icon_state = "swordfishcom"
	force = DAMAGE_DAGGER
	dropshrink = 0.8
	possible_item_intents = list(/datum/intent/dagger/thrust, /datum/intent/food)
