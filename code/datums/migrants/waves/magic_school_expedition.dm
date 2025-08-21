/datum/migrant_role/magic_teacher
	name = "Magic School Teacher"
	greet_text = "Among the lofty spires of Kingsfield’s arcane academies, one school conceived a daring idea: a grand overland expedition, on foot, through untamed lands. \
	As fortune (or folly) would have it, you have been chosen as the guiding hand and watchful protector of your eager pupils. \
	Your task is to lead them safely across the wilds, through hardship and wonder alike, until at last the halls of learning they seek rise before you."
	grant_lit_torch = TRUE
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/magic_teacher


/datum/outfit/job/magic_teacher/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)

	head = /obj/item/clothing/head/wizhat
	backr = /obj/item/storage/backpack/satchel
	armor = /obj/item/clothing/shirt/robe/colored/black
	belt  =	/obj/item/storage/belt/leather
	beltr = /obj/item/storage/magebag/apprentice
	backl = /obj/item/weapon/polearm/woodstaff
	shoes = /obj/item/clothing/shoes/shortboots
	neck = /obj/item/clothing/neck/mana_star
	backpack_contents = list(/obj/item/book/granter/spellbook/expert = 1, /obj/item/storage/belt/pouch/coins/rich = 1)

	if(H.mind)
		H.set_patron(/datum/patron/divine/noc)
		H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

		if(prob(5)) //extremely rare
			H.cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'
		else
			H.cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'

		if(H.dna.species.id == SPEC_ID_HUMEN)
			if(H.gender == MALE)
				H.dna.species.soundpack_m = new /datum/voicepack/male/wizard()
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 4)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_SPD, -1)

		H.adjust_spell_points(10)
		H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)


/datum/migrant_role/magic_student
	name = "Magic School Student"
	greet_text = "When the call went out for daring pupils to join a great overland trek from Kingsfield, you eagerly volunteered, visions of adventure, discovery, and excitement dancing in your mind. \
	Of course, the creatures that lurk along the road seem just as eager... though perhaps for very different reasons."
	allowed_ages = list(AGE_CHILD)
	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/magic_student

/datum/outfit/job/magic_student/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)

	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/colored/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = /obj/item/clothing/shirt/shortshirt
		belt  = /obj/item/storage/belt/leather
		beltl = /obj/item/book/granter/spellbook/adept // spoiled brats
		beltr = /obj/item/storage/magebag/apprentice
		armor = /obj/item/clothing/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/satchel
		head = /obj/item/clothing/head/wizhat/gen
		neck = /obj/item/clothing/neck/mana_star
	else
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/random
		pants = /obj/item/clothing/pants/tights/colored/random
		belt  =	/obj/item/storage/belt/leather
		beltl = /obj/item/book/granter/spellbook/adept // spoiled brats
		beltr = /obj/item/storage/magebag/apprentice
		armor = /obj/item/clothing/shirt/robe/newmage/adept
		backr = /obj/item/storage/backpack/satchel
		head = /obj/item/clothing/head/wizhat/witch
		neck = /obj/item/clothing/neck/mana_star
	if(H.mind)
		H.set_patron(/datum/patron/divine/noc)
		H.adjust_spell_points(6)
		backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/chalk = 1)
		H.adjust_skillrank(/datum/skill/magic/arcane, pick(2,2,2,3), TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)// Focused on their studies.
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)// Focused on their studies.
		H.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)// Focused on their studies.
		H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 3) // Smart
		H.change_stat(STATKEY_SPD, -2)

	H.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation)
	if(prob(5)) //extremely rare
		H.cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'
	else
		H.cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'

/datum/migrant_wave/magic_school_expedition
	name = "Magic School Expedition"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/magic_school_expedition
	downgrade_wave = /datum/migrant_wave/magic_school_expedition_down
	weight = 5
	roles = list(
		/datum/migrant_role/magic_teacher = 1,
		/datum/migrant_role/magic_student = 5
	)
	greet_text = "A teacher in travel-worn robes takes a seat, a cluster of young apprentices following close behind. Their satchels clink faintly with glass and metal, and the smell of old parchment drifts from their packs."

/datum/migrant_wave/magic_school_expedition_down
	name = "Magic School Expedition"
	shared_wave_type = /datum/migrant_wave/magic_school_expedition
	downgrade_wave = /datum/migrant_wave/magic_school_expedition_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/magic_teacher = 1,
		/datum/migrant_role/magic_student = 3
	)
	greet_text = "The door opens to a weary teacher and a smaller band of pupils. Their robes are torn at the hems, and one student’s hands are wrapped in singed cloth."

/datum/migrant_wave/magic_school_expedition_two
	name = "Magic School Expedition"
	shared_wave_type = /datum/migrant_wave/magic_school_expedition
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/magic_teacher = 1,
		/datum/migrant_role/magic_student = 1
	)
	greet_text = "Only a single student remains beside the teacher. They sit quietly, eyes fixed on the table, as dark stains dry on the cuffs of their robes."
