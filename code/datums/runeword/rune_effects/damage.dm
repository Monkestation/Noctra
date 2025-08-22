/datum/rune_effect/damage
	ranged = TRUE
	var/damage_type = FIRE_DAMAGE
	var/elemental_penetration = 0
	var/min_damage = 1
	var/max_damage = 3

/datum/rune_effect/damage/get_description()
	return "Adds [min_damage] - [max_damage] [get_damage_type_name()] damage"

/datum/rune_effect/damage/get_group_key()
	return "[get_damage_type_name()] damage"

/datum/rune_effect/damage/get_combined_description(list/effects)
	var/total_min = 0
	var/total_max = 0
	for(var/datum/rune_effect/damage/effect in effects)
		total_min += effect.min_damage
		total_max += effect.max_damage
	return "Adds [total_min] - [total_max] [get_damage_type_name()] damage"

/datum/rune_effect/damage/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		min_damage = effects[1]
	if(effects.len >= 2)
		max_damage = effects[2]
	if(effects.len >= 3)
		elemental_penetration = effects[3]

/datum/rune_effect/damage/get_bonus_damage(mob/living/target, mob/living/user)
	return rand(min_damage, max_damage)

/datum/rune_effect/damage/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/damage = get_bonus_damage(target, user)
	if(damage > 0)
		target.apply_elemental_damage(damage, damage_type, elemental_penetration)
		to_chat(user, "<span class='notice'>[user.get_active_held_item()] deals [damage] additional [get_damage_type_name()] damage!</span>")

/datum/rune_effect/damage/proc/get_damage_type_name()
	switch(damage_type)
		if(FIRE_DAMAGE)
			return "fire"
		if(COLD_DAMAGE)
			return "cold"
		if(LIGHTNING_DAMAGE)
			return "lightning"
		else
			return "elemental"

/datum/rune_effect/damage/fire
	name = "fire damage"
	damage_type = FIRE_DAMAGE

/datum/rune_effect/damage/cold
	name = "cold damage"
	damage_type = COLD_DAMAGE

/datum/rune_effect/damage/lightning
	name = "lightning damage"
	damage_type = LIGHTNING_DAMAGE

/datum/rune_effect/damage/holy
	name = "holy damage"

/datum/rune_effect/damage/holy/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/damage = get_bonus_damage(target, user)
	if(damage > 0)
		if(target.mob_biotypes & MOB_UNDEAD)
			damage *= 2

		target.apply_damage(damage, BURN)
		to_chat(user, "<span class='notice'>[user.get_active_held_item()] deals [damage] additional holy damage!</span>")

/datum/rune_effect/damage/necrotic
	name = "necrotic damage"

/datum/rune_effect/damage/necrotic/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/damage = get_bonus_damage(target, user)
	if(damage > 0)
		if(target.mob_biotypes & MOB_UNDEAD)
			damage *= 0
		if(!damage)
			return
		target.apply_elemental_damage(damage, BURN)
		to_chat(user, "<span class='notice'>[user.get_active_held_item()] deals [damage] additional necrotic damage!</span>")
