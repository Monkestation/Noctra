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
		/datum/supply_pack/armor/light/skullcap,
		/datum/supply_pack/armor/light/minerhelmet,
		/datum/supply_pack/armor/light/poth,
		/datum/supply_pack/armor/steel/nasalh,
		/datum/supply_pack/armor/light/chaincoif_iron,
		/datum/supply_pack/armor/light/bracers,
		/datum/supply_pack/armor/light/chain_gloves_iron,
		/datum/supply_pack/armor/light/chainlegs_iron,
		/datum/supply_pack/armor/light/chainkilt_iron,
		/datum/supply_pack/armor/light/light_armor_boots,
		// Apparel
		/datum/supply_pack/apparel/hatfur,
		/datum/supply_pack/apparel/leather_boots,
		/datum/supply_pack/apparel/workervest,
		/datum/supply_pack/apparel/leather_trousers,
		/datum/supply_pack/apparel/knitcap,
		/datum/supply_pack/apparel/coif,
		/datum/supply_pack/apparel/apron_brown,
		/datum/supply_pack/armor/light/leather_bracers,
		/datum/supply_pack/storage/scabbard,
		/datum/supply_pack/storage/sheath,
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
		/datum/supply_pack/food/drinks/blackgoat,
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
		/datum/supply_pack/armor/light/cuirass_iron,
		/datum/supply_pack/armor/light/chainmail_iron,
		/datum/supply_pack/armor/steel/chaincoif_steel,
		/datum/supply_pack/armor/steel/chainlegs_steel,
		/datum/supply_pack/armor/steel/chainkilt_steel,
		/datum/supply_pack/armor/light/ihalf_plate,
		/datum/supply_pack/armor/light/heavy_gloves,
		/datum/supply_pack/armor/steel/steel_boots,
		// Apparel
		/datum/supply_pack/apparel/leather_vest_random,
		/datum/supply_pack/apparel/trousers,
		// Weapons - Dwarven combat gear
		/datum/supply_pack/weapons/steel/baxe,
		/datum/supply_pack/weapons/iron/mace,
		/datum/supply_pack/weapons/steel/smace,
		/datum/supply_pack/weapons/iron/shortsword,
		/datum/supply_pack/weapons/iron/sword_iron,
		/datum/supply_pack/weapons/shield/iron,
		/datum/supply_pack/weapons/shield/towershield,
		// Food & Drink
		/datum/supply_pack/food/drinks/butterhair,
		/datum/supply_pack/food/drinks/stonebeard,
		/datum/supply_pack/food/drinks/grenzelbeer,
		/datum/supply_pack/food/salami,
		// Instruments
		/datum/supply_pack/instruments/mbox,
		/datum/supply_pack/instruments/vocals,
		// Materials
		/datum/supply_pack/rawmats/sinew
	)
	rare_pool = list(
		// High-end armor
		/datum/supply_pack/armor/steel/brigandine,
		/datum/supply_pack/armor/steel/cuirass,
		/datum/supply_pack/armor/steel/chainmail,
		/datum/supply_pack/armor/steel/plate_gloves,
		/datum/supply_pack/armor/steel/sallet,
		/datum/supply_pack/armor/steel/bracers,
		/datum/supply_pack/armor/steel/hounskull,
		/datum/supply_pack/armor/light/ifull_plate,
		// Apparel
		/datum/supply_pack/apparel/ridingboots,
		// Weapons
		/datum/supply_pack/weapons/iron/greatsword,
		/datum/supply_pack/weapons/steel/halberd,
		/datum/supply_pack/weapons/steel/sword,
		/datum/supply_pack/weapons/iron/greatmace,
		/datum/supply_pack/weapons/iron/flail,
		/datum/supply_pack/weapons/iron/axe,
		/datum/supply_pack/weapons/iron/bardiche,
		/datum/supply_pack/weapons/steel/greatsword,
		/datum/supply_pack/weapons/steel/greatmace,
		/datum/supply_pack/weapons/steel/saxe,
		// Food & Luxury
		/datum/supply_pack/food/drinks/voddena,
		/datum/supply_pack/jewelry/circlet,
		/datum/supply_pack/luxury/silver_plaque_belt
	)
	exotic_pool = list(
		/datum/supply_pack/armor/steel/coatofplates,
		/datum/supply_pack/armor/steel/buckethelm,
		/datum/supply_pack/armor/steel/chainmail_hauberk,
		/datum/supply_pack/armor/steel/visorsallet,
		/datum/supply_pack/armor/steel/half_plate,
		/datum/supply_pack/jewelry/goldring,
		/datum/supply_pack/rawmats/riddle_of_steel,
		/datum/supply_pack/luxury/talkstone,
		/datum/supply_pack/luxury/gold_plaque_belt,
		/datum/supply_pack/weapons/ranged/puffer,
		/datum/supply_pack/weapons/ammo/bullets
	)

/datum/world_faction/mountain_clans/initialize_faction_stock()
	..()
	// Mountain clans value tools and metalwork
	hard_value_multipliers[/obj/item/weapon/pick] = 1.3
	hard_value_multipliers[/obj/item/ingot] = 1.4
