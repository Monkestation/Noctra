
/datum/mob_affix/unstoppable
	name = "Unstoppable"
	description = "Cannot be slowed or stunned"
	color = "#FFD700"
	intensity = 1.0
	delve_level = 1

/datum/mob_affix/unstoppable/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	RegisterSignal(target, COMSIG_LIVING_STATUS_STUN, PROC_REF(block_stun))
	RegisterSignal(target, COMSIG_LIVING_STATUS_KNOCKDOWN, PROC_REF(block_stun))
	RegisterSignal(target, COMSIG_LIVING_STATUS_PARALYZE, PROC_REF(block_stun))

/datum/mob_affix/unstoppable/proc/block_stun()
	return COMPONENT_NO_STUN

/datum/mob_affix/unstoppable/cleanup_affix(mob/living/simple_animal/hostile/retaliate/target)
	UnregisterSignal(target, COMSIG_LIVING_STATUS_STUN)
	UnregisterSignal(target, COMSIG_LIVING_STATUS_KNOCKDOWN)
	UnregisterSignal(target, COMSIG_LIVING_STATUS_PARALYZE)
