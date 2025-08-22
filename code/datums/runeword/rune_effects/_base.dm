/datum/rune_effect
	var/name = ""
	var/ranged = FALSE

/datum/rune_effect/New(list/effect_data)
	if(effect_data)
		apply_effects_from_list(effect_data)

/datum/rune_effect/proc/apply_effects_from_list(list/effects)
	return // Override in subtypes

/datum/rune_effect/proc/get_bonus_damage(mob/living/target, mob/living/user)
	return 0 // Override in subtypes

/datum/rune_effect/proc/apply_combat_effect(mob/living/target, mob/living/user, damage_dealt)
	return

/datum/rune_effect/proc/apply_stat_effect(datum/component/modifications/source, obj/item/item)

/datum/rune_effect/proc/get_description()
	return name || "Unknown effect"

/datum/rune_effect/proc/get_group_key()
	return name

/datum/rune_effect/proc/get_combined_description(list/effects)
	// Default: just return individual description
	return get_description()

/datum/rune_effect/proc/apply_effect(obj/item/item)
	return
