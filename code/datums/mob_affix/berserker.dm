/datum/mob_affix/berserker
	name = "Berserker"
	description = "Becomes more dangerous when wounded"
	color = "#FF4444"

/datum/mob_affix/berserker/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	description = "Gains [round(30 * intensity)]% damage when below 40% health"
	RegisterSignal(target, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(berserker_pre_attack))

/datum/mob_affix/berserker/proc/berserker_pre_attack(mob/living/simple_animal/hostile/retaliate/source, atom/target)
	SIGNAL_HANDLER
	if(source.health <= source.maxHealth * 0.4)
		var/damage_bonus = round(source.harm_intent_damage * (0.3 * intensity))
		source.harm_intent_damage += damage_bonus
		addtimer(CALLBACK(src, PROC_REF(reset_damage), source, damage_bonus), 1)

/datum/mob_affix/berserker/proc/reset_damage(mob/living/simple_animal/hostile/retaliate/source, bonus)
	source.harm_intent_damage -= bonus
