/datum/gem_cut
	var/name = "generic"
	var/downgrade_chance = 10
	var/skill_required = 1
	var/requires_teaching = FALSE

	var/weapon_effect_type
	var/list/weapon_effect_data
	var/armor_effect_type
	var/list/armor_effect_data
	var/shield_effect_type
	var/list/shield_effect_data

/datum/gem_cut/proc/setup_cut(multiplier)
	return

/datum/gem_cut/proc/transfer_properties(datum/gem_effect/dest)
	dest.weapon_effect_type = weapon_effect_type
	dest.weapon_effect_data = weapon_effect_data
	dest.armor_effect_type = armor_effect_type
	dest.armor_effect_data = armor_effect_data
	dest.shield_effect_type = shield_effect_type
	dest.shield_effect_data = shield_effect_data
