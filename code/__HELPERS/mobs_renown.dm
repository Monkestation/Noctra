#define TITLE_PREVIOUSTITLE 1
#define ONLY_NEWTTITLE 2
#define TITLE_ADJECTIVE 3
#define TITLE_NOUN_PEPHRASE 4
#define TITLE_NOUN 5

/mob/proc/process_renown_beast(sentient_kill = FALSE)
	//if(!npc_mob)
		//var/playerrenown = GLOB.mob_renown_list[src.mobid]
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
			if(!isliving(src))
				return
			var/mob/living/bober = src
			if(bober.dontmakesentient)
				return
			if(src.ckey || src.client)
				return
			if(length(SSmapping.retainer.sentientmob) >= 5)
				return
			SSmapping.add_world_trait(/datum/world_trait/sentient_mob, -1)
			GLOB.sentient_legiable += src
			for(var/mob/dead/observer/D in GLOB.player_list)
				D.sentient_beast_call()
			for(var/mob/living/carbon/spirit/D in GLOB.player_list)
				D.sentient_beast_call()


/mob/proc/give_beast_name()
	if(!isliving(src))
		return
	var/previoustitle = src.real_name
	var/title = pick("Chax", "Gifflet", "Abigor", "Akar", "Tuwile", "Ernesh", "Leah", "Daghishat", "Nirnasha", "Azazel", "Heath", "Agrona", "Gorgon", "khazz", "Trurr", "Thekuax", "Gyrr", "Thruc", "Gengol", "Sryt", "Matirè", "Nikot", "Rithod", "Asmuk", "Cifano", "Sasmok", "Lebes", "Kök", "Rashgur", "Osp", "Geshak", "Zursmu", "Ber", "Metava", "Fer", "Suku", "Zewoth", "Imici", "Sinsot", "Rathi", "Vulo", "Disuth", "Mozfel", "Ogthrak", "Pushkrimp", "Golm", "John") //bunch of fuck off names, mostly dwarf fortress words.
	var/adjective = pick("Strong", "Weak", "Fast", "Slow", "Beast", "Wild", "Sophisticated", "Silent", "Savage", "Frenzied", "Brutal", "Bloodthirsty", "Unstoppable", "Vicious", "Puny", "Shy", "tricky", "Wicked", "Swift", "Reaper", "Heartless", "Timid", "Wastefull", "One-Word", "Biter", "One", "Blast", "Cannibal", "Itchy", "Smelly", "Fat", "Bewitched", "Handsome", "Charming", "Angry", "Bloated", "Agonizer", "Cruel", "Dead", "Gentle", "Friendly", "Greedy", "Funny", "Hungry", "Dumb", "Screamer", "Merciful", "Ever-Loving", "Stone-Gut", "Oblivious", "Poet", "Runt", "Messenger", "Prophet", "Whiner", "Teary-Eyed", "Shamed")
	var/noun = pick("Annihilator", "Destroyer", "Scourge", "Bane", "Breaker", "Killer", "Slayer", "Slaver", "Eater", "Crusher", "Cleaver", "Desecrator", "Wrecker", "Ravager", "Ruiner", "Vandal", "Devastater")
	var/pephrase = pick("Bones", "Worlds", "Towns", "Elves", "Skulls", "Dwarves", "Trees", "Mountains", "Iron", "Steel", "Humens", "Orcs", "Goblins", "Trolls", "Spiders", "Harpies", "Kobolds", "Hollow-Kin", "Tieflings", "Blood-suckers", "Werevolves", "Volves", "Moo-Beast", "Adventurers", "Fools", "Mercenaries", "Cities", "Machines", "Hearts", "Spleens", "Horcs", "Drow", "Lungs", "Throats", "Eyes", "Tongues", "Zizo", "astrata", "Noc", "Dendor", "Necra", "Ravox", "Xylix", "Pestra", "Malum", "Eora", "Graggar", "Matthios", "Baotha", "Faithless", "Walls", "Towers", "Houses", "Guilds", "Legs", "Arms", "Fingers", "Armour", "Weapons", "Thrones")
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


/mob/proc/sentient_beast_call()
	SEND_SOUND(src, sound('sound/misc/notice (2).ogg'))
	if(alert(src, "A beast calls for higher intelligence", "Be sentience?", "Yes", "No") == "Yes")
		if(!has_world_trait(/datum/world_trait/sentient_mob))
			to_chat(src, span_warning("Another mind was chosen."))
		returntolobby()

/mob/proc/make_beast_sentient(mob/user)
	for(var/mob/bober in GLOB.sentient_legiable)
		var/name = bober.real_name
		bober.ckey = user.key
		bober.visible_message(span_warning("[name] blinks repeatedly, their eyes flared with newfound intelligence."))
		log_game("[key_name(user)] has taken control of ([key_name(bober)]) as their sentience")

		GLOB.sentient_legiable -= bober
		SSmapping.retainer.sentientmob |= user.mind

		//canning all of this shit for later, I spent hours trying to fix make_beast_sentient proc
		//if I look at this place for any longer I'll fucking shoot myself -clown

		//for(var/mob/entity in range(src, loc))
			//if(!entity)
				//apply_mob_quirk()
				//return
			//if(!entity.ckey && !entity.client)

//mob/proc/apply_mob_quirk
	//if(!GLOB.mob_quirks)
		//build_mob_quirks()



#undef TITLE_PREVIOUSTITLE
#undef ONLY_NEWTTITLE
#undef TITLE_ADJECTIVE
#undef TITLE_NOUN_PEPHRASE
#undef TITLE_NOUN

//N/A put this shit in its own file
/*
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
*/
/*datum/mob_quirks/proc/roll_random_mob_quirks(client/player)
	var/list/eligible_weight = list()
	for(var/trait_type in GLOB.mob_quirks)
		var/datum/mob_quirks/quirk = MOB_QUIRK(quirk_type)
		eligible_weight[trait_type] = quirk.weight

	if(!length(eligible_weight))
		return null

	return pickweight(eligible_weight)

/datum/mob_quirks/proc/apply_mob_quirk_if_able(mob/living/character, client/player, quirk_type)
	if(!charactet_eligible_for_quirk(character, player, quirk_type))
		log_game("QUIRKS: Failed to apply [quirk_type] for [key_name(character)]")
		return FALSE
	log_game("QUIRKS: Applied [quirk_type] for [key_name(character)]")
	apply_mob_quirk(character, quirk_type)
	return TRUE

/datum/mob_quirks/proc/charactet_eligible_for_quirk(mob/living/character, client/player, quirk_type)
	var/datum/mob_quirks/quirk = MOB_QUIRK(quirk_type)
	if(!isnull(quirk.allowed_races) && !(character.dna.species.type in special.allowed_races))
		return FALSE

	if(!quirk.can_apply(character))
		return FALSE
	return TRUE

/proc/get_random_quirk_for_char(mob/living/character, client/player)
	var/list/eligible_weight = list()
	for(var/trait_type in GLOB.mob_quirks)
		var/datum/mob_quirks/quirk = MOB_QUIRK(quirk_type)
		if(!charactet_eligible_for_trait(character, player, quirk_type))
			continue
		eligible_weight[quirk_type] = quirk.weight

	if(!length(eligible_weight))
		return null

	return pickweight(eligible_weight)

/datum/mob_quirks/proc/apply_mob_quirk(mob/living/character, trait_type, silent)
	var/datum/mob_quirks/quirk = MOB_QUIRK(quirk_type)
	quirk.on_apply(character, silent)
	if(!silent && quirk.greet_text)
		to_chat(character, quirk.greet_text)


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

/*
/datum/mob_quirks/well_acquainted
	name = "well met"
	greet_text = span_notice("I know everybody around here, I've been to some's weddings' at a distance, and they won't even wave back!")
	weight = 50
	simplemoballowed = TRUE

/datum/mob_quirks/well_acquainted/on_apply(mob/living/character, silent)
	for(var/X in GLOB.player_list)
		character.known_people += X
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
	//could use some stats too cause its clearly not fucked enough

/datum/mob_quirks/perceptive
	name = "Perceptive"
	greet_text = span_notice("I've got some intense vision, you saw that? I did.")
	weight = 42

/datum/mob_quirks/perceptive/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_HEARING_SENSITIVE, "[type]")
	character.change_stat("perception", 2)

/datum/mob_quirks/thickskin
	name = "Tough"
	greet_text = span_notice("I feel it. Thick Skin. Dense Flesh. Durable Bones. I'm a punch-taking machine.") //N/A can be less blatantly copy pasted
	weight = 40

/datum/mob_quirk/thickskin/on_apply(mob/living/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")
	character.change_stat("constitution", 2)

/datum/mob_quirks/dead_king
	name = "Risen King"
	greet_text = span_notice("I used to rule the lands, Seas would rise when I gave the word. I have taken my rest, I will rule again.")
	restricted_races = list(/mob/living/carbon/human/races/skeleton, /mob/living/carbon/human/races/zizombie)
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
	//more skills and stats should be fine too, who the hell is going to rebel to the side of the dead guy?

/datum/mob_quirks/dead_inq
	name = "Risen Inquisitor"
	greet_text = span_notice("I walked before the Patheon was many, and I rested as our Father's name was smeared, now I am given a second chance.") //holy moly its shadow the hedgehog
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
	//needs gun skills, maybe the inquisitor verbs too.

/datum/mob_quirks/optimist
	name = "Optimist"
	greet_text = span_notice("I may be hated by everything at large and not particularly favored by the patheon, but I'll get through it, and I'll do it with a smile!")
	weight = 38

/datum/mob_quirks/optimist/on_apply(mob/living/character, silent)
	character.(/datum/stressevent/elevated_optimist)

/datum/mob_quirks/werewolf, //self explanatory, exclusive to rousman
/datum/mob_quirks/bandit, //self explanatory, non exlusive, gives them the bandit hat or mask
/datum/mob_quirks/assassin, //self explanatory, gives copper mask too
/datum/mob_quirks/vampire, //self explanatory, exclusive to goblins and rousman from feeding
/datum/mob_quirks/maniac, //self explanatory, non exclusive
/datum/mob_quirks/lich, //self explanatory, zizozom and skeleton
/datum/mob_quirks/blood_brother, //polls for a second mob to spawn alongside the original. they are within the same team
/datum/mob_quirks/monster_king, //a king monster noble (not actually noble blooded). spawns with 2 'royal guards'
/datum/mob_quirks/monster_diplomat, //like the monster king, but only spawns with a single mercenary guard
/datum/mob_quirks/jester, //self explanatory, gives them the jester gitup
/datum/mob_quirk/bard, //self explanatory, gives the bard hat and an instrument
/datum/mob_quirks/nemesis_gaffer, //orc exclusive, one eyed, spawns with the hint of beef at an unspecified 'that archer', it is supposed to be someone the gaffer shot in the eye once, but its left ambigious incase the player doesn't want to play along
/datum/mob_quirks/nemesis_courtmage, //see above, skeleton rousman that had all of their meaty parts burnt off.
/datum/mob_quirks/nemesis_vet, //see above, battle scarred goblin
/datum/mob_quirks/nemesis_matron, //see above, skeleton missing an arm, which was stolen
/datum/mob_quirks/nemesis_elder, //see above a charmed zizozombie that kept its intelligence
/datum/mob_quirks/nemesis_inq, //see above, a burnt man that was falsely sentenced
/datum/mob_quirks/whip, //self explanatory, whip skill and the whip it self
/datum/mob_quirks/quack_doc, //non exclusive, gives physicker mask and robes, with medical skill
/datum/mob_quirks/butcher, //self explanatory, gives a bag of meat and a cleaver
/datum/mob_quirks/biter, //self explanatory, gives strong biter trait
/datum/mob_quirks/dwarf, //self explanatory, shortens player sprite size
/datum/mob_quirks/giant, //self explanatory, makes sprite bigger
/datum/mob_quirks/magician_weak, //self explanatory
/datum/mob_quirks/magician_mid, //self explanatory
/datum/mob_quirks/beutiful, //self explanatory
/datum/mob_quirks/ugly, //self explanatory
/datum/mob_quirks/high, //self explanatory, gives them a bunch of drugs
/datum/mob_quirks/booms, //gives the skill and tools for making bombs
/datum/mob_quirks/horse, //self explanatory, spawns them with a tamed and saddled horse
/datum/mob_quirks/tourist, //knows all languages
/datum/mob_quirks/silent, //self explanatory
/datum/mob_quirks/drunk, //self explanatory
/datum/mob_quirks/addict, //self explanatory
/datum/mob_quirks/wartorn, //battle scarred
/datum/mob_quirks/cyclops, //self explanatory
/datum/mob_quirks/tongueless, //self explanatory
/datum/mob_quirks/screamer, //gives barbarian yell and prevents them from talking
/datum/mob_quirks/coal, //gives a pick as their weapon, some mason and mining and smithing skill
/datum/mob_quirks/dodge_expert, //self explanatory
/datum/mob_quirks/jester_phobic, //self explanatory
/datum/mob_quirks/lone_wolf, //gives the loner flaw
/datum/mob_quirks/diary, //don't think this flaw actually got added
/datum/mob_quirks/paranoid, //self explanatory
/datum/mob_quirks/bad_sight, //self explanatory
/datum/mob_quirks/hunted, //self explanatory, points out how its a bit redundant
/datum/mob_quirks/masocist, //self explanatory
/datum/mob_quirks/two_mind //gives double personality trauma (if it even works)
/datum/mob_quirks/big_bud //goblin exclusive, spawns a troll friend (also sentient)
/datum/mob_quirks/odd_merc //spawns them with merc clothes and face hidden, trying to blend into the town
/datum/mob_quirks/odd_acoltye //above but acolyte
/datum/mob_quirks/odd_guard //above
/datum/mob_quirks/odd_traveler //you get it
/datum/mob_quirks/monster_legend_archer //these are all monster variants of the old adventurer party. maybe exclusive
/datum/mob_quirks/monster_legend_magic
/datum/mob_quirks/monster_legend_tank
/datum/mob_quirks/monster_legend_support
/datum/mob_quirks/monster_legend_thief
/datum/mob_quirks/RNGEEZ //gives all the stats based on RNG
/datum/mob_quirks/love_birds //spawns them married with another monster (sentient)
/datum/mob_quirks/dragonborn //you get it
/datum/mob_quirks/tamer //self explanatory, tames animals
/datum/mob_quirks/wayfarer //its own inque rare antag, has the power of making the same type of monsters as it sentient, think: that scene from detroit become human with the robots touching the other making them sentient, probably has some church miracle rules for casting
/datum/mob_quirks/sophisticated //gives them the stuck up noble clothes
/datum/mob_quirks/null //combines the effects from other quirks at complete random
/datum/mob_quirks/potionboy //has potions, has skill to make them too
/datum/mob_quirks/poison //has many poison types on them
/datum/mob_quirks/experiment //disfigured orc
/datum/mob_quirks/monster_priest //an astrata priest, but a monster
/datum/mob_quirks/spider //has a posse of 3 spiders, can call for more if they die
/datum/mob_quirks/



\*/
