/datum/rune_effect/status
	ranged = TRUE
	var/trigger_chance = 25
	var/status_key = STATUS_KEY_BLEED
	var/intensity = 1

/datum/rune_effect/status/get_description()
	return "[trigger_chance]% chance to [name]"

/datum/rune_effect/status/get_combined_description(list/effects)
	var/total_chance = 0
	for(var/datum/rune_effect/status/effect in effects)
		total_chance += effect.trigger_chance
	return "[total_chance]% chance to [name]"

/datum/rune_effect/status/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		trigger_chance = effects[1]
	if(effects.len >= 2)
		intensity = effects[2]

/datum/rune_effect/status/bleed
	name = "bleed"

/datum/rune_effect/status/bleed/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/status_mod = (target.get_status_mod(status_key) * 0.01)

	if(!prob(trigger_chance * status_mod))
		return
	target.simple_add_wound(/datum/wound/slash/small)

/datum/rune_effect/status/ignite
	name = "ignite"
	status_key = STATUS_KEY_IGNITE

/datum/rune_effect/status/ignite/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/status_mod = (target.get_status_mod(status_key) * 0.01)

	if(!prob(trigger_chance * status_mod))
		return
	target.adjust_fire_stacks(intensity)

/datum/rune_effect/status/chill
	name = "chill"
	status_key = STATUS_KEY_CHILL

/datum/rune_effect/status/chill/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/status_mod = (target.get_status_mod(status_key))

	if(!prob(trigger_chance - status_mod))
		return
	target.apply_status_effect(/datum/status_effect/debuff/chilled, 5 SECONDS * intensity)

/datum/rune_effect/status/poison
	name = "poison"
	status_key = STATUS_KEY_POISON

/datum/rune_effect/status/poison/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	var/status_mod = (target.get_status_mod(status_key))

	if(!prob(trigger_chance - status_mod))
		return
	target.reagents.add_reagent(/datum/reagent/toxin/venom, 2)
