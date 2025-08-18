/obj/effect/contextual_actor

	icon = 'icons/testing/source.dmi'
	icon_state = MAP_SWITCH("none", "actor")

	/* SHIT MAPPERS CAN CHANGE FOR THEIR PURPOSES BELOW*/

	/// an html to pick from when sending to the player, can be a single or a list
	var/raw_html_to_pick_from
	/// the range at which the raw html is sent to when activated
	var/range_to_display_in = 8
	/// a sound to play when activated, can be a single or a list
	var/sounds_to_pick_from = 'sound/villain/dreamer_warning.ogg'
	/// how close do you have to step for it to activate
	var/activation_radius = 2
	/// is this actor deleted on activation? if false, will be disabled for the duration of the reactivation timer on activation
	var/delete_me_on_activate = FALSE
	/// how long is the cooldown for activation
	var/reactivation_timer = 5 SECONDS

	/* CODE STUFF BELOW, DON'T TOUCH THIS IF YOU DON'T KNOW WHAT IT DOES */

	/// used for tracking which mobs have triggered this actor already, if they have, they won't activate it.
	var/weak_refs_to_mobs_that_have_seen_me = list()
	/// tracks if this actor is currently activated
	var/active = TRUE
	/// proximity monitor associated with the actor
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
