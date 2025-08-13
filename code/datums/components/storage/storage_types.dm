/datum/component/storage/concrete/scabbard
	max_items = 1
	rustle_sound = 'sound/foley/equip/scabbard_holster.ogg'
	max_w_class = WEIGHT_CLASS_BULKY
	quickdraw = TRUE
	allow_look_inside = FALSE
	insert_verb = "slide"
	insert_preposition = "in"

/datum/component/storage/concrete/scabbard/knife/New(list/raw_args)
	. = ..()
	set_holdable(list(/obj/item/weapon/knife))

/datum/component/storage/concrete/scabbard/sword/New(list/raw_args)
	. = ..()
	set_holdable(list(/obj/item/weapon/sword), list(/obj/item/weapon/sword/long/exe, /obj/item/weapon/sword/long/greatsword))
