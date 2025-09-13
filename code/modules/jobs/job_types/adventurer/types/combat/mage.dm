/datum/advclass/combat/mage
	name = "Mage"
	tutorial = "A wandering graduate of the many colleges of magick across Psydonia, you search for a job to put your degree to use. And they say school was hard..."

	outfit = /datum/outfit/job/adventurer/mage
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4
	cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'

/datum/outfit/job/adventurer/mage
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo)

/datum/outfit/job/adventurer/mage/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	head = /obj/item/clothing/head/roguehood/colored/mage
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/robe/colored/mage
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/storage/magebag/poor
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	backpack_contents = list(/obj/item/book/granter/spellbook/apprentice = 1, /obj/item/chalk = 1)
	r_hand = /obj/item/weapon/polearm/woodstaff
	if(H.patron.type == /datum/patron/inhumen/zizo)
		H.grant_language(/datum/language/undead)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
	if(H.age == AGE_OLD)
		head = /obj/item/clothing/head/wizhat/gen
		armor = /obj/item/clothing/shirt/robe/colored/plain
		backl = /obj/item/storage/backpack/backpack
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
		H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_CON, -2)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_SPD, -2)
	H.adjust_spell_points(5)
	H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
