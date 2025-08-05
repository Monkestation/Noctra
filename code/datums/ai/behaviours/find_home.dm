/datum/ai_behavior/find_and_set/home
	action_cooldown = 10 SECONDS

/datum/ai_behavior/find_and_set/home/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/list/valid_homes = list()
	var/mob/living/pawn = controller.pawn

	if(istype(pawn.loc, locate_path))
		return pawn.loc //for premade homes

	for(var/obj/structure/potential_home in oview(search_range, pawn))
		if(!SEND_SIGNAL(potential_home, COMSIG_HABITABLE_HOME, pawn))
			continue
		valid_homes += potential_home

	if(valid_homes.len)
		return pick(valid_homes)

/datum/ai_behavior/find_and_set/home/atom_allowed(atom/movable/checking, locate_path, atom/pawn)
	if(checking == pawn)
		return FALSE
	if(istype(pawn.loc, locate_path))
		return FALSE // already home
	if(!istype(checking, /obj/structure))
		return FALSE
	if(!SEND_SIGNAL(checking, COMSIG_HABITABLE_HOME, pawn))
		return FALSE
	return TRUE
