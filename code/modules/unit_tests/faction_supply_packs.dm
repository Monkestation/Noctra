/datum/unit_test/supply_pack_coverage/Run()
	var/list/all_supply_packs = subtypesof(/datum/supply_pack)

	var/list/all_factions = subtypesof(/datum/world_faction)

	var/list/used_supply_packs = list()

	for(var/faction_type in all_factions)
		var/datum/world_faction/faction = new faction_type()

		if(faction.essential_packs)
			used_supply_packs |= faction.essential_packs

		if(faction.common_pool)
			used_supply_packs |= faction.common_pool

		if(faction.uncommon_pool)
			used_supply_packs |= faction.uncommon_pool


		if(faction.rare_pool)
			used_supply_packs |= faction.rare_pool

		if(faction.exotic_pool)
			used_supply_packs |= faction.exotic_pool

		qdel(faction)

	var/list/unused_supply_packs = list()
	for(var/supply_pack_type in all_supply_packs)
		if(!(supply_pack_type in used_supply_packs))
			unused_supply_packs += supply_pack_type

	for(var/datum/supply_pack/pack as anything in unused_supply_packs)
		if(!initial(pack.contains))
			unused_supply_packs -= pack

	var/unused_list = ""
	for(var/i = 1; i <= unused_supply_packs.len; i++)
		unused_list += "[unused_supply_packs[i]]"
		if(i < unused_supply_packs.len)
			unused_list += ", "

	TEST_ASSERT(!length(unused_supply_packs), "The following supply packs are not used by any world faction: [unused_list]")
