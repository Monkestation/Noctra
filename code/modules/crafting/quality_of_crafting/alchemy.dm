/datum/repeatable_crafting_recipe/alchemy
	abstract_type = /datum/repeatable_crafting_recipe/alchemy
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 0
	category = "Alchemy"

/datum/repeatable_crafting_recipe/alchemy/essence_connector
	name = "Essence Connector"
	output = /obj/item/essence_connector
	requirements = list(
		/obj/item/ingot/thaumic = 1,
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/ingot/thaumic
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_jar
	name = "Essence Node Jar"
	output = /obj/item/essence_node_jar
	requirements = list(
		/obj/item/ingot/thaumic = 1,
		/obj/item/natural/glass = 3,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_gauntlet
	name = "Essence Gauntlet"
	output = /obj/item/clothing/gloves/essence_gauntlet
	requirements = list(
		/obj/item/ingot/thaumic = 3,
		/obj/item/natural/glass = 4,
		/obj/item/mana_battery/mana_crystal = 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife

/datum/repeatable_crafting_recipe/alchemy/essence_vial
	name = "Essence Vial"
	output = /obj/item/essence_vial
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 3

/datum/repeatable_crafting_recipe/alchemy/feau_dust
	name = "Feau Dust"
	output = /obj/item/alch/feaudust
	requirements = list(
		/obj/item/alch/golddust = 1,
		/obj/item/alch/irondust = 1,
	)
	tool_usage = list(
		/obj/item/pestle = list("starts to mix the dust together", "start to mix the dust together")
	)
	attacked_atom = /obj/item/reagent_containers/glass/mortar
	starting_atom = /obj/item/pestle
	output_amount = 2
	craftdiff = 1

//a way to get raw essentia other than rng by grinding down manablooms
//not a "good" way due to consuming four essentia to get two
//however, it's a guaranteed method of acquiring, which I believe justifies the costs
/datum/repeatable_crafting_recipe/alchemy/magic_dust
	name = "Raw Essentia"
	output = /obj/item/alch/runedust
	requirements = list(
		/obj/item/alch/waterdust = 1,
		/obj/item/alch/airdust = 1,
		/obj/item/alch/firedust = 1,
		/obj/item/alch/earthdust = 1,
	)
	tool_usage = list(
		/obj/item/pestle = list("starts to mix the dust together", "start to mix the dust together")
	)
	attacked_atom = /obj/item/reagent_containers/glass/mortar
	starting_atom = /obj/item/pestle
	output_amount = 2
	craftdiff = 3

//rather expensive crafting recipe
//you get more magic essence this way, but lose out on some order and earth essence from the runedust and small mana crystal, respectively
/datum/repeatable_crafting_recipe/alchemy/rune_dust
	name = "Pure Essentia"
	output = /obj/item/alch/magicdust
	requirements = list(
		/obj/item/reagent_containers/powder/manabloom = 3,
		/obj/item/mana_battery/mana_crystal/small = 2,
		/obj/item/alch/runedust = 1,
	)
	tool_usage = list(
		/obj/item/pestle = list("starts to crush and grind the items together", "start to crush and grind the items together")
	)
	attacked_atom = /obj/item/reagent_containers/glass/mortar
	starting_atom = /obj/item/pestle
	output_amount = 1
	craftdiff = 4
