/turf/atom_destruction(damage_flag)
	if(islist(debris))
		for(var/I in debris)
			for(var/i in 1 to debris[I])
				new I (get_turf(src))
	else if(debris)
		new debris(get_turf(src))
	return ..()

/turf/bullet_act(obj/projectile/P)
	. = ..()
	if(. != BULLET_ACT_FORCE_PIERCE)
		P.handle_drop()
		return BULLET_ACT_HIT
