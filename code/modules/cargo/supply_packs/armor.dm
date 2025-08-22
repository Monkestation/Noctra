// PRICESHEET: (this prices are based on aprox 1.5X before tax of prices of the player market at 11/08/25 )
// Leather = 20 per
// Iron = 30 per
// Steel = 50 per
// Wood = betwen 10-20
// essential items can be discounted because nobody even makes those anyways.
// any item can be little more or less , this is just a reference to not outcompete the smiths.

/datum/supply_pack/armor
	group = "Armor"
	crate_name = "merchant guild's crate"
	crate_type = /obj/structure/closet/crate/chest/merchant

// IRON GEAR

/datum/supply_pack/armor/light
	group = "Armor(Light)"

// HELMETS

/datum/supply_pack/armor/light/skullcap
	name = "Skullcap Helmet"
	cost = 30
	contains = /obj/item/clothing/head/helmet/skullcap

/datum/supply_pack/armor/light/minerhelmet
	name = "Miner's Helm"
	cost = 30
	contains = /obj/item/clothing/head/helmet/leather/minershelm

/datum/supply_pack/armor/light/poth
	name = "Pot Helmet"
	cost = 30
	contains = /obj/item/clothing/head/helmet/ironpot

// MASK COIF NECK

/datum/supply_pack/armor/light/imask
	name = "Iron Facemask"
	cost = 25
	contains = /obj/item/clothing/face/facemask

/datum/supply_pack/armor/light/chaincoif_iron
	name = "Iron Chain Coif"
	cost = 25
	contains = /obj/item/clothing/neck/chaincoif/iron

// ARMOR

/datum/supply_pack/armor/light/lightleather_armor
	name = "Leather Armor"
	cost = 30
	contains = /obj/item/clothing/armor/leather

/datum/supply_pack/armor/light/splint
	name = "Splint Armor"
	cost = 50
	contains = /obj/item/clothing/armor/leather/splint

/datum/supply_pack/armor/light/studleather
	name = "Hardened Leather Armor"
	cost = 60
	contains = /obj/item/clothing/armor/leather/advanced

/datum/supply_pack/armor/light/cuirass_iron
	name = "Iron Cuirass"
	cost = 30
	contains = /obj/item/clothing/armor/cuirass/iron

/datum/supply_pack/armor/light/ihalf_plate
	name = "Iron Half-plate"
	cost = 60
	contains = /obj/item/clothing/armor/plate/iron

/datum/supply_pack/armor/light/ifull_plate
	name = "Iron Plate Armor"
	cost = 90
	contains = /obj/item/clothing/armor/cuirass/iron

// SHIRT ARMOR

/datum/supply_pack/armor/light/chainmail_iron
	name = "Iron Chainmail"
	cost = 30
	contains = /obj/item/clothing/armor/chainmail/iron

/datum/supply_pack/armor/light/haukberk
	name = "Iron hauberk"
	cost = 60
	contains = /obj/item/clothing/armor/chainmail/hauberk/iron

// ARMS

/datum/supply_pack/armor/light/leather_bracers
	name = "Leather Bracers"
	cost = 20
	contains = /obj/item/clothing/wrists/bracers/leather

/datum/supply_pack/armor/light/bracers
	name = "iron vambraces"
	cost = 30
	contains = /obj/item/clothing/wrists/bracers/iron

/datum/supply_pack/armor/light/heavy_gloves
	name = "Heavy Leather Gloves"
	cost = 20
	contains = /obj/item/clothing/gloves/angle

/datum/supply_pack/armor/light/chain_gloves_iron
	name = "Iron Chain Gloves"
	cost = 30
	contains = /obj/item/clothing/gloves/chain/iron

// PANTS

/datum/supply_pack/armor/light/chainlegs_iron
	name = "Iron Chain Chausses"
	cost = 30
	contains = /obj/item/clothing/pants/chainlegs/iron

/datum/supply_pack/armor/light/chainkilt_iron
	name = "Iron Chain Kilt"
	cost = 30
	contains = /obj/item/clothing/pants/chainlegs/kilt/iron

// BOOTS

/datum/supply_pack/armor/light/light_armor_boots
	name = "Iron Boots"
	cost = 30
	contains = /obj/item/clothing/shoes/boots/armor/light

// STEEL GEAR

/datum/supply_pack/armor/steel
	group = "Armor(Steel)"

// HELMETS
/datum/supply_pack/armor/steel/hounskull
	name = "Hounskull Helmet"
	cost = 100
	contains = /obj/item/clothing/head/helmet/visored/hounskull

/datum/supply_pack/armor/steel/nasalh
	name = "Nasal Helmet"
	cost = 50
	contains = /obj/item/clothing/head/helmet/nasal

/datum/supply_pack/armor/steel/sallet
	name = "Sallet Helmet"
	cost = 50
	contains = /obj/item/clothing/head/helmet/sallet

/datum/supply_pack/armor/steel/visorsallet
	name = "Visored Sallet"
	cost = 80
	contains = /obj/item/clothing/head/helmet/visored/sallet

/datum/supply_pack/armor/steel/buckethelm
	name = "Great Helm"
	cost = 50
	contains = /obj/item/clothing/head/helmet/heavy/bucket

// MASK COIF NECK

/datum/supply_pack/armor/steel/smask
	name = "Steel Facemask"
	cost = 50
	contains = /obj/item/clothing/face/facemask/steel

/datum/supply_pack/armor/steel/chaincoif_steel
	name = "Steel Chain Coif"
	cost = 30
	contains = /obj/item/clothing/neck/chaincoif

// ARMOR

/datum/supply_pack/armor/steel/cuirass
	name = "Steel Cuirass"
	cost = 50
	contains = /obj/item/clothing/armor/cuirass

/datum/supply_pack/armor/steel/brigandine
	name = "Brigandine"
	cost = 100
	contains = /obj/item/clothing/armor/brigandine

/datum/supply_pack/armor/steel/coatofplates
	name = "Coat Of Plates"
	cost = 130
	contains = /obj/item/clothing/armor/brigandine/coatplates

/datum/supply_pack/armor/steel/half_plate // so heavy users have something to buy
	name = "Steel Half-plate"
	cost = 150
	contains = /obj/item/clothing/armor/plate

// SHIRT ARMOR

/datum/supply_pack/armor/steel/chainmail
	name = "Steel Chainmail"
	cost = 50
	contains = /obj/item/clothing/armor/chainmail

/datum/supply_pack/armor/steel/chainmail_hauberk
	name = "Hauberk"
	cost = 80
	contains = /obj/item/clothing/armor/chainmail/hauberk

// ARMS

/datum/supply_pack/armor/steel/bracers
	name = "Steel Bracers"
	cost = 50
	contains = /obj/item/clothing/wrists/bracers

/datum/supply_pack/armor/steel/plate_gloves
	name = "Heavy Plate Gloves"
	cost = 50
	contains = /obj/item/clothing/gloves/plate

// PANTS

/datum/supply_pack/armor/steel/chainlegs_steel
	name = "Steel Chain Chausses"
	cost = 50
	contains = /obj/item/clothing/pants/chainlegs

/datum/supply_pack/armor/steel/chainkilt_steel
	name = "Steel Chain Kilt"
	cost = 50
	contains = /obj/item/clothing/pants/chainlegs/kilt

// BOOTS

/datum/supply_pack/armor/steel/steel_boots
	name = "Plate Boots"
	cost = 50
	contains = /obj/item/clothing/shoes/boots/armor
