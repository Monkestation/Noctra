/obj/effect/mob_spawn/human/dwarf
	mob_species = /datum/species/dwarf/mountain

/obj/effect/mob_spawn/human/dwarf/trader
	outfit = /datum/outfit/job/miner

/datum/world_faction/mountain_clans
	faction_name = "Dwarven Clans"
	desc = "Hardy dwarves from the mountain passes"
	faction_color = "#708090"
	trader_outfits = list(
		/obj/effect/mob_spawn/human/dwarf/trader
	)
	trader_type_weights = list(
		/datum/trader_data/weapon_merchant = 15,
		/datum/trader_data/tool_merchant = 25,
		/datum/trader_data/material_merchant = 20,
		/datum/trader_data/food_merchant = 12,
		/datum/trader_data/clothing_merchant = 8,
		/datum/trader_data/alchemist = 7,
		/datum/trader_data/livestock_merchant = 5,
		/datum/trader_data/luxury_merchant = 5,
		/datum/trader_data/medicine_merchant = 3,
	)
	essential_packs = list(
		/datum/supply_pack/tools/pick,
		/datum/supply_pack/tools/hammer,
		/datum/supply_pack/tools/tongs,
		/datum/supply_pack/rawmats/iron,
		/datum/supply_pack/rawmats/coal
	)
	common_pool = list(
		// Armor - Heavy focus on practical protective gear
		/datum/supply_pack/armor/skullcap,
		/datum/supply_pack/armor/minerhelmet,
		/datum/supply_pack/armor/poth,
		/datum/supply_pack/armor/nasalh,
		/datum/supply_pack/armor/chaincoif_iron,
		/datum/supply_pack/armor/bracers,
		/datum/supply_pack/armor/chain_gloves_iron,
		/datum/supply_pack/armor/chainlegs_iron,
		/datum/supply_pack/armor/chainkilt_iron,
		/datum/supply_pack/armor/light_armor_boots,
		// Apparel
		/datum/supply_pack/apparel/hatfur,
		/datum/supply_pack/apparel/leather_boots,
		/datum/supply_pack/apparel/workervest,
		/datum/supply_pack/apparel/leather_trousers,
		/datum/supply_pack/apparel/knitcap,
		/datum/supply_pack/apparel/coif,
		/datum/supply_pack/apparel/apron_brown,
		/datum/supply_pack/apparel/black_leather_gloves,
		/datum/supply_pack/armor/leather_bracers,
		/datum/supply_pack/apparel/scabbard,
		/datum/supply_pack/apparel/sheath,
		// Tools - Core dwarven crafting tools
		/datum/supply_pack/tools/shovel,
		/datum/supply_pack/tools/rope,
		/datum/supply_pack/tools/chain,
		/datum/supply_pack/tools/Sickle,
		/datum/supply_pack/tools/pitchfork,
		/datum/supply_pack/tools/hoe,
		/datum/supply_pack/tools/thresher,
		/datum/supply_pack/tools/plough,
		/datum/supply_pack/tools/bucket,
		// Food - Hearty dwarven fare
		/datum/supply_pack/food/meat,
		/datum/supply_pack/food/blackgoat,
		/datum/supply_pack/food/potato,
		/datum/supply_pack/food/wheat,
		/datum/supply_pack/food/egg,
		/datum/supply_pack/food/butter,
		// Materials
		/datum/supply_pack/rawmats/copper,
		/datum/supply_pack/rawmats/tin,
		/datum/supply_pack/rawmats/lumber,
		/datum/supply_pack/rawmats/blocks,
		/datum/supply_pack/rawmats/ash
	)
	uncommon_pool = list(
		// Better armor
		/datum/supply_pack/armor/gambeson,
		/datum/supply_pack/armor/chainmail_iron,
		/datum/supply_pack/armor/chaincoif_steel,
		/datum/supply_pack/armor/chainlegs_steel,
		/datum/supply_pack/armor/chainkilt_steel,
		/datum/supply_pack/armor/angle_gloves,
		/datum/supply_pack/armor/steel_boots,
		// Apparel
		/datum/supply_pack/apparel/leather_vest_random,
		/datum/supply_pack/apparel/trousers,
		// Weapons - Dwarven combat gear
		/datum/supply_pack/weapons/axe,
		/datum/supply_pack/weapons/mace,
		/datum/supply_pack/weapons/smace,
		/datum/supply_pack/weapons/shortsword,
		/datum/supply_pack/weapons/sword_iron,
		/datum/supply_pack/weapons/shield,
		/datum/supply_pack/weapons/towershield,
		// Food & Drink
		/datum/supply_pack/food/butterhair,
		/datum/supply_pack/food/stonebeard,
		/datum/supply_pack/food/grenzelbeer,
		/datum/supply_pack/food/salami,
		// Instruments
		/datum/supply_pack/instruments/mbox,
		/datum/supply_pack/instruments/vocals,
		// Materials
		/datum/supply_pack/rawmats/sinew
	)
	rare_pool = list(
		// High-end armor
		/datum/supply_pack/armor/cuirass_iron,
		/datum/supply_pack/armor/brigandine,
		/datum/supply_pack/armor/cuirass,
		/datum/supply_pack/armor/plate_gloves,
		/datum/supply_pack/armor/sallet,
		/datum/supply_pack/armor/hounskull,
		// Apparel
		/datum/supply_pack/apparel/ridingboots,
		// Weapons
		/datum/supply_pack/weapons/greatsword,
		/datum/supply_pack/weapons/halberd,
		/datum/supply_pack/weapons/sword,
		/datum/supply_pack/weapons/greatmace,
		/datum/supply_pack/weapons/flail,
		// Food & Luxury
		/datum/supply_pack/food/voddena,
		/datum/supply_pack/jewelry/circlet,
		/datum/supply_pack/luxury/silver_plaque_belt
	)
	exotic_pool = list(
		/datum/supply_pack/armor/coatofplates,
		/datum/supply_pack/armor/buckethelm,
		/datum/supply_pack/armor/visorsallet,
		/datum/supply_pack/jewelry/goldring,
		/datum/supply_pack/rawmats/riddle_of_steel,
		/datum/supply_pack/luxury/talkstone,
		/datum/supply_pack/luxury/gold_plaque_belt
	)

/datum/world_faction/mountain_clans/initialize_faction_stock()
	..()
	// Mountain clans value tools and metalwork
	hard_value_multipliers[/obj/item/weapon/pick] = 1.3
	hard_value_multipliers[/obj/item/ingot] = 1.4
