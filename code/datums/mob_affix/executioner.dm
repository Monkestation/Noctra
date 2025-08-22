
/datum/mob_affix/executioner
	name = "Executioner's"
	description = "Deals extra damage to wounded foes"
	color = "#8B0000"
	intensity = 1.0
	delve_level = 1

/datum/mob_affix/executioner/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	RegisterSignal(target, COMSIG_HOSTILE_PRE_ATTACKINGTARGET, PROC_REF(on_pre_attack))

/datum/mob_affix/executioner/proc/on_pre_attack(mob/living/simple_animal/hostile/retaliate/attacker, atom/target_atom)
	if(ismob(target_atom))
		var/mob/living/victim = target_atom
		var/health_percent = victim.health / victim.maxHealth
		var/damage_bonus = (1 - health_percent) * 2 * intensity // 20% per 10% missing health

		attacker.melee_damage_lower = initial(attacker.melee_damage_lower) * (1 + damage_bonus)
		attacker.melee_damage_upper = initial(attacker.melee_damage_upper) * (1 + damage_bonus)

		addtimer(CALLBACK(src, PROC_REF(reset_damage), attacker), 0.1 SECONDS)

/datum/mob_affix/executioner/proc/reset_damage(mob/living/simple_animal/hostile/retaliate/attacker)
	attacker.melee_damage_lower = initial(attacker.melee_damage_lower)
	attacker.melee_damage_upper = initial(attacker.melee_damage_upper)

/datum/mob_affix/executioner/cleanup_affix(mob/living/simple_animal/hostile/retaliate/target)
	UnregisterSignal(target, COMSIG_HOSTILE_PRE_ATTACKINGTARGET)
