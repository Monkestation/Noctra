/datum/rune_effect/status_resistance
	var/trigger_chance = 25
	var/status_key = STATUS_KEY_BLEED
	var/intensity = 1

/datum/rune_effect/status_resistance/get_description()
	return "[trigger_chance]% chance to resist [name]"

/datum/rune_effect/status_resistance/get_combined_description(list/effects)
	var/total_chance = 0
	for(var/datum/rune_effect/status_resistance/effect in effects)
		total_chance += effect.trigger_chance
	return "[total_chance]% chance to resist [name]"

/datum/rune_effect/status_resistance/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		trigger_chance = effects[1]

/datum/rune_effect/status_resistance/apply_stat_effect(datum/component/modifications/source, obj/item/item)


/datum/rune_effect/status_resistance/bleed
	name = "bleed"

/datum/rune_effect/status_resistance/ignite
	name = "ignite"
	status_key = STATUS_KEY_IGNITE

/datum/rune_effect/status_resistance/chill
	name = "chill"
	status_key = STATUS_KEY_CHILL

/datum/rune_effect/status_resistance/poison
	name = "poison"
	status_key = STATUS_KEY_POISON
