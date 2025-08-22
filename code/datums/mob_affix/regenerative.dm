/datum/mob_affix/regenerative
	name = "Regenerative"
	description = "Rapidly heals wounds"
	color = "#00FF44"
	var/regen_timer

/datum/mob_affix/regenerative/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	description = "Regenerates [round(2 * intensity)] health every 3 seconds"
	regen_timer = addtimer(CALLBACK(src, PROC_REF(regenerate), target), 30, TIMER_LOOP | TIMER_STOPPABLE)

/datum/mob_affix/regenerative/proc/regenerate(mob/living/simple_animal/hostile/retaliate/target)
	if(!target || target.stat == DEAD)
		return
	if(target.health < target.maxHealth)
		var/heal_amount = round(2 * intensity)
		target.adjustBruteLoss(-heal_amount)
		target.adjustFireLoss(-heal_amount)

/datum/mob_affix/regenerative/cleanup_affix(mob/living/simple_animal/hostile/retaliate/target)
	if(regen_timer)
		deltimer(regen_timer)
