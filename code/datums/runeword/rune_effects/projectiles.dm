/datum/rune_effect/projectile
	ranged = TRUE
	var/list/effect_values = list()

/datum/rune_effect/projectile/apply_effects_from_list(list/effects)
	if(length(effects))
		effect_values = effects.Copy()

/datum/rune_effect/projectile/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	. = ..()
	RegisterSignal(item, COMSIG_PROJECTILE_BEFORE_FIRE, PROC_REF(apply_projectile_effect))

/datum/rune_effect/projectile/proc/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)

/datum/rune_effect/projectile/extra_projectiles
	name = "Extra Projectiles"

/datum/rune_effect/projectile/extra_projectiles/get_description()
	if(length(effect_values) >= 2)
		return "Fires [effect_values[1]]-[effect_values[2]] additional projectiles"
	else if(length(effect_values) >= 1)
		return "Fires [effect_values[1]] additional projectiles"
	return "Fires additional projectiles"

/datum/rune_effect/projectile/extra_projectiles/get_combined_description(list/effects)
	var/total_min = 0
	var/total_max = 0

	for(var/datum/rune_effect/projectile/extra_projectiles/effect in effects)
		total_min += effect.effect_values[1]
		total_max += effect.effect_values[2]
	return "Fires [total_min]-[total_max] additional projectiles"

/datum/rune_effect/projectile/extra_projectiles/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(!proj.fired_from || !user)
		return

	if(proj.dirty & DIRTY_EXTRA)
		return

	var/extra_count = length(effect_values) >= 2 ? rand(effect_values[1], effect_values[2]) : effect_values[1]

	// Fire additional projectiles with slight angle variations
	for(var/i in 1 to extra_count)
		var/angle_offset = (rand() - 0.5) * 45  // Up to ±22.5 degrees
		var/new_angle = proj.Angle + angle_offset

		// Create new projectile of same type
		var/obj/projectile/new_proj = new proj.type(get_turf(proj.fired_from))
		new_proj.fired_from = proj.fired_from
		new_proj.firer = proj.firer
		new_proj.original = proj.original

		new_proj.dirty |= DIRTY_EXTRA
		new_proj.fire(new_angle)


/datum/rune_effect/projectile/damage_modifier
	name = "Projectile Damage"

/datum/rune_effect/projectile/damage_modifier/get_description()
	if(length(effect_values) >= 1)
		var/percent = effect_values[1] * 100
		return "Projectile damage [percent > 100 ? "increased" : "reduced"] by [abs(percent - 100)]%"
	return "Modifies projectile damage"

/datum/rune_effect/projectile/damage_modifier/get_combined_description(list/effects)
	var/total_percent = 0
	for(var/datum/rune_effect/projectile/damage_modifier/effect in effects)
		total_percent += effect.effect_values[1] * 100
	return "Projectile damage [total_percent > 100 ? "increased" : "reduced"] by [abs(total_percent - 100)]%"

/datum/rune_effect/projectile/damage_modifier/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(length(effect_values) >= 1)
		proj.damage *= effect_values[1]

/datum/rune_effect/projectile/speed
	name = "Projectile Speed"

/datum/rune_effect/projectile/speed/get_description()
	if(length(effect_values) >= 1)
		var/percent = effect_values[1] * 100
		return "Projectile speed [percent > 100 ? "increased" : "reduced"] by [abs(percent - 100)]%"
	return "Modifies projectile speed"

/datum/rune_effect/projectile/speed/get_combined_description(list/effects)
	var/total_percent = 0
	for(var/datum/rune_effect/projectile/speed/effect in effects)
		total_percent += effect.effect_values[1] * 100
	return "Projectile speed [total_percent > 100 ? "increased" : "reduced"] by [abs(total_percent - 100)]%"


/datum/rune_effect/projectile/speed/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(length(effect_values) >= 1)
		proj.speed /= effect_values[1]

/datum/rune_effect/projectile/random_targeting
	name = "Random Targeting"

/datum/rune_effect/projectile/random_targeting/get_description()
	if(length(effect_values) >= 1)
		return "Projectiles fire in random directions within [effect_values[1]] degree spread"
	return "Projectiles fire in random directions"

/datum/rune_effect/projectile/random_targeting/get_combined_description(list/effects)
	var/total_range = 0
	for(var/datum/rune_effect/projectile/random_targeting/effect in effects)
		total_range += effect.effect_values[1]

	return "Projectiles fire in random directions within [total_range] degree spread"

/datum/rune_effect/projectile/random_targeting/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(!length(effect_values))
		return

	var/max_angle_deviation = effect_values[1] // Maximum degrees of deviation from original angle

	// Generate random angle offset
	var/angle_offset = (rand() - 0.5) * 2 * max_angle_deviation // Range: -max_angle_deviation to +max_angle_deviation
	var/new_angle = proj.Angle + angle_offset

	// Clear the original target since we're firing randomly
	proj.original = null
	proj.setAngle(new_angle)


/datum/rune_effect/projectile/bounce
	name = "Bouncing Projectiles"

/datum/rune_effect/projectile/bounce/get_description()
	if(length(effect_values) >= 1)
		return "Projectiles bounce [effect_values[1]] time\s off walls"
	return "Projectiles bounce off walls"

/datum/rune_effect/projectile/bounce/get_combined_description(list/effects)
	var/bounces = effect_values[1]
	for(var/datum/rune_effect/projectile/bounce/effect in effects)
		bounces += effect.effect_values[1]

	return "Projectiles bounce [bounces] time\s off walls"

/datum/rune_effect/projectile/bounce/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(length(effect_values) >= 1)
		proj.ricochets_max = effect_values[1]
		proj.ricochet_chance = 100  // Always bounce off walls


/datum/rune_effect/projectile/split
	name = "Splitting Projectiles"

/datum/rune_effect/projectile/split/get_description()
	if(length(effect_values) >= 1)
		return "On hit, splits into [effect_values[1]] projectiles"
	return "Projectiles split on impact"

/datum/rune_effect/projectile/split/get_combined_description(list/effects)
	var/splits = effect_values[1]
	for(var/datum/rune_effect/projectile/split/effect in effects)
		splits += effect.effect_values[1]
	return "On hit, splits into [splits] projectiles"

/datum/rune_effect/projectile/split/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	if(proj.dirty & DIRTY_SPLIT)
		return
	proj.AddComponent(/datum/component/projectile_split, effect_values[1])


/datum/rune_effect/projectile/fork
	name = "Forking Projectiles"

/datum/rune_effect/projectile/fork/get_description()
	if(length(effect_values) >= 2)
		return "On hit, forks to [effect_values[1]] enemies within [effect_values[2]] tiles"
	else if(length(effect_values) >= 1)
		return "On hit, forks to [effect_values[1]] nearby enemies"
	return "Projectiles fork to nearby enemies"

/datum/rune_effect/projectile/fork/get_combined_description(list/effects)
	var/forks = 0
	for(var/datum/rune_effect/projectile/fork/effect in effects)
		forks += effect.effect_values[1]
	return "On hit, forks to [forks] nearby enemies"

/datum/rune_effect/projectile/fork/apply_projectile_effect(obj/item/firer, obj/projectile/proj, atom/target, mob/living/user)
	var/fork_count = length(effect_values) >= 1 ? effect_values[1] : 1
	var/fork_range = length(effect_values) >= 2 ? effect_values[2] : 3
	if(proj.dirty & DIRTY_FORK)
		return
	proj.AddComponent(/datum/component/projectile_fork, fork_count, fork_range)

/datum/component/projectile_split
	var/split_count = 3

/datum/component/projectile_split/Initialize(count = 3)
	split_count = count
	RegisterSignal(parent, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_projectile_hit))

/datum/component/projectile_split/proc/on_projectile_hit(obj/projectile/source, atom/target)
	var/turf/hit_turf = get_turf(target)
	if(!hit_turf)
		return

	// Create split projectiles in a cone
	for(var/i in 1 to split_count)
		var/angle_offset = (360 / split_count) * i
		var/obj/projectile/split_proj = new source.type(hit_turf)
		split_proj.damage = source.damage * 0.7  // Reduced damage for splits
		split_proj.fired_from = source.fired_from
		split_proj.firer = source.firer
		split_proj.original = null
		split_proj.dirty |= DIRTY_SPLIT | DIRTY_EXTRA
		split_proj.fire(source.Angle + angle_offset)

/datum/component/projectile_fork
	var/fork_count = 1
	var/fork_range = 3

/datum/component/projectile_fork/Initialize(count = 1, range = 3)
	fork_count = count
	fork_range = range
	RegisterSignal(parent, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_projectile_hit))

/datum/component/projectile_fork/proc/on_projectile_hit(obj/projectile/source, atom/target)
	var/turf/hit_turf = get_turf(target)
	if(!hit_turf || !source.firer)
		return

	var/list/fork_targets = list()

	// Find nearby living targets
	for(var/mob/living/potential_target in range(fork_range, hit_turf))
		if(potential_target == source.firer)
			continue
		if(potential_target == target)  // Don't fork to the same target
			continue
		if(potential_target.stat == DEAD)
			continue
		fork_targets += potential_target

	var/forks_created = 0
	for(var/mob/living/fork_target in fork_targets)
		if(forks_created >= fork_count)
			break

		var/obj/projectile/fork_proj = new source.type(hit_turf)
		fork_proj.damage = source.damage * 0.8  // Slightly reduced damage for forks
		fork_proj.fired_from = source.fired_from
		fork_proj.firer = source.firer
		fork_proj.original = fork_target
		fork_proj.dirty |= DIRTY_FORK | DIRTY_EXTRA

		var/fork_angle = get_angle(hit_turf, get_turf(fork_target))
		fork_proj.fire(fork_angle, fork_target)

		forks_created++
