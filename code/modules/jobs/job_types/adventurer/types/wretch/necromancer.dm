/datum/advclass/wretch/necromancer
	name = "Necromancer"
	tutorial = "You have been ostracized and hunted by society for your dark magics and perversion of life."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/necromancer
	category_tags = list(CTAG_WRETCH)
	cmode_music = 'sound/music/cmode/antag/CombatLich.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/wretch/necromancer/pre_equip(mob/living/carbon/human/H)
	..()
	H.set_patron(/datum/patron/inhumen/zizo) //Zizo only, obviously.
	H.mind.current.faction += FACTION_CABAL
	H.mana_pool?.intrinsic_recharge_sources &= ~MANA_ALL_LEYLINES
	H.mana_pool?.set_intrinsic_recharge(MANA_SOULS)
	H.mana_pool?.ethereal_recharge_rate += 0.1
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
	head = /obj/item/clothing/head/helmet/skullcap/cult
	pants = /obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/shortboots
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/shirt/robe/necromancer
	shirt = /obj/item/clothing/shirt/tunic/colored
	wrists = /obj/item/clothing/wrists/bracers
	gloves = /obj/item/clothing/gloves/chain
	belt = /obj/item/storage/belt/leather/black
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/reagent_containers/glass/bottle/manapot
	r_hand = /obj/item/weapon/polearm/woodstaff
	backpack_contents = list(
		/obj/item/book/granter/spellbook/adept = 1,
		/obj/item/chalk = 1,
		/obj/item/rope/chain = 1,
		/obj/item/reagent_containers/glass/bottle/stronghealthpot = 1,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/weapon/knife/dagger/silver/arcyne = 1
	)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_INT, 4)
	H.adjust_spell_points(7)
	H.grant_language(/datum/language/undead)
	H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
	H.add_spell(/datum/action/cooldown/spell/eyebite)
	H.add_spell(/datum/action/cooldown/spell/projectile/sickness)
	H.add_spell(/datum/action/cooldown/spell/conjure/raise_lesser_undead/necromancer)
	H.add_spell(/datum/action/cooldown/spell/gravemark)
	ADD_TRAIT(H, TRAIT_CABAL, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INHUMENCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	wretch_select_bounty(H)
