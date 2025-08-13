/obj/item/clothing/pants/skirt
	name = "skirt"
	desc = "Long, flowing, and modest."
	icon_state = "skirt"
	item_state = "skirt"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'
	color = CLOTHING_LINEN

/obj/item/clothing/pants/skirt/colored
	misc_flags = CRAFTING_TEST_EXCLUDE

/obj/item/clothing/pants/skirt/colored/random
	name = "skirt"

/obj/item/clothing/pants/skirt/colored/random/Initialize()
	color = pick(CLOTHING_SALMON, CLOTHING_BERRY_BLUE, CLOTHING_SPRING_GREEN, CLOTHING_PEAR_YELLOW)
	return ..()

/obj/item/clothing/pants/skirt/colored/blue
	color = CLOTHING_BERRY_BLUE

/obj/item/clothing/pants/skirt/colored/green
	color = CLOTHING_SPRING_GREEN

/obj/item/clothing/pants/skirt/colored/red
	color = CLOTHING_RED_OCHRE
