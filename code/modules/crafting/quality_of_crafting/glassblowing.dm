/datum/repeatable_crafting_recipe/glassblowing
	abstract_type = /datum/repeatable_crafting_recipe/glassblowing
	requirements = list(
		/obj/item/natural/glass = 1
	)
	tool_usage = list(
		/obj/item/weapon/glassblowpipe = list("starts to melt and shape", "start to melt and shape")
	)

	starting_atom = /obj/item/flashlight/flare/torch
	attacked_atom = /obj/item/natural/glass
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 1
	subtypes_allowed = TRUE // Let them blow glass shards, why not.
	category = "Glassware"

/datum/repeatable_crafting_recipe/glassblowing/bottle
	name = "glass bottle"
	output = /obj/item/reagent_containers/glass/bottle
	requirements = list(/obj/item/natural/glass = 2)

/datum/repeatable_crafting_recipe/glassblowing/vial
	name = "glass vial"
	output = /obj/item/reagent_containers/glass/bottle/vial
	requirements = list(/obj/item/natural/glass = 1)

/datum/repeatable_crafting_recipe/glassblowing/carafe
	name = "glass carafe"
	output = /obj/item/reagent_containers/glass/carafe
	requirements = list(/obj/item/natural/glass = 2)

