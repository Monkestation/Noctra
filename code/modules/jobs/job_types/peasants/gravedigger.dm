/datum/job/undertaker
	title = "Gravetender"
	tutorial = "As a servant of Necra, you embody the sanctity of her domain, \
	ensuring the dead rest peacefully within the earth. \
	You are the bane of grave robbers and necromancers, \
	and your holy magic brings undead back into Necra's embrace: \
	the only rightful place for lost souls."
	department_flag = CHURCHMEN
	display_order = JDO_GRAVETENDER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	min_pq = -10
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_NONHERETICAL

	outfit = /datum/outfit/job/undertaker
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'

/datum/outfit/job/undertaker
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/padded/deathshroud
	neck = /obj/item/clothing/neck/psycross/silver/necra
	pants = /obj/item/clothing/pants/trou/leather/mourning
	armor = /obj/item/clothing/shirt/robe/necra
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/gravetender
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backr = /obj/item/weapon/shovel

	if(H.patron != /datum/patron/divine/necra)
		H.set_patron(/datum/patron/divine/necra)

	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) // these are basically the acolyte skills with a bit of other stuff
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	//H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE) gravetenders don't get the skill, for "balance", you can probably beat a man to death with the shovel anyways
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)//more athletics than acolytes, refer to the comment on the strength stat
	H.adjust_skillrank(/datum/skill/misc/climbing, pick(0,0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, pick(0,0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)//worse cooking than regular acolytes
	H.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	H.change_stat(STATKEY_STR, 2)//in exchange for the above mentioned, they get 2 extra strength. Digging graves and hauling bodies is physically exhausting.
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_PER, -1) // similar to acolyte's stats
	if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
		H.grant_language(/datum/language/celestial)
		to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Operating with corpses every day.
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC) // In case they need to move tombs or anything.

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
