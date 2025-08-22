/datum/mob_affix/poisonous
	name = "Poisonous"
	description = "Attacks inject deadly toxins"
	color = "#44FF44"

/datum/mob_affix/poisonous/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	description = "Attacks apply [round(5 * intensity)] toxic damage"
	RegisterSignal(target, COMSIG_HOSTILE_ATTACKINGTARGET, PROC_REF(poisonous_attack))

/datum/mob_affix/poisonous/proc/poisonous_attack(mob/living/simple_animal/hostile/retaliate/source, atom/target)
	SIGNAL_HANDLER
	if(isliving(target))
		var/mob/living/L = target
		L.apply_damage(round(5 * intensity), TOX)
		L.visible_message(span_warning("[L] looks sickly from [source]'s toxic attack!"))
