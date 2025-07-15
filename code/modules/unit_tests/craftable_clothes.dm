// this unit test makes sure every piece of clothing is craftable
/datum/unit_test/craftable_clothes

/datum/unit_test/craftable_clothes/Run()
	var/list/obj/clothes_list = subtypesof(/obj/item/clothing)
	var/list/overall_recipe_typepaths = list()

	for(var/datum/repeatable_crafting_recipe/recipe as anything in subtypesof(/datum/repeatable_crafting_recipe))
		if(isclothing(recipe.output))
			overall_recipe_typepaths += recipe.output

	for(var/datum/orderless_slapcraft/recipe as anything in subtypesof(/datum/orderless_slapcraft))
		if(isclothing(recipe.output_item))
			overall_recipe_typepaths += recipe.output_item

	for(var/datum/anvil_recipe/recipe as anything in subtypesof(/datum/anvil_recipe))
		if(isclothing(recipe.created_item))
			overall_recipe_typepaths += recipe.created_item

	for(var/datum/crafting_recipe/recipe as anything in subtypesof(/datum/crafting_recipe))
		if(isclothing(recipe.result))
			overall_recipe_typepaths += recipe.result

	for(var/recipe as anything in overall_recipe_typepaths)
		for(var/obj/piece_of_clothing as anything in clothes_list)
			if(piece_of_clothing == recipe)
				clothes_list -= piece_of_clothing
				break

	if(!clothes_list.len)
		return

	TEST_FAIL("The following clothing subtypes do not have a crafting recipe: [clothes_list.Join(", ")]")
