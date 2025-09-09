/datum/advclass/wretch/hedgemage
	name = "Hedge Mage"
	tutorial = "They reject your genius, they cast you out, they call you unethical. They do not understand the SACRIFICES you must make. But it does not matter anymore, your power eclipse any of those fools, save for the Court Magos themselves. Show them true magic."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/hedgemage
	category_tags = list(CTAG_WRETCH)

	cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'
	maximum_possible_slots = 2

/datum/outfit/job/wretch/hedgemage
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo)

/datum/outfit/job/wretch/hedgemage/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	head = /obj/item/clothing/head/roguehood/colored/black
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/robe/colored/black
	belt = /obj/item/storage/belt/leather/rope
	neck = /obj/item/clothing/neck/mana_star //Stolen from the academy, dude trust
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/storage/magebag/apprentice
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	backpack_contents = list(
		/obj/item/book/granter/spellbook/adept = 1,
		/obj/item/chalk = 1,
		/obj/item/rope/chain = 1,
		/obj/item/reagent_containers/glass/bottle/stronghealthpot = 1,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/weapon/knife/dagger/silver/arcyne = 1
		)
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff/steel
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
	if(H.age == AGE_OLD)
		head = /obj/item/clothing/head/wizhat
		backl = /obj/item/storage/backpack/backpack
		H.change_stat(STATKEY_INT, 1)
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
	H.change_stat(STATKEY_INT, 4)
	H.change_stat(STATKEY_END, 1)
	H.adjust_spell_points(12)
	H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
	wretch_select_bounty(H)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INHUMENCAMP, TRAIT_GENERIC)
