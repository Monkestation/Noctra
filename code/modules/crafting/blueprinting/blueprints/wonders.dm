/datum/blueprint_recipe/structure/wonder
	name = "wonder"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	verbage = "constructs"
	craftsound = 'sound/foley/Building-01.ogg'
	skillcraft = null
	requires_learning = TRUE
	construct_tool = null

/datum/blueprint_recipe/structure/wonder/first
	name = "first wonder (2 bodyparts, 1 stomach)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 1,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/second
	name = "second wonder (2 bodyparts, 2 lungs)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart = 2,
		/obj/item/organ/lungs = 2,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/third
	name = "third wonder (2 bodyparts, 3 heads, 2 stomachs)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/bodypart/head = 3,
		/obj/item/bodypart = 2,
		/obj/item/organ/stomach = 2,
	)
	requires_learning = TRUE

/datum/blueprint_recipe/structure/wonder/fourth
	name = "fourth wonder (4 tongues, 3 eyes, 4 livers)"
	result_type = /obj/structure/wonder
	required_materials = list(
		/obj/item/organ/tongue = 4,
		/obj/item/organ/eyes = 3,
		/obj/item/organ/liver = 4,
	)
	requires_learning = TRUE
