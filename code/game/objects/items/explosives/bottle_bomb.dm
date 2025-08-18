/obj/item/explosive/bottle
	name = "bottle bomb"
	desc = "Dangerous explosion, in a bottle."
	icon = 'icons/obj/bombs.dmi'
	icon_state = "clear_bomb"
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5

	impact_explode = TRUE

	ex_light = 1
	ex_heavy = 0
	ex_smoke = 2
	ex_hotspot_range = 2

	shrapnel_type = null

/obj/item/explosive/bottle/homemade
	prob2fail = 20
