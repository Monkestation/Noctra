// Alright. I'm sorting this shit now because Zeth is either a fucking sociopath or incompetent when it comes to tagging.


//////////////////////////
/// ALCHEMICAL POTIONS ///
//////////////////////////

/obj/item/reagent_containers/glass/bottle/additive
	list_reagents = list(/datum/reagent/additive = 10)

/obj/item/reagent_containers/glass/bottle/healthpot
	list_reagents = list(/datum/reagent/medicine/healthpot = 45)

/obj/item/reagent_containers/glass/bottle/stronghealthpot
	list_reagents = list(/datum/reagent/medicine/stronghealth = 45)

/obj/item/reagent_containers/glass/bottle/manapot
	list_reagents = list(/datum/reagent/medicine/manapot = 45)

/obj/item/reagent_containers/glass/bottle/strongmanapot
	list_reagents = list(/datum/reagent/medicine/strongmana = 45)

/obj/item/reagent_containers/glass/bottle/stampot
	list_reagents = list(/datum/reagent/medicine/stampot = 45)

/obj/item/reagent_containers/glass/bottle/strongstampot
	list_reagents = list(/datum/reagent/medicine/strongstam = 45)

/obj/item/reagent_containers/glass/bottle/poison
	list_reagents = list(/datum/reagent/berrypoison = 15)

/obj/item/reagent_containers/glass/bottle/strongpoison
	list_reagents = list(/datum/reagent/strongpoison = 15)

/obj/item/reagent_containers/glass/bottle/stampoison
	list_reagents = list(/datum/reagent/stampoison = 15)

/obj/item/reagent_containers/glass/bottle/strongstampoison
	list_reagents = list(/datum/reagent/strongstampoison = 15)

/obj/item/reagent_containers/glass/bottle/killersice
	list_reagents = list(/datum/reagent/killersice = 15)

/obj/item/reagent_containers/glass/bottle/water
	list_reagents = list(/datum/reagent/water = 45)

/obj/item/reagent_containers/glass/bottle/antidote
	list_reagents = list(/datum/reagent/medicine/antidote = 45)

/obj/item/reagent_containers/glass/bottle/diseasecure
	list_reagents = list(/datum/reagent/medicine/diseasecure = 45)

/obj/item/reagent_containers/glass/bottle/vial/strpot
	list_reagents = list(/datum/reagent/buff/strength = 30)

/obj/item/reagent_containers/glass/bottle/vial/perpot
	list_reagents = list(/datum/reagent/buff/perception = 30)

/obj/item/reagent_containers/glass/bottle/vial/intpot
	list_reagents = list(/datum/reagent/buff/intelligence = 30)

/obj/item/reagent_containers/glass/bottle/vial/conpot
	list_reagents = list(/datum/reagent/buff/constitution = 30)

/obj/item/reagent_containers/glass/bottle/vial/endpot
	list_reagents = list(/datum/reagent/buff/endurance = 30)

/obj/item/reagent_containers/glass/bottle/vial/spdpot
	list_reagents = list(/datum/reagent/buff/speed = 30)

/obj/item/reagent_containers/glass/bottle/vial/lucpot
	list_reagents = list(/datum/reagent/buff/fortune = 30)

/obj/item/reagent_containers/glass/bottle/vial/genderpot
	list_reagents = list(/datum/reagent/medicine/gender_potion = 5)

/obj/item/reagent_containers/glass/bottle/vial/strongpoison
	list_reagents = list(/datum/reagent/strongpoison = 30)

/obj/item/reagent_containers/glass/bottle/vial/antidote
	list_reagents = list(/datum/reagent/medicine/antidote = 30)

/obj/item/reagent_containers/glass/bottle/vial/healthpot
	list_reagents = list(/datum/reagent/medicine/healthpot = 30)

/obj/item/reagent_containers/glass/bottle/vial/stronghealthpot
	list_reagents = list(/datum/reagent/medicine/stronghealth = 30)

//////////////////////////
/// ALCOHOLIC BOTTLES ///	- add fancy var to retain custom descriptions when corking
//////////////////////////

// BEER - Cheap, Plentiful, Saviours of Family Life
/obj/item/reagent_containers/glass/bottle/beer
	name = "bottle of beer"
	desc = "A bottle that contains a generic housebrewed small-beer. It has an improvised corkseal made of hardened clay."
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 70)
	fancy = TRUE
	auto_label = TRUE

/obj/item/reagent_containers/glass/bottle/beer/spottedhen
	desc = "A bottle with the spotted-hen cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/spottedhen = 70)
	auto_label_name = "spotted hen"

/obj/item/reagent_containers/glass/bottle/beer/blackgoat
	desc = "A bottle with the black goat kriek cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/blackgoat = 70)
	auto_label_name = "black goat"

/obj/item/reagent_containers/glass/bottle/beer/ratkept
	desc = "A bottle with surprisingly no cork-seal. On the glass is carved the word \"ONI-N\", the 'O' seems to have been scratched out completely. Dubious. On the glass is a paper glued to it showing an illustration of rats guarding a cellar filled with bottles against a hoard of beggars."
	list_reagents = list(/datum/reagent/consumable/ethanol/onion = 70)
	auto_label_name = "\"ONI-N\""

/obj/item/reagent_containers/glass/bottle/beer/hagwoodbitter
	desc = "A bottle with the hagwood bitters cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/hagwoodbitter = 70)
	auto_label_name = "hagwood bitters"

/obj/item/reagent_containers/glass/bottle/beer/aurorian
	desc = "A bottle with the aurorian brewhouse cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/aurorian = 70)
	auto_label_name = "the aurorian"

/obj/item/reagent_containers/glass/bottle/beer/fireleaf
	desc = "A bottle with a generic leaf cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/fireleaf= 70)
	auto_label_name = "fireleaf"

/obj/item/reagent_containers/glass/bottle/beer/butterhairs
	desc = "A bottle with the Dwarven Federation Trade Alliance cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/butterhairs = 70)
	auto_label_name = "butter hairs"

/obj/item/reagent_containers/glass/bottle/beer/stonebeardreserve
	desc = "A bottle with the House Stoutenson cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/stonebeards = 70)
	auto_label_name = "stonebeard's reserve"

/obj/item/reagent_containers/glass/bottle/beer/voddena
	desc = "A bottle with the House Stoutenson cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/voddena = 45)
	auto_label_name = "voddena"

// WINES - Expensive, Nobleblooded
/obj/item/reagent_containers/glass/bottle/wine
	name = "bottle of wine"
	desc = "A bottle that contains a generic red-wine, likely from Zaladin. It has a red-clay cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 70)
	fancy = TRUE
	auto_label = TRUE

/obj/item/reagent_containers/glass/bottle/wine/sourwine
	desc = "A bottle that contains a Grenzelhoftian classic with a black ink cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/sourwine = 70)
	auto_label_name = "black eagle sour"

/obj/item/reagent_containers/glass/bottle/redwine
	desc = "A bottle with the Valorian Merchant Guild cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 70)
	auto_label_name = "young valorian red"

/obj/item/reagent_containers/glass/bottle/whitewine
	desc = "A bottle with the Valorian Merchant Guild cork-seal."
	list_reagents = list(/datum/reagent/consumable/ethanol/whitewine = 70)
	auto_label_name = "sweet valorian white"

/obj/item/reagent_containers/glass/bottle/elfred
	desc = "A bottle gilded with a silver cork-seal. Likely worth more than what an entire village makes!"
	list_reagents = list(/datum/reagent/consumable/ethanol/elfred = 70)
	auto_label_name = "elvish valorian red"

/obj/item/reagent_containers/glass/bottle/elfblue
	desc = "A bottle gilded with a golden cork-seal. This bottle would swoon Gods over!"
	list_reagents = list(/datum/reagent/consumable/ethanol/elfblue = 70)
	auto_label_name = "valmora blue"

/obj/item/reagent_containers/glass/bottle/tiefling_wine
	desc = "A bottle of generic red-wine, at first glance. The wine is infused with Tiefling blood and glows in the dark."
	list_reagents = list(/datum/reagent/consumable/ethanol/tiefling/aged = 45)
	auto_label_name = "tiefling-blood wine"
