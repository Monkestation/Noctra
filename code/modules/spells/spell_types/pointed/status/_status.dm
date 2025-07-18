/**
 * ## Status effect spells
 *
 * Spells that grant a status effect to a living mob.
 *
 * Always applies the effect onto cast_on but extra target handling can extend cast.
 *
 * Set cooldown_time to 0 to inherit the duration
 */
/datum/action/cooldown/spell/status
	self_cast_possible = TRUE

	/// Path of status effect to add
	var/datum/status_effect/status_effect = /datum/status_effect/buff/calm
	/// Duration of the status effect, null to use status effect duration
	var/duration = null
	/// If attunement strength scales the duration
	var/duration_scaling = FALSE
	/// Base duration increase, if null multiply duration by attuned strength
	var/duration_modification = 2 MINUTES
	/// Extra arguments to pass, must be a list
	/// Will have no effect unless on_creation has 3+ args
	var/extra_args

/datum/action/cooldown/spell/status/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return
	return isliving(cast_on)

/datum/action/cooldown/spell/status/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	if(duration_scaling)
		if(duration_modification)
			duration += duration_modification * attuned_strength
		else
			duration *= attuned_strength

/datum/action/cooldown/spell/status/cast(mob/living/cast_on)
	. = ..()
	var/list/status_args = list(
		status_effect,
		duration,
	)
	if(extra_args && islist(extra_args))
		status_args += extra_args
	cast_on.apply_status_effect(arglist(status_args))
	cooldown_time = cooldown_time || duration
