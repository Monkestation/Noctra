/datum/job/mageapprentice
	title = "Magician's Apprentice"
	tutorial = "Your family managed to send you to college to learn the Arcyne Arts.\
	 It's been stressful, but you'll earn your degree and become a fully fleged Magician one dae.\
	  As long as you can keep your grades up, that is..."
	flag = APPRENTICE
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_PLAYER_ALL
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD, AGE_ADULT)
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo) //see court mage for explaination

	outfit = /datum/outfit/job/mageapprentice
	display_order = JDO_WAPP
	min_pq = 3 //they actually have good magick now
	give_bank_account = TRUE
	bypass_lastclass = TRUE
	banned_leprosy = FALSE
	can_have_apprentices = FALSE

/datum/outfit/job/mageapprentice/pre_equip(mob/living/carbon/human/H)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather/rope
		beltl = /obj/item/storage/keyring/mageapprentice
		beltr = /obj/item/storage/magebag/apprentice
		armor = /obj/item/clothing/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/satchel
		backpack_contents = list(/obj/item/book/granter/spellbook/apprentice = 1, /obj/item/chalk = 1)
	else
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = /obj/item/clothing/shirt/dress
		pants = /obj/item/clothing/pants/tights/random
		belt = /obj/item/storage/belt/leather/rope
		beltl = /obj/item/storage/keyring/mageapprentice
		beltr = /obj/item/storage/magebag/apprentice
		armor = /obj/item/clothing/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/satchel
		backpack_contents = list(/obj/item/book/granter/spellbook/apprentice = 1, /obj/item/chalk = 1)
	if (H.age == AGE_ADULT)
		H.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.adjust_spellpoints(4)
	else
		H.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE) //children can have one spellpoint, as a treat.
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_SPD, -1)
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
