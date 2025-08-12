/*
this unit test makes sure all crafting recipes are unique
abstract types are automatically excluded.

*/
/datum/unit_test/crafting_recipe_sanity
	/// explicitly excluded paths with this path only
	var/list/exclusions = list(


	)

/datum/unit_test/crafting_recipe_sanity/proc/path_checks(path)
	if(is_abstract(path))
		return FALSE
	if(path in exclusions)
		return FALSE

	return TRUE

/datum/unit_test/crafting_recipe_sanity/Run()

	var/list/all_outputs = list()
	var/list/all_names = list()
	var/list/failed_outputs = list()
	var/list/failed_names = list()

	for(var/datum/repeatable_crafting_recipe/repeatable in subtypesof(/datum/repeatable_crafting_recipe))
		if(!path_checks(repeatable))
			continue

		LAZYADDASSOC(all_outputs, repeatable::output, "[repeatable]")
		LAZYADDASSOC(all_names, repeatable::name, "[repeatable]")

	for(var/datum/anvil_recipe/anvil in subtypesof(/datum/anvil_recipe))
		if(!path_checks(anvil))
			continue

		LAZYADDASSOC(all_outputs, anvil::created_item, "[anvil]")
		LAZYADDASSOC(all_names, anvil::name, "[anvil]")

	for(var/datum/orderless_slapcraft/orderless in subtypesof(/datum/orderless_slapcraft))
		if(!path_checks(orderless))
			continue

		LAZYADDASSOC(all_outputs, orderless::output_item, "[orderless]")
		LAZYADDASSOC(all_names, orderless::name, "[orderless]")

	for(var/datum/artificer_recipe/artificer in subtypesof(/datum/artificer_recipe))
		if(!path_checks(artificer))
			continue

		LAZYADDASSOC(all_outputs, artificer::created_item, "[artificer]")
		LAZYADDASSOC(all_names, artificer::name, "[artificer]")

	for(var/list/list_item as anything in all_outputs)
		if(length(list_item) > 1)
			failed_outputs += list_item

	for(var/list/list_item as anything in all_names)
		if(length(list_item) > 1)
			failed_names += list_item

	if(length(failed_outputs) || length(failed_names))
		var/name_string = ""
		for(var/list/name_pair as anything in failed_names)
			name_string += name_pair
			name_string +=

		TEST_FAIL("failed names: [failed_names.Join("\n")] \n \n failed outputs: [failed_outputs.Join("\n")]")



