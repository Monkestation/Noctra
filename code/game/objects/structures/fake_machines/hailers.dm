//this is mostly a noticeboard clone, but it works!

/obj/structure/fake_machine/hailer
	name = "HAILER"
	desc = "A machine that shares the parchment fed to it to all existing HAILERBOARDs for viewing"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "hailer"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/hailer/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/fake_machine/hailer/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/fake_machine/hailer/Initialize(mapload)
	. = ..()
	SSroguemachine.hailer += src

/obj/structure/fake_machine/hailer/Destroy()
	SSroguemachine.hailer -= src
	return ..()

/obj/structure/fake_machine/hailer/attackby(obj/item/H, mob/user, params)
	if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
		to_chat(user, span_danger("you can't feed the [src] without carrying it's burden"))
		return
	if(istype(H, /obj/item/reagent_containers/powder/salt)) //mmmm, salt.
		to_chat(user, "<span class='notice'>the [src]'s tongue slips between its bronze teeth to lap at the salt in [user]'s hand, finishing with effectionate licks across their palm... gross </span>")
		say("mmmpphh... grrrrrhh... hhhrrrnnn...")
		playsound(src, 'sound/gore/flesh_eat_03.ogg', 70, FALSE, ignore_walls = TRUE)
		qdel(H)
		return
	if(!istype(H, /obj/item/paper))
		to_chat(user, "<span class='notice'>the [src] only accepts paper</span>")
		playsound(src, 'sound/misc/godweapons/gorefeast5.ogg', 70, FALSE, ignore_walls = TRUE)
		say("GRRRRHHH!!...GRAAAAGH")
		return
	if(!user.transferItemToLoc(H, src))
		return
	to_chat(user, "<span class='notice'>I feed the [H] to the [src].</span>")
	playsound(src, 'sound/gore/flesh_eat_03.ogg', 70, FALSE, ignore_walls = TRUE)
	say("Bbbllrrr... fffrrrtt... brrrhh...")
	return ..()

/obj/structure/fake_machine/hailer/interact(mob/user)
	ui_interact(user)

/obj/structure/fake_machine/hailer/ui_interact(mob/user)
	. = ..()
	var/auth = TRUE
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/H in src)
		if(istype(H, /obj/item/paper))
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A> [auth ? "<A href='byond://?src=[REF(src)];write=[REF(H)]'>Write</A> <A href='byond://?src=[REF(src)];remove=[REF(H)]'>Remove</A> <A href='byond://?src=[REF(src)];rename=[REF(H)]'>Rename</A>": ""]<BR>"
		else
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A> [auth ? "<A href='byond://?src=[REF(src)];remove=[REF(H)]'>Remove</A>" : ""]<BR>"
	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=HAILER")
	onclose(user, "HAILER")

/obj/structure/fake_machine/hailer/Topic(href, href_list)
	..()
	usr.set_machine(src)
	if(href_list["remove"])
		if(!usr.can_perform_action(src, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH))	//For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/I = locate(href_list["remove"]) in contents
		if(istype(I) && I.loc == src)
			I.forceMove(usr.loc)
			usr.put_in_hands(I)
			say("kchaak... khaa...")


	if(href_list["write"])
		if(!usr.can_perform_action(src, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH)) //For when a player is handcuffed while they have the notice window open
			return
		var/obj/item/P = locate(href_list["write"]) in contents
		if(istype(P) && P.loc == src)
			var/obj/item/I = usr.is_holding_item_of_type(/obj/item/natural/feather)
			if(I)
				add_fingerprint(usr)
				P.attackby(I, usr)
			else
				to_chat(usr, "<span class='warning'>You'll need something to write with!</span>")

	if(href_list["read"])
		for(var/obj/structure/fake_machine/hailer/hailer as anything in SSroguemachine.hailer)
			var/obj/item/paper/I = locate(href_list["read"]) in hailer.contents
			if(istype(I) && I.loc == hailer && in_range(src, usr))
				I.read(usr)

	if(href_list["rename"]) //this doesnt even update the menu in real time, people are gonna think it aint workin' for sure, lol, lmao - the clown
		var/obj/item/I = locate(href_list["rename"]) in contents
		var/obj/item/P = usr.is_holding_item_of_type(/obj/item/natural/feather)
		if(P)
			if(istype(I) && I.loc == src)
				add_fingerprint(usr)
				var/n_name = stripped_input(usr, "give your notice a header!", "Paper Labelling", null, MAX_NAME_LEN)
				I.name = "[(n_name ? text("- '[n_name]'") : null)]"
				return
		to_chat(usr, "<span class='warning'>You'll need something to write with!</span>")

/obj/structure/fake_machine/hailerboard
	name = "HAILER BOARD"
	desc = "A notice board that shows all the notices the Gaffer has put up"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "hailerboard"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/hailerboard/r
	pixel_y = 0
	pixel_x = 32

/obj/structure/fake_machine/hailerboard/l
	pixel_y = 0
	pixel_x = -32

/obj/structure/fake_machine/hailerboard/Initialize()
	. = ..()
	START_PROCESSING(SSslowobj, src)

/obj/structure/fake_machine/hailerboard/Destroy()
	STOP_PROCESSING(SSslowobj, src)
	return ..()

/obj/structure/fake_machine/hailerboard/process()//hailer hails? damn
	. = ..()
	var/message = pick(
		"BbbRRRMMMPHHH... GGRRRRNNN!!",
		"GGGGRRRRR... BLLRRTTT!!",
		"NNNGGGRRBB... MMPHHH!!",
		"Hhbbbh...Mhhaamm--maaahrhh...")
	playsound(src, 'sound/surgery/organ2.ogg', 70, FALSE, ignore_walls = TRUE)
	message = span_danger(message)
	say(message)

/obj/structure/fake_machine/hailerboard/attack_hand(mob/user)
	. = ..()
	ui_interact(user)

/obj/structure/fake_machine/hailerboard/ui_interact(mob/user)
	. = ..()
	var/dat = "<B>[name]</B><BR>"
	for(var/obj/item/H in SSroguemachine.hailer)
		if(istype(H, /obj/item/paper))
			dat += "<A href='byond://?src=[REF(src)];read=[REF(H)]'>[H.name]</A><BR>"

	user << browse("<HEAD><TITLE>Notices</TITLE></HEAD>[dat]","window=HAILER BOARD")
	onclose(user, "HAILER BOARD")

/obj/structure/fake_machine/hailerboard/Topic(href, href_list)
	..()
	if(href_list["read"])
		for(var/obj/structure/fake_machine/hailer/hailer as anything in SSroguemachine.hailer)
			var/obj/item/paper/I = locate(href_list["read"]) in hailer.contents
			if(istype(I) && I.loc == hailer && in_range(src, usr))
				I.read(usr, TRUE)

/obj/structure/fake_machine/hailer/inn_hailer
	name = "INN-HAILER"
	desc = "A machine that shares the parchment fed to it to all existing HAILERBOARDs for viewing. This one stands upright by it's own 'lungs'."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "inn_hailer"
	density = TRUE

/obj/structure/fake_machine/hailer/inn_hailer/attackby(obj/item/H, mob/user, params)
	var/obj/item/the_chain = locate(/obj/item/clothing/neck/tyrants_chain) in user
	if(!the_chain)
		to_chat(user, span_danger("you can't feed the [src] without the chain."))
		return
	if(istype(H, /obj/item/reagent_containers/powder/salt)) //mmmm, salt.
		to_chat(user, "<span class='notice'>the [src]'s tongue slips between its bronze teeth to lap at the salt in [user]'s hand, finishing with effectionate licks across their palm... gross </span>")
		say("mmmpphh... grrrrrhh... hhhrrrnnn...")
		playsound(src, 'sound/gore/flesh_eat_03.ogg', 70, FALSE, ignore_walls = TRUE)
		qdel(H)
		return
	if(istype(H, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/food = H
		if(food.eat_effect == /datum/status_effect/debuff/rotfood)
			to_chat(user, "<span class='notice'>the [src]'s tongue slips between its bronze teeth to lap at the [food] in [user]'s hand, finishing with effectionate licks across their palm... gross </span>")
			say("mmmpphh... grrrrrhh... hhhrrrnnn...")
			playsound(src, 'sound/gore/flesh_eat_03.ogg', 70, FALSE, ignore_walls = TRUE)
			qdel(food)
			return
	if(!istype(H, /obj/item/paper))
		to_chat(user, "<span class='notice'>the [src] only accepts paper</span>")
		playsound(src, 'sound/misc/godweapons/gorefeast5.ogg', 70, FALSE, ignore_walls = TRUE)
		say("GRRRRHHH!!...GRAAAAGH")
		return
	if(!user.transferItemToLoc(H, src))
		return
	to_chat(user, "<span class='notice'>I feed the [H] to the [src].</span>")
	playsound(src, 'sound/gore/flesh_eat_03.ogg', 70, FALSE, ignore_walls = TRUE)
	say("Bbbllrrr... fffrrrtt... brrrhh...")
	return ..()

/obj/structure/fake_machine/hailerboard/inn_hailer_board
	name = "INN-HAILER BOARD"
	desc = "A notice board that shows all the notices the Gaffer and the Innkeeper has put up"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "hailerboard_inn"
	density = TRUE
	pixel_y = 0

/obj/structure/fake_machine/hailerboard/inn_hailer_board/process()//they are inn hailing
	. = ..()
	var/message = pick(
		"Hhhh... hhh... HHHHhhhhh...",
		"Hoo... Hooo... HHH...",
		"Ggggg... GGGHH... Hhhk...",
		"Paaaaff... Hhhheeee... hhhhhh...")
	playsound(src, 'sound/surgery/organ2.ogg', 70, FALSE, ignore_walls = TRUE)
	message = span_danger(message)
	say(message)
