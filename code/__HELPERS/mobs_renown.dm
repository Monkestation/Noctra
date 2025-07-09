#define TITLE_PREVIOUSTITLE 1
#define ONLY_NEWTTITLE 2
#define TITLE_ADJECTIVE 3
#define TITLE_NOUN_PEPHRASE 4
#define TITLE_NOUN 5

/mob/proc/process_renown_beast(npc_mob = TRUE, sentient_kill = FALSE)
	if(!npc_mob)
		var/playerrenown = GLOB.mob_renown_list[src.mobid]
		//if(playerrenown == 8)
			//check if they are already in the list here
				//GLOB.legendary_name_maybeevil_regex += src.real_name
				//return



	var/killcount = GLOB.mob_kill_count[src.mobid]
	GLOB.mob_renown_list[src.mobid] += FLOOR(killcount / 3, 1)
	if(killcount == 1)
		give_beast_name()
	if(istype(src, /mob/living/carbon/human/species)) //this used to look through all humanoid type npcs
		var/renown = GLOB.mob_renown_list[src.mobid] //but grung told me to shorten it to the subtyoe, so player zombies
		if(renown >= 1) //may also get these stuff now? I guess its fine???
			if(renown <= 4)
				promote_beast()

	if(sentient_kill)
		var/sentkillcount = GLOB.mob_sentient_kill_count[src.mobid]
		if(sentkillcount == 1)
			make_beast_sentient()
			//however the hell you check if a mob is near a player or being viewed you we check it here
			//apply_mob_quirk

/mob/proc/give_beast_name()
	if(!isliving(src))
		return
	var/previoustitle = src.real_name
	var/title = pick("Chax", "Gifflet", "Abigor", "Akar", "Tuwile", "Ernesh", "Leah", "Daghishat", "Nirnasha", "Azazel", "Heath", "Agrona", "Gorgon", "khazz", "Trurr", "Thekuax", "Gyrr", "Thruc", "Gengol", "Sryt", "Matirè", "Nikot", "Rithod", "Asmuk", "Cifano", "Sasmok", "Lebes", "Kök", "Rashgur", "Osp", "Geshak", "Zursmu", "Ber", "Metava", "Fer", "Suku", "Zewoth", "Imici", "Sinsot", "Rathi", "Vulo", "Disuth", "Mozfel", "Ogthrak", "Pushkrimp", "Golm") //bunch of fuck off names, mostly dwarf fortress words.
	var/adjective = pick("Strong", "Weak", "Fast", "Slow", "Beast", "Wild", "Sophisticated", "Silent", "Savage", "Frenzied", "Brutal", "Bloodthirsty", "Unstoppable", "Vicious", "Puny", "Shy", "tricky", "Wicked", "Swift", "Reaper", "Heartless", "Timid", "Wastefull", "One-Word", "Biter", "One", "Blast", "Cannibal", "Itchy", "Smelly", "Fat", "Bewitched", "Handsome", "Charming", "Angry", "Bloated", "Agonizer", "Cruel", "Dead", "Gentle", "Friendly", "Greedy", "Funny", "Hungry", "Dumb", "Screamer", "Merciful", "Ever-Loving", "Stone-Gut", "Oblivious", "Poet", "Runt", "Messenger", "Prophet", "Whiner", "Teary-Eyed", "Shamed")
	var/noun = pick("Annihilator", "Destroyer", "Scourge", "Bane", "Breaker", "Killer", "Slayer", "Slaver", "Eater", "Crusher", "Cleaver", "Desecrator", "Wrecker", "Ravager", "Ruiner", "Vandal", "Devastater")
	var/pephrase = pick("Bones", "Worlds", "Towns", "Elves", "Skulls", "Dwarves", "Trees", "Mountains", "Iron", "Steel", "Humens", "Orcs", "Goblins", "Trolls", "Spiders", "Harpies", "Kobolds", "Hollow-Kin", "Tieflings", "Blood-suckers", "Werevolves", "Volves", "Moo-Beast", "Adventurers", "Fools", "Mercenaries", "Cities", "Machines", "Hearts", "Spleens", "Horcs", "Drow", "Lungs", "Throats", "Eyes", "Tongues", "Zizo", "Astrasta", "Noc", "Dendor", "Necra", "Ravox", "Xylix", "Pestra", "Malum", "Eora", "Graggar", "Matthios", "Baotha", "Faithless", "Walls", "Towers", "Houses", "Guilds", "Legs", "Arms", "Fingers", "Armour", "Weapons", "Thrones")
	switch(rand(1,5))
		if(TITLE_PREVIOUSTITLE) // title + previoustitle, ie 'john the goblin', this of course means we are hoping that the npc title is the species of the owner, otherwise this is going to get dumb
			src.real_name = "[title] the [previoustitle]"
		if(ONLY_NEWTTITLE) //just the new title, ie 'mario'
			src.real_name = "[title]"
		if(TITLE_ADJECTIVE) // title + adjective, ie 'john the fast'
			src.real_name = "[title] the [adjective]"
		if(TITLE_NOUN_PEPHRASE) // title + noun + pephrase, ie 'john the destroyer of worlds'
			src.real_name = "[title] the [noun] of [pephrase]"
		if(TITLE_NOUN) //title + noun, ie just john the destroyer
			src.real_name = "[title] the [noun]"

/mob/proc/promote_beast()
	if(!isliving(src))
		return
	var/mob/living/O = src
	O.adjust_skillrank(/datum/skill/combat/polearms, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/swords, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/wrestling, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/unarmed, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/knives, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/axesmaces, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/misc/athletics, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/combat/shields, rand(0,1), TRUE)
	O.adjust_skillrank(/datum/skill/misc/climbing, rand(0,1), TRUE)
	O.STASTR += 1
	O.STACON += 1
	O.STASPD += 1
	O.STAPER += 1
	O.STAINT += 1
	O.STAEND += 1

/mob/proc/make_beast_sentient()
	set waitfor = 1
	if(!isliving(src))
		return
	var/mob/living/bober = src
	if(bober.dontmakesentient)
		return
	if(bober.ckey)
		return
	var/name = bober.real_name
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("[name] HAS EARNED HIGHER INTELLIGENCE, WILL YOU CONTROL THEM?", null, null, null, 150, bober, null, new_players = TRUE)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		bober.ckey = C.key
		bober.visible_message("[name] blinks repeatedly, their eyes flared with newfound intelligence.")
		log_game("[key_name(C)] has taken control of ([key_name(bober)]) as their sentience")

///mob/proc/apply_mob_quirk



#undef TITLE_PREVIOUSTITLE
#undef ONLY_NEWTTITLE
#undef TITLE_ADJECTIVE
#undef TITLE_NOUN_PEPHRASE
#undef TITLE_NOUN

//this is just special_trait, couldn't make it a subtype cause its for carbon/human which wouldn't let simple mobs
//and I don't know how to make a work around for that. its not even functional right now, why?
//because its hot as fuck, my cat is in heat and wont shut up, and I can't even test pollcandformob.
//I am dying here, and this is the unsexy part of hobby code contribution that needs actual talent and skill


//N/A put this shit in its own file
/datum/mob_quirks
	abstract_type = /datum/mob_quirks
	/// name of the trait
	var/name
	/// the text that is displayed to the user when they spawn in
	var/greet_text
	/// the chance this trait will be rolled, the lower this is - the rarer it will roll.
	var/weight = 100
	// these are self explanatory
	var/list/restricted_races
	var/simplemoballowed = FALSE

GLOBAL_LIST_INIT(mob_quirks, build_mob_quirks())

#define MOB_QUIRK(quirk_type) GLOB.mob_quirks[quirk_type]

/proc/build_mob_quirks()
	. = list()
	for(var/type in typesof(/datum/mob_quirks))
		if(is_abstract(type))
			continue
		.[type] = new type()
	return .

/*/proc/roll_random_mob_quirks(client/player)
	var/list/eligible_weight = list()
	for(var/trait_type in GLOB.mob_quirks)
		var/datum/mob_quirks/special = MOB_QUIRK(quirk_type)
		eligible_weight[trait_type] = special.weight

	if(!length(eligible_weight))
		return null

	return pickweight(eligible_weight)

/proc/print_quirk_text(mob/user, quirk_type)
	var/datum/special_trait/quirk = MOB_QUIRK(quirk_type)
	to_chat(user, span_notice("<b>[quirk.name]</b>"))
	to_chat(user, quirk.greet_text)
	//if(quirk.req_text)
		//to_chat(user, span_boldwarning("Requirements: [special.req_text]"))

/proc/try_apply_character_post_equipment(mob/living/carbon/human/character, client/player)
	var/datum/job/job
	if(character.job)
		job = SSjob.name_occupations[character.job]
	if(!job)
		// Apply the stuff if we dont have a job for some reason
		apply_character_post_equipment(character, player)
		return
	if(length(job.advclass_cat_rolls))
		// Dont apply the stuff, let adv class handler do it later
		return
	// Apply the stuff if we have a job that has no adv classes
	apply_character_post_equipment(character, player)

/proc/apply_character_post_equipment(mob/living/carbon/human/character, client/player)
	if(!player)
		player = character.client
	apply_prefs_special(character, player)

/proc/apply_prefs_special(mob/character, client/player)
	if(!player)
		player = character.client
	if(!player)
		return
	if(!player.prefs)
		return
	var/trait_type = player.prefs.next_special_trait
	if(!trait_type)
		return
	apply_special_trait_if_able(character, player, trait_type)
	player.prefs.next_special_trait = null

/proc/apply_mob_quirk_if_able(mob/living/character, client/player, quirk_type)
	if(!charactet_eligible_for_quirk(character, player, quirk_type))
		log_game("SPECIALS: Failed to apply [quirk_type] for [key_name(character)]")
		return FALSE
	log_game("SPECIALS: Applied [quirk_type] for [key_name(character)]")
	apply_mob_quirk(character, quirk_type)
	return TRUE

/// Applies random special trait IF the client has specials enabled in prefs
/proc/apply_random_mob_quirk(mob/living/character, client/player)
	if(!player)
		player = character.client
	if(!player)
		return
	var/quirk_type = get_random_special_for_char(character, player)
	if(!quirk_type) // Ineligible for all of them, somehow
		return
	apply_special_trait(character, quirk_type)

/proc/charactet_eligible_for_quirk(mob/living/character, client/player, quirk_type)
	var/datum/special_trait/special = MOB_QUIRK(quirk_type)
	var/datum/job/job
	if(character.job)
		job = SSjob.name_occupations[character.job]
	if(!isnull(special.allowed_jobs))
		if(!job)
			return FALSE
		if(!(job.type in special.allowed_jobs))
			return FALSE
	if(!isnull(special.restricted_jobs) && job && (job.type in special.restricted_jobs))
		return FALSE
	if(!isnull(special.allowed_races) && !(character.dna.species.type in special.allowed_races))
		return FALSE
	if(!isnull(special.allowed_migrants))
		if(!character.migrant_type)
			return FALSE
		if(!(character.migrant_type in special.allowed_migrants))
			return FALSE
	if(!isnull(special.restricted_migrants) && character.migrant_type && (character.migrant_type in special.restricted_migrants))
		return FALSE
	if(!isnull(special.restricted_races) && (character.dna.species.type in special.restricted_races))
		return FALSE
	if(!isnull(special.allowed_sexes) && !(character.gender in special.allowed_sexes))
		return FALSE
	if(!isnull(special.allowed_ages) && !(character.age in special.allowed_ages))
		return FALSE
	if(!isnull(special.allowed_patrons) && !(character.patron.type in special.allowed_patrons))
		return FALSE
	if(!isnull(special.restricted_traits))
		var/has_trait
		for(var/trait in special.restricted_traits)
			if(HAS_TRAIT(character, trait))
				has_trait = TRUE
				break
		if(has_trait)
			return FALSE

	//put if for allowed races here
	if(!special.can_apply(character))
		return FALSE
	return TRUE

/proc/get_random_quirk_for_char(mob/living/character, client/player)
	var/list/eligible_weight = list()
	for(var/trait_type in GLOB.mob_quirks)
		var/datum/mob_quirks/special = MOB_QUIRK(quirk_type)
		if(!charactet_eligible_for_trait(character, player, quirk_type))
			continue
		eligible_weight[quirk_type] = special.weight

	if(!length(eligible_weight))
		return null

	return pickweight(eligible_weight)

/proc/apply_mob_quirk(mob/living/character, trait_type, silent)
	var/datum/mob_quirks/special = MOB_QUIRK(quirk_type)
	special.on_apply(character, silent)
	if(!silent && special.greet_text)
		to_chat(character, special.greet_text)

/datum/mob_quirks/proc/can_apply(mob/living/carbon/human/character)
	return TRUE

/// called after latejoin and transfercharacter in roundstart
/datum/mob_quirks/proc/on_apply(mob/living/carbon/human/character, silent)
	return
*/
/*
/datum/mob_quirks/lame
	name = "lame"
	greet_text = span_notice("I am who I am, nothing more, nothing less")
	weight = 50
	simplemoballowed = TRUE

/datum/mob_quirks/true_lame
	name = "lame"
	greet_text = span_notice("I am who I am, nothing more, nothing less")
	weight = 49

/datum/mob_quirks/true_lame/on_apply(mob/living/character, silent)
	if(istype(character, /mob/living/carbon/human))
		var/mob/living/carbon/human/O = character
		O.virginity = TRUE

/*/datum/mob_quirks/well_acquainted
	name = "well met"
	greet_text = span_notice("I know everybody around here, I've been to some's weddings' at a distance, and they won't even wave back!")
	weight = 50
	simplemoballowed = TRUE

/datum/mob_quirks/well_acquainted/on_apply(mob/living/character, silent)
	for(var/X in GLOB.player_list)
		character.peopleiknow += X
*/

/datum/mob_quirks/web_walker
	name = "web walker"
	greet_text = span_notice("I've been around spiders for a while, I know how to walk through webs")
	weight = 37

/datum/mob_quirks/web_walker/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_WEBWALK, "[type]")

/datum/mob_quirks/atheletic
	name = "Atheletic"
	greet_text = span_notice("I am real athletic and can jump real high alright, just watch me!")
	weight = 38

/datum/mob_quirks/high_jumper/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")
	character.change_stat("speed", 2)
	character.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	character.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	character.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)


/datum/mob_quirks/lady_killer
	name = "lady killer"
	greet_text = span_notice("I killed a girl... and I liked it!")
	weight = 43

/datum/mob_quirks/lady_killer/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_HATEWOMEN, "[type]")
	character.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE) //nothing to read into here

/datum/mob_quirks/not_weak
	name = "Deceiving Meekness"
	greet_text = span_notice("I can hide my strength real good, you don't know what hit ya")
	weight = 42

/datum/mob_quirks/not_meak/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	character.change_stat("strength", 2)

/datum/mob_quirks/knife_freak //boss
	name = "!!KNIFE FREAK!!"
	greet_text = span_notice("WHO NEEDS ANYTHING ELSE, I GOT A FUCKING KNIFE!!")
	weight = 5

/datum/mob_quirks/knife_freak/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_NUDIST, "[type]")
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")
	ADD_TRAIT(character, TRAIT_WEBWALK, "[type]")
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")
	ADD_TRAIT(character, TRAIT_HEARING_SENSITIVE, "[type]")
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	ADD_TRAIT(character, TRAIT_NOFALLDAMAGE2, "[type]")
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")
	ADD_TRAIT(character, TRAIT_SHARPER_BLADES, "[type]")
	ADD_TRAIT(character, TRAIT_CRACKHEAD, "[type]")
	ADD_TRAIT(character, TRAIT_SCHIZO_AMBIENCE, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(character, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(character, TRAIT_TOXIMMUNE, "[type]")
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.head)
	QDEL_NULL(character.r_hand)
	QDEL_NULL(character.l_hand)
	//var/obj/item/freak = new /obj/item/weapon/knife/dagger/steel/freak(get_turf(character)) N/A make the knife
	//character.put_in_hands(freak,forced = TRUE)
	character.adjust_skillrank(/datum/skill/combat/knives, 6, TRUE)
	character.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
	character.adjust_skillrank(/datum/skill/misc/swimming, 6, TRUE)
	character.reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, 999)
	character.reagents.add_reagent(/datum/reagent/moondust, 999) //lets hope the boatha trait prevents the screen effects, otherwise, this is unplayable
	character.reagents.add_reagent(/datum/reagent/ozium, 999)

/datum/mob_quirks/perceptive
	name = "Perceptive"
	greet_text = span_notice("I've got some intense vision, you saw that? I did.")
	weight = 42

/datum/mob_quirks/perceptive/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_HEARING_SENSITIVE, "[type]")
	character.change_stat("perception", 2)

/datum/mob_quirks/thickskin
	name = "Tough"
	greet_text = span_notice("I feel it. Thick Skin. Dense Flesh. Durable Bones. I'm a punch-taking machine.")
	weight = 40

/datum/mob_quirk/thickskin/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")
	character.change_stat("constitution", 2)

/datum/mob_quirks/dead_king
	name = "Risen King"
	greet_text = span_notice("I used to rule the lands, Seas would rise when I gave the word. I have taken my rest, I will rule again.")
	restricted_races = list(/mob/living/carbon/human/races/skeleton)
	weight = 10

/datum/mob_quirks/dead_king/on_apply(mob/living/character, silent)
	QDEL_NULL(character.cloak)
	QDEL_NULL(character.wear_ring)
	QDEL_NULL(character.wear_mask)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.wear_pants)
	QDELL_NULL(character.gloves)
	QDELL_NULL(character.head)
	character.equip_to_slot_or_del(new /obj/item/weapon/sword/long/greatsword/steelclaymore(character), ITEM_SLOT_BACK_R)
	character.equip_to_slot_or_del(new /obj/item/clothing/ring/active/nomag(character), ITEM_SLOT_RING)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/leather/plaquegold(character), ITEM_SLOT_BELT)
	character.equip_to_slot_or_del(new /obj/item/clothing/face/facemask/goldmask(character), ITEM_SLOT_MASK)
	character.equip_to_slot_or_del(new /obj/item/clothing/cloak/lordcloak(character), ITEM_SLOT_CLOAK)
	character.equip_to_slot_or_del(new /obj/item/clothing/armor/plate/blkknight(character), ITEM_SLOT_ARMOR)
	character.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/blacksteel/bucket(character), ITEM_SLOT_HEAD)
	character.equip_to_slot_or_del(new /obj/item/clothing/pants/platelegs/blk(character), ITEM_SLOT_PANTS)
	character.equip_to_slot_or_del(new /obj/item/clothing/gloves/plate/blk(character), ITEM_SLOT_GLOVES)
	character.equip_to_slot_or_del(new /obj/item/clothing/shoes/boots/armor/blkknight(character), ITEM_SLOT_SHOES)
	//N/A give them rebel leader datum

/datum/mob_quirks/dead_inq
	name = "Risen Inquisitor"
	greet_text = span_notice("I walked before the Patheon was many, and I rested as our Father's name was smeared, now I am given a second chance.")
	restricted_races = list(/mob/living/carbon/human/races/skeleton)
	weight = 20

/datum/mob_quirks/dead_inq/on_apply(mob/living/character, silent)
	QDEL_NULL(character.cloak)
	QDELL_NULL(character.head)
	QDELL_NULL(character.gloves)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.r_hand)
	QDEL_NULL(character.l_hand)
	QDEL_NULL(character.neck)
	character.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(character), ITEM_SLOT_BACK_R)
	character.equip_to_slot_or_del(new /obj/item/weapon/knife/dagger/steel(character), ITEM_SLOT_BELT_L)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/pouch/bullets(character), ITEM_SLOT_BELT_R)
	character.equip_to_slot_or_del(new /obj/item/clothing/head/leather/inqhat(character), ITEM_SLOT_HEAD)
	character.equip_to_slot_or_del(new /obj/item/clothing/gloves/otavan/inqgloves(character), ITEM_SLOT_GLOVES)
	character.equip_to_slot_or_del(new /obj/item/clothing/cloak/cape/inquisitor(character), ITEM_SLOT_CLOAK)
	character.equip_to_slot_or_del(new /obj/item/clothing/neck/psycross/silver(character), ITEM_SLOT_NECK)
	var/obj/item/gun = new /obj/item/gun/ballistic/revolver/grenadelauncher/pistol(get_turf(character))
	var/obj/item/gunpowder = new /obj/item/reagent_containers/glass/bottle/aflask(get_turf(character))
	character.put_in_hands(gun,forced = TRUE)
	character.put_in_hands(gunpowder,forced = TRUE)
*/
