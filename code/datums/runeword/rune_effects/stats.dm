/datum/rune_effect/stat
	var/increase = 3

/datum/rune_effect/stat/apply_effects_from_list(list/effects)
	if(effects.len >= 1)
		increase = effects[1]

/datum/rune_effect/stat/get_combined_description(list/effects)
	var/total_increase = 0
	for(var/datum/rune_effect/stat/effect in effects)
		total_increase += effect.increase
	return "+[total_increase] [name]"

/datum/rune_effect/stat/force
	name = "physical damage"

/datum/rune_effect/stat/force/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	item.force += increase
	item.force_wielded += increase*2

/datum/rune_effect/stat/throw_force
	name = "thrown physical damage"

/datum/rune_effect/stat/throw_force/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	item.throwforce += increase

/datum/rune_effect/stat/rarity
	name = "increased item rarity"

/datum/rune_effect/stat/throw_force/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	item.rarity_mod += increase

/datum/rune_effect/stat/lightweight
	name = "reduced weight"

/datum/rune_effect/stat/lightweight/apply_stat_effect(datum/component/modifications/source, obj/item/item)
	item.item_weight /= 1 + (increase * 0.01)
