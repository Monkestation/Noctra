/obj/effect/contextual_actor

	icon = 'icons/testing/source.dmi'
	icon_state = MAP_SWITCH("none", "actor")

	var/text_to_pick_from

	var/spans_to_pick_from

	var/range_to_display_in = 1

	var/sounds_to_pick_from

	var/remove_on_activation = FALSE

	var/radius = 1

	var/delete_me_on_activate = FALSE

	var/reactivation_timer = 5 SECONDS

	var/active = TRUE

	var/datum/proximity_monitor/proximity_monitor

/obj/effect/contextual_actor/Initialize(mapload)
	. = ..()
	if(text_to_pick_from && !islist(text_to_pick_from))
		text_to_pick_from = list(text_to_pick_from)
	if(spans_to_pick_from && !islist(spans_to_pick_from))
		spans_to_pick_from = list(spans_to_pick_from)
	if(sounds_to_pick_from && !islist(sounds_to_pick_from))
		sounds_to_pick_from = list(sounds_to_pick_from)

	create_trippers()

/obj/effect/contextual_actor/proc/create_trippers()
	if((radius == 1))
		return

	proximity_monitor = new(src, radius)

/obj/effect/contextual_actor/Destroy(force)
	. = ..()
	QDEL_NULL(proximity_monitor)

/obj/effect/contextual_actor/HasProximity(atom/movable/AM)
	. = ..()
	stepped_on(AM)

/obj/effect/contextual_actor/Crossed(atom/movable/AM, oldloc)
	. = ..()
	stepped_on(AM)

/obj/effect/contextual_actor/proc/stepped_on(atom/movable/AM)
	if(!isliving(AM) || QDELETED(src))
		return
	if(!active)
		return

	do_acting()

/obj/effect/contextual_actor/proc/display_text(mob/displayed_to)
	to_chat(displayed_to, "[spans_to_pick_from ? "<span class=\'>[pick(spans_to_pick_from)]\'" : ""][pick(text_to_pick_from)][spans_to_pick_from ? "</span>" : ""]")

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
