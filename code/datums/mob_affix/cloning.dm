/datum/mob_affix/mirror_images
	name = "Cloning"
	description = "Periodically creates mirror images of itself"
	color = "#E6E6FA"
	intensity = 1.0
	delve_level = 1
	var/clone_timer

/datum/mob_affix/mirror_images/apply_affix(mob/living/simple_animal/hostile/retaliate/target)
	clone_timer = addtimer(CALLBACK(src, PROC_REF(create_clones), target), 16 SECONDS, TIMER_STOPPABLE | TIMER_LOOP)

/datum/mob_affix/mirror_images/proc/create_clones(mob/living/simple_animal/hostile/retaliate/target)
	var/clones_to_make = 2 + round(intensity)
	for(var/i = 1 to clones_to_make)
		var/turf/spawn_turf = get_turf(target)
		if(spawn_turf)
			var/mob/living/simple_animal/hostile/retaliate/clone = new target.type(spawn_turf)
			clone.maxHealth = target.maxHealth * 0.1 // Weak clones
			clone.health = clone.maxHealth
			clone.melee_damage_lower = target.melee_damage_lower * 0.3
			clone.melee_damage_upper = target.melee_damage_upper * 0.3
			clone.alpha = 150 // Slightly transparent
			QDEL_IN(clone, 5 SECONDS) // Clones disappear after 5 seconds

/datum/mob_affix/mirror_images/cleanup_affix(mob/living/simple_animal/hostile/retaliate/target)
	deltimer(clone_timer)
