/obj/structure/fake_machine/hateface
	name = "SEIGFREED"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "goldvendor"
	density = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 0
	anchored = TRUE
	layer = BELOW_OBJ_LAYER
	var/budget = 0
	var/static/list/paerpywork = list(
		"Parchment" = list(
			"type" = /obj/item/paper,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/key/mercenary,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/gold_prick,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/merctoken,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_contract,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_contract/worker,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_work_onetime,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_work_conti,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_autograph,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_will,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merc_will/adven_will,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/political_PM/guild_tax_exempt,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/political_PM/merc_parade,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/political_PM/bloodseal/exemptfromlaw,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/political_PM/bloodseal/exempt_from_cruelty,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/merchant_merger,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
		"bo hoo keey" = list(
			"type" = /obj/item/paper/inn_partnership,
			"cost" = 10,
			"desc" = "bo bo bo",
		),
    )

/obj/structure/fake_machine/hateface/Initialize()
	. = ..()
	START_PROCESSING(SSslowobj, src)

/obj/structure/fake_machine/hateface/Destroy()
	STOP_PROCESSING(SSslowobj, src)
	return ..()

/obj/structure/fake_machine/hateface/process()//hailer hails? damn
	. = ..()
	if(prob(0.1))
		hate_monologue()
		return
	say("HATE! HATE!!")

/obj/structure/fake_machine/hateface/proc/hate_monologue() //N/A write later
	return

/obj/structure/fake_machine/hateface/examine(mob/user)
	. = ..()
	//this is the most fun part so leave it for last sleep

/obj/structure/fake_machine/hateface/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
		to_chat(user, span_danger("[src] doesn't respond to any of my inputs..."))
		return
	if(istype(I, /obj/item/coin))
		var/money = I.get_real_price()
		budget += money
		qdel(I)
		to_chat(user, span_info("I put [money] mammon in [src]."))
		//playsound(get_turf(src), 'sound/misc/machinevomit.ogg', 100, TRUE, -1) could probably use distorted versions of all of these sounds
		attack_hand(user)
		return
	if(istype(I, /obj/item/paper))
		var/message = span_red("CHECKING CONTRACT...")
		say(message)
		//contracttest(I) doesn't really need to be its own proc

///obj/structure/fake_machine/hateface/proc/contracttest()
	//if()

/obj/structure/fake_machine/hateface/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
		to_chat(user, span_danger("[src] doesn't respond to any of my inputs..."))
		return
	user.changeNext_move(CLICK_CD_MELEE)
	//playsound(loc, 'sound/misc/beep.ogg', 100, FALSE, -1)
	var/contents
	if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
		contents = "<center>THE EVER HATEFUL<BR>"
		contents +="<a href='byond://?src=[REF(src)];change=1'>MAMMON LOADED:</a> [budget]<BR>"
	else
		contents = "<center>[stars("THE EVER HATEFUL")]<BR>"
		contents += "<a href='byond://?src=[REF(src)];change=1'>[stars("MAMMON LOADED:")]</a> [budget]<BR>"
	contents += "</center><BR>"
	for(var/name in paerpywork)
		var/paper_cost = name["cost"]
		var/paper_desc = name["desc"]
		var/paper_type = name["type"]

		if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
			contents += "[icon2html((paper_type), user)] - [name] - [paper_cost] <a href='byond://?src=[REF(src)];buy=[REF(name)]'>BUY</a><BR> [paper_desc] <BR>"
		else
			contents += "[icon2html((paper_type), user)] - [stars(name)] - [paper_cost] <a href='byond://?src=[REF(src)];buy=[REF(name)]'>[stars("BUY")]</a><BR> [stars(paper_desc)] <BR>"
	var/datum/browser/popup = new(user, "HATEFULMACHINE", "", 370, 400)
	popup.set_content(contents)
	popup.open()


/obj/structure/fake_machine/hateface/Topic(href, href_list)
	if(href_list["change"])
		if(!usr.can_perform_action(src, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH))
			return
		if(ishuman(usr))
			if(budget > 0)
				budget2change(budget, usr)
				budget = 0
	if(href_list["buy"])
		var/obj/item/P = locate(href_list["buy"]) in paerpywork
		if(!P || !istype(P))
			return
		if(!usr.can_perform_action(src, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH))
			return
		if(ishuman(usr))
			if(budget >= paerpywork[P]["cost"])
				budget -= paerpywork[P]["cost"]
				var/paper_type = paerpywork[P]["type"]
				var/obj/item/I = new paper_type(get_turf(usr))
				if(!usr.put_in_hands(I))
					I.forceMove(get_turf(usr))
			else
				var/hate = span_red("YOU LACK THE MAMMONS")
				say(hate)
				return
