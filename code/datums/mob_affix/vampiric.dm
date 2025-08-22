/datum/mob_affix/vampiric
	name = "Vampiric"
	description = "Drains life from enemies"
	color = "#CC0000"

/datum/mob_affix/vampiric/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	description = "Heals [round(3 * intensity)] health on successful attacks"
	RegisterSignal(target, COMSIG_HOSTILE_ATTACKINGTARGET, PROC_REF(vampiric_attack))

/datum/mob_affix/vampiric/proc/vampiric_attack(mob/living/simple_animal/hostile/retaliate/source, atom/target)
	SIGNAL_HANDLER
	if(isliving(target))
		var/heal_amount = round(3 * intensity)
		source.adjustBruteLoss(-heal_amount)
		source.adjustFireLoss(-heal_amount)
		source.visible_message(span_danger("[source] seems to heal from the attack!"))
