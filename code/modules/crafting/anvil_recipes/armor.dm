/datum/anvil_recipe/armor
	appro_skill = /datum/skill/craft/armorsmithing
	i_type = "Armor"
	craftdiff = 1
	abstract_type = /datum/anvil_recipe/armor
	category = "Armor"

//For the sake of keeping the code modular with the introduction of new metals, each recipe has had it's main resource added to it's datum
//This way, we can avoid having to name things in strange ways and can simply have iron/cuirass, stee/cuirass, blacksteel/cuirass->
//-> and not messy names like ibreastplate and hplate

// --------- COPPER -----------

/datum/anvil_recipe/armor/copper
	abstract_type = /datum/anvil_recipe/armor/copper
	craftdiff = 0 // for starters
	req_bar = /obj/item/ingot/copper
///////////////////////////////////////////////

// COPPER ARMOR
/datum/anvil_recipe/armor/copper/cuirass
	name = "Copper heart protector"
	recipe_name = "a simple armor piece for the chest"
	created_item = /obj/item/clothing/armor/cuirass/copperchest

/datum/anvil_recipe/armor/copper/bracers
	name = "Copper bracers"
	recipe_name = "a pair of Copper bracers"
	created_item = /obj/item/clothing/wrists/bracers/copper

/datum/anvil_recipe/armor/copper/mask
	name = "Copper mask"
	recipe_name = "a mask of copper"
	created_item = /obj/item/clothing/face/facemask/copper

// NECK ARMOR
/datum/anvil_recipe/armor/copper/gorget
	name = "Copper neck protector"
	recipe_name = "a neck protector"
	created_item = /obj/item/clothing/neck/gorget/copper

// HELMETS
/datum/anvil_recipe/armor/copper/cap
	name = "Lamellar cap"
	recipe_name = "a copper cap"
	created_item = /obj/item/clothing/head/helmet/coppercap

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- IRON -----------
/datum/anvil_recipe/armor/iron
	req_bar = /obj/item/ingot/iron
	craftdiff = 1
	abstract_type = /datum/anvil_recipe/armor/iron
///////////////////////////////////////////////

// IRON ARMOR
/datum/anvil_recipe/armor/iron/splint
	name = "Splint Armor (+Hide)"
	recipe_name = "durable light armor"
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/armor/leather/splint

/datum/anvil_recipe/armor/iron/cuirass
	name = "Iron Cuirass"
	recipe_name = "an iron cuirass"
	created_item = /obj/item/clothing/armor/cuirass/iron

/datum/anvil_recipe/armor/iron/chausses
	name = "Iron Plate Chausses"
	recipe_name = "a pair of iron Plate Chausses"
	created_item = /obj/item/clothing/pants/platelegs/iron

/datum/anvil_recipe/armor/iron/platemask
	name = "2x Iron Face Masks"
	recipe_name = "a Face Mask"
	created_item = /obj/item/clothing/face/facemask
	createditem_extra = 1
	craftdiff = 0

// IRON CHAIN ARMOR
/datum/anvil_recipe/armor/iron/chainmail
	name = "Iron Maille"
	recipe_name = "an iron maille shirt"
	created_item = /obj/item/clothing/armor/chainmail/iron

/datum/anvil_recipe/armor/iron/hauberk
	name = "Iron Hauberk (+Bar)"
	recipe_name = "a Hauberk"
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/chainmail/hauberk/iron

/datum/anvil_recipe/armor/iron/chainleg
	name = "Iron Chain Chausses"
	recipe_name = "a pair of Chain Chausses"
	created_item = /obj/item/clothing/pants/chainlegs/iron

/datum/anvil_recipe/armor/iron/chainkilt
	name = "Iron Chain Kilt"
	recipe_name = "a short Chain Kilt"
	created_item = /obj/item/clothing/pants/chainlegs/kilt/iron

/datum/anvil_recipe/armor/iron/chainglove
	name = "2x Iron Chain Gauntlets"
	recipe_name = "two pairs of Chain Gauntlets"
	created_item = /obj/item/clothing/gloves/chain/iron
	createditem_extra = 1

// IRON NECK ARMOR
/datum/anvil_recipe/armor/iron/gorget
	name = "Iron Gorget"
	recipe_name = "a gorget"
	created_item = /obj/item/clothing/neck/gorget

/datum/anvil_recipe/armor/iron/chaincoif
	name = "Iron Chain Coif"
	recipe_name = "a Chain Coif"
	created_item = /obj/item/clothing/neck/chaincoif/iron

/datum/anvil_recipe/armor/iron/highcollier
	name = "Iron High Collier"
	recipe_name = "a High Collier"
	created_item = /obj/item/clothing/neck/highcollier/iron
	craftdiff = 1

/datum/anvil_recipe/armor/iron/highcollier_renegade
	name = "Iron Renegade Collar"
	recipe_name = "a renegade collar"
	created_item = /obj/item/clothing/neck/highcollier/iron/renegadecollar
	craftdiff = 1

/datum/anvil_recipe/armor/iron/chainglove
	name = "2x Iron Chain Gauntlets"
	recipe_name = "two pairs of Chain Gauntlets"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/gloves/chain/iron
	createditem_extra = 1
	craftdiff = 0

/datum/anvil_recipe/armor/iron/igauntlets
	name = "Iron Plate Gauntlets"
	recipe_name = "a pair of Plate Gauntlets"
	created_item = /obj/item/clothing/gloves/plate/iron

/datum/anvil_recipe/armor/iron/ibracers
	name = "Iron Plate Vambraces"
	recipe_name = "a pair of Plate Vambraces"
	created_item = /obj/item/clothing/wrists/bracers/iron

/datum/anvil_recipe/armor/iron/chainmail
	name = "Iron Haubergeon"
	recipe_name = "a Haubergeon"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/armor/chainmail/iron

/datum/anvil_recipe/armor/iron/hauberk
	name = "Hauberk (+Bar)"
	recipe_name = "a Hauberk"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/chainmail/hauberk/iron

/datum/anvil_recipe/armor/iron/cuirass
	name = "Iron Cuirass"
	recipe_name = "a cuirass"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/armor/cuirass/iron
	craftdiff = 0

/datum/anvil_recipe/armor/iron/platefull
	name = "Iron Plate Armor (+Bar x3)"
	recipe_name = "a full set of Full-Plate Armor"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/plate/full/iron
	craftdiff = 2

/datum/anvil_recipe/armor/iron/platefull_shadow
	name = "Iron Plate Shadow Armor (+Bar x3)"
	recipe_name = "a full set of Full-Plate Shadow Armor"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/cuirass/iron/shadowplate
	craftdiff = 2

/datum/anvil_recipe/armor/iron/halfplate
	name = "Iron Half-plate (+Bar x2)"
	recipe_name = "a Half-Plate Armor"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/plate/iron
	craftdiff = 1

/datum/anvil_recipe/armor/iron/platehelmet
	name = "Iron Plate Helmet (+Bar)"
	recipe_name = "a heavy iron helmet"
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/heavy/ironplate
	craftdiff = 1

/datum/anvil_recipe/armor/iron/barred_helmet
	name = "Barred Helmet (+Bar)"
	recipe_name = "a heavy iron helmet"
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/townwatch/gatemaster
	craftdiff = 1

/datum/anvil_recipe/armor/iron/winged_helmet
	name = "Winged Helmet"
	recipe_name = "an iron helmet"
	created_item = /obj/item/clothing/head/helmet/winged
	craftdiff = 1

/datum/anvil_recipe/armor/iron/horned_helmet
	name = "Horned Helmet"
	recipe_name = "an iron helmet"
	created_item = /obj/item/clothing/head/helmet/horned
	craftdiff = 1

/datum/anvil_recipe/armor/steel/bastion_helm
	name = "Bastion helm (+Bar X2)"
	recipe_name = "a heavy steel bastion helmet"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/helmet/heavy/necked
	craftdiff = 2

/datum/anvil_recipe/armor/steel/crusader_helm
	name = "Crusader helm (+Bar X2)"
	recipe_name = "a heavy steel crusader helmet"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/helmet/heavy/crusader
	craftdiff = 2

/datum/anvil_recipe/armor/steel/totod_crusader_helm
	name = "Totod Crusader helm (+Bar X2)"
	recipe_name = "a heavy steel totod crusader helmet"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/helmet/heavy/crusader/t
	craftdiff = 2

/datum/anvil_recipe/armor/iron/cage_helmet
	name = "feldsher's cage"
	recipe_name = "a cage helmet"
	created_item = /obj/item/clothing/head/helmet/feld
	craftdiff = 1

/datum/anvil_recipe/armor/iron/pothelmet
	name = "Pot Helmet"
	recipe_name = "a sturdy iron helmet"
	created_item = /obj/item/clothing/head/helmet/ironpot

/datum/anvil_recipe/armor/iron/nasal_helmet
	name = "Nasal helmet"
	recipe_name = "a Nasal helmet"
	created_item = /obj/item/clothing/head/helmet/nasal

/datum/anvil_recipe/armor/iron/skullcap
	name = "Skullcap"
	recipe_name = "a skullcap"
	created_item = /obj/item/clothing/head/helmet/skullcap

/datum/anvil_recipe/armor/iron/helmetkettle
	name = "Iron Kettle Helmet"
	recipe_name = "a Kettle Helmet"
	created_item = /obj/item/clothing/head/helmet/kettle/iron

/datum/anvil_recipe/armor/iron/helmetslitkettle
	name = "Slitted Iron Kettle Helmet"
	recipe_name = "a slitted kettle helmets"
	created_item = /obj/item/clothing/head/helmet/kettle/slit/iron

/datum/anvil_recipe/armor/iron/helmetsall
	name = "Iron Sallet"
	recipe_name = "a Sallet"
	created_item = /obj/item/clothing/head/helmet/sallet/iron

/datum/anvil_recipe/armor/iron/helmetsallv
	name = "Visored Iron Sallet (+Bar)"
	recipe_name = "a Visored Sallet"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/visored/sallet/iron
	craftdiff = 2

/datum/anvil_recipe/armor/iron/eoran_sallet
	name = "Eoran Sallet (+Bar)"
	recipe_name = "an Eoran Sallet"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/sallet/eoran
	craftdiff = 2

/datum/anvil_recipe/armor/iron/helmetknight
	name = "Iron Knight's helmet (+Bar)"
	recipe_name = "a Knight's Helmet"
	additional_items = list(/obj/item/ingot/iron)
	created_item = (/obj/item/clothing/head/helmet/visored/knight/iron)
	craftdiff = 2

// IRON PLATE ARMOR
/datum/anvil_recipe/armor/iron/halfplate
	name = "Iron Half-plate (+Bar x2)"
	recipe_name = "a Half-Plate Armor"
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/plate/iron

/datum/anvil_recipe/armor/iron/platefull
	name = "Iron Plate Armor (+Bar x3)"
	recipe_name = "a full set of Full-Plate Armor"
	additional_items = list(/obj/item/ingot/iron,/obj/item/ingot/iron,/obj/item/ingot/iron)
	created_item = /obj/item/clothing/armor/plate/full/iron
	craftdiff = 2

/datum/anvil_recipe/armor/iron/platehelmet
	name = "Iron Plate Helmet (+Bar)"
	recipe_name = "a heavy iron helmet"
	additional_items = list(/obj/item/ingot/iron)
	created_item = /obj/item/clothing/head/helmet/heavy/ironplate
	craftdiff = 2

/datum/anvil_recipe/armor/bronze/gorget
	name = "Bronze Gorget"
	recipe_name = "a bronze gorget"
	req_bar = /obj/item/ingot/bronze
	created_item = /obj/item/clothing/neck/gorget/hoplite
	craftdiff = 0

/datum/anvil_recipe/armor/iron/bevor
	name = "Iron Bevor"
	recipe_name = "a Bevor"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/neck/bevor/iron

/datum/anvil_recipe/armor/iron/platebootlight
	name = "Light Plate Boots"
	recipe_name = "a pair of Light Plate Boots"
	created_item = /obj/item/clothing/shoes/boots/armor/light

/datum/anvil_recipe/armor/iron/nasal_helmet
	name = "Nasal helmet"
	recipe_name = "a Nasal helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/helmet/nasal
	craftdiff = 1

/datum/anvil_recipe/armor/iron/town_watch_helmet
	name = "Town Watch helmet"
	recipe_name = "a Town Watch helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/helmet/townwatch
	craftdiff = 1

/datum/anvil_recipe/armor/iron/town_watch_helmet_alt
	name = "Town Watch helmet (alt)"
	recipe_name = "a Town Watch helmet"
	req_bar = /obj/item/ingot/iron
	created_item = /obj/item/clothing/head/helmet/townwatch/alt
	craftdiff = 1

/datum/anvil_recipe/armor/iron/skullcap
	name = "Skullcap"
	recipe_name = "a skullcap"
	created_item = /obj/item/clothing/head/helmet/skullcap

/datum/anvil_recipe/armor/iron/splint
	name = "Splint Armor (+Hide)"
	recipe_name = "durable light armor"
	req_bar = /obj/item/ingot/iron
	additional_items = list(/obj/item/natural/hide)
	created_item = /obj/item/clothing/armor/leather/splint
	craftdiff = 1

// --------- STEEL -----------
/datum/anvil_recipe/armor/steel
	req_bar = /obj/item/ingot/steel
	abstract_type = /datum/anvil_recipe/armor/steel
	craftdiff = 2

/datum/anvil_recipe/armor/steel/bevor
	name = "Bevor"
	recipe_name = "a Bevor"
	req_bar = /obj/item/ingot/steel
	craftdiff = 2 // this is the good stuff
	abstract_type = /datum/anvil_recipe/armor/steel
///////////////////////////////////////////////

// STEEL ARMOR
/datum/anvil_recipe/armor/steel/jackchain
	name = "2x Jack Chains"
	recipe_name = "two pairs of Jack Chains"
	created_item = /obj/item/clothing/wrists/bracers/jackchain
	createditem_extra = 1

/datum/anvil_recipe/armor/steel/platemask
	name = "Steel Mask"
	recipe_name = "a Face Mask"
	created_item = (/obj/item/clothing/face/facemask/steel)

/datum/anvil_recipe/armor/steel/cuirass
	name = "Steel Cuirass"
	recipe_name = "a Cuirass"
	created_item = /obj/item/clothing/armor/cuirass

/datum/anvil_recipe/armor/steel/brigadine
	name = "Brigandine (+Bar x2, +Cloth)"
	recipe_name = "a Brigandine"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/armor/brigandine
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Great Helm"
	recipe_name = "a Bucket Helmet"
	req_bar = /obj/item/ingot/steel
	created_item = (/obj/item/clothing/head/helmet/heavy/bucket)
	craftdiff = 2

/datum/anvil_recipe/armor/iron/shadow_plate_gauntlets
	name = "Shadow Plate Gauntlets"
	recipe_name = "a pair of Shadow Plate Gauntlets"
	created_item = /obj/item/clothing/gloves/chain/iron/shadowgauntlets
	craftdiff = 3

/datum/anvil_recipe/armor/steel/templar
	craftdiff = 3
	abstract_type = /datum/anvil_recipe/armor/steel/templar

/datum/anvil_recipe/armor/steel/templar/helmet_noc
	name = "Noc Helmet (+Silver Bar)"
	recipe_name = "a noc helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/noc
	additional_items = list(/obj/item/ingot/silver)

/datum/anvil_recipe/armor/steel/templar/gold_helmet
	name = "Gold Helmet (+Gold Bar)"
	recipe_name = "a golden helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/bucket/gold
	additional_items = list(/obj/item/ingot/gold)

/datum/anvil_recipe/armor/steel/templar/helmet_astrata
	name = "Astratan Helmet (+Gold Bar)"
	recipe_name = "an astratan helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/astrata
	additional_items = list(/obj/item/ingot/gold)

/datum/anvil_recipe/armor/steel/templar/helmet_necra
	name = "Necran Helmet (+Iron Bar)"
	recipe_name = "a necran helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/necra
	additional_items = list(/obj/item/ingot/iron)

/datum/anvil_recipe/armor/steel/templar/helmet_dendor
	name = "Dendor Helmet (+Small Log)"
	recipe_name = "a dendorian helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/dendorhelm
	additional_items = list(/obj/item/grown/log/tree/small)

/datum/anvil_recipe/armor/steel/templar/helmet_pestra
	name = "Pestran Helmet (+Iron Bar)"
	recipe_name = "a pestran helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/pestrahelm
	additional_items = list(/obj/item/ingot/iron)

/datum/anvil_recipe/armor/steel/templar/helmet_malum
	name = "Malum Helmet (+Iron Bar)"
	recipe_name = "a malumite helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/malumhelm
	additional_items = list(/obj/item/ingot/iron)

/datum/anvil_recipe/armor/steel/templar/helmet_ravox
	name = "Ravox Helmet (+Iron Bar)"
	recipe_name = "a ravoxian helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/ravox
	additional_items = list(/obj/item/ingot/iron)

/datum/anvil_recipe/armor/steel/templar/helmet_xylix
	name = "Xylix Helmet (+Iron Bar)"
	recipe_name = "a xylixian helmet"
	created_item = /obj/item/clothing/head/helmet/heavy/necked/xylix
	additional_items = list(/obj/item/ingot/iron)

/datum/anvil_recipe/armor/steel/chainleg
	name = "Chain Chausses"
	recipe_name = "a pair of Chain Chausses"
	created_item = /obj/item/clothing/pants/chainlegs

/datum/anvil_recipe/armor/steel/chainkilt_steel
	name = "Chain Kilt"
	recipe_name = "a long Chain Kilt"
	created_item = /obj/item/clothing/pants/chainlegs/kilt

/datum/anvil_recipe/armor/steel/haubergeon
	name = "Haubergeon"
	recipe_name = "a Haubergeon"
	created_item = /obj/item/clothing/armor/chainmail

/datum/anvil_recipe/armor/steel/chainglove
	name = "2x Chain Gauntlets"
	recipe_name = "two pairs of Chain Gauntlets"
	created_item = /obj/item/clothing/gloves/chain
	createditem_extra = 1

/datum/anvil_recipe/armor/steel/hauberk
	name = "Hauberk (+Bar)"
	recipe_name = "a Hauberk"
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/chainmail/hauberk
	craftdiff = 3

/datum/anvil_recipe/armor/steel/scalemail
	name = "Scalemail (+Bar)"
	recipe_name = "a Scalemail"
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/medium/scale
	craftdiff = 3

// STEEL NECK ARMOR
/datum/anvil_recipe/armor/steel/bevor
	name = "Bevor"
	recipe_name = "a Bevor"
	created_item = /obj/item/clothing/neck/bevor

/datum/anvil_recipe/armor/steel/chaincoif
	name = "Chain Coif"
	recipe_name = "a Chain Coif"
	created_item = /obj/item/clothing/neck/chaincoif

/datum/anvil_recipe/armor/steel/highcolleir
	name = "High Collier"
	recipe_name = "a High Collier"
	created_item = /obj/item/clothing/neck/highcollier
	craftdiff = 3

// STEEL HELMETS
/datum/anvil_recipe/armor/steel/helmetbuc
	name = "Great Helm"
	recipe_name = "a Bucket Helmet"
	created_item = (/obj/item/clothing/head/helmet/heavy/bucket)

/datum/anvil_recipe/armor/steel/helmetkettle
	name = "Kettle Helmet"
	recipe_name = "a Kettle Helmet"
	created_item = /obj/item/clothing/head/helmet/kettle

/datum/anvil_recipe/armor/steel/helmetslitkettle
	name = "Slitted Kettle Helmet"
	recipe_name = "a slitted kettle helmets"
	created_item = /obj/item/clothing/head/helmet/kettle/slit

/datum/anvil_recipe/armor/steel/froghelmet
	name = "Frog Helmet"
	recipe_name = "a frog helmet"
	created_item = (/obj/item/clothing/head/helmet/heavy/frog)

/datum/anvil_recipe/armor/steel/helmetsall
	name = "Sallet"
	recipe_name = "a Sallet"
	created_item = /obj/item/clothing/head/helmet/sallet

/datum/anvil_recipe/armor/steel/bascinet
	name = "Bascinet"
	recipe_name = "a bascinet"
	created_item = /obj/item/clothing/head/helmet/bascinet

/datum/anvil_recipe/armor/steel/spangenhelm
	name = "Spangenhelm"
	recipe_name = "a nasal helm with built in eye protection"
	created_item = /obj/item/clothing/head/helmet/heavy/viking
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetknight
	name = "Knight's helmet (+Bar)"
	recipe_name = "a Knight's Helmet"
	additional_items = list(/obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/knight)
	craftdiff = 3

/datum/anvil_recipe/armor/steel/helmetsallv
	name = "Visored sallet (+Bar)"
	recipe_name = "a Visored Sallet"
	additional_items = list(/obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/sallet)
	craftdiff = 3

/datum/anvil_recipe/armor/steel/hounskull
	name = "Hounskull Helmet (+Bar x2)"
	recipe_name = "a Hounskull Helmet"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = (/obj/item/clothing/head/helmet/visored/hounskull)
	craftdiff = 4

// STEEL DECORATED HELMS
/datum/anvil_recipe/armor/steel/decoratedbascinet
	name = "Decorated Bascinet (+Cloth)"
	recipe_name = "a decorated bascinet"
	additional_items = list(/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/bascinet

/datum/anvil_recipe/armor/steel/decoratedhelmetbucgold
	name = "Decorated Gold-trimmed Great Helm (+Gold Bar, +Cloth)"
	additional_items = list(/obj/item/ingot/gold,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/golden

/datum/anvil_recipe/armor/steel/decoratedhelmetknight
	name = "Decorated Knight's Helmet (+Bar, +Cloth)"
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/knight
	craftdiff = 4

/datum/anvil_recipe/armor/steel/buckethelm
	name = "Decorated Great Helm (+Bar, +Cloth)"
	additional_items = list(/obj/item/ingot/steel, /obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/bucket
	craftdiff = 4

/datum/anvil_recipe/armor/steel/decoratedhelmetpig
	name = "Decorated Hounskull Helmet (+Bar x2, +Cloth)"
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel,/obj/item/natural/cloth)
	created_item = /obj/item/clothing/head/helmet/heavy/decorated/hounskull
	craftdiff = 4

/datum/anvil_recipe/armor/steel/halfplate_decrorated
	name = "Decorated Half-plate (+Steel Bar x2, + Gold Bar)"
	recipe_name = "a decorated Half-Plate Armor"
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel, /obj/item/ingot/gold)
	created_item = /obj/item/clothing/armor/plate/decorated
	craftdiff = 4

/datum/anvil_recipe/armor/steel/halfplate_decrorated_corset
	name = "Decorated Half-plate With Corset (+Steel Bar x2, + Gold Bar, + Silk x3)"
	recipe_name = "a decorated Half-Plate Armor with Corset"
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel, /obj/item/ingot/gold, /obj/item/natural/silk, /obj/item/natural/silk, /obj/item/natural/silk)
	created_item = /obj/item/clothing/armor/plate/decorated/corset
	craftdiff = 4

// STEEL PLATE ARMOR
/datum/anvil_recipe/armor/steel/halfplate
	name = "Steel Half-plate (+Bar x2)"
	recipe_name = "a Half-Plate Armor"
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/plate
	craftdiff = 3

/datum/anvil_recipe/armor/steel/platefull
	name = "Plate Armor (+Bar x3)"
	recipe_name = "a Full-Plate Armor"
	additional_items = list(/obj/item/ingot/steel,/obj/item/ingot/steel,/obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/plate/full
	craftdiff = 4

/datum/anvil_recipe/armor/steel/platebracer
	name = "Plate Vambraces"
	recipe_name = "Plate Vambraces"
	created_item = /obj/item/clothing/wrists/bracers
	craftdiff = 4

/datum/anvil_recipe/armor/steel/plateleg
	name = "Plate Chausses"
	recipe_name = "a pair of Plate Chausses"
	created_item = /obj/item/clothing/pants/platelegs
	craftdiff = 4

/datum/anvil_recipe/armor/steel/plateglove
	name = "Plate Gauntlets"
	recipe_name = "a pair of Plate Gauntlets"
	created_item = /obj/item/clothing/gloves/plate
	craftdiff = 4

/datum/anvil_recipe/armor/steel/plateboot
	name = "Plated boots"
	recipe_name = "some Plated Boots"
	created_item = /obj/item/clothing/shoes/boots/armor
	craftdiff = 4

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- SILVER -----------
/datum/anvil_recipe/armor/silver
	req_bar = /obj/item/ingot/silver
	craftdiff = 3 // harder to work with. mostly jewelry
	abstract_type = /datum/anvil_recipe/armor/silver
///////////////////////////////////////////////

// --------- SILVER -----------
/datum/anvil_recipe/armor/silver/bascinet
	name = "Silver Bascinet (+Steel Bar x2)"
	recipe_name = "a silver bascinet"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/head/helmet/visored/silver

/datum/anvil_recipe/armor/silver/plateleg
	name = "Silver Plate Chausses (+Steel Bar x2)"
	recipe_name = "a pair of Silver Plate Chausses"
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/pants/platelegs/silver

/datum/anvil_recipe/armor/silver/platefull
	name = "Silver Plate Armor (+Silver Bar, +Steel Bar x3)"
	recipe_name = "a Full-Plate Silver Armor"
	additional_items = list(/obj/item/ingot/silver, /obj/item/ingot/steel, /obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/clothing/armor/plate/full/silver
	craftdiff = 4

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- GOLD -----------
/datum/anvil_recipe/armor/gold
	req_bar = /obj/item/ingot/gold
	craftdiff = 3 // harder to work with. mostly jewelry
	abstract_type = /datum/anvil_recipe/armor/gold
///////////////////////////////////////////////

/datum/anvil_recipe/armor/gold/mask
	name = "Gold Mask"
	created_item = /obj/item/clothing/face/facemask/goldmask

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- BLACKSTEEL -----------
/datum/anvil_recipe/armor/blacksteel
	req_bar = /obj/item/ingot/blacksteel
	craftdiff = 4 // this is the good stuff
	abstract_type = /datum/anvil_recipe/armor/blacksteel
///////////////////////////////////////////////

// --------- BLACKSTEEL -----------
/datum/anvil_recipe/armor/blacksteel/platechest
	name = "Blacksteel Plate Armor (+Bar x3)"
	additional_items = list(/obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel, /obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/armor/plate/blkknight
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/platelegs
	name = "Blacksteel Plate Chausses (+Bar)"
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/pants/platelegs/blk
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/bucket
	name = "Blacksteel Great Helm (+Bar)"
	additional_items = list(/obj/item/ingot/blacksteel)
	created_item = /obj/item/clothing/head/helmet/blacksteel/bucket
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/plategloves
	name = "Blacksteel Plate Gauntlets"
	created_item = /obj/item/clothing/gloves/plate/blk
	craftdiff = 5

/datum/anvil_recipe/armor/blacksteel/plateboots
	name = "Blacksteel Plate Boots"
	created_item = /obj/item/clothing/shoes/boots/armor/blkknight
	craftdiff = 5
