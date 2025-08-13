//N/A lamerd version of the headeater until I make it not suck

/obj/item/natural/head
	var/headprice = 0
	var/headpricemin
	var/headpricemax

/obj/item/natural/head/Initialize()
	. = ..()
	if(headpricemax)
		headprice = rand(headpricemin, headpricemax)

/obj/item/natural/head/examine(mob/user)
	. = ..()
	if(headprice > 0 && (HAS_TRAIT(user, TRAIT_BURDEN) || is_gaffer_assistant_job(user.mind.assigned_role)))
		. += "<span class='info'>HEADEATER value: [headprice]</span>"

/obj/item/bodypart/head
	var/headprice = 0
	var/headpricemin
	var/headpricemax

/obj/item/bodypart/head/Initialize()
	. = ..()
	if(headpricemax)
		headprice = rand(headpricemin, headpricemax)

/obj/item/bodypart/head/examine(mob/user)
	. = ..()
	if(headprice > 0 && (HAS_TRAIT(user, TRAIT_BURDEN) || is_gaffer_assistant_job(user.mind.assigned_role)))
		. += "<span class='info'>HEADEATER value: [headprice]</span>"

/obj/item/painting/lorehead
	var/headprice = 0
	var/headpricemin
	var/headpricemax

/obj/item/painting/lorehead/Initialize()
	. = ..()
	if(headpricemax)
		headprice = rand(headpricemin, headpricemax)


/obj/item/painting/lorehead/examine(mob/user)
	. = ..()
	if(headprice > 0 && (HAS_TRAIT(user, TRAIT_BURDEN) || is_gaffer_assistant_job(user.mind.assigned_role)))
		. += "<span class='info'>HEADEATER value: [headprice]</span>"

/obj/structure/fake_machine/headeater
	name = "HEAD EATER"
	desc = "A machine that feeds on certain heads for coin, despite all this time... this itteration still seems unfinished, what a sell out"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "headeater"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/headeater/Initialize()
	SSroguemachine.headeater = src
	. = ..()

/obj/structure/fake_machine/headeater/Destroy()
	SSroguemachine.headeater = null
	. = ..()

/obj/structure/fake_machine/headeater/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/fake_machine/headeater/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/fake_machine/headeater/attackby(obj/item/H, mob/user, params)
	. = ..()
	if(!istype(H, /obj/item/natural/head) && !istype(H, /obj/item/bodypart/head) && !istype(H, /obj/item/painting/lorehead))
		to_chat(user, span_danger("It seems uninterested by the [H]"))
		return

	if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
		to_chat(user, span_danger("you can't feed the [src] without carrying it's burden"))
		return

	if(istype(H, /obj/item/bodypart/head))
		var/obj/item/bodypart/head/E = H
		if(E.headprice > 0)
			to_chat(user, span_danger("the [src] consumes the [E] spitting out coins in its place!"))
			budget2change(E.headprice, user)
			playsound(src, 'sound/misc/godweapons/gorefeast3.ogg', 70, FALSE, ignore_walls = TRUE)
			qdel(E)
			return

	if(istype(H, /obj/item/natural/head))
		var/obj/item/natural/head/A = H
		if(A.headprice > 0)
			to_chat(user, span_danger("the [src] consumes the [A] spitting out coins in its place!"))
			budget2change(A.headprice, user)
			playsound(src, 'sound/misc/godweapons/gorefeast3.ogg', 70, FALSE, ignore_walls = TRUE)
			qdel(A)
			return

	if(istype(H, /obj/item/painting/lorehead) && is_gaffer_job(user.mind.assigned_role)) //this will hopefully be more thematic when the HEAD EATER is in its real form
		var/obj/item/painting/lorehead/D = H
		if(D.headprice > 0)
			to_chat(user, span_danger("as the [src] consumes [D] without a trace, you are hit with a wistful feeling, your past...gone in an instant."))
			user.add_stress(/datum/stressevent/destroyed_past)
			playsound(src, 'sound/misc/godweapons/gorefeast3.ogg', 70, FALSE, ignore_walls = TRUE)
			budget2change(D.headprice, user)
			qdel(D)
			return

	if(istype(H, /obj/item/painting/lorehead))
		var/obj/item/painting/lorehead/Y = H
		if(Y.headprice > 0)
			to_chat(user, span_danger("the [src] consumes the [Y] spitting out coins in its place!"))
			playsound(src, 'sound/misc/godweapons/gorefeast3.ogg', 70, FALSE, ignore_walls = TRUE)
			budget2change(Y.headprice, user)
			qdel(Y)

	if(istype(H, /obj/item/paper/inn_partnership))
		var/obj/item/paper/inn_partnership/inn = H
		if(!inn.gaffsigned || !inn.used || !inn.inkeep)
			return
		var/obj/core = new /obj/item/hailer_core
		if(!usr.put_in_hands(core))
			core.forceMove(get_turf(user))
		//N/A sound and message
		return
	if(istype(H, /obj/item/paper/merchant_merger))
		var/obj/item/paper/merchant_merger/guild = H
		if(!guild.gaffsigned || !guild.used || !guild.merchant)
			return
		var/obj/hspawn = new /obj/item/headeater_spawn
		if(!usr.put_in_hands(hspawn))
			hspawn.forceMove(get_turf(user))
		//N/A sound and message
		return

/obj/structure/fake_machine/headeater/proc/aggresive_income(income)
	if(income)
		budget2change(income)
