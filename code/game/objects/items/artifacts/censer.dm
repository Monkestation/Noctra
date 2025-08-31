/datum/intent/bless
	name = "bless"
	icon_state = "inbless"
	no_attack = TRUE
	candodge = TRUE
	canparry = TRUE

/datum/intent/weep
	name = "weep"
	icon_state = "inweep"
	no_attack = TRUE
	candodge = FALSE
	canparry = FALSE

/atom/movable/screen/alert/status_effect/buff/censerbuff
	name = "Inspired by Psydon."
	desc = "The lingering blessing of Pyson tells me to ENDURE."
	icon_state = "censerbuff"

/datum/status_effect/buff/censerbuff
	id = "censer"
	alert_type = /atom/movable/screen/alert/status_effect/buff/censerbuff
	duration = 15 MINUTES
	effectedstats = list("endurance" = 1, "constitution" = 1)

/datum/stressevent/syoncalamity
	stressadd = 15
	desc = span_boldred("Yet another part of Psydon lost!")
	timer = 15 MINUTES

/datum/intent/flail/strike/smash/golgotha
	hitsound = list('sound/items/beartrap2.ogg')

/obj/effect/temp_visual/censer_dust
	icon = 'icons/effects/effects.dmi'
	icon_state = "extinguish"
	duration = 8

/obj/item/flashlight/flare/torch/lantern/psycenser
	name = "Golgatha"
	desc = "A masterfully-crafted thurible that, when opened, emits a ghastly perfume that reinvigorates the flesh-and-steel. It is said to contain a linger portion of Psydon."
	icon_state = "psycenser"
	item_state = "psycenser"
	icon = 'icons/roguetown/weapons/32.dmi'
	light_outer_range = 8
	light_color ="#70d1e2"
	possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
	fuel = 999 MINUTES
	force = 30
	var/next_smoke
	var/smoke_interval = 2 SECONDS

/obj/item/flashlight/flare/torch/lantern/psycenser/examine(mob/user)
	. = ..()
	if(fuel > 0)
		. += span_info("If opened, it may bless Psydon weapons and those of Psydon faith.")
		. += span_warning("Smashing a creature with it open will create a devastating explosion and render it useless.")
	if(fuel <= 0)
		. += span_info("It is gone.")

/obj/item/flashlight/flare/torch/lantern/psycenser/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.4,"sx" = -2,"sy" = -4,"nx" = 9,"ny" = -4,"wx" = -3,"wy" = -4,"ex" = 2,"ey" = -4,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 45, "sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 45,"sturn" = 45,"wturn" = 45,"eturn" = 45,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/obj/item/flashlight/flare/torch/lantern/psycenser/attack_self(mob/user)
	if(fuel > 0)
		if(on)
			turn_off()
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha)
			user.update_a_intents()
		else
			playsound(src.loc, 'sound/items/censer_on.ogg', 100)
			possible_item_intents = list(/datum/intent/flail/strike/smash/golgotha, /datum/intent/bless)
			user.update_a_intents()
			on = TRUE
			update_brightness()
			//force = on_damage
			if(ismob(loc))
				var/mob/M = loc
				M.update_inv_hands()
			START_PROCESSING(SSobj, src)
	else if(fuel <= 0 && user.used_intent.type == /datum/intent/weep)
		to_chat(user, span_info("It is gone. You weep."))
		user.emote("cry")

/obj/item/flashlight/flare/torch/lantern/psycenser/process()
	if(on && next_smoke < world.time)
		new /obj/effect/temp_visual/censer_dust(get_turf(src))
		next_smoke = world.time + smoke_interval


/obj/item/flashlight/flare/torch/lantern/psycenser/turn_off()
	playsound(src.loc, 'sound/items/censer_off.ogg', 100)
	STOP_PROCESSING(SSobj, src)
	..()
	if(ismob(loc))
		var/mob/M = loc
		M.update_inv_hands()
		M.update_inv_belt()
	damtype = BRUTE


/obj/item/flashlight/flare/torch/lantern/psycenser/fire_act(added, maxstacks)
	return

/obj/item/flashlight/flare/torch/lantern/psycenser/afterattack(atom/movable/A, mob/user, proximity)
	. = ..()	//We smashed a guy with it turned on. Bad idea!
	if(ismob(A) && on && (user.used_intent.type == /datum/intent/flail/strike/smash/golgotha) && user.cmode)
		user.visible_message(span_warningbig("[user] smashes the exposed [src], shattering the shard of SYON!"))
		explosion(get_turf(A),devastation_range = 2, heavy_impact_range = 3, light_impact_range = 4, flame_range = 2, flash_range = 4, smoke = FALSE)
		fuel = 0
		turn_off()
		icon_state = "psycenser-broken"
		possible_item_intents = list(/datum/intent/weep)
		user.update_a_intents()
		for(var/mob/living/carbon/human/H in view(get_turf(src)))
			H.add_stress(/datum/stressevent/syoncalamity)
	if(isitem(A) && on && user.used_intent.type == /datum/intent/bless)
		var/datum/component/psyblessed/CP = A.GetComponent(/datum/component/psyblessed)
		if(!CP)
			A.AddComponent(/datum/component/psyblessed, FALSE, 3, FALSE, 50, 1, TRUE)
			CP = A.GetComponent(/datum/component/psyblessed)
		if(CP)
			if(!CP.is_blessed)
				playsound(user, 'sound/magic/censercharging.ogg', 100)
				user.visible_message(span_info("[user] holds \the [src] over \the [A]..."))
				if(do_after(user, 50, target = A))
					CP.try_bless()
					new /obj/effect/temp_visual/censer_dust(get_turf(A))
			else
				to_chat(user, span_info("It has already been blessed."))

	if(ishuman(A) && on && (user.used_intent.type == /datum/intent/bless))
		var/mob/living/carbon/human/H = A
		if(!H.has_status_effect(/datum/status_effect/buff/censerbuff))
			playsound(user, 'sound/magic/censercharging.ogg', 100)
			user.visible_message(span_info("[user] holds \the [src] over \the [A]..."))
			if(do_after(user, 50, target = A))
				H.apply_status_effect(/datum/status_effect/buff/censerbuff)
				to_chat(H, span_notice("The lingering Psydon invigorates you."))
				playsound(H, 'sound/magic/holyshield.ogg', 100)
				new /obj/effect/temp_visual/censer_dust(get_turf(H))
		else
			to_chat(span_warning("They've already been blessed."))

/datum/component/psyblessed
	var/is_blessed
	var/pre_blessed
	var/added_force
	var/added_blade_int
	var/added_int
	var/added_def
	var/silver

/datum/component/psyblessed/Initialize(preblessed = FALSE, force, blade_int, int, def, makesilver)
	if(!istype(parent, /obj/item/weapon))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))
	pre_blessed = preblessed
	added_force = force
	added_blade_int = blade_int
	added_int = int
	added_def = def
	silver = makesilver
	if(pre_blessed)
		apply_bless()

/datum/component/psyblessed/proc/on_examine(datum/source, mob/user, list/examine_list)
	if(!is_blessed)
		examine_list += span_info("<font color = '#cfa446'>This object may be blessed by the lingering fragment of Psydon. Until then, its impure alloying of silver-and-steel cannot blight inhumen foes on its own.</font>")
	if(is_blessed)
		examine_list += span_info("<font color = '#46bacf'>This object has been blessed by the fragment of Psydon.</font>")
		if(silver)
			examine_list += span_info("It has been imbued with <b>silver</b>.")

/datum/component/psyblessed/proc/try_bless()
	if(!is_blessed)
		apply_bless()
		play_effects()
		return TRUE
	else
		return FALSE

/datum/component/psyblessed/proc/play_effects()
	if(isitem(parent))
		var/obj/item/I = parent
		playsound(I, 'sound/magic/holyshield.ogg', 100)
		I.visible_message(span_notice("[I] glistens with power!"))

/datum/component/psyblessed/proc/apply_bless()
	if(isitem(parent))
		var/obj/item/I = parent
		is_blessed = TRUE
		I.force += added_force
		if(I.force_wielded)
			I.force_wielded += added_force
		if(I.max_blade_int)
			I.max_blade_int += added_blade_int
			I.blade_int = I.max_blade_int
		I.modify_max_integrity(I.max_integrity + added_int)
		I.wdefense += added_def
		I.name = "blessed [I.name]"
