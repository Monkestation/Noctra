/obj/effect/contextual_actor

	icon = 'icons/testing/source.dmi'
	icon_state = MAP_SWITCH("none", "actor")

	var/text_to_pick_from

	var/spans_to_pick_from

	var/range_to_display_in = 1

	var/sounds_to_pick_from

	var/remove_on_activation = FALSE

	var/x_spanning_radius = 0

	var/y_spanning_radius = 0

	var/area_spanning = FALSE

	var/delete_me_on_activate = FALSE

	var/reactivation_timer = 5 SECONDS

	var/active = TRUE

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
	if(area_spanning && (!x_spanning_radius || !y_spanning_radius))
		CRASH("can't create an area with one of the radiuses being 1!")

	if(area_spanning)



/obj/effect/contextual_actor/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(isliving(AM) && !QDELETED(src))
		stepped_on()

/obj/effect/contextual_actor/proc/stepped_on()
	if(active)
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

/obj/effect/tripper
	name = "don't map this in"

	var/datum/weakref/context_to_pick_from_actor_ref

/obj/effect/tripper/Crossed(atom/movable/AM, oldloc)
	. = ..()
	var/obj/effect/contextual_actor/actor = context_to_pick_from_actor_ref.resolve()
	if(!actor)
		qdel(src)
		return

	actor.stepped_on()

/obj/effect/tripper/Initialize(mapload, actor)
	. = ..()
	if(!text_to_pick_from)
		stack_trace("[src] spawned without a passed text_to_pick_from")
		qdel(src)
		return

	actor = WEAKREF(text_to_pick_from)

	RegisterSignal(text_to_pick_from, COMSIG_PARENT_QDELETING, PROC_REF(on_parent_deletion))

/obj/effect/tripper/proc/on_parent_deletion(datum/parent)
	SIGNAL_HANDLER
	qdel(src)

