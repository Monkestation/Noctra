/**
 * ### Pointed beam spell
 *
 * Creates a beam between the caster and the target.
 */
/datum/action/cooldown/spell/beam
	// Beam creation vars
	var/beam_icon = 'icons/effects/beam.dmi'
	var/beam_icon_state = "3-full"
	var/time = 5 SECONDS
	var/max_distance = 10
	var/beam_type = /obj/effect/ebeam/reacting
	var/beam_color = null
	var/emissive = TRUE
	var/beam_layer = ABOVE_ALL_MOB_LAYER
	var/beam_plane = GAME_PLANE_UPPER

	// Beam instance
	var/datum/beam/active

/datum/action/cooldown/spell/beam/Destroy()
	if(active)
		QDEL_NULL(active)
	return ..()

/datum/action/cooldown/spell/beam/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	return isliving(cast_on) || (isatom(cast_on) && cast_on.density)

/datum/action/cooldown/spell/beam/cast(atom/cast_on)
	. = ..()

	active = owner.Beam(
		cast_on,
		beam_icon_state,
		beam_icon,
		time,
		max_distance,
		beam_type,
		emissive,
		beam_layer,
		beam_plane,
	)

	on_beam_connect(cast_on, owner)

	if(ispath(beam_type, /obj/effect/ebeam/reacting))
		RegisterSignal(active, COMSIG_BEAM_ENTERED, PROC_REF(beam_entered))
		RegisterSignal(active, COMSIG_BEAM_EXITED, PROC_REF(beam_exited))

/// When the beam is connected to the target
/datum/action/cooldown/spell/beam/proc/on_beam_connect(atom/victim, mob/caster)
	return

/// When movable enters the ebeam
/datum/action/cooldown/spell/beam/proc/beam_entered(datum/beam/source, obj/effect/ebeam/hit, atom/movable/entered)
	SIGNAL_HANDLER

	return

/// When movable exits the ebeam
/datum/action/cooldown/spell/beam/proc/beam_exited(datum/beam/source, obj/effect/ebeam/hit, atom/movable/exited)
	SIGNAL_HANDLER

	return
