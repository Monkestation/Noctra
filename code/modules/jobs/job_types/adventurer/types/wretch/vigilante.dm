/datum/advclass/wretch/vigilante
	name = "Renegade"
	tutorial = "A renegade, deserter and a gunslinger, Favoured by Matthios, You've turned your back on the black empire and psydon alike, Now? you wander around Faience, wielding black powder, grit, and a gambler's instinct."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/wretch/vigilante
	category_tags = list(CTAG_WRETCH)
	maximum_possible_slots = 1 //There can be only one.
	pickprob = 25


/datum/outfit/job/wretch/vigilante/pre_equip(mob/living/carbon/human/H)
	H.set_patron(/datum/patron/inhumen/matthios) //The idea is that they're a matthiosite with a boon from said god.
	neck = /obj/item/clothing/neck/highcollier/iron/renegadecollar
	mask = /obj/item/clothing/face/spectacles/inqglasses
	pants =  /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/armor/gambeson/heavy/colored/dark
	head = /obj/item/clothing/head/leather/inqhat/vigilante
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/colored/wretchrenegade
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/knifebelt/black/iron
	gloves = /obj/item/clothing/gloves/leather/advanced
	shoes = /obj/item/clothing/shoes/nobleboot
	wrists = /obj/item/clothing/wrists/bracers/leather/advanced
	backpack_contents = list(
		/obj/item/weapon/knife/hunting = 1,
		/obj/item/storage/belt/pouch/coins/poor = 1,
		/obj/item/storage/fancy/cigarettes/zig = 1,
		/obj/item/flint = 1,
		/obj/item/reagent_containers/glass/bottle/stronghealthpot = 1,
	)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_LCK, 2) //Lucky son of a bitch
	ADD_TRAIT(H, TRAIT_DECEIVING_MEEKNESS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_INHUMENCAMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.add_spell(/datum/action/cooldown/spell/undirected/conjure_item/puffer)


/datum/outfit/job/wretch/vigilante/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()

	if(alert("Do you wish for a random title? You will not receive one if you click No.", "", "Yes", "No") == "Yes")
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/title
		var/list/titles = list("The Showoff", "The Gunslinger", "Mammon Shot", "The Desperado", "Last Sight", "The Courier", "Lethal Shot", "Guns Blazing", "Punished Shade", "The One Who Sold Creation", "V1", "V2", "The Opposition", "Mattarella", "High Noon", "Subterra-Walker", "Big Iron") //Dude, Trust.
		title = pick(titles)
		H.real_name = "[prev_real_name], [title]"
		H.name = "[prev_name], [title]"
	wretch_select_bounty(H)
