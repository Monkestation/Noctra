// this unit test makes sure every piece of clothing is craftable
/datum/unit_test/craftable_clothes

/datum/unit_test/reagent_id_typos/Run()
	var/list/obj/item/clothes_list = subtypesof(/obj/item/clothing)
	var/list/datum/repeatable_crafting_recipe/repeatables_list = subtypesof(/datum/repeatable_crafting_recipe)
	var/list/datum/orderless_slapcraft/orderless_list = subtypesof(/datum/orderless_slapcraft)

	for(var/obj/item/piece_of_clothe as anything in clothes_list)
		for(var/datum/repeatable_crafting_recipe/recipe as anything in repeatables_list)
			if(recipe.output == piece_of_clothe.type)
				clothes_list -= piece_of_clothe
				break

	for(var/obj/item/piece_of_clothe as anything in clothes_list)
		for(var/datum/repeatable_crafting_recipe/recipe as anything in repeatables_list)
			if(recipe.output == piece_of_clothe.type)
				clothes_list -= piece_of_clothe
				break

	if(!clothes_list.len)
		return

	TEST_FAIL("The following clothing subtypes do not have a crafting recipe: [clothes_list.Join(", ")]")
