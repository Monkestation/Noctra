/datum/blueprint_recipe/dendor
	craftdiff = 0
	category = "Dendor Shrine"
	requires_learning = TRUE
	construct_tool = null

/datum/blueprint_recipe/dendor/shrine
	name = "growing shrine to Dendor (unique)"
	required_materials = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/thorn = 3,
				/obj/item/natural/head/gote = 1)
	result_type = /obj/structure/fluff/psycross/crafted/shrine/dendor_gote
	verbage = "consecrate"
	verbage_tp = "consecrates"
	craftsound = 'sound/foley/Building-01.ogg'

/datum/blueprint_recipe/dendor/shrine/saiga
	name = "stinging shrine to Dendor (unique)"
	required_materials = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/thorn = 3,
				/obj/item/natural/head/saiga = 1)
	result_type = /obj/structure/fluff/psycross/crafted/shrine/dendor_saiga

/datum/blueprint_recipe/dendor/shrine/volf
	name = "devouring shrine to Dendor (unique)"
	required_materials = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/thorn = 3,
				/obj/item/natural/head/volf = 1)
	result_type = /obj/structure/fluff/psycross/crafted/shrine/dendor_volf

/datum/blueprint_recipe/dendor/shrine/troll
	name = "lording shrine to Dendor (unique)"
	required_materials = list(/obj/item/grown/log/tree/small = 1,
				/obj/item/natural/thorn = 3,
				/obj/item/natural/head/troll = 1)
	result_type = /obj/structure/fluff/psycross/crafted/shrine/dendor_troll
