/*	.................   Cheap dye crafting   ................... */
/datum/orderless_slapcraft/cheapdye
	name = "cheap dyes"
	recipe_name = "Cheap dyes"
	starting_item = /obj/item/ash
	related_skill = /datum/skill/misc/sewing
	skill_xp_gained = 2
	requirements = list(
		list(
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison,
			/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry,
			/obj/item/reagent_containers/food/snacks/produce/swampweed) = 2
	)
	output_item = /obj/item/dye_pack/cheap
