// this unit test makes sure every piece of clothing is craftable
/datum/unit_test/craftable_clothes
	var/list/excluded_paths = list(
		/obj/item/clothing/neck,
	)
	var/list/excluded_paths_with_their_subtypes = list(
		/obj/item/clothing/neck/mercmedal,
	)
	var/list/excluded_paths_subtypes_only = list(
		/obj/item/clothing/neck/keffiyeh,
	)

	var/list/obj/clothes_list = subtypesof(/obj/item/clothing) - excluded_paths

/datum/unit_test/craftable_clothes/proc/perform_check(obj/item/clothing/checking_typepath)
	clothes_list -= piece_of_clothing

/datum/unit_test/craftable_clothes/Run()
	for(var/paths_to_exclude in excluded_paths_with_their_subtypes)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude))
				clothes_list -= path

	for(var/paths_to_exclude in excluded_paths_subtypes_only)
		for(var/path in clothes_list)
			if(ispath(path, paths_to_exclude) && (paths_to_exclude != path))
				clothes_list -= path

	for(var/datum/repeatable_crafting_recipe/recipe as anything in subtypesof(/datum/repeatable_crafting_recipe))
		if(isclothing_path(recipe.output))
			perform_check(recipe.output)

	for(var/datum/orderless_slapcraft/recipe as anything in subtypesof(/datum/orderless_slapcraft))
		if(isclothing_path(recipe.output_item))
			perform_check(recipe.output_item)

	for(var/datum/anvil_recipe/recipe as anything in subtypesof(/datum/anvil_recipe))
		if(isclothing_path(recipe.created_item))
			perform_check(recipe.created_item)

	for(var/datum/crafting_recipe/recipe as anything in subtypesof(/datum/crafting_recipe))
		if(isclothing_path(recipe.result))
			perform_check(recipe.result)

	for(var/datum/artificer_recipe/recipe as anything in subtypesof(/datum/artificer_recipe))
		if(isclothing_path(recipe.created_item))
			perform_check(recipe.created_item)

	if(!clothes_list.len)
		return

	TEST_FAIL("The following clothing subtypes do not have a crafting recipe: [clothes_list.Join(", ")]")
