// Based on holopad rays. Causes a Shadow to move from T to C
// "sprite" var can be replaced to use another icon_state from icons/effects/96x96.dmi
/proc/shadow(atom/C, turf/T, sprite = "rune_blind")
	var/disty = C.y - T.y
	var/distx = C.x - T.x
	var/newangle
	if(!disty)
		if(distx >= 0)
			newangle = 90
		else
			newangle = 270
	else
		newangle = arctan(distx/disty)
		if(disty < 0)
			newangle += 180
		else if(distx < 0)
			newangle += 360
	var/matrix/M1 = matrix()
	var/matrix/M2 = turn(M1.Scale(1, sqrt(distx*distx+disty*disty)), newangle)
	return anim(target = C, a_icon = 'icons/effects/vampire/96x96.dmi', flick_anim = sprite, offX = -32, offY = -32, plane = ABOVE_LIGHTING_PLANE, trans = M2)

/proc/cheap_pythag(const/Ax, const/Ay)
	var/dx = abs(Ax)
	var/dy = abs(Ay)

	if (dx >= dy)
		return dx + (0.5 * dy) // The longest side add half the shortest side approximates the hypotenuse.
	else
		return dy + (0.5 * dx)

/datum/rune_spell/stun
	name = "Stun"
	desc = "Overwhelm everyone's senses with a blast of pure chaotic energy. Cultists will recover their senses a bit faster."
	desc_talisman = "Use to produce a smaller radius blast, or touch someone with it to focus the entire power of the spell on their person."
	invocation = "Fuu ma'jin!"
	touch_cast = TRUE
	word1 = /datum/rune_word/join
	word2 = /datum/rune_word/hide
	word3 = /datum/rune_word/technology
	page = "Concentrated chaotic energies violently released that will temporarily enfeeble anyone in a large radius, even cultists, although those recover a second faster than non-cultists.\
		<br><br>When cast from a talisman, the energy affects creatures in a smaller radius and for a smaller duration, which might still be useful in an enclosed space.\
		<br><br>However the real purpose of this rune when imbued into a talisman is revealed when you directly touch someone with it, as all of the energies will be concentrated onto their single body, \
		paralyzing and muting them for a longer duration. This application was created to allow cultists to easily kidnap crew members to convert or torture."


/datum/rune_spell/stun/pre_cast()
	var/mob/living/user = activator

	if (istype (spell_holder, /obj/effect/blood_rune))
		invoke(user, invocation)
		cast()
	else if (istype (spell_holder, /obj/item/talisman))
		invoke(user, invocation, 1)
		cast_talisman()

/datum/rune_spell/stun/cast()
	var/obj/effect/blood_rune/R = spell_holder
	R.one_pulse()

	new/obj/effect/blood_ritual/stun(R.loc, 1, activator)

	qdel(R)

/datum/rune_spell/stun/cast_talisman()
	var/turf/T = get_turf(spell_holder)
	new/obj/effect/blood_ritual/stun(T, 2, activator)
	qdel(src)

/datum/rune_spell/stun/cast_touch(mob/living/M)
	anim(target = M, a_icon = 'icons/effects/vampire/64x64.dmi', flick_anim = "touch_stun", offX = -32/2, offY = -32/2, plane = ABOVE_LIGHTING_PLANE)

	playsound(spell_holder, 'sound/effects/vampire/stun_talisman.ogg', 25, 0, -5)
	invoke(activator, invocation, 1)

	if(iscarbon(M))
		to_chat(M, span_danger("A surge of dark energies takes hold of your limbs. You stiffen and fall down.") )
		var/mob/living/carbon/C = M
		C.Knockdown(5 SECONDS)//used to be 25
		C.Stun(5 SECONDS)//used to be 25

	if (!(locate(/obj/effect/stun_indicator) in M))
		new /obj/effect/stun_indicator(M)

	qdel(src)

/obj/effect/blood_ritual/stun
	icon_state = "stun_warning"
	color = "black"
	anchored = TRUE
	alpha = 0
	plane = GAME_PLANE_UPPER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/stun_duration = 10 SECONDS

/obj/effect/blood_ritual/stun/Initialize(mapload, type = 1, mob/living/carbon/caster)
	. = ..()

	switch(type)
		if(1)
			stun_duration = 10 SECONDS
			anim(target = loc, a_icon = 'icons/effects/vampire/64x64.dmi', flick_anim = "rune_stun", sleeptime = 20, offX = -16, offY = -16, plane = ABOVE_LIGHTING_PLANE)
			icon = 'icons/effects/vampire/480x480.dmi'
			SET_BASE_PIXEL(-224, -224)
			animate(src, alpha = 255, time = 1 SECONDS)
		if(2)
			stun_duration = 5 SECONDS
			anim(target = loc, a_icon = 'icons/effects/vampire/64x64.dmi', flick_anim = "talisman_stun", sleeptime = 20, offX = -16, offY = -16, plane = ABOVE_LIGHTING_PLANE)
			icon = 'icons/effects/vampire/224x224.dmi'
			SET_BASE_PIXEL(-96, -96)
			animate(src, alpha = 255, time = 1 SECONDS)

	playsound(src, 'sound/effects/vampire/stun_rune_charge.ogg', 75, 0, 0)

	addtimer(CALLBACK(src, PROC_REF(do_stun)), 2 SECONDS)

/obj/effect/blood_ritual/stun/proc/do_stun()
	playsound(src, 'sound/effects/vampire/stun_rune.ogg', 75, 0, 0)
	visible_message(span_warning("The rune explodes in a bright flash of chaotic energies!") )

	for(var/mob/living/L in dview(7, get_turf(src)))
		var/duration = stun_duration
		var/dist = cheap_pythag(L.x - src.x, L.y - src.y)
		if(type == 1 && dist >= 8)
			continue
		if(type == 2 && dist >= 4)//talismans have a reduced range
			continue
		shadow(L, get_turf(src), "rune_stun")
		if(L.clan)
			duration = 1 SECONDS
		if(iscarbon(L))
			var/mob/living/carbon/C = L
			C.Knockdown(duration)
			C.Stun(duration)
	qdel(src)
