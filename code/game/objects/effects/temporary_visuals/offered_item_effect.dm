/obj/effect/temp_visual/offered_item_effect
	duration = 11 SECONDS
	fade_time = 0.5 SECONDS
	var/datum/weakref/offerer_weak_ref
	var/datum/weakref/offered_to_weak_ref
	var/datum/weakref/offered_thing_weak_ref
	plane = GAME_PLANE_FOV_HIDDEN
	mouse_opacity = MOUSE_OPACITY_ICON
	var/handover_in_progress = FALSE


/obj/effect/temp_visual/offered_item_effect/Initialize(mapload, obj/offered_thing, mob/living/offerer, mob/living/offered_to)
	. = ..()
	icon = offered_thing.icon
	icon_state = offered_thing.icon_state
	appearance = offered_thing.appearance
	filters += filter(type="rays")
	transform /= 1.3
	offered_thing_weak_ref = WEAKREF(offered_thing)
	offerer_weak_ref = WEAKREF(offerer)
	offered_to_weak_ref = WEAKREF(offered_to)
	RegisterSignal(offerer, COMSIG_MOVABLE_MOVED, PROC_REF(someone_moved))
	RegisterSignal(offered_to, COMSIG_MOVABLE_MOVED, PROC_REF(someone_moved))
	RegisterSignal(offerer, COMSIG_LIVING_STOPPED_OFFERING_ITEM, PROC_REF(stopped_offering))
	RegisterSignal(offerer, COMSIG_PARENT_QDELETING, PROC_REF(timed_out))
	calculate_offset()

/obj/effect/temp_visual/offered_item_effect/proc/stopped_offering(mob/living/offerer)
	if(handover_in_progress)
		return

	handover_in_progress = TRUE

	if((x != offerer.x) || (y != offerer.y))
		Move(get_turf(offerer))

	animate(src, transform = matrix() * 0, alpha = 0, pixel_w = 0, pixel_z = 0, time = 0.7 SECONDS)

/obj/effect/temp_visual/offered_item_effect/proc/someone_moved(datum/parent)
	SIGNAL_HANDLER

	if(QDELETED(src))
		return

	if(handover_in_progress)
		return

	var/mob/living/offerer = offerer_weak_ref.resolve()
	var/mob/living/offered_to = offered_to_weak_ref.resolve()

	if(isnull(offerer) || isnull(offered_to))
		qdel(src)
		return

	if(!offerer.Adjacent(offered_to))
		timed_out()
		return

	calculate_offset()

/obj/effect/temp_visual/offered_item_effect/proc/calculate_offset()
	if(QDELETED(src))
		return

	var/mob/living/offerer = offerer_weak_ref.resolve()
	var/mob/living/offered_to = offered_to_weak_ref.resolve()

	if(isnull(offerer) || isnull(offered_to))
		qdel(src)
		return

	if((x != offerer.x) || (y != offerer.y))
		Move(get_turf(offerer))

	var/w_displace = (offered_to.x - offerer.x) * 16
	var/z_displace = (offered_to.y - offerer.y) * 16 + 4

	animate(src, pixel_w = w_displace, pixel_z = z_displace, time = 0.2 SECONDS)

/obj/effect/temp_visual/offered_item_effect/attack_hand(mob/living/user)
	. = ..()
	var/mob/living/offerer = offerer_weak_ref.resolve()
	var/obj/offered_thing = offered_thing_weak_ref.resolve()
	if(isnull(offered_thing) || isnull(offerer))
		return

	if(!user.try_accept_offered_item(offerer, offered_thing))
		return

	if(handover_in_progress)
		return

	handover_in_progress = TRUE

	animate(src, transform = matrix() * 0, alpha = 0, pixel_w = src.pixel_w * 2, pixel_z = src.pixel_z * 2 - 8, time = 0.5 SECONDS)
