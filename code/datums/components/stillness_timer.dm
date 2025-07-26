/datum/component/stillness_timer
	/// Time required before callback invoking
	var/time_between_callbacks
	/// Maximum amount of callbacks
	var/max_callbacks
	/// The callback reference
	var/datum/callback/to_invoke
	/// Timer reference to clear on move
	var/move_timer

/datum/component/stillness_timer/Initialize(time_between_callbacks = 15 SECONDS, max_callbacks = null, to_invoke)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE
	src.time_between_callbacks = time_between_callbacks
	src.max_callbacks = max_callbacks
	if(!to_invoke)
		CRASH("[type] added to [parent] without a callback, it won't do anything!")
	src.to_invoke = to_invoke

	move_timer = addtimer(CALLBACK(src, PROC_REF(do_invoke)), time_between_callbacks, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/component/stillness_timer/Destroy(force)
	deltimer(move_timer)
	move_timer = null
	to_invoke = null
	return ..()

/datum/component/stillness_timer/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(reset_timer))

/datum/component/stillness_timer/proc/do_invoke()
	to_invoke.Invoke()
	if(isnum(max_callbacks))
		max_callbacks--
		if(max_callbacks <= 0)
			qdel(src)
			return

	reset_timer()

/datum/component/stillness_timer/proc/reset_timer()
	SIGNAL_HANDLER

	move_timer = addtimer(CALLBACK(src, PROC_REF(do_invoke)), time_between_callbacks, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE)
