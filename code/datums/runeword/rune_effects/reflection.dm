/datum/rune_effect/reflection
	var/reflect = 3

/datum/rune_effect/reflection/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		reflect = effects[1]

/datum/rune_effect/reflection/get_description()
	return "Reflect [reflect] damage when hit."

/datum/rune_effect/reflection/get_combined_description(list/effects)
	var/total_increase = 0
	for(var/datum/rune_effect/reflection/effect in effects)
		total_increase += effect.reflect
	return "Reflect [total_increase] damage when hit."

/datum/rune_effect/reflection/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	RegisterSignal(item, COMSIG_ITEM_EQUIPPED, PROC_REF(check_equipped))
	RegisterSignal(item, COMSIG_ITEM_DROPPED, PROC_REF(remove_stats))

/datum/rune_effect/reflection/proc/check_equipped(obj/item/source, mob/living/carbon/equipper, slot)
	if(!source.item_action_slot_check(slot, equipper))
		remove_stats(source, equipper)
		return
	equipper.AddElement(/datum/element/relay_attackers)
	RegisterSignal(equipper, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(retaliate))

/datum/rune_effect/reflection/proc/remove_stats(obj/item/source, mob/living/carbon/equipper, slot)
	equipper.RemoveElement(/datum/element/relay_attackers)
	UnregisterSignal(equipper, COMSIG_ATOM_WAS_ATTACKED)

/datum/rune_effect/reflection/proc/retaliate(mob/living/attacked, mob/living/attacker, damage)
	attacker.apply_damage(reflect, BRUTE)
