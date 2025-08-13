//N/A write for this shit.
//N/A most of these need checks for reading, even if they don't understand it, it should at least point out they can't

/obj/item/gold_prick
	name = "GOLDEN PRICK"
	desc = ""
	icon_state = ""
	icon = ""
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH //putting pricks in your mouth might be fun for a bit, just don't go on that second date.
	var/mob/living/blood

/obj/item/gold_prick/update_icon_state()
	. = ..()
	if(blood)
		icon_state = ""
		return
	icon_state = ""

/obj/item/gold_prick/attack_self(mob/living/user)
	user.flash_fullscreen("redflash3")
	playsound(user, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
	visible_message(span_warning("[user] draws blood with the [src]"))
	if(HAS_TRAIT(user, TRAIT_NOBLE))
		if(!HAS_TRAIT(user, TRAIT_NOPAIN))
			user.emote("painscream")
			to_chat(user, span_warning("THAT BURNS!!"))
	blood = user
	addtimer(CALLBACK(src, PROC_REF(clear_blood)), 1 MINUTES)

/obj/item/gold_prick/attack_right(mob/user)
	. = ..()
	if(.)
		return
	if(blood)
		user.changeNext_move(CLICK_CD_MELEE)
		blood = null
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			to_chat(user, span_warning("I pinch the end of the prick and trace my fingers up along it's length, until the only blood left is on my fingers."))
			playsound(src, 'sound/magic/enter_blood.ogg', 30, FALSE, ignore_walls = FALSE)
			user.add_stress(/datum/stressevent/ring_madness)
			return
		to_chat(user, span_warning("I clean the prick"))

/obj/item/gold_prick/examine(mob/user)
	if(HAS_TRAIT(user, TRAIT_BURDEN))
		. = ""
	if(HAS_TRAIT(user, TRAIT_NOBLE))
		. = ""
	if(HAS_TRAIT(user, TRAIT_SEEPRICES))
		. += "<span class='info'>value: Worthless.</span>"

/obj/item/gold_prick/proc/clear_blood()
	if(blood)
		blood = null
		update_icon_state()

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
	icon_state = "contractunsigned"
	var/signed = FALSE
	var/mob/living/signedmerc = null
	COOLDOWN_DECLARE(recallcool)

/obj/item/paper/merc_contract/Initialize(new_employee)
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
	if(istype(P, /obj/item/flashlight/flare/torch))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/flashlight/flare/torch/T = P
			if(T.on && user.used_intent.type != INTENT_HARM  && signedmerc)
				bloodvodoo()
				return
	if(istype(P, /obj/item/candle))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/candle/C = P
			if(C.lit && user.used_intent.type != INTENT_HARM  && signedmerc)
				bloodvodoo()
				return
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(signed)
				to_chat(user, span_warning("This contract has already been ratified."))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] ratifies the contract")
			signed = TRUE
			if(signedmerc)
				ADD_TRAIT(signedmerc, TRAIT_MERCGUILD, type)
			update_icon_state()
			return

		if(signedmerc)
			to_chat(user, span_warning("This contract has already been signed."))
			return
		if(!user.can_read(src))
			to_chat(user, span_warning("I don't know what I'm agreeing too..."))
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] signs the contract")
		signedmerc = user
		if(signed)
			ADD_TRAIT(signedmerc, TRAIT_MERCGUILD, type)


/obj/item/paper/merc_contract/examine(mob/user)
	. = ..()
	if(!HAS_TRAIT(user, TRAIT_BURDEN))
		. += "A noticably oily parchment. written on it is an oddly worded contract telling that the signee works for the Mercenary Guild"
		return
	if(!signedmerc)
		. += "A lesser pact with the HEADEATER, whenever I dim my eyes and gaze again at the words, they change in some way, never enough to be meaningful, never enough to be ignored."
		user.add_stress(/datum/stressevent/ring_madness)
		return
	if(signedmerc.stat == DEAD)
		var/loldied = pick("Dirty", "Cold", "Scabby", "Stiff", "Limp", "Rotted", "Mutilated", "Pallid", "Withered")
		. += "I can still see the skin shivering, it is [loldied]"
		return
	else
		. += "I can still see the skin shivering, it is warm"

/obj/item/paper/merc_contract/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
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

/obj/item/paper/merc_contract/Destroy()
	if(signedmerc)
		REMOVE_TRAIT(signedmerc, TRAIT_MERCGUILD, type)
		to_chat(signedmerc, span_warning("in a blink, it was as if the world's joy was dimmed. The songs of birds, The sounds of children playing, they grew distant, hard to notice. As if the monotony of life muffled the song of wonder... or maybe, I just became unemployed."))
		signedmerc.add_stress(/datum/stressevent/merc_fired)
	. = ..()

/obj/item/paper/merc_contract/proc/bloodvodoo(mob/user)
	var/fuckitupterry = browser_alert(user, "The fire is inches away from the parchment", "THE PACT", "Absolve Contract", "Recall Champion")
	if(!fuckitupterry)
		to_chat(user, "")
		return
	if(fuckitupterry == "Absolve Contract")
		to_chat(user, "without even being claimed by the fire, the contract crumbles to ash.")
		var/ash = new /obj/item/ash
		qdel(src)
		user.put_in_active_hand(ash)
		return
	if(fuckitupterry == "Recall Champion")
		if(!COOLDOWN_FINISHED(src, recallcool))
			to_chat(user, "")
			return
		if(!isliving(signedmerc) || signedmerc.stat == UNCONSCIOUS)
			to_chat(user, "")
			return
		to_chat(signedmerc, span_warning("a gentle warmth spreads into my soul, beckoning me closer to the place I find rest...")) //not too obvious
		//playsoound_local(signedmerc, '')
		//N/A sound here would be neat
		COOLDOWN_START(src, recallcool, 10 MINUTES)

/obj/item/paper/merc_contract/attack_obj(obj/O, mob/living/user)
	if(istype(O, /obj/item/flashlight/flare/torch))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/flashlight/flare/torch/T = O
			if(T.on && user.used_intent.type != INTENT_HARM && signedmerc)
				bloodvodoo()
				return
	if(istype(O, /obj/item/candle))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/candle/C = O
			if(C.lit && user.used_intent.type != INTENT_HARM && signedmerc)
				bloodvodoo()
				return


/obj/item/paper/merc_contract/worker
	name = "Covenant of Guild Commitments and Operational Service"


/obj/item/paper/merc_contract/worker/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += "THIS AGREEMENT IS MADE AND ENTERED INTO AS OF THE DATE OF LAST SIGNATURE BELOW, BY AND BETWEEN [signedmerc.real_name] (HEREAFTER REFERRED TO AS OUR BENEFICIARY), \
        AND THE MERCENARY GUILD (HEREAFTER REFERRED TO AS THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH)<BR>WITNESSETH:<BR>WHEREAS, OUR BENEFICIARY IS A NATURAL BORN HUMEN OR HUMENOID, POSSESSING SKILLS UPON WHICH HE/SHE/PREFERRED-IDENTITY-PROVIDE  CAN AID THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH, \
        WHO SEEKS TO CONTRIBUTE IN THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH.<BR>WHEREAS, THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AGREES TO UNCONDITIONALLY PROVIDE PAYMENT, AND BENEFITS, WORTHY AND ACCEPTABLE TO OUR BENEFICIARY, \
        IN EXCHANGE FOR CONTINIOUS COOPERATION.<BR>NOW THEREFORE IN CONSIDERATION OF THE MUTUAL COVENANTS HEREIN CONTAINED, AND OTHER GOOD AND VALUABLE CONSIDERATION, THE PARTIES HERETO MUTUALLY AGREE AS FOLLOWS:\
        <BR>IN EXCHANGE FOR PALTRY PAYMENTS AND BENEFITS, OUR BENEFICIARY AGREES TO KEEP THEIR WORK EXCLUSIVELY IN BENEFIT TO THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH REPRESENTETIVE (REFERRED TO AS WHELP DESPITE LACK OF MENTION HEREAFTER), \
        FOR THE REMAINDER OF HIS OR HER OR PREFERRED-IDENTITY-PROVIDE CURRENT LIFE.  PROVIDED OUR BENEFICIARY REMAIN IN DESIRE TO WORK FOR  THE SOVEREIGN BROTHERHOOD OF GLORY AND WEALTH AND WITHOUT THE LAWFUL  EVISCERATION OF THE AGREEMENT STRUCK HEREIN THIS PARCHMENT.<BR> \
        <BR>SIGNED,<BR><i>[signedmerc.real_name]</i>" //still sucks. refer to above
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


/obj/item/paper/merc_work_onetime //this whole shpeal is unintuitive on purpose, we are laying the groundwork for people not paying their debt and having their assets siezed
	name = "One-Time Service and Engagement Agreement" //the actual UI for this sucking isn't part of it though
	desc = ""
	icon_state = "contractunsigned"
	var/signed = FALSE
	var/jobsdone = FALSE
	var/thejob = null
	var/payment = null
	var/mob/living/jobber = null
	var/mob/living/jobed = null

/obj/item/paper/merc_work_onetime/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/merc_work_onetime/update_icon_state()
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

/obj/item/paper/merc_work_onetime/attackby(obj/item/P, mob/living/user, params)
	. = ..()
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		var/awfulpaperworking = browser_input_list(user, "What are you filling out?", src, list("Payment", "Employer signature", "Employee signature", "Job details", "Formalize Contract", "Job completion signature"))
		if(!awfulpaperworking)
			return
		if(!user.is_holding(src) || !Adjacent(src))
			return
		switch(awfulpaperworking)
			if("payment")
				if(payment)
					to_chat(user, span_warning("This section has already been filled."))
					return
				var/discheck = input(user, "How much are you willing to part with?") as null|num
				if(user.is_holding(src) || Adjacent(src))
					payment = discheck
			if("Employer Signature")
				if(jobber)
					to_chat(user, span_warning("This section has already been filled."))
					return
				jobber = user
			if("Employee signature")
				if(!HAS_TRAIT(user, TRAIT_MERCGUILD))
					to_chat(user, span_warning("I don't even work for the guild!"))
					return
				if(jobed)
					to_chat(user, span_warning("This section has already been filled."))
					return
				jobed = user
			if("Job details")
				if(thejob)
					to_chat(user, span_warning("This section has already been filled."))
					return
				var/discheck2 = input(user, "What am I paying them for?")
				if(user.is_holding(src) || Adjacent(src))
					thejob = discheck2
			if("Formalize Contract")
				if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
					to_chat(user, span_warning("This needs the signature of the Guild Master..."))
					return
				if(signed)
					to_chat(user, span_warning("This section has already been filled."))
					return
				signed = TRUE
			if("Job completion signature")
				if(jobsdone)
					to_chat(user, span_warning("This section has already been filled."))
					return
				if(!(thejob || jobed || signed || jobber || payment))
					to_chat(user, span_warning("This contract isn't even filled."))
					return
				if(user != jobber || !(HAS_TRAIT(user, TRAIT_BURDEN) && is_gaffer_assistant_job(user.mind.assigned_role))) //will there ever be an issue with this and the changelings, I don't know
					to_chat(user, span_warning("This isn't mine to sign off"))
					return
				jobsdone = TRUE
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] writes on the contract")
		update_icon_state()

/obj/item/paper/merc_work_conti
	name = "Continuous Engagement and Service Agreement"
	desc = ""
	icon_state = "contractunsigned"
	var/signed = FALSE
	var/thejob = null
	var/payment = null
	var/worktime = null
	var/daycount = null
	var/mob/living/jobber = null
	var/mob/living/jobed = null

/obj/item/paper/merc_work_conti/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/merc_work_conti/update_icon_state()
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

/obj/item/paper/merc_work_conti/attackby(obj/item/P, mob/living/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		var/awfulpaperworking = browser_input_list(user, "What are you filling out?", src, list("Payment", "Employer signature", "Employee signature", "Job details", "Work duration", "Formalize Contract"))
		if(!awfulpaperworking)
			return
		if(!user.is_holding(src) || !Adjacent(src))
			return
		switch(awfulpaperworking)
			if("payment")
				if(payment)
					to_chat(user, span_warning("This section has already been filled."))
					return
				var/discheck = input(user, span_warning("How much are you willing to part with?")) as null|num
				if(user.is_holding(src) || Adjacent(src))
					payment = discheck
			if("Employer Signature")
				if(jobber)
					to_chat(user, span_warning("This section has already been filled."))
					return
				jobber = user
			if("Employee signature")
				if(!HAS_TRAIT(user, TRAIT_MERCGUILD))
					to_chat(user, span_warning("I don't even work for the guild!"))
					return
				if(jobed)
					to_chat(user, span_warning("This section has already been filled."))
					return
				jobed = user
			if("Job details")
				if(thejob)
					to_chat(user, span_warning("This section has already been filled."))
					return
				var/discheck2 = input(user, span_warning("What am I paying them for?"))
				if(user.is_holding(src) || Adjacent(src))
					thejob = discheck2
			if("Work duration")
				if(worktime)
					to_chat(user, span_warning("This section has already been filled."))
					return
				var/discheck3 = input(user, span_warning("How long must they work?")) as null|num
				if(user.is_holding(src) || Adjacent(src))
					worktime = discheck3
					daycount = GLOB.dayspassed
			if("Formalize Contract")
				if(!HAS_TRAIT(user, TRAIT_BURDEN) && !is_gaffer_assistant_job(user.mind.assigned_role))
					to_chat(user, span_warning("This needs the signature of the Guild Master..."))
					return
				if(signed)
					to_chat(user, span_warning("This section has already been filled."))
					return
				signed = TRUE
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] writes on the contract")
		update_icon_state()

/*/obj/item/merc_asset_steal //not sure about this one yet
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	var/signed = FALSE
	var/stewardsigned = FALSE
*/

/obj/item/paper/merc_autograph
	name = ""
	desc = ""
	icon_state = "contractunsigned" //N/A this one should have a unique sprite
	var/mob/living/signed = null

/obj/item/paper/merc_autograph/Initialize()
	switch(rand(1,2))
		if(1) //Lady Lazarus. maybe a little little inappropriate here, but I've always liked that poem.
			info += "</center>I have done it again.<BR>"
			info += "</center>One year in every ten.<BR>"
			info += "</center>I manage it——<BR>"
			info += "</center>A sort of walking miracle, my skin,<BR>"
			info += "</center>Covered in Black Jade<BR>"
			info += "</center>My right foot<BR>"
			info += "</center>Leaves track laid.<BR>"
			info += "</center>My face a featureless, fine<BR>"
			info += "</center>Thick Sallade.<BR>"
			info += "</center>Peel off the hide<BR>"
			info += "</center>O my enemy.<BR>"
			info += "</center>Do I terrify?<BR>"
		if(2) //Ozymandias, kinda hard to pull off without being able to do the "my name is [blank]" sadly
			info += "</center>My name you know well,<BR>" //and you know, Ozymandias is really short
			info += "</center>I am the King of Champions!<BR>"
			info += "</center>Look on my form, ye Mighty,<BR>"
			info += "</center>and despair!<BR>"
	. = ..()


/obj/item/paper/merc_autograph/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		user.hud_used.reads.icon_state = "scroll"
		user.hud_used.reads.show()
		var/dat = {"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
					<html><head><style type=\"text/css\">
					body { background-image:url('book.png');background-repeat: repeat; }</style>
					</head><body scroll=yes>"}
		dat += "[info]<br>"
		dat += "Signature: [signed.real_name]" //"signature" is a bit lame.
		dat += "<a href='byond://?src=[REF(src)];close=1' style='position:absolute;right:50px'>Close</a>"
		dat += "</body></html>"
		user << browse(dat, "window=reading;size=460x300;can_close=0;can_minimize=0;can_maximize=0;can_resize=0;titlebar=0")
		onclose(user, "reading", src)
	else
		return "<span class='warning'>I'm too far away to read it.</span>"


/obj/item/paper/merc_autograph/update_icon_state()
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

/obj/item/paper/merc_autograph/attackby(obj/item/P, mob/living/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!HAS_TRAIT(user, TRAIT_MERCGUILD))
			to_chat(user, span_warning("I haven't sold my likeness to these shills!")) //too opinionated
			return
		if(signed)
			to_chat(user, span_warning("This is already signed")) //too opinionated
			return
		//var/renown = GLOB.mob_renown_list[user.mobid]
		////N/A canned until port. the mercenary check should be fine enough, its 1 point of happiness it can't be that bad
		//if(renown <= 3)
			//to_chat(user, span_warning("I'm uhh...not famous enough for this type of thing."))
			//return
		signed = user
		update_icon_state()

/obj/item/paper/merc_autograph/examine(mob/user)
	. = ..()
	if(!signed)
		return
	if(user.is_holding(src))
		user.add_stress(/datum/stressevent/autograph_fangirl_1)
		//var/Erenown = GLOB.mob_renown_list[signed.mobid]
		//if(Erenown <= 4)
			//user.add_stress(/datum/stressevent/autograph_fangirl_1)
			//return
		//if(Erenown <= 6)
			//user.add_stress(/datum/stressevent/autograph_fangirl_2)
			//return
		//if(Erenown >= 7)
			//user.add_stress(/datum/stressevent/autograph_fangirl_3)
			//return


/obj/item/paper/merc_will //don't look now, but this whole thing is a ploy to make adventurers and mercs keep their money in the banks so they actually contribute to capital
	name = "Mercenary Service Risk Mitigation and Final Testament Agreement"
	icon_state = "contractunsigned"
	var/mob/soontodie
	var/mob/inheretorial
	var/mob/yuptheydied
	var/stewardsigned = FALSE

/obj/item/paper/merc_will/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/merc_will/update_icon_state()
	. = ..()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(yuptheydied)
		icon_state = "contractsigned"
		return
	icon_state = "contractunsigned"

/obj/item/paper/merc_will/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN) || is_gaffer_assistant_job(user.mind.assigned_role))
			if(!soontodie || !inheretorial)
				to_chat(user, span_warning("This will isn't complete."))
				return
			if(yuptheydied)
				to_chat(user, span_warning("This is already signed."))
				return
			var/aretheydead = browser_alert(user, "Has the mercenary passed, is it time to pay the grievers?", "CONFIRM DEATH", "They rest now", "They Walk")
			if(aretheydead == "They walk")
				return
			if(aretheydead == "They rest now" && (user.is_holding(src) || user.Adjacent(src)))
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] confirms [soontodie.real_name]'s death.")
				yuptheydied = user
				update_icon_state()
				return
		if(is_steward_job(user.mind.assigned_role))
			if(!stewardsigned)
				to_chat(user, span_warning("nothing else to write here."))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] ratifies the papers") //ratify doesnt work here
			stewardsigned = TRUE
			return
		if(HAS_TRAIT(user, TRAIT_MERCGUILD))
			if(soontodie && inheretorial)
				to_chat(user, span_warning("nothing else to write here."))
				return
			var/list/bozo = user.mind.known_people
			var/selection = input(user, "Who shall have my wealth once I pass?", "CHOOSE YOUR INHERITOR") as null | anything in bozo
			if(!selection)
				return
			if(!user.is_holding(src) || !Adjacent(src))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] finishes their final statement")
			inheretorial = selection
			soontodie = user
			return
		to_chat(user, span_warning("I can't do anything with this."))



/obj/item/paper/merc_will/adven_will
	name = "Adventurer's Legacy and Risk Waiver Agreement"

/obj/item/paper/merc_will/adven_will/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/merc_will/adven_will/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN) || is_gaffer_assistant_job(user.mind.assigned_role))
			if(!soontodie || !inheretorial)
				to_chat(user, span_warning("This will isn't complete."))
				return
			if(yuptheydied)
				to_chat(user, span_warning("This is already signed."))
				return
			var/aretheydead = browser_alert(user, "Has the mercenary passed, is it time to pay the grievers?", "CONFIRM DEATH", "They rest now", "They Walk")
			if(aretheydead == "They walk")
				return
			if(aretheydead == "They rest now" && (user.is_holding(src) || user.Adjacent(src)))
				playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
				visible_message("[user] confirms [soontodie.real_name]'s death.")
				yuptheydied = user
				update_icon_state()
				return
		if(is_steward_job(user.mind.assigned_role))
			if(!stewardsigned)
				to_chat(user, span_warning("nothing else to write here."))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] ratifies the papers") //ratify doesnt work here
			stewardsigned = TRUE
			return
		if(soontodie && inheretorial)
			to_chat(user, span_warning("nothing else to write here."))
			return
		var/list/bozo = user.mind.known_people
		var/selection = input(user, "Who shall have my wealth once I pass?", "CHOOSE YOUR INHERITOR") as null | anything in bozo
		if(!selection)
			return
		if(!user.is_holding(src) || !Adjacent(src))
			return
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] finishes their final statement")
		inheretorial = selection
		soontodie = user
		return
	to_chat(user, span_warning("I can't do anything with this."))


/obj/item/paper/political_PM
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	var/mob/gaffsigned = null
	var/mob/signed = null
	var/datum/job/jobthatcansign = null

/obj/item/paper/political_PM/update_icon_state()
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

/obj/item/paper/political_PM/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(gaffsigned)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			gaffsigned = user
			if(signed)
				addtimer(CALLBACK(src, PROC_REF(contract_effect)), 12 SECONDS)
				triumph_effect()
				//N/A need to add something to check if they've claimed these triumphs
			return
		if(istype(user.mind.assigned_role, jobthatcansign))
			if(signed)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			signed = user
			update_icon_state()
			if(gaffsigned)
				addtimer(CALLBACK(src, PROC_REF(contract_effect)), 12 SECONDS)
				triumph_effect()
			return
		to_chat(user, span_warning("I can't do anything with this."))

/obj/item/paper/political_PM/proc/contract_effect()
	return

/obj/item/paper/political_PM/proc/triumph_effect()
	return

/obj/item/paper/political_PM/guild_tax_exempt
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	jobthatcansign = /datum/job/steward

/obj/item/paper/political_PM/guild_tax_exempt/Destroy()
	if(signed)
		if(SStreasury.mercnotax == TRUE)
			SStreasury.mercnotax = FALSE
	. = ..()

/obj/item/paper/political_PM/guild_tax_exempt/contract_effect()
	if(signed)
		if(SStreasury.mercnotax == FALSE)
			SStreasury.mercnotax = TRUE

/obj/item/paper/political_PM/guild_tax_exempt/triumph_effect()
	gaffsigned.adjust_triumphs(1)

/obj/item/paper/political_PM/guild_tax_exempt/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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


/obj/item/paper/political_PM/merc_parade
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	jobthatcansign = /datum/job/captain

/obj/item/paper/political_PM/merc_parade/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/political_PM/bloodseal
	COOLDOWN_DECLARE(punish)

/obj/item/paper/political_PM/bloodseal/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/flashlight/flare/torch))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/flashlight/flare/torch/T = P
			if(T.on && user.used_intent.type != INTENT_HARM  && signed)
				bloodvodoo()
				return
	if(istype(P, /obj/item/candle))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/candle/C = PANTS_LAYER
			if(C.lit && user.used_intent.type != INTENT_HARM  && signed)
				bloodvodoo()
				return

	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!HAS_TRAIT(user, TRAIT_BURDEN))
			to_chat(user, span_warning("I can't do anything with this."))
			return
		if(gaffsigned)
			to_chat(user, span_warning("This is already signed"))
			return
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] signs the contract")
		gaffsigned = user
		if(signed)
			addtimer(CALLBACK(src, PROC_REF(contract_effect)), 12 SECONDS)
			triumph_effect()
			//N/A need to add something to check if they've claimed these triumphs
		return
	if(istype(P, /obj/item/gold_prick))
		var/obj/item/gold_prick/G = P
		if(!istype(user.mind.assigned_role, jobthatcansign))
			to_chat(user, span_warning("I can't do anything with this."))
			return
		if(!G.blood)
			to_chat(user, span_warning("The prick is dry."))
			return
		if(signed)
			to_chat(user, span_warning("This is already signed"))
			return
		if(G.blood != user)
			to_chat(user, span_warning("Nothing I write seems to stain the parchment."))
			return
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] signs the contract")
		signed = user
		update_icon_state()
		if(gaffsigned)
			addtimer(CALLBACK(src, PROC_REF(contract_effect)), 12 SECONDS)
			triumph_effect()

/obj/item/paper/political_PM/bloodseal/attack_obj(obj/O, mob/living/user)
	if(istype(O, /obj/item/flashlight/flare/torch))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/flashlight/flare/torch/T = O
			if(T.on && user.used_intent.type != INTENT_HARM && signed)
				bloodvodoo()
				return
	if(istype(O, /obj/item/candle))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/candle/C = O
			if(C.lit && user.used_intent.type != INTENT_HARM && signed)
				bloodvodoo()
				return

/obj/item/paper/political_PM/bloodseal/proc/bloodvodoo(mob/user)
	var/fuckitupterry = browser_alert(user, "The fire is inches away from the parchment", "THE PACT", "Absolve Contract", "Intimidate Whelp") //"Mark for death"
	if(!fuckitupterry)
		to_chat(user, "")
		return
	if(fuckitupterry == "Absolve Contract")
		to_chat(user, "without even being claimed by the fire, the contract crumbles to ash.")
		var/ash = new /obj/item/ash
		qdel(src)
		user.put_in_active_hand(ash)
		return
	if(fuckitupterry == "Intimidate Whelp")
		if(!COOLDOWN_FINISHED(src, punish))
			to_chat(user, "")
			return
		if(!isliving(signed) || signed.stat == UNCONSCIOUS)
			to_chat(user, "")
			return
		//N/A the maniac hallucination code would be neat for this so just wait till thats merged
		COOLDOWN_START(src, punish, 15 MINUTES)
	//if("Mark for death")
		//return

/obj/item/paper/political_PM/bloodseal/exemptfromlaw
	name = ""
	jobthatcansign = /datum/job/lord

/obj/item/paper/political_PM/bloodseal/exemptfromlaw/contract_effect()
	for(var/obj/structure/fake_machine/scomm/X as anything in SSroguemachine.scomm_machines)
		X.getmerced()

/obj/item/paper/political_PM/bloodseal/exemptfromlaw/triumph_effect()
	gaffsigned.adjust_triumphs(2)

/obj/item/paper/political_PM/bloodseal/exemptfromlaw/Destroy()
	if(signed)
		for(var/obj/structure/fake_machine/scomm/X as anything in SSroguemachine.scomm_machines)
			if(X.merctakeover == TRUE)
				X.merctakeover = FALSE
	. = ..()

/obj/item/paper/political_PM/bloodseal/exemptfromlaw/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty
	name = ""

/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/flashlight/flare/torch))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/flashlight/flare/torch/T = P
			if(T.on && user.used_intent.type != INTENT_HARM  && signed)
				bloodvodoo()
				return
	if(istype(P, /obj/item/candle))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			var/obj/item/candle/C = PANTS_LAYER
			if(C.lit && user.used_intent.type != INTENT_HARM  && signed)
				bloodvodoo()
				return

	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(!HAS_TRAIT(user, TRAIT_BURDEN))
			to_chat(user, span_warning("I can't do anything with this."))
			return
		if(gaffsigned)
			to_chat(user, span_warning("This is already signed"))
			return
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] signs the contract")
		gaffsigned = user
		if(signed)
			contract_effect()
			triumph_effect()
			//N/A need to add something to check if they've claimed these triumphs
		return
	if(istype(P, /obj/item/gold_prick))
		var/obj/item/gold_prick/G = P
		if(!is_inquisitor_job(user.mind.assigned_role) && !is_priest_job(user.mind.assigned_role))
			to_chat(user, span_warning("I can't do anything with this."))
			return
		if(!G.blood)
			to_chat(user, span_warning("The prick is dry."))
			return
		if(signed)
			to_chat(user, span_warning("This is already signed"))
			return
		if(G.blood != user)
			to_chat(user, span_warning("Nothing I write seems to stain the parchment."))
			return
		playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
		visible_message("[user] signs the contract")
		signed = user
		update_icon_state()
		if(gaffsigned)
			if(is_priest_job(user.mind.assigned_role))
				addtimer(CALLBACK(src, PROC_REF(contract_effect), TRUE), 12 SECONDS)
			else
				addtimer(CALLBACK(src, PROC_REF(contract_effect)), 12 SECONDS)
			triumph_effect()


/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty/contract_effect(priestsigned = FALSE)
	if(priestsigned)
		for(var/obj/structure/fluff/statue/astrata/statue as anything in GLOB.astrata_statues)
			statue.breaking = TRUE
			statue.update_appearance(UPDATE_OVERLAYS)
		return
	for(var/obj/item/clothing/neck/psycross/cross as anything in GLOB.psycrosses)
		cross.rotting = TRUE
		cross.update_appearance(UPDATE_OVERLAYS)

/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty/triumph_effect()
	gaffsigned.adjust_triumphs(2)

/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty/Destroy()
	if(signed)
		if(signed.mind.assigned_role == "Priest" || signed.mind.assigned_role == "Priestess")
			for(var/obj/structure/fluff/statue/astrata/statue as anything in GLOB.astrata_statues)
				statue.breaking = FALSE
				statue.update_appearance(UPDATE_OVERLAYS)
		else
			for(var/obj/item/clothing/neck/psycross/cross as anything in GLOB.psycrosses)
				cross.rotting = FALSE
				cross.update_appearance(UPDATE_OVERLAYS)
	. = ..()


/obj/item/paper/political_PM/bloodseal/exempt_from_cruelty/read(mob/user)
	if(!user.client || !user.hud_used)
		return
	if(!user.hud_used.reads)
		return
	if(!user.can_read(src))
		to_chat(user, span_warning("Even if I could read, I don't think I would care to."))
		return
	if(in_range(user, src) || isobserver(user))
		info += ""
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

/obj/item/paper/merchant_merger
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	var/gaffsigned = FALSE
	var/used = FALSE
	var/mob/merchant

/obj/item/paper/merchant_merger/update_icon_state()
	. = ..()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(merchant)
		icon_state = "contractsigned"
		return
	icon_state = "contractunsigned"

/obj/item/paper/merchant_merger/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(gaffsigned)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			gaffsigned = TRUE
			if(merchant)
				ADD_TRAIT(merchant, TRAIT_MERCGUILD, type)
			return
		if(is_merchant_job(user.mind.assigned_role))
			if(merchant)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			merchant = user
			if(gaffsigned)
				ADD_TRAIT(user, TRAIT_MERCGUILD, type)
			update_icon_state()
			return
		to_chat(user, span_warning("I can't do anything with this."))

/obj/item/paper/inn_partnership
	name = ""
	desc = ""
	icon_state = "contractunsigned"
	var/gaffsigned = FALSE
	var/used = FALSE
	var/mob/inkeep

/obj/item/paper/inn_partnership/update_icon_state()
	. = ..()
	if(mailer)
		icon_state = "paper_prep"
		name = "letter"
		throw_range = 7
		return
	name = initial(name)
	throw_range = initial(throw_range)
	if(inkeep)
		icon_state = "contractsigned"
		return
	icon_state = "contractunsigned"

/obj/item/paper/inn_partnership/attackby(obj/item/P, mob/living/carbon/human/user, params)
	if(istype(P, /obj/item/natural/thorn) || istype(P, /obj/item/natural/feather))
		if(HAS_TRAIT(user, TRAIT_BURDEN))
			if(gaffsigned)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			gaffsigned = TRUE
			if(inkeep)
				ADD_TRAIT(inkeep, TRAIT_MERCGUILD, type)
			return
		if(is_innkeep_job(user.mind.assigned_role))
			if(inkeep)
				to_chat(user, span_warning("This is already signed"))
				return
			playsound(src, 'sound/items/write.ogg', 50, FALSE, ignore_walls = FALSE)
			visible_message("[user] signs the contract")
			inkeep = user
			if(gaffsigned)
				ADD_TRAIT(user, TRAIT_MERCGUILD, type)
			update_icon_state()
			return
		to_chat(user, span_warning("I can't do anything with this."))

/*
/obj/item/tournament //need to do some logistics with this first.
	name = ""
	desc = ""
	icon_state = "contractunsigned"

*/


//canned until the delver ranking is imported
/*
/obj/item/renown1
	name = "Official Decree of Mercenary Renown and Valor Recognition"
	desc = ""
	icon_state = "contractunsigned"

/obj/item/renown2
	name = "The Scroll of Valor and Mercenary's Esteemed Recognition"
	desc = ""
	icon_state = "contractunsigned"

/obj/item/renown3
	name = "The Record of Heroic Achievements and Mercenary's Esteem"
	desc = ""
	icon_state = "contractunsigned"
*/



/obj/item/headeater_spawn
	name = "HEADEATER SPAWN"
	icon_state = "headeater_spawn"
	icon = 'icons/roguetown/items/misc.dmi'
	desc = "Slithering mass of loose teeth and dark red flesh, it pulsates randomly."
	//lefthand_file = ''
	//righthand_file = ''
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.4
	drop_sound = 'sound/surgery/organ1.ogg'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/item/headeater_spawn/pickup(mob/user)
	to_chat(user, span_danger("WHAT IS THIS PUTRID THING?!!"))
	user.add_stress(/datum/stressevent/touched_headeater_spawn)
	. = ..()

/obj/item/headeater_spawn/examine(mob/user)
	. += "<span class='info'></span>"

/obj/item/hailer_core
	//name = ""
	//icon_state = ""
	//icon = ''
	//desc = ""
	//lefthand_file = ''
	//righthand_file = ''
	w_class = WEIGHT_CLASS_TINY
	dropshrink = 0.4
	drop_sound = 'sound/surgery/organ1.ogg'
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/usage = 2

/obj/item/hailer_core/attack_self(mob/living/user)
	var/alert = alert(user, "Do I want to use this?", "HAILER CORE", "Yes", "No")
	if(alert == "No")
		return
	var/turf/place = get_step(get_turf(user), user.dir)
	if(usage == 2)
		new /obj/structure/fake_machine/hailer/inn_hailer(place)
	else
		new /obj/structure/fake_machine/hailerboard/inn_hailer_board(place)
	playsound(place, 'sound/combat/gib (2).ogg')
	to_chat(user, span_notice("The writhing flesh compresses itself into a different shape..."))
	usage--

/*-----------------------------------------------------------------\
|  MERCHANT ZONE PAST THIS POINT. PSYDON SAVE ALL YEE WHO PASS     |
\-----------------------------------------------------------------*/

/*
/obj/item/paper/merchant_contract //base
/obj/item/paper/merchant_contract/private_worker // hire miners, woodcutters, fishers. etc to work only for the merchant guild
/obj/item/paper/merchant_contract/private_mine // make it illegal to work in the mines without the guilds approval. own the ore market and by proxy the makers guild..
/obj/item/paper/merchant_contract/purchase_farm_land //purchase all the farm lands, pay the soilsons dimes to work their own land. own the food market and by proxy, the inn
/obj/item/paper/merchant_contract/fish_conservation_act //make it illegal to fish in the town borders, same idea as above..
/obj/item/paper/merchant_contract/ethical_herb_gathering_act //say it is inhumane the grow herbs inside town borders with requirements that are unreachable, hire people to get herbs outside and sell it in bulk. own the potion industry
/obj/item/paper/merchant_contract/town_inheretance_site //make bog and the woods into an inheretence site that you get to upkeep, own the wood and...I dunno what the bog offers?
*/
