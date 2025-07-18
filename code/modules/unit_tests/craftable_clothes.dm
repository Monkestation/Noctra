// this unit test makes sure every piece of clothing is craftable
/datum/unit_test/craftable_clothes
	// abstract types are automatically excluded.
	var/list/excluded_paths = list(
		/obj/item/clothing/neck/blkknight, // mapped in only
		/obj/item/clothing/accessory/medal/gold/ordom, // memorial item, RIP OrdoM.
		/* special uncraftables designed for specific roles next */
		/obj/item/clothing/neck/portalamulet, // vampire antag item
		/obj/item/clothing/head/cyberdeck, // fluff item for maniac
		/obj/item/clothing/head/helmet/visored/royalknight, // royal knight only
		/obj/item/clothing/head/helmet/medium/decorated/skullmet,
		/obj/item/clothing/head/helmet/visored/zizo, // zizo knight only
		/obj/item/clothing/head/helmet/visored/captain, // captain only
		/obj/item/clothing/head/helmet/visored/warden, // warden only
		/obj/item/clothing/neck/mana_star, // court mage only
		/obj/item/clothing/head/helmet/visored/knight/black, // deathknight item
		/obj/item/clothing/neck/gorget/hoplite, // mercenary item
	)
	var/list/excluded_paths_with_their_subtypes = list(
		/obj/item/clothing/neck/mercmedal, // only earnable via hermes
		/obj/item/clothing/neck/shalal, // this is a medal
		/obj/item/clothing/neck/psycross/silver/holy, // unimplemented
	)
	var/list/excluded_paths_subtypes_only = list(
		/obj/item/clothing/neck/keffiyeh,
		/* temporary solution to subtypes that change color only below */
	)
	var/list/excluded_paths_by_text = list(
		"goblin",
		"orc",
	)

/datum/unit_test/craftable_clothes/Run()
	var/list/datum/supply_pack/supply_pack_list = subtypesof(/datum/supply_pack)
	var/list/obj/clothes_list = subtypesof(/obj/item/clothing) - excluded_paths

	for(var/obj/item/clothing/path as anything in clothes_list)
		if(is_abstract(path) || (path.misc_flags & CRAFTING_TEST_EXCLUDE))
			clothes_list -= path

	for(var/path as anything in clothes_list)
		for(var/text_to_find as anything in excluded_paths_by_text)
			if(findtextEx("[path]", "/[text_to_find]"))
				clothes_list -= path
				break

	for(var/paths_to_exclude as anything in excluded_paths_with_their_subtypes)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude))
				clothes_list -= path

	for(var/paths_to_exclude as anything in excluded_paths_subtypes_only)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude) && (paths_to_exclude != path))
				clothes_list -= path

	for(var/datum/repeatable_crafting_recipe/recipe as anything in subtypesof(/datum/repeatable_crafting_recipe))
		if(isclothing_path(recipe.output))
			clothes_list -= recipe.output

	for(var/datum/orderless_slapcraft/recipe as anything in subtypesof(/datum/orderless_slapcraft))
		if(isclothing_path(recipe.output_item))
			clothes_list -= recipe.output_item

	for(var/datum/anvil_recipe/recipe as anything in subtypesof(/datum/anvil_recipe))
		if(isclothing_path(recipe.created_item))
			clothes_list -= recipe.created_item

	for(var/datum/crafting_recipe/recipe as anything in subtypesof(/datum/crafting_recipe))
		if(isclothing_path(recipe.result))
			clothes_list -= recipe.result

	for(var/datum/artificer_recipe/recipe as anything in subtypesof(/datum/artificer_recipe))
		if(isclothing_path(recipe.created_item))
			clothes_list -= recipe.created_item

	// also exclude supply pack clothes
	for(var/datum/supply_pack/supply_pack_being_checked as anything in supply_pack_list)
		var/list/supply_pack_contents = list()
		LAZYADD(supply_pack_contents, supply_pack_being_checked.contains) // some contains definitions are not lists (should be unit tested tbh)
		for(var/path_in_contents as anything in supply_pack_contents)
			if(isclothing_path(path_in_contents))
				clothes_list -= path_in_contents

	if(!clothes_list.len)
		return

	TEST_FAIL("The following clothing subtypes do not have a crafting recipe: [clothes_list.Join(", ")]")









