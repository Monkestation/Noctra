#define TITLE_PREVIOUSTITLE 1
#define ONLY_NEWTTITLE 2
#define TITLE_ADJECTIVE 3
#define TITLE_NOUN_PEPHRASE 4
#define TITLE_NOUN 5
/*
/datum/renown
	var/mob/owner
	var/rank = 0
	var/killcount = 0

/datum/renown/New()
	if(owner.ckey && owner.client)
		owner.AddComponent(/datum/component/renown_hearing, GLOB.legendary_name_evil_regex, "red", src)
		owner.AddComponent(/datum/component/renown_hearing, GLOB.legendary_name_maybeevil_regex, "yellow", src)

/datum/renown/proc/process_renown(sentient = TRUE)
	if(!sentient)
		killcount++
		rank = FLOOR(killcount / 2, 1)
		if(killcount == 3)
			give_beast_name()
			//make_beast_sentient()


	//if(HAS_TRAIT(owner, TRAIT))
	if(HAS_TRAIT(owner, TRAIT_MERCGUILD)) //only guild members get renown for now, until party datum is added.
		rank++


/datum/renown/proc/give_beast_name()
	var/previoustitle = owner.real_name
	var/title = pick("Chax", "Gifflet", "Abigor", "Akar", "Tuwile", "Ernesh", "Leah", "Daghishat", "Nirnasha", "Azazel", "Heath", "Agrona", "Gorgon", "khazz", "Trurr", "Thekuax", "Gyrr", "Thruc", "Gengol", "Sryt", "Matirè", "Nikot", "Rithod", "Asmuk", "Cifano", "Sasmok", "Lebes", "Kök", "Rashgur", "Osp", "Geshak", "Zursmu", "Ber", "Metava", "Fer", "Suku", "Zewoth", "Imici", "Sinsot", "Rathi", "Vulo", "Disuth", "Mozfel", "Ogthrak", "Pushkrimp", "Golm") //bunch of fuck off names, mostly dwarf fortress words.
	var/adjective = pick("Strong", "Weak", "Fast", "Slow", "Beast", "Wild", "Sophisticated", "Silent", "Savage", "Frenzied", "Brutal", "Bloodthirsty", "Unstoppable", "Vicious", "Puny", "Shy", "tricky", "Wicked", "Swift", "Reaper", "Heartless", "Timid", "Wastefull", "One-Word", "Biter", "One", "Blast", "Cannibal", "Itchy", "Smelly", "Fat", "Bewitched", "Handsome", "Charming", "Angry", "Bloated", "Agonizer", "Cruel", "Dead", "Gentle", "Friendly", "Greedy", "Funny", "Hungry", "Dumb", "Screamer", "Merciful", "Ever-Loving", "Stone-Gut", "Oblivious", "Poet", "Runt", "Messenger", "Prophet", "Whiner", "Teary-Eyed", "Shamed")
	var/noun = pick("Annihilator", "Destroyer", "Scourge", "Bane", "Breaker", "Killer", "Slayer", "Slaver", "Eater", "Crusher", "Cleaver", "Desecrator", "Wrecker", "Ravager", "Ruiner", "Vandal", "Devastater")
	var/pephrase = pick("Bones", "Worlds", "Towns", "Elves", "Skulls", "Dwarves", "Trees", "Mountains", "Iron", "Steel", "Humens", "Orcs", "Goblins", "Trolls", "Spiders", "Harpies", "Kobolds", "Hollow-Kin", "Tieflings", "Blood-suckers", "Werevolves", "Volves", "Moo-Beast", "Adventurers", "Fools", "Mercenaries", "Cities", "Machines", "Hearts", "Spleens", "Horcs", "Drow", "Lungs", "Throats", "Eyes", "Tongues", "Zizo", "astrata", "Noc", "Dendor", "Necra", "Ravox", "Xylix", "Pestra", "Malum", "Eora", "Graggar", "Matthios", "Baotha", "Faithless", "Walls", "Towers", "Houses", "Guilds", "Legs", "Arms", "Fingers", "Armour", "Weapons", "Thrones")
	switch(rand(1,5))
		if(TITLE_PREVIOUSTITLE) // title + previoustitle, ie 'john the goblin', this of course means we are hoping that the npc title is the species of the owner, otherwise this is going to get dumb
			owner.real_name = "[title] the [previoustitle]"
		if(ONLY_NEWTTITLE) //just the new title, ie 'mario'
			owner.real_name = "[title]"
		if(TITLE_ADJECTIVE) // title + adjective, ie 'john the fast'
			owner.real_name = "[title] the [adjective]"
		if(TITLE_NOUN_PEPHRASE) // title + noun + pephrase, ie 'john the destroyer of worlds'
			owner.real_name = "[title] the [noun] of [pephrase]"
		if(TITLE_NOUN) //title + noun, ie just john the destroyer
			owner.real_name = "[title] the [noun]"

/datum/renown/proc/promote_beast()
	if(!owner.ckey && !owner.client)
		var/promotionlegibrace = list(/mob/living/carbon/human/species/skeleton, /mob/living/carbon/human/species/goblin, /mob/living/carbon/human/species/orc)
		var/promotionlegiable = istype(owner, promotionlegibrace)
		if(promotionlegiable)
			if(rank >= 0)
				if(rank <= 4)
					var/mob/living/O = owner
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

/datum/renown/proc/make_beast_sentient()
	var/mob/living/bober = owner
	if(!bober.dontmakesentient)
		if(!bober.ckey)
			var/name = bober.real_name
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("[name] HAS EARNED HIGHER INTELLIGENCE, WILL YOU CONTROL THEM?", ROLE_NECRO_SKELETON, null, null, 70, bober, POLL_IGNORE_SENTIENCE_POTION, TRUE)
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				bober.visible_message("[name] cackles maniacally, their eyes flared with new found intelligence.")
				message_admins("[key_name_admin(C)] has taken control of ([key_name_admin(bober)]) as their sentience")
				bober.key = C.key */

#undef TITLE_PREVIOUSTITLE
#undef ONLY_NEWTTITLE
#undef TITLE_ADJECTIVE
#undef TITLE_NOUN_PEPHRASE
#undef TITLE_NOUN
