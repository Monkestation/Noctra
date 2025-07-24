/datum/repeatable_crafting_recipe/engineering/bomb
	abstract_type = /datum/repeatable_crafting_recipe/engineering/bomb
	skillcraft = /datum/skill/craft/engineering
	craftdiff = 3 // skilled on engineering unlocks most bombs
	minimum_skill_level = 2 // nuh uh , no 5% craftings

/datum/repeatable_crafting_recipe/engineering/bomb/homemade
	name = "homemade bottle bomb"

	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1, //raw ingredient for the lesser bomb
		/obj/item/reagent_containers/glass/bottle = 1,
	)
	reagent_requirements = list(
		/datum/reagent/consumable/ethanol = 10
	)

	starting_atom = /obj/item/natural/cloth
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/bomb/homemade
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE
	reagent_subtypes_allowed = TRUE
	craftdiff = 2
	minimum_skill_level = 1

/datum/repeatable_crafting_recipe/engineering/bomb/smoke
	name = "smoke bomb"

	requirements = list(
		/obj/item/alch/firedust = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/ash = 2,
	)

	starting_atom = /obj/item/ash
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/smokebomb
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/engineering/bomb/breaching_charge
	name = "breaching charge"
	requirements = list(
		/obj/item/reagent_containers/powder/blastpowder = 2,
		/obj/item/natural/fibers = 1,
		/obj/item/natural/cloth = 1,
	)

	attacked_atom = /obj/item/natural/cloth
	starting_atom = /obj/item/reagent_containers/powder/blastpowder
	output = /obj/item/breach_charge
	craft_time = 5 SECONDS
