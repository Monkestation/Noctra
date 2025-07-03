//some of these aren't actual /paper with stuff to read on em because I am not feeling creative enough to write
//actual legally binding contracts right now, feel free to add em if you want

/obj/item/merctoken
	name = "mercenary token"
	desc = "A small, palm-fitting bound scroll - a minuature writ of commendation for a mercenary under MGE."
	icon_state = "merctoken"
	icon = 'icons/roguetown/items/misc.dmi'
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.5
	firefuel = 30 SECONDS
	sellprice = 2
	throwforce = 0
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_MOUTH
	var/signee = null
	var/signeejob = null

/obj/item/merctoken/examine(mob/user)
	. = ..()
	if(!signee)
		. += span_info("Present to a Guild representative for signing.")
	else
		. += span_info("SIGNEE: [signee], [signeejob] of Vanderlin.")

/obj/item/merctoken/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!user.can_read(src))
			to_chat(user, span_warning("Even a reader would find these verba incomprehensible."))
			return
		if(signee)
			to_chat(user, span_warning("This token has already been signed."))
			return
		if(!is_gaffer_job(user.mind.assigned_role))
			if(is_mercenary_job(user.mind.assigned_role))
				to_chat(user, span_warning("I can not sign my own commendation."))
			else
				to_chat(user, span_warning("This is incomprehensible."))
			return
		else
			signee = user.real_name
			signeejob = user.mind.assigned_role.get_informed_title(user)
			visible_message(span_warning("[user] writes [user.p_their()] name on [src]."))
			playsound(src, 'sound/items/write.ogg', 100, FALSE)
			return

/obj/item/paper/merc_contract
	name = "Covenant of Mercenary Service and Operational Commitments"
	desc = ""
	icon_state = "contractunsigned"
	info = ""
	var/signed = FALSE
	var/mob/living/signedmerc = null

/obj/item/paper/merc_contract/Initialize(mapload, new_employee)
	if(new_employee)
		signedmerc = new_employee
		signed = TRUE
	. = ..()

/obj/item/paper/merc_contract/update_icon_state()
	. = ..()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(signed)
		icon_state = "contractsigned"
		return
	icon_state = "contractunsigned"

/obj/item/paper/merc_contract/attackby(obj/item/P, mob/living/user, params)
	. = ..()
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(signed)
				to_chat(user, span_warning("This contract has already been ratified."))
				return
			if(signedmerc)
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] ratifies the contract")
				signed = TRUE
				ADD_TRAIT(signedmerc, TRAIT_MERCGUILD, type)
				update_icon_state()
			if(!signedmerc)
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] ratifies the contract")
				signed = TRUE
				update_icon_state()

		if(signedmerc)
			to_chat(user, span_warning("This contract has already been signed."))
			return
		if(signed)
			if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
				to_chat(user, span_warning("I don't know what I'm agreeing too..."))
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			signedmerc = user
			ADD_TRAIT(signedmerc, TRAIT_MERCGUILD, type)
			update_icon_state()
		if(!signed)
			if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
				to_chat(user, span_warning("I don't know what I'm agreeing too..."))
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			signedmerc = user
			update_icon_state()

/obj/item/paper/merc_contract/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_BURDEN))
		if(signedmerc.stat == DEAD)
			var/loldied = pick("Dirty", "Cold", "Scabby", "Stiff", "Limp", "Rotted", "Mutilated", "Pallid", "Withered")
			. += "A weirdly [loldied] parchment, stained with ink. it is proof that [signedmerc.real_name] works for the guild."
		if(signedmerc.stat == CONSCIOUS)
			. += "A weirdly warm parchment, stained with ink. it is proof that [signedmerc.real_name] works for the guild."
		else
			. += "A lesser pact with the patron, whenever I dim my eyes and gaze again at the words, they change in some way, never enough to be noticable, never enough to be ignored."
			user.add_stress(/datum/stressevent/ring_madness)

/obj/item/paper/merc_contract/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, "Even if I could read, I don't think I would care to.")
		return
	if(in_range(user, src) || isobserver(user))
		info += "THIS AGREEMENT IS MADE AND ENTERED INTO AS OF THE DATE OF LAST SIGNATURE BELOW, BY AND BETWEEN [signedmerc.real_name] (HEREAFTER REFERRED TO AS OUR CHAMPION), \
		AND THE MERCENARY GUILD (HEREAFTER REFERRED TO AS THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH)<BR>WITNESSETH:<BR>WHEREAS, OUR CHAMPION IS A NATURAL BORN HUMEN OR HUMENOID, POSSESSING SKILLS OF; PHYSICAL STRENGTH, NIMBLE DEXTERITY, UNBREAKING CONSITUTION AND OR EXCELING IN FIELDS OF PHYSICALLY DEMANDING LABOUR.  UPON WHICH HE/SHE/PREFERRED-IDENTITY-PROVIDE  CAN AID THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH, \
		WHO SEEKS TO CONTRIBUTE IN THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH.<BR>WHEREAS, THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AGREES TO UNCONDITIONALLY PROVIDE PAYMENT, AND BENEFITS, WORTHY AND ACCEPTABLE TO OUR CHAMPION, \
		IN EXCHANGE FOR CONTINIOUS COOPERATION.<BR>NOW THEREFORE IN CONSIDERATION OF THE MUTUAL COVENANTS HEREIN CONTAINED, AND OTHER GOOD AND VALUABLE CONSIDERATION, THE PARTIES HERETO MUTUALLY AGREE AS FOLLOWS:\
		<BR>IN EXCHANGE FOR PALTRY PAYMENTS AND BENEFITS, OUR CHAMPION AGREES TO KEEP THEIR WORK EXCLUSIVELY PROVIDED AND CHOSEN BY THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH REPRESENTETIVE (REFERRED TO AS WHELP DESPITE LACK OF MENTION HEREAFTER), \
		FOR THE REMAINDER OF HIS OR HER OR PREFERRED-IDENTITY-PROVIDE CURRENT LIFE.  PROVIDED OUR CHAMPION REMAIN IN DESIRE TO WORK FOR  THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AND WITHOUT THE LAWFUL  EVISCERATION OF THE AGREEMENT STRUCK HEREIN THIS PARCHMENT.<BR> \
		<BR>SIGNED,<BR><i>[signedmerc.real_name]</i>" //this conracts sucks, it doesn't even fit the time period but god I am not in the mood to write a contract, call this a place holder
		user.hud_used.reads.icon_state = "scroll"
		user.hud_used.reads.show()
		var/dat = {"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
					<html><head><style type=\"text/css\">
					body { background-image:url('book.png');background-repeat: repeat; }</style>
					</head><body scroll=yes>"}
		dat += "[info]<br>"
		dat += "<a href='byond://?src=[REF(src)];close=1' style='position:absolute;right:50px'>Close</a>"
		dat += "</body></html>"
		user << browse(dat, "window=reading;size=460x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=0")
		onclose(user, "reading", src)
	else
		return "<span class='warning'>I'm too far away to read it.</span>"

/obj/item/paper/merc_worker_contract
	name = "Covenant of Guild Commitments and Operational Service"
	desc = ""
	icon_state = "contractunsigned"
	info = ""
	var/signed = FALSE
	var/mob/living/signee = null

/obj/item/paper/merc_worker_contract/update_icon_state()
	. = ..()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(signed)
		icon_state = "contractsigned"
		return
	icon_state = "contractunsigned"

/obj/item/paper/merc_worker_contract/attackby(obj/item/P, mob/living/user, params)
	. = ..()
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(signed)
				to_chat(user, span_warning("This contract has already been ratified."))
				return
			if(signee)
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] ratifies the contract")
				signed = TRUE
				ADD_TRAIT(signee, TRAIT_MERCGUILD, type)
				update_icon_state()
			if(!signee)
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] ratifies the contract")
				signed = TRUE
				update_icon_state()

		if(signee)
			to_chat(user, span_warning("This contract has already been signed."))
			return
		if(signed)
			if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
				to_chat(user, span_warning("I don't know what I'm agreeing too..."))
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			signee = user
			ADD_TRAIT(signee, TRAIT_MERCGUILD, type)
			update_icon_state()
		if(!signed)
			if(user.can_perform_action(src, NEED_LITERACY|FORBID_TELEKINESIS_REACH))
				to_chat(user, span_warning("I don't know what I'm agreeing too..."))
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			signee = user
			update_icon_state()

/obj/item/paper/merc_worker_contract/examine(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_BURDEN))
		if(signee.stat == DEAD)
			var/loldied = pick("Dirty", "Cold", "Scabby", "Stiff", "Limp", "Rotted", "Mutilated", "Pallid", "Withered")
			. += "A weirdly [loldied] parchment, stained with ink. it is proof that [signee.real_name] works for the guild."
		if(signee.stat == CONSCIOUS)
			. += "A weirdly warm parchment, stained with ink. it is proof that [signee.real_name] works for the guild."
		else
			. += "A lesser pact with the patron, whenever I dim my eyes and gaze again at the words, they change in some way, never enough to be noticable, never enough to be ignored."
			user.add_stress(/datum/stressevent/ring_madness)

/obj/item/paper/merc_worker_contract/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, "Even if I could read, I don't think I would care to.")
		return
	if(in_range(user, src) || isobserver(user))
		info += "THIS AGREEMENT IS MADE AND ENTERED INTO AS OF THE DATE OF LAST SIGNATURE BELOW, BY AND BETWEEN [signee.real_name] (HEREAFTER REFERRED TO AS OUR BENEFICIARY), \
        AND THE MERCENARY GUILD (HEREAFTER REFERRED TO AS THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH)<BR>WITNESSETH:<BR>WHEREAS, OUR BENEFICIARY IS A NATURAL BORN HUMEN OR HUMENOID, POSSESSING SKILLS UPON WHICH HE/SHE/PREFERRED-IDENTITY-PROVIDE  CAN AID THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH, \
        WHO SEEKS TO CONTRIBUTE IN THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH.<BR>WHEREAS, THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AGREES TO UNCONDITIONALLY PROVIDE PAYMENT, AND BENEFITS, WORTHY AND ACCEPTABLE TO OUR BENEFICIARY, \
        IN EXCHANGE FOR CONTINIOUS COOPERATION.<BR>NOW THEREFORE IN CONSIDERATION OF THE MUTUAL COVENANTS HEREIN CONTAINED, AND OTHER GOOD AND VALUABLE CONSIDERATION, THE PARTIES HERETO MUTUALLY AGREE AS FOLLOWS:\
        <BR>IN EXCHANGE FOR PALTRY PAYMENTS AND BENEFITS, OUR BENEFICIARY AGREES TO KEEP THEIR WORK EXCLUSIVELY IN BENEFIT TO THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH REPRESENTETIVE (REFERRED TO AS WHELP DESPITE LACK OF MENTION HEREAFTER), \
        FOR THE REMAINDER OF HIS OR HER OR PREFERRED-IDENTITY-PROVIDE CURRENT LIFE.  PROVIDED OUR BENEFICIARY REMAIN IN DESIRE TO WORK FOR  THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AND WITHOUT THE LAWFUL  EVISCERATION OF THE AGREEMENT STRUCK HEREIN THIS PARCHMENT.<BR> \
        <BR>SIGNED,<BR><i>[signee.real_name]</i>" //still sucks. refer to above
		user.hud_used.reads.icon_state = "scroll"
		user.hud_used.reads.show()
		var/dat = {"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
					<html><head><style type=\"text/css\">
					body { background-image:url('book.png');background-repeat: repeat; }</style>
					</head><body scroll=yes>"}
		dat += "[info]<br>"
		dat += "<a href='byond://?src=[REF(src)];close=1' style='position:absolute;right:50px'>Close</a>"
		dat += "</body></html>"
		user << browse(dat, "window=reading;size=460x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=0")
		onclose(user, "reading", src)
	else
		return "<span class='warning'>I'm too far away to read it.</span>"






/obj/item/merc_work_onetime
	name = "One-Time Service and Engagement Agreement"


/obj/item/merc_work_conti
	name = "Continuous Engagement and Service Agreement"

/obj/item/merc_will
	name = "Mercenary Service Risk Mitigation and Final Testament Agreement"

/obj/item/adven_will
	name = "Adventurer's Legacy and Risk Waiver Agreement"

/obj/item/renown1
	name = "Official Decree of Mercenary Renown and Valor Recognition"

/obj/item/renown2
	name = "The Scroll of Valor and Mercenary's Esteemed Recognition"

/obj/item/renown3
	name = "The Record of Heroic Achievements and Mercenary's Esteem"

