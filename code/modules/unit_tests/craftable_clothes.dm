/*
this unit test makes sure every piece of clothing is craftable
abstract types are automatically excluded.

*/
/datum/unit_test/craftable_clothes
	/// explicitly excluded paths with this path only
	var/list/excluded_paths = list(
		/obj/item/clothing/neck/blkknight, // mapped in only
		/obj/item/clothing/accessory/medal/gold/ordom, // memorial item, RIP OrdoM.
		/* special uncraftables designed for specific roles next */
		/obj/item/clothing/neck/portalamulet, // vampire antag item
		/obj/item/clothing/head/cyberdeck, // fluff item for maniac
		/obj/item/clothing/shirt/formal, // fluff item for maniac
		/obj/item/clothing/pants/tights/formal, // fluff item for maniac
		/obj/item/clothing/head/helmet/visored/royalknight, // royal knight only
		/obj/item/clothing/head/helmet/medium/decorated/skullmet,
		/obj/item/clothing/head/helmet/visored/zizo, // zizo knight only
		/obj/item/clothing/head/helmet/visored/captain, // captain only
		/obj/item/clothing/head/helmet/visored/warden, // warden only
		/obj/item/clothing/neck/mana_star, // court mage only
		/obj/item/clothing/head/helmet/visored/knight/black, // deathknight item
		/obj/item/clothing/head/peaceflower, // spawns naturally
		/obj/item/clothing/head/corruptflower, // spawns naturally
		/obj/item/clothing/face/facemask/prisoner, // shouldn't be attainable
	)
	// these don't use misc_flags = CRAFTING_TEST_EXCLUDE because we want to explicitly know which paths we are excluding.
	/// excludes paths along with their subtypes
	var/list/excluded_paths_with_their_subtypes = list(
		/obj/item/clothing/neck/mercmedal, // only earnable via hermes
		/obj/item/clothing/neck/shalal, // this is a medal
		/obj/item/clothing/neck/psycross/silver/holy, // unimplemented
		/obj/item/clothing/armor/skin_armor, // bruh
		/obj/item/clothing/head/hooded, // abstract items connected to a cloak, shouldn't be craftable
		/obj/item/clothing/ring, // TEMPORARY (TODO)
		/obj/item/clothing/cloak/tabard, // TODO
		/obj/item/clothing/cloak/stabard, // TODO
		/obj/item/clothing/accessory, // ???
		/obj/item/clothing/head/crown/serpcrown, // should only be one
		/obj/item/clothing/face/cigarette, // ???
	)

	/// excludes paths that are subtypes of these types and only subtypes
	var/list/excluded_paths_subtypes_only = list(

	)

	/// if the path of the item contains this keyword, it will be excluded
	var/list/excluded_paths_by_text = list(
		"goblin",
		"orc",
		"rousman",
		"rare",
		"vampire", // TODO (?)
		"cult", // TODO (?)
	)

/datum/unit_test/craftable_clothes/Run()
	/// list of all supply packs
	var/list/datum/supply_pack/supply_pack_list = subtypesof(/datum/supply_pack)
	/// list of all clothes paths, which we will remove paths that have a recipe or a supply_pack entry from.
	var/list/obj/clothes_list = subtypesof(/obj/item/clothing) - excluded_paths

	/* exclusions removed */

	// abstract typepaths and CRAFTING_TEST_EXCLUDE
	for(var/obj/item/clothing/path as anything in clothes_list)
		if(is_abstract(path) || (path.misc_flags & CRAFTING_TEST_EXCLUDE))
			clothes_list -= path

	// paths by text, if a piece of this text is found in the typepath it's excluded
	for(var/path as anything in clothes_list)
		for(var/text_to_find as anything in excluded_paths_by_text)
			if(findtextEx("[path]", "/[text_to_find]"))
				clothes_list -= path
				break

	// paths with subtypes
	for(var/paths_to_exclude as anything in excluded_paths_with_their_subtypes)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude))
				clothes_list -= path

	// paths by subtypes only
	for(var/paths_to_exclude as anything in excluded_paths_subtypes_only)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude) && (paths_to_exclude != path))
				clothes_list -= path

	/* misc checks go next */

	var/list/typepaths_of_loot = list()
	var/list/subtypes_of_loot_tables = subtypesof(/datum/loot_table)

	// check loot tables
	for(var/datum/loot_table/loot_datum as anything in subtypes_of_loot_tables)
		var/datum/loot_table/loot_table_to_check = new loot_datum
		for(var/list/parent_list as anything in loot_table_to_check.loot_table)
			for(var/loot_path as anything in parent_list)
				clothes_list -= loot_path
				typepaths_of_loot += loot_path

	// supply pack clothes
	for(var/datum/supply_pack/supply_pack_being_checked as anything in supply_pack_list)
		var/list/supply_pack_contents = list()
		supply_pack_contents += supply_pack_being_checked.contains // some contains definitions are not lists
		for(var/path_in_contents as anything in supply_pack_contents)
			clothes_list -= path_in_contents

	/* crafting recipes go next */

	// repeatables
	for(var/datum/repeatable_crafting_recipe/recipe as anything in subtypesof(/datum/repeatable_crafting_recipe))
		clothes_list -= initial(recipe.output)

	// orderless slapcraft
	for(var/datum/orderless_slapcraft/recipe as anything in subtypesof(/datum/orderless_slapcraft))
		clothes_list -= initial(recipe.output_item)

	// anvil recipes
	for(var/datum/anvil_recipe/recipe as anything in subtypesof(/datum/anvil_recipe))
		clothes_list -= initial(recipe.created_item)

	// crafting recipes
	for(var/datum/crafting_recipe/recipe as anything in subtypesof(/datum/crafting_recipe))
		clothes_list -= initial(recipe.result)

	// artificer recipes
	for(var/datum/artificer_recipe/recipe as anything in subtypesof(/datum/artificer_recipe))
		clothes_list -= initial(recipe.created_item)

	if(!clothes_list.len)
		return

	TEST_FAIL("The following clothing subtypes do not have a crafting recipe: [clothes_list.Join(", ")]\n \n also these are all the loot table stuff: [typepaths_of_loot.Join(", ")] \n \n subtypes of loot datum: [subtypes_of_loot_tables.Join(", ")]")
