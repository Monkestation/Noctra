/datum/brewing_recipe/aqua_vitae
	name = "Aqua Vitae - Apple"
	brewed_amount = 3
	brew_time = 5 MINUTES
	sell_value = 120
	needed_reagents = list(/datum/reagent/consumable/ethanol/cider = 150) // keep this in sync with this recipe's output volume
	reagent_to_brew = /datum/reagent/consumable/ethanol/aqua_vitae
	pre_reqs = /datum/reagent/consumable/ethanol/cider

/datum/brewing_recipe/aqua_vitae/pear
	name = "Aqua Vitae - Plum"
	needed_reagents = list(/datum/reagent/consumable/ethanol/cider/pear = 150)
	pre_reqs = /datum/reagent/consumable/ethanol/cider/pear

/datum/brewing_recipe/aqua_vitae/strawberry
	name = "Aqua Vitae - Strawberry"
	needed_reagents = list(/datum/reagent/consumable/ethanol/cider/strawberry = 150)
	pre_reqs = /datum/reagent/consumable/ethanol/cider/strawberry

/datum/brewing_recipe/aqua_vitae/tangerine
	name = "Aqua Vitae - Tangerine"
	needed_reagents = list(/datum/reagent/consumable/ethanol/tangerine = 150)
	pre_reqs = /datum/reagent/consumable/ethanol/tangerine

/datum/brewing_recipe/aqua_vitae/plum
	name = "Aqua Vitae - Plum"
	needed_reagents = list(/datum/reagent/consumable/ethanol/brandy/plum = 150)
	pre_reqs = /datum/reagent/consumable/ethanol/brandy/plum
