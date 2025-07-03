#define TITLE_PREVIOUSTITLE 1
#define ONLY_NEWTTITLE 2
#define TITLE_ADJECTIVE 3
#define TITLE_NOUN_PEPHRASE 4
#define TITLE_NOUN 5

/mob/proc/process_renown(sentient = TRUE)
	//var/renown = GLOB.mob_renown_list[src.mobid]
	if(!sentient)
		var/killcount = GLOB.mob_kill_count[src.mobid]
		var/sentkillcount = GLOB.mob_sentient_kill_count[src.mobid]
		GLOB.mob_renown_list[src.mobid] += FLOOR(killcount / 2, 1)
		if(killcount == 1)
			give_beast_name(src)
		if(istype(src, /mob/living/carbon/human/species))
			var/renown = GLOB.mob_renown_list[src.mobid]
			if(renown >= 1)
				if(renown <= 4)
					promote_beast(src)
		if(sentkillcount == 1)
			make_beast_sentient(src)


/mob/proc/give_beast_name(mob/owner)
	var/previoustitle = owner.real_name
	var/title = pick("Chax", "Gifflet", "Abigor", "Akar", "Tuwile", "Ernesh", "Leah", "Daghishat", "Nirnasha", "Azazel", "Heath", "Agrona", "Gorgon", "khazz", "Trurr", "Thekuax", "Gyrr", "Thruc", "Gengol", "Sryt", "Matirè", "Nikot", "Rithod", "Asmuk", "Cifano", "Sasmok", "Lebes", "Kök", "Rashgur", "Osp", "Geshak", "Zursmu", "Ber", "Metava", "Fer", "Suku", "Zewoth", "Imici", "Sinsot", "Rathi", "Vulo", "Disuth", "Mozfel", "Ogthrak", "Pushkrimp", "Golm") //bunch of fuck off names, mostly dwarf fortress words.
	var/adjective = pick("Strong", "Weak", "Fast", "Slow", "Beast", "Wild", "Sophisticated", "Silent", "Savage", "Frenzied", "Brutal", "Bloodthirsty", "Unstoppable", "Vicious", "Puny", "Shy", "tricky", "Wicked", "Swift", "Reaper", "Heartless", "Timid", "Wastefull", "One-Word", "Biter", "One", "Blast", "Cannibal", "Itchy", "Smelly", "Fat", "Bewitched", "Handsome", "Charming", "Angry", "Bloated", "Agonizer", "Cruel", "Dead", "Gentle", "Friendly", "Greedy", "Funny", "Hungry", "Dumb", "Screamer", "Merciful", "Ever-Loving", "Stone-Gut", "Oblivious", "Poet", "Runt", "Messenger", "Prophet", "Whiner", "Teary-Eyed", "Shamed")
	var/noun = pick("Annihilator", "Destroyer", "Scourge", "Bane", "Breaker", "Killer", "Slayer", "Slaver", "Eater", "Crusher", "Cleaver", "Desecrator", "Wrecker", "Ravager", "Ruiner", "Vandal", "Devastater")
	var/pephrase = pick("Bones", "Worlds", "Towns", "Elves", "Skulls", "Dwarves", "Trees", "Mountains", "Iron", "Steel", "Humens", "Orcs", "Goblins", "Trolls", "Spiders", "Harpies", "Kobolds", "Hollow-Kin", "Tieflings", "Blood-suckers", "Werevolves", "Volves", "Moo-Beast", "Adventurers", "Fools", "Mercenaries", "Cities", "Machines", "Hearts", "Spleens", "Horcs", "Drow", "Lungs", "Throats", "Eyes", "Tongues", "Zizo", "Astrasta", "Noc", "Dendor", "Necra", "Ravox", "Xylix", "Pestra", "Malum", "Eora", "Graggar", "Matthios", "Baotha", "Faithless", "Walls", "Towers", "Houses", "Guilds", "Legs", "Arms", "Fingers", "Armour", "Weapons", "Thrones")
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

/mob/proc/promote_beast(mob/owner)
	if(isliving(owner))
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

/mob/proc/make_beast_sentient(mob/owner)
	var/mob/living/bober = owner
	if(!bober.dontmakesentient)
		if(!bober.ckey)
			var/name = bober.real_name
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("[name] HAS EARNED HIGHER INTELLIGENCE, WILL YOU CONTROL THEM?", null, null, null, 150, bober, null, new_players = TRUE)
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				bober.ckey = C.key
				bober.visible_message("[name] cackles maniacally, their eyes flared with newfound intelligence.")
				log_game("[key_name(C)] has taken control of ([key_name(bober)]) as their sentience")


#undef TITLE_PREVIOUSTITLE
#undef ONLY_NEWTTITLE
#undef TITLE_ADJECTIVE
#undef TITLE_NOUN_PEPHRASE
#undef TITLE_NOUN

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
