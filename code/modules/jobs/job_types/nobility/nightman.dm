/datum/job/apothecary
	title = "Apothecary"
	tutorial = "You know every plant growing on these grounds and in the woods like the back of your hand. \
	You are tasked with mixing tinctures and supplying the town and Feldsher with medicine for pain... or pleasure. \
	For a price, of course. \
	You have been known to kill men who cross you or your work-partner."
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_APOTHECARY
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 1
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/apothecary
	give_bank_account = 100
	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/apothecary
	job_bitflag = BITFLAG_ROYALTY | BITFLAG_CONSTRUCTOR

/datum/outfit/job/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/gambeson/apothecary
	shoes = /obj/item/clothing/shoes/apothboots
	shirt = /obj/item/clothing/shirt/apothshirt
	pants = /obj/item/clothing/pants/trou/apothecary
	gloves = /obj/item/clothing/gloves/leather/apothecary
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/apothecary
	beltr = /obj/item/storage/belt/pouch/coins/poor
	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(2,2,3), TRUE)//so he can help the feldsher hold down unruly patients
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)//I assume they venture often into the wild for herbs
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_PER, -1)

