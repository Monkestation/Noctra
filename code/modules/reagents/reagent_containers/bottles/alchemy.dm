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

/obj/item/reagent_containers/glass/bottle/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 45)

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
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 70)
	desc = "A bottle that contains a generic housebrewed small-beer. It has an improvised corkseal made of hardened clay."
	fancy = TRUE

/obj/item/reagent_containers/glass/bottle/beer/spottedhen
	list_reagents = list(/datum/reagent/consumable/ethanol/spottedhen = 70)
	desc = "A bottle with the spotted-hen cork-seal. An extremely cheap lager hailing from a local brewery."

/obj/item/reagent_containers/glass/bottle/beer/blackgoat
	list_reagents = list(/datum/reagent/consumable/ethanol/blackgoat = 70)
	desc = "A bottle with the black goat kriek cork-seal. A fruit-sour beer brewed with jackberries for a tangy taste."

/obj/item/reagent_containers/glass/bottle/beer/ratkept
	list_reagents = list(/datum/reagent/consumable/ethanol/onion = 70)
	desc = "A bottle with surprisingly no cork-seal. On the glass is carved the word \"ONI-N\", the 'O' seems to have been scratched out completely. Dubious. On the glass is a paper glued to it showing an illustration of rats guarding a cellar filled with bottles against a hoard of beggars."

/obj/item/reagent_containers/glass/bottle/beer/hagwoodbitter
	list_reagents = list(/datum/reagent/consumable/ethanol/hagwoodbitter = 70)
	desc = "A bottle with the hagwood bitters cork-seal. The least bitter thing to be exported from the Grenzelhoft occupied state of Zorn."

/obj/item/reagent_containers/glass/bottle/beer/aurorian
	list_reagents = list(/datum/reagent/consumable/ethanol/aurorian = 70)
	desc = "A bottle with the aurorian brewhouse cork-seal. An Elvish beer brewed from an herbal gruit."

/obj/item/reagent_containers/glass/bottle/beer/fireleaf
	list_reagents = list(/datum/reagent/consumable/ethanol/fireleaf= 70)
	desc = "A bottle with a generic leaf cork-seal. An Elvish beer formed by distilling cabbages. You're pretty sure you can make your own with certainly higher quality."

/obj/item/reagent_containers/glass/bottle/beer/butterhairs
	list_reagents = list(/datum/reagent/consumable/ethanol/butterhairs = 70)
	desc = "A bottle with the Dwarven Federation Trade Alliance cork-seal. This beer, known as butterhairs: is widely considered one of the greatest exported by the Dwarves."

/obj/item/reagent_containers/glass/bottle/beer/stonebeardreserve
	list_reagents = list(/datum/reagent/consumable/ethanol/stonebeards = 70)
	desc = "A bottle with the House Stoutenson cork-seal. Stonebeards Reserve is one of the most legendary beers in existence, with only a few hundred barrels made every year."

/obj/item/reagent_containers/glass/bottle/beer/voddena
	list_reagents = list(/datum/reagent/consumable/ethanol/voddena = 45)
	desc = "A bottle with the House Stoutenson cork-seal. This strange liquid is considered as the most spicy and alcoholic drink in all the Mountainhomes. Bought by nobles of all ages, mostly those with a deathwish."

// WINES - Expensive, Nobleblooded
/obj/item/reagent_containers/glass/bottle/wine
	list_reagents = list(/datum/reagent/consumable/ethanol/wine = 70)
	desc = "A bottle that contains a generic red-wine, likely from Zaladin. It has a red-clay cork-seal."
	fancy = TRUE

/obj/item/reagent_containers/glass/bottle/wine/sourwine
	list_reagents = list(/datum/reagent/consumable/ethanol/sourwine = 70)
	desc = "A bottle that contains a Grenzelhoftian classic with a black ink cork-seal.. An extremely sour wine that is watered down with mineral water."

/obj/item/reagent_containers/glass/bottle/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 70)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a relatively young red-wine from the coinlord state."

/obj/item/reagent_containers/glass/bottle/whitewine
	list_reagents = list(/datum/reagent/consumable/ethanol/whitewine = 70)
	desc = "A bottle with the Valorian Merchant Guild cork-seal. This one appears to be labelled as a sweet wine from the colder northern regions."

/obj/item/reagent_containers/glass/bottle/elfred
	list_reagents = list(/datum/reagent/consumable/ethanol/elfred = 70)
	desc = "A bottle gilded with a silver cork-seal. It appears to be labelled as a elvish red wine from Valoria. Likely worth more than what an entire village makes!"

/obj/item/reagent_containers/glass/bottle/elfblue
	list_reagents = list(/datum/reagent/consumable/ethanol/elfblue = 70)
	desc = "A bottle gilded with a golden cork-seal. This is the legendary Valmora Blue from the Vineyard of Valmora, headed by a sainted Dark-Elf swordsmaster. This bottle would swoon Gods over!"

/obj/item/reagent_containers/glass/bottle/tiefling_wine
	list_reagents = list(/datum/reagent/consumable/ethanol/tiefling/aged = 45)

/obj/item/reagent_containers/glass/bottle/jagdtrunk
	list_reagents = list(/datum/reagent/consumable/ethanol/jagdtrunk = 48)
	desc = "A bottle with a Saigabuck cork-seal. This dark liquid is the strongest alcohol coming out of Grenzelhoft available. A herbal schnapps, sure to burn out any disease."

/obj/item/reagent_containers/glass/bottle/apfelweinheim
	list_reagents = list(/datum/reagent/consumable/ethanol/apfelweinheim = 48)
	desc = "A bottle with the Apfelweinheim cork-seal. A cider from the Grenzelhoftian town of Apfelweinheim. Well received for its addition of pear, alongside crisp apples."

/obj/item/reagent_containers/glass/bottle/rtoper
	list_reagents = list(/datum/reagent/consumable/ethanol/rtoper = 48)
	desc = "A bottle with the Lirvas-crest cork-seal. An especially tart cider from the petty kingdom of Lirvas. Myths say the brewers let the barrels age in the bog, which results in that especially stong flavour."

/obj/item/reagent_containers/glass/bottle/nred
	list_reagents = list(/datum/reagent/consumable/ethanol/nred = 48)
	desc = "A bottle with the City of Norwandine cork-seal. A red ale brewed to perfection in the lands of Hammerhold."

/obj/item/reagent_containers/glass/bottle/gronnmead
	list_reagents = list(/datum/reagent/consumable/ethanol/gronnmead = 48)
	desc = "A bottle with a Shieldmaiden Berewrey cork-seal. A deep red honey-wine, refined with the red berries native to Gronns highlands."

/obj/item/reagent_containers/glass/bottle/avarmead
	list_reagents = list(/datum/reagent/consumable/ethanol/avarmead = 48)
	desc = "A bottle with a simple cork-seal. A golden honey-wine brewed in the Avar Steppes. Manages to keep a proper taste while staying strong."

/obj/item/reagent_containers/glass/bottle/avarrice
	list_reagents = list(/datum/reagent/consumable/ethanol/avarrice = 48)
	desc = "A bottle with a simple cork-seal. A murky, white wine made from rice grown in the steppes of Avar."

/obj/item/reagent_containers/glass/bottle/saigamilk
	list_reagents = list(/datum/reagent/consumable/ethanol/saigamilk = 48)
	desc = "A bottle with a Running Saiga cork-seal. A form of alcohol brewed from the milk of a saiga and salt. Common drink of the nomads living in the steppe."

/obj/item/reagent_containers/glass/bottle/kgunlager
	list_reagents = list(/datum/reagent/consumable/ethanol/kgunlager = 48)
	desc = "A bottle with a Yamaguchi Brewery cork-seal. A pale lager brewed in the far-away lands of Kazengun, refined with green tea for an unique flavour-profile. Even lighter than elven-brew!"

/obj/item/reagent_containers/glass/bottle/kgunsake
	list_reagents = list(/datum/reagent/consumable/ethanol/kgunsake = 48)
	desc = "A bottle with a Golden Swan cork-seal. A translucient, pale-blue liquid made from rice. A favourite drink of the warlords and nobles of Kazengun."

/obj/item/reagent_containers/glass/bottle/kgunplum
	list_reagents = list(/datum/reagent/consumable/ethanol/kgunplum = 48)
	desc = "A bottle with a Golden Swan cork-seal. A reddish-golden alcohol made from a fruit commonly found on the Kazengun-isles. A favourite of the commoners."

/obj/item/reagent_containers/glass/bottle/kgunshochu
	list_reagents = list(/datum/reagent/consumable/ethanol/kgunshochu = 48)
	desc = "A bottle with a Golden Swan cork-seal. A clean alcohol made by distilling rice. With a dry and clean finish. Popular amongst the warrior caste of Kazengun."

// Zhongese Drinks
/obj/item/reagent_containers/glass/bottle/black
	name = "wine pot"
	desc = "A wine pot made of glazed clay."
	icon_state = "blackbottle"
	fill_icon_thresholds = null

/obj/item/reagent_containers/glass/bottle/black/Initialize()
	. = ..()
	icon_state = "blackbottle"
	update_appearance(UPDATE_OVERLAYS)

/obj/item/reagent_containers/glass/bottle/black/huangjiu
	list_reagents = list(/datum/reagent/consumable/ethanol/huangjiu = 48)
	desc = "A bottle with a red seal. A strong, sweet yellow rice wine that is often used in cooking."

/obj/item/reagent_containers/glass/bottle/black/baijiu
	list_reagents = list(/datum/reagent/consumable/ethanol/baijiu = 48)
	desc = "A bottle with a red seal. A strong, clear liquor made from fermented sorghum or rice. The favored drink of wandering warriors."

/obj/item/reagent_containers/glass/bottle/black/yaojiu
	list_reagents = list(/datum/reagent/consumable/ethanol/yaojiu = 48)
	desc = "A bottle with a red seal. A strong, sweet rice wine infused with medicinal herbs, including Ginseng. Often prescribed as a medicine on the Zhongese mainland."

/obj/item/reagent_containers/glass/bottle/black/shejiu
	list_reagents = list(/datum/reagent/consumable/ethanol/shejiu = 48)
	desc = "A bottle with a red seal. A strong rice wine with a dead snake inside. In the land of Zhong, It is believed that drinking this will improve one's virility and blood circulation."

/obj/item/reagent_containers/glass/bottle/black/murkwine
	list_reagents = list(/datum/reagent/consumable/ethanol/murkwine = 48)
	desc = "A bottle with a Possumtail Brewery mark. A special brew made from murky water and swampweed. A Heartfelt special."

/obj/item/reagent_containers/glass/bottle/black/nocshine
	list_reagents = list(/datum/reagent/consumable/ethanol/nocshine = 48)
	desc = "A bottle with a blue, Crescent moon mark. A special brew that is extremely potent and toxic, but strengthen the body. If you dare."

/obj/item/reagent_containers/glass/bottle/black/whipwine
	list_reagents = list(/datum/reagent/consumable/ethanol/whipwine = 48)
	desc = "A strange bottle with a concerningly brown color. It bears the seal of a snake's head over a leaf. Markings indicate the contents are supposed to be good for health..."

/obj/item/reagent_containers/glass/bottle/black/komuchisake
	list_reagents = list(/datum/reagent/consumable/ethanol/komuchisake = 48)
	desc = "A dusty, ancient bottle with a red-ochre coloring. It bears an intricately detailed golden skull seal, and the markings on it are clearly of the Shogunate. It looks to be filled with herbs inside."
