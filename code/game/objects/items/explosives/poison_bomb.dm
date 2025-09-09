/obj/item/smokebomb/poison_bomb
	name = "poison bomb"


/obj/item/smokebomb/poison_bomb/explode()
	var/turf/T = get_turf(src)
	if(!T)
		return
	playsound(src.loc, 'sound/items/smokebomb.ogg' , 50)
	var/radius = 3
	var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread/poison
	S.set_up(radius, T)
	S.start()
	if(prob(25))
		new /obj/item/fertilizer/ash(T)
	qdel(src)

