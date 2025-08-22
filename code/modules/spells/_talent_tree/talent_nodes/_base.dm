/datum/talent_node
	var/name = "Talent"
	var/desc = "A talent"
	var/icon = 'icons/mob/actions/actions_spells.dmi'
	var/icon_state = "spell_default"
	var/talent_cost = 1
	var/list/prerequisites = list() // List of talent node types required
	var/max_rank = 1 // How many times this can be learned
	var/current_rank = 0
	var/talent_tree_id = "generic" // Which tree this belongs to
	var/singular_requirement = FALSE

/datum/talent_node/proc/on_talent_learned(mob/user)
	// Override this in subtypes to apply talent effects
	return
