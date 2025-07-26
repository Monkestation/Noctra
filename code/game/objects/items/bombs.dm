/obj/item/bomb
	name = "bottle bomb"
	desc = "Dangerous explosion, in a bottle."
	icon = 'icons/obj/bombs.dmi'
	icon_state = "clear_bomb"
	w_class = WEIGHT_CLASS_NORMAL
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.5
	var/fuze = 50
	var/lit = FALSE
	var/prob2fail = 5
	var/lit_state = "clear_bomb_lit"
	grid_width = 32
	grid_height = 64

/obj/item/bomb/homemade
	prob2fail = 20

/obj/item/bomb/homemade/Initialize()
	. = ..()
	fuze = rand(20, 50)

/obj/item/bomb/spark_act()
	light()

/obj/item/bomb/fire_act()
	light()

/obj/item/bomb/ex_act()
	if(!QDELETED(src))
		lit = TRUE
		explode(TRUE)

/obj/item/bomb/proc/light()
	if(!lit)
		START_PROCESSING(SSfastprocess, src)
		icon_state = lit_state
		lit = TRUE
		playsound(src.loc, 'sound/items/firelight.ogg', 100)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/extinguish()
	snuff()

/obj/item/bomb/proc/snuff()
	if(lit)
		lit = FALSE
		STOP_PROCESSING(SSfastprocess, src)
		playsound(src.loc, 'sound/items/firesnuff.ogg', 100)
		icon_state = initial(icon_state)
		if(ismob(loc))
			var/mob/M = loc
			M.update_inv_hands()

/obj/item/bomb/proc/explode(skipprob)
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(T)
		if(lit)
			if(!skipprob && prob(prob2fail))
				playsound(T, 'sound/items/firesnuff.ogg', 100) //changed to always smash if it fails
				new /obj/item/natural/glass/shard (T)
			else
				explosion(T, light_impact_range = 1, hotspot_range = 2, smoke = TRUE, soundin = pick('sound/misc/explode/bottlebomb (1).ogg','sound/misc/explode/bottlebomb (2).ogg'))
		else
			playsound(T, 'sound/items/firesnuff.ogg', 100)
			new /obj/item/natural/glass/shard (T)

	qdel(src)

/obj/item/bomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	explode()

/obj/item/bomb/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/smokebomb
	name = "smoke bomb"
	desc = "A soft sphere with an alchemical mixture and a dispersion mechanism hidden inside. Any pressure will detonate it."
	icon = 'icons/obj/bombs.dmi'
	icon_state = "smokebomb"
	w_class = WEIGHT_CLASS_NORMAL
	//dropshrink = 0
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP
	throw_speed = 0.75
	grid_width = 32
	grid_height = 64

/obj/item/smokebomb/attack_self(mob/user, params)
	..()
	explode()

/obj/item/smokebomb/ex_act()
	if(!QDELETED(src))
		. = ..()
	explode()

/obj/item/smokebomb/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	explode()

/obj/item/smokebomb/proc/explode()
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	if(!T)
		return
	playsound(src.loc, 'sound/items/smokebomb.ogg' , 50)
	var/radius = 3
	var/datum/effect_system/smoke_spread/S = new /datum/effect_system/smoke_spread
	S.set_up(radius, T)
	S.start()
	if(prob(25))
		new /obj/item/ash(T)
	qdel(src)

/obj/item/holy_grenade
	name = "\improper The Holy Hand Grenade of Antioch"
	desc = "A sacred relic carried by Brother Maynard."
	icon = 'icons/obj/holy_grenade.dmi'
	icon_state = "holy_grenade"
	var/fuze = 25
	var/primed = FALSE

	/// How many lines have been heard
	var/scripture_heard = 0
	/// The next wanted scripture
	var/scripture_wanted
	/// The required scripture
	var/list/scripture_required = list(
		"And Saint Attila raised the Hand Grenade up on high, saying,",
		"'O Lord, bless this Thy Hand Grenade that, with it, Thou mayest blow Thine enemies into tiny bits in Thy mercy.'",
		"And the Lord did grin, and the people did feast upon the lambs and sloths and carp and anchovies and orangutans and breakfeast cereals and fruit bats and large chu--",
		"Skip a bit, Brother.",
		"And the Lord spake, saying, 'First shalt thou take out the Holy Pin. Then, shalt thou count to three. No more. No less.",
		"Three shalt be the number thou shalt count, and the number of the counting shall be three.",
		"Four shalt thou not count, nor either count thou two, excepting that thou then proceed to three. Five is right out.",
		"Once the number three, being the third number, be reached, then, lobbest thou thy Holy Hand Grenade of Antioch towards thy foe, who, being naughty in My sight, shall snuff it.'",
		"Amen",
	)

/obj/item/holy_grenade/Initialize(mapload, ...)
	. = ..()
	become_hearing_sensitive()
	scripture_wanted = LAZYACCESS(scripture_required, 1)

/obj/item/holy_grenade/Destroy()
	lose_hearing_sensitivity()
	return ..()

/obj/item/holy_grenade/process()
	fuze--
	if(fuze <= 0)
		explode(TRUE)

/obj/item/holy_grenade/equipped(mob/user, slot, initial)
	. = ..()
	to_chat(user, span_nicegreen("You hear a chant: \"Pie lesu domine, dona eis requiem.\""))

/obj/item/holy_grenade/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode, original_message)
	if(findtext(html_decode(original_message), scripture_wanted))
		scripture_heard++
		if(scripture_heard > length(scripture_required))
			lose_hearing_sensitivity()
			return
		scripture_wanted = scripture_required[scripture_heard++]

/obj/item/holy_grenade/attack_self(mob/user, params)
	. = ..()
	if(scripture_heard < length(scripture_required))
		to_chat(user, span_notice("I pull the holy pin... but it doesn't release! Bring forth the Book of Armaments!"))
		return
	to_chat(user, span_userdanger("I pull the holy pin! Count to three!"))
	playsound(get_turf(user), 'sound/foley/industrial/clunk.ogg', 40, FALSE, -1)
	icon_state = "[icon_state]_armed"
	primed = TRUE
	START_PROCESSING(SSfastprocess, src)

/obj/item/holy_grenade/proc/explode()
	STOP_PROCESSING(SSfastprocess, src)
	var/turf/T = get_turf(src)
	explosion(T, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 4, flash_range = 6, flame_range = 2, smoke = TRUE, soundin = 'sound/magic/hallelujah.ogg')
	qdel(src)

/obj/item/holy_grenade/longer_fuze
	fuze = 50

/obj/item/holy_grenade/ready
	scripture_heard = 1
	scripture_required = list()

/obj/item/holy_grenade/ready/Initialize(mapload, ...)
	. = ..()
	lose_hearing_sensitivity()
