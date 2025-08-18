//shield
/datum/advclass/combat/inhumencleric
	name = "Inhumen Cleric"
	tutorial = "Those Clerics are wandering warriors of the Inhumens"
	allowed_races = RACES_PLAYER_ALL
	vampcompat = FALSE
	outfit = /datum/outfit/job/adventurer/inhumencleric
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4
	allowed_patrons = ALL_PROFANE_PATRONS

/datum/outfit/job/adventurer/inhumencleric
	allowed_patrons = ALL_PROFANE_PATRONS

/datum/outfit/job/adventurer/inhumencleric/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/ironpot
	armor = /obj/item/clothing/armor/cuirass/iron // Adventurers are not supposed to have fricking steel, at all
	shirt = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/leather
	neck = /obj/item/clothing/neck/chaincoif/iron // Everyone gets iron coif, instead of variable neck armor
	belt = /obj/item/storage/belt/leather
	backr = /obj/item/weapon/shield/heater
	if(ispath(H.patron?.type, /datum/patron/inhumen/graggar))
		beltl = /obj/item/weapon/axe/iron
	else if(ispath(H.patron?.type, /datum/patron/inhumen/matthios))
		backl = /obj/item/weapon/polearm/woodstaff/quarterstaff
	else if(ispath(H.patron?.type, /datum/patron/inhumen/baotha))
		beltl = /obj/item/weapon/knife/dagger/steel
		backl = /obj/item/storage/backpack/satchel
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/poison = 2, /obj/item/weapon/knife/dagger/steel = 1) //Poison
	else
		if(iself(H) || ishalfelf(H))
			beltl = /obj/item/weapon/mace/elvenclub
		else
			beltl = /obj/item/weapon/mace
	beltr = /obj/item/storage/belt/pouch/coins/poor
	switch(H.patron?.type)
		if(/datum/patron/inhumen/graggar)
			cloak = /obj/item/clothing/cloak/raincloak/colored/mortus
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
		if(/datum/patron/inhumen/graggar_zizo)
			cloak = /obj/item/clothing/cloak/raincloak/colored/mortus
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
		if(/datum/patron/inhumen/zizo)
			cloak = /obj/item/clothing/cloak/raincloak/colored/mortus
			head = /obj/item/clothing/head/helmet/skullcap/cult
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
		if(/datum/patron/inhumen/matthios)
			cloak = /obj/item/clothing/cloak/raincloak/colored/mortus
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
		if(/datum/patron/inhumen/baotha)
			head = /obj/item/clothing/head/crown/circlet
			mask = /obj/item/clothing/face/spectacles/sglasses
			cloak = /obj/item/clothing/cloak/raincloak/colored/purple
			ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
		else // Failsafe
			cloak = /obj/item/clothing/cloak/tabard/crusader // Give us a generic crusade tabard
			wrists = /obj/item/clothing/neck/psycross/silver // Give us a silver psycross for protection against lickers
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'


	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		var/datum/skill/to_add = /datum/skill/combat/axesmaces
		if(ispath(H.patron?.type, /datum/patron/inhumen/matthios))
			to_add = /datum/skill/combat/polearms
		if(ispath(H.patron?.type, /datum/patron/inhumen/baotha))
			to_add = /datum/skill/combat/knives
			H.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.adjust_skillrank(to_add, 3, TRUE)
		if(H.age == AGE_OLD)
			H.adjust_skillrank(to_add, 1, TRUE)
			H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Even if it has limited slots, it is a common drifter role available to anyone. Their armor also is not heavy, so medium armor training is enough
	var/holder = H.patron?.devotion_holder
	if(holder)
		var/datum/devotion/devotion = new holder()
		devotion.make_cleric()
		devotion.grant_to(H)
