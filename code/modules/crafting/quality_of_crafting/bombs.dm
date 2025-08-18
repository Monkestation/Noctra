/datum/repeatable_crafting_recipe/bomb
	abstract_type = /datum/repeatable_crafting_recipe/bomb
	skillcraft = /datum/skill/craft/bombs
	craftdiff = 2
	category = "Bombs"

/datum/repeatable_crafting_recipe/bomb/homemade
	name = "homemade bottle bomb"

	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
	)
	reagent_requirements = list(
		/datum/reagent/consumable/ethanol = 10
	)

	starting_atom = /obj/item/natural/cloth
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/explosive/bottle/homemade
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE
	reagent_subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/bomb/smokebomb
	name = "smoke bomb"

	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/fyritius = 1,
		/obj/item/reagent_containers/glass/bottle = 1,
		/obj/item/fertilizer/ash = 2,
	)

	starting_atom = /obj/item/fertilizer/ash
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/smokebomb
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/bomb/pipe_bomb
	name = "homemade pipe bomb"

	requirements = list(
		/obj/item/natural/fibers = 1,
		/obj/item/reagent_containers/powder/blastpowder = 2,
		/obj/item/reagent_containers/glass/bottle = 1,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/reagent_containers/glass/bottle
	output = /obj/item/explosive
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE
	reagent_subtypes_allowed = TRUE
