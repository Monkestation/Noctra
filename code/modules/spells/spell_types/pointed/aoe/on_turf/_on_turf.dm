/**
 * ## On turf AOE spells
 *
 * AOE spell where get_things_to_cast_on is a block of turfs
 */
/datum/action/cooldown/spell/aoe/on_turf
	/// Turfs with density can't be targets
	var/respect_density = TRUE
	/// Get turfs in view instead of range
	var/respect_LOS = TRUE
	/// Ignore openspace
	var/ignore_openspace = FALSE

/datum/action/cooldown/spell/aoe/on_turf/is_valid_target(atom/cast_on)
	if(ignore_openspace && isopenspace(cast_on))
		return FALSE
	if(respect_density && cast_on.density)
		return FALSE
	return TRUE

/datum/action/cooldown/spell/aoe/on_turf/get_things_to_cast_on(atom/center)
	var/list/turfs = list()
	if(respect_LOS)
		for(var/turf/T in view(aoe_radius, center))
			if(!is_valid_target(T))
				continue
			turfs += T
	else
		for(var/turf/T as anything in RANGE_TURFS(aoe_radius, center))
			if(!is_valid_target(T))
				continue
			turfs += T

	return turfs

// Stub for turf/victim
/datum/action/cooldown/spell/aoe/on_turf/cast_on_thing_in_aoe(turf/victim, atom/caster)
	SHOULD_CALL_PARENT(FALSE)
	CRASH("[type] did not implement cast_on_thing_in_aoe and either has no effects or implemented the spell incorrectly.")

/// Uses a circle instead of a square, slower than the other ones
/datum/action/cooldown/spell/aoe/on_turf/circle/get_things_to_cast_on(atom/center)
	var/list/turfs = list()
	if(respect_LOS)
		for(var/turf/T as anything in circle_view_turfs(center, aoe_radius))
			if(respect_density && T.density)
				continue
			turfs += T
	else
		for(var/turf/T as anything in circle_range_turfs(center, aoe_radius))
			if(respect_density && T.density)
				continue
			turfs += T

	return turfs
