/datum/mob_affix/explosive
	name = "Explosive"
	description = "Explodes violently upon death"
	color = "#FF8800"

/datum/mob_affix/explosive/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	description = "Explodes for [round(15 * intensity)] damage on death"
	RegisterSignal(target, COMSIG_MOB_DEATH, PROC_REF(explosive_death))

/datum/mob_affix/explosive/proc/explosive_death(mob/living/simple_animal/hostile/retaliate/source, gibbed)
	SIGNAL_HANDLER
	source.visible_message(span_danger("[source] explodes violently!"))
	explosion(source, 0, 1, 2)
