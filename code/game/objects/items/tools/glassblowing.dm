//................	Chisel	............... //
/obj/item/weapon/glassblowpipe
	name = "glass blower's pipe"
	desc = "A steel pipe with a rounded end, used to shape molten glass into a more usable form. I should use a torch to heat glass if I plan on shaping it."
	icon_state = "blowpipe"
	icon = 'icons/roguetown/weapons/tools.dmi'
	experimental_inhand = TRUE
	experimental_onhip = TRUE
	force = 2
	throwforce = 2
	possible_item_intents = list(INTENT_GENERIC)
	sharpness = IS_BLUNT
	dropshrink = 0.6
	w_class = WEIGHT_CLASS_SMALL
	wdefense = 0
	blade_dulling = 0
	max_integrity = 60
	slot_flags = ITEM_SLOT_HIP
	drop_sound = 'sound/foley/dropsound/brick_drop.ogg'
	associated_skill = null
	sellprice = 20
	dropshrink = 0.9
	grid_height = 64
	grid_width = 32
	smeltresult = /obj/item/ingot/iron
	var/time_multiplier = 1

/obj/item/weapon/glassblowpipe/iron
	name = "iron glass blower's pipe"
	desc = "An iron pipe with a rounded end, used to shape molten glass into a more usable form. I should use a torch to heat glass if I plan on shaping it."
	icon_state = "iblowpipe"
	smeltresult = /obj/item/ingot/iron
	time_multiplier = 1.1
	sellprice = 15

/obj/item/weapon/glassblowpipe/bronze
	name = "bronze glass blower's pipe"
	desc = "A bronze pipe with a rounded end, used to shape molten glass into a more usable form. I should use a torch to heat glass if I plan on shaping it."
	icon_state = "bblowpipe"
	smeltresult = /obj/item/ingot/bronze
	time_multiplier = 1.2
	sellprice = 10
