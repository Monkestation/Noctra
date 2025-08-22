
/datum/world_faction/zalad_traders
	faction_name = "Zalad"
	desc = "Nomadic traders from the harsh desert regions"
	faction_color = "#D2691E"
	trader_type_weights = list(
		/datum/trader_data/exotic_merchant = 15,
		/datum/trader_data/artifact_weapons = 1,
		/datum/trader_data/seed_merchant = 18,
		/datum/trader_data/alchemist = 25,
		/datum/trader_data/clothing_merchant = 20,
		/datum/trader_data/material_merchant = 12,
		/datum/trader_data/medicine_merchant = 8,
		/datum/trader_data/food_merchant = 5,
		/datum/trader_data/livestock_merchant = 7,
		/datum/trader_data/weapon_merchant = 5,
		/datum/trader_data/tool_merchant = 10,
	)
	essential_packs = list(
		/datum/supply_pack/storage/backpack,
		/datum/supply_pack/storage/satchel,
		/datum/supply_pack/storage/pouch,
		/datum/supply_pack/tools/rope,
		/datum/supply_pack/food/drinks/water,
		/datum/supply_pack/food/hardtack,
		/datum/supply_pack/apparel/leather_belt,
		/datum/supply_pack/storage/sack
	)
	common_pool = list(
		// Light armor for desert travel
		/datum/supply_pack/armor/light/imask,
		/datum/supply_pack/armor/steel/smask,
		// Apparel suited for desert nomads
		/datum/supply_pack/apparel/headband,
		/datum/supply_pack/apparel/sandals,
		/datum/supply_pack/apparel/undershirt_random,
		/datum/supply_pack/apparel/tights_random,
		/datum/supply_pack/apparel/simpleshoes,
		/datum/supply_pack/apparel/shortshirt_random,
		/datum/supply_pack/apparel/tunic_random,
		// Food essentials
		/datum/supply_pack/food/meat,
		/datum/supply_pack/food/cheese,
		/datum/supply_pack/food/pepper,
		/datum/supply_pack/food/honey,
		/datum/supply_pack/luxury/premiun_cutlery,
		// Tools for survival
		/datum/supply_pack/tools/candles,
		/datum/supply_pack/tools/flint,
		/datum/supply_pack/tools/bottle,
		/datum/supply_pack/tools/needle,
		/datum/supply_pack/tools/scroll,
		/datum/supply_pack/tools/parchment,
		/datum/supply_pack/tools/sleepingbag,
		/datum/supply_pack/tools/keyrings,
		// Materials
		/datum/supply_pack/rawmats/cloth,
		// Seeds for cultivation
		/datum/supply_pack/seeds/onion,
		/datum/supply_pack/seeds/potato,
		/datum/supply_pack/seeds/spelt,
		/datum/supply_pack/seeds/cabbage,
		/datum/supply_pack/seeds/turnip,
		/datum/supply_pack/luxury/spectacles_onyxa,
		/datum/supply_pack/jewelry/mercator,
		/datum/supply_pack/apparel/engineering_goggles,
		/datum/supply_pack/apparel/hatblu
	)
	uncommon_pool = list(
		// Better armor
		/datum/supply_pack/armor/light/splint,
		/datum/supply_pack/armor/light/haukberk,
		// Apparel
		/datum/supply_pack/apparel/raincloak_random,
		/datum/supply_pack/apparel/leather_gloves,
		/datum/supply_pack/apparel/black_leather_belt,
		/datum/supply_pack/apparel/raincloak_furcloak_brown,
		/datum/supply_pack/apparel/dress_gen_random,
		/datum/supply_pack/armor/light/lightleather_armor,
		// Weapons
		/datum/supply_pack/weapons/iron/huntingknife,
		/datum/supply_pack/weapons/iron/dagger,
		/datum/supply_pack/weapons/steel/sdagger,
		/datum/supply_pack/weapons/ranged/whip,
		/datum/supply_pack/weapons/steel/sflail,
		// Food & Drink
		/datum/supply_pack/food/drinks/beer,
		/datum/supply_pack/food/drinks/onin,
		// Tools
		/datum/supply_pack/tools/lamptern,
		/datum/supply_pack/tools/dyebin,
		/datum/supply_pack/tools/lockpicks,
		// Materials & Seeds
		/datum/supply_pack/rawmats/feather,
		/datum/supply_pack/seeds/berry,
		/datum/supply_pack/seeds/weed,
		/datum/supply_pack/seeds/sleaf,
		// Instruments
		/datum/supply_pack/instruments/drum,
		/datum/supply_pack/instruments/lute,
		// Narcotics/Trade goods
		/datum/supply_pack/narcotics/sigs,
		/datum/supply_pack/narcotics/zigbox,
		/datum/supply_pack/narcotics/soap
	)
	rare_pool = list(
		// Apparel
		/datum/supply_pack/apparel/silkdress_random,
		/datum/supply_pack/apparel/shepherd,
		/datum/supply_pack/apparel/robe,
		/datum/supply_pack/apparel/armordress,
		/datum/supply_pack/armor/light/studleather,
		// Weapons
		/datum/supply_pack/weapons/iron/spear,
		/datum/supply_pack/weapons/ranged/shortbow,
		/datum/supply_pack/weapons/ranged/bow,
		/datum/supply_pack/weapons/steel/baxe,
		/datum/supply_pack/weapons/ranged/crossbow,
		/datum/supply_pack/weapons/ammo/quivers,
		/datum/supply_pack/weapons/ammo/arrowquiver,
		/datum/supply_pack/weapons/shield/wood,
		/datum/supply_pack/weapons/ammo/Blowpouch,

		// Food
		/datum/supply_pack/food/drinks/spottedhen,
		// Materials
		/datum/supply_pack/rawmats/silk,
		// Seeds
		/datum/supply_pack/seeds/sunflowers,
		/datum/supply_pack/seeds/plum,
		/datum/supply_pack/seeds/strawberry,
		// Narcotics
		/datum/supply_pack/narcotics/ozium,
		/datum/supply_pack/narcotics/poison
	)
	exotic_pool = list(
		/datum/supply_pack/apparel/silkcoat,
		/datum/supply_pack/apparel/menacing,
		/datum/supply_pack/apparel/bardhat,
		/datum/supply_pack/jewelry/silverring,
		/datum/supply_pack/food/chocolate,
		/datum/supply_pack/narcotics/spice,
		/datum/supply_pack/narcotics/spoison,
		/datum/supply_pack/seeds/sugarcane,
		/datum/supply_pack/luxury/merctoken,
		/datum/supply_pack/narcotics/zigboxempt,
		/datum/supply_pack/jewelry/consort_crown,
		/datum/supply_pack/jewelry/psycross,
		/datum/supply_pack/jewelry/bglasses,
		/datum/supply_pack/jewelry/gmask,
		/datum/supply_pack/jewelry/scom
	)

/datum/world_faction/zalad_traders/initialize_faction_stock()
	..()
	hard_value_multipliers[/obj/item/reagent_containers/food] = 1.3
	hard_value_multipliers[/obj/item/clothing/armor] = 1.2
