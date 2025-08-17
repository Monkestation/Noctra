/obj/effect/contextual_actor

	icon = 'icons/testing/source.dmi'
	icon_state = MAP_SWITCH("none", "actor")

	var/raw_html_to_pick_from

	var/range_to_display_in = 8

	var/sounds_to_pick_from = 'sound/villain/dreamer_warning.ogg'

	var/remove_on_activation = FALSE

	var/activation_radius = 2

	var/delete_me_on_activate = FALSE

	var/reactivation_timer = 5 SECONDS

	var/weak_refs_to_mobs_that_have_seen_me = list()

	var/active = TRUE

	var/datum/proximity_monitor/proximity_monitor

/obj/effect/contextual_actor/Initialize(mapload)
	. = ..()
	if(raw_html_to_pick_from && !islist(raw_html_to_pick_from))
		raw_html_to_pick_from = list(raw_html_to_pick_from)
	if(sounds_to_pick_from && !islist(sounds_to_pick_from))
		sounds_to_pick_from = list(sounds_to_pick_from)

	create_trippers()

/obj/effect/contextual_actor/proc/create_trippers()
	proximity_monitor = new(src, activation_radius)

/obj/effect/contextual_actor/Destroy(force)
	. = ..()
	QDEL_NULL(proximity_monitor)

/obj/effect/contextual_actor/HasProximity(atom/movable/AM)
	. = ..()
	stepped_on(AM)

/obj/effect/contextual_actor/proc/stepped_on(atom/movable/AM)
	if(!isliving(AM) || QDELETED(src))
		return
	if(!active)
		return
	var/mob/living/stepper = AM

	if(!stepper.client)
		return

	var/list/mobs_that_have_seen_me_before = list()

	for(var/datum/weakref/ref as anything in weak_refs_to_mobs_that_have_seen_me)
		var/mob/living/seeker = ref.resolve()
		if(seeker)
			mobs_that_have_seen_me_before += seeker

	if(stepper in (mobs_that_have_seen_me_before))
		return FALSE

	do_acting()

/obj/effect/contextual_actor/proc/display_text(mob/displayed_to)
	to_chat(displayed_to, pick(raw_html_to_pick_from))
	weak_refs_to_mobs_that_have_seen_me += WEAKREF(displayed_to)

/obj/effect/contextual_actor/proc/do_acting()
	for(var/mob/viewer in view(range_to_display_in))
		display_text(viewer)

	if(sounds_to_pick_from)
		var/picked_sound = pick(sounds_to_pick_from)
		playsound(src, picked_sound, 100)

	if(delete_me_on_activate)
		qdel(src)
	else
		active = FALSE
		addtimer(VARSET_CALLBACK(src, active, TRUE), reactivation_timer)

/obj/effect/contextual_actor/preset
	raw_html_to_pick_from = \
		"<!DOCTYPE html>\
		<html>\
		<head>\
		    <title>DANGER!</title>\
		    <style>\
		        .scary-text {\
		            font-size: 20px;\
		            text-shadow: 0 0 10px red;\
					color: darkred;\
		            animation: flicker 0.5s infinite alternate;\
		            white-space: pre;\
		        }\
		        \
		        @keyframes flicker {\
		            0% { opacity: 0.8; }\
		            100% { opacity: 1; }\
		        }\
		    </style>\
		</head>\
		<body>\
		    <div class=\"scary-text\">\
		        %TEXT_TO_REPLACE_WITH\
		    </div>\
		</body>\
		</html>";


	var/text_to_replace_with = "\
		YOU LOOK AROUND<br>\
		YOU ARE SURROUNDED BY GOBLINS!\
		"

/obj/effect/contextual_actor/preset/Initialize(mapload)
	. = ..()
	if(!islist(text_to_replace_with))
		text_to_replace_with = list(text_to_replace_with)
	for(var/html_num in 1 to length(raw_html_to_pick_from))
		raw_html_to_pick_from[html_num] = replacetext(raw_html_to_pick_from[html_num], "%TEXT_TO_REPLACE_WITH", pick(text_to_replace_with))
