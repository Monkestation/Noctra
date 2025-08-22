/datum/action_state
	var/name = "base_state"
	var/description = "Base state"
	var/datum/action_state_manager/manager

	///what blackboards we need to have
	var/list/preconditions = list()
	var/cost = 1

/datum/action_state/New(datum/action_state_manager/_manager)
	. = ..()
	manager = _manager

/datum/action_state/proc/can_execute(datum/ai_controller/controller)
	SHOULD_CALL_PARENT(TRUE)
	for(var/precond in preconditions)
		if(!controller.blackboard[precond])
			return FALSE
	return TRUE

//If you want this to be only done during certain things change this!
/datum/action_state/proc/get_cost(datum/ai_controller/controller)
	return cost

// Called when entering this state
/datum/action_state/proc/enter_state(datum/ai_controller/controller)
	return

// Called every tick while in this state
/datum/action_state/proc/process_state(datum/ai_controller/controller, delta_time)
	return ACTION_STATE_CONTINUE

// Called when exiting this state
/datum/action_state/proc/exit_state(datum/ai_controller/controller)
	return

// Check if we can transition to another state
/datum/action_state/proc/can_transition_to(datum/action_state/new_state, datum/ai_controller/controller)
	return TRUE

///so like why do you want an action state over a planning tree?
///the simple answer is action_states are for things that are predetermined paths ie I pickup item, I move item, I walk back.
///you could put this in a behavior and planning tree, but this handles it more effciently as thats its job.
/datum/action_state_manager
	var/datum/action_state/current_state
	var/datum/action_state/queued_state
	var/list/available_states = list(
		/datum/action_state/idle,
		/datum/action_state/transport,
		/datum/action_state/farming,
		/datum/action_state/alchemy,
		/datum/action_state/splitter,
		/datum/action_state/return_home,
	)
	var/atom/last_movement_target = null

/datum/action_state_manager/New()
	init_states()

/datum/action_state_manager/proc/init_states()
	var/list/created_list = list()
	for(var/datum/action_state/state_type as anything in available_states)
		created_list[initial(state_type.name)] = new state_type(src)
	available_states = created_list
	current_state = available_states["idle"]

/datum/action_state_manager/proc/process_machine(datum/ai_controller/controller, delta_time)
	var/mob/living/pawn = controller.pawn

	// Check if we're still moving to a target
	if(last_movement_target)
		if(get_dist(pawn, last_movement_target) > 1)
			if(controller.ai_movement.moving_controllers[controller] != last_movement_target)
				controller.ai_movement.start_moving_towards(controller, last_movement_target)
			return // Still moving, don't process state machine
		else
			controller.set_movement_target(type, null)
			controller.ai_movement.stop_moving_towards(controller)
			last_movement_target = null // Reached target, clear it


	// Handle state transitions
	if(queued_state && current_state.can_transition_to(queued_state, controller))
		change_state(controller, queued_state)
		queued_state = null

	// Process current state
	var/result = current_state.process_state(controller, delta_time)
	switch(result)
		if(ACTION_STATE_COMPLETE, ACTION_STATE_FAILED)
			// Return to idle or handle completion
			if(current_state.name != "idle")
				queue_state("idle")
			return FALSE
	return TRUE

/datum/action_state_manager/proc/change_state(datum/ai_controller/controller, datum/action_state/new_state)
	if(current_state)
		current_state.exit_state(controller)
	current_state = new_state
	current_state.enter_state(controller)

/datum/action_state_manager/proc/queue_state(state_name)
	if(state_name in available_states)
		queued_state = available_states[state_name]
		return TRUE
	return FALSE

/datum/action_state_manager/proc/set_movement_target(datum/ai_controller/controller, atom/target)
	controller.set_movement_target(type, target)
	controller.ai_movement.start_moving_towards(controller, target)
	last_movement_target = target

/datum/action_state_manager/proc/get_state_name()
	return current_state?.name || "unknown"
