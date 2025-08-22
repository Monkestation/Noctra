/datum/action/cooldown/spell/inhumen_healing
	name = "Corrupted Lesser Miracle"
	desc = "Call upon your patron to heal the wounds of yourself or others."
	button_icon_state = "lesserheal"
	sound = 'sound/magic/heal.ogg'
	charge_sound = 'sound/magic/holycharging.ogg'

	cast_range = 6
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/skill/magic/holy

	charge_required = FALSE
	cooldown_time = 10 SECONDS
	spell_cost = 10

	/// Base healing before adjustments
	var/base_healing = 25
	/// Wound healing modifier
	var/wound_modifier = 0.25
	/// Blood healing amount
	var/blood_restoration = 0

/datum/action/cooldown/spell/inhumen_healing/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	return isliving(cast_on)

/datum/action/cooldown/spell/inhumen_healing/cast(mob/living/cast_on)
	. = ..()
	var/conditional_buff = FALSE
	var/situational_bonus = 10
	//this if chain is stupid, replace with variables on /datum/patron when possible?
	if(isliving(owner))
		var/mob/living/living_owner = owner
		switch(living_owner.patron?.type)
			if(/datum/patron/inhumen/zizo)
				cast_on.visible_message(span_info("Vital energies are sapped towards [cast_on]!"), span_notice("The life around me pales as I am restored!"))
				// set up a ritual pile of bones (or just cast near a stack of bones whatever) around us for massive bonuses, cap at 50 for 75 healing total (wowie)
				situational_bonus = 0
				for (var/obj/item/alch/bone/O in oview(5, owner))
					situational_bonus = min(situational_bonus + 5, 50)
				if (situational_bonus > 0)
					conditional_buff = TRUE
			if(/datum/patron/inhumen/graggar)
				cast_on.visible_message(span_info("Foul fumes billow outward as [cast_on] is restored!"), span_notice("A noxious scent burns my nostrils, but I feel better!"))
				// if you've got lingering toxin damage, you get healed more, but your bonus healing doesn't affect toxin
				var/toxloss = cast_on.getToxLoss()
				if (toxloss >= 10)
					conditional_buff = TRUE
					situational_bonus = 25
					cast_on.adjustToxLoss(situational_bonus) // remember we do a global toxloss adjust down below so this is okay
			if(/datum/patron/inhumen/matthios)
				cast_on.visible_message(span_info("A shadowed hand passes [cast_on] a small, stolen vial... its contents glimmer faintly before sinking into their veins..."), span_notice("A quick swig and the ache fades..."))
				// COMRADES! WE MUST BAND TOGETHER! Or Outlaw.
				if (HAS_TRAIT(cast_on, TRAIT_BANDITCAMP) || (cast_on.real_name in GLOB.outlawed_players))
					conditional_buff = TRUE
					situational_bonus = 25
			if(/datum/patron/inhumen/baotha)
				cast_on.visible_message(span_info("A sweet, dizzying haze swirls around [cast_on], their eyes glimmering with bliss..."), span_notice("Mmm... the world softens... and I melt into it..."))
				//If the owner or cast_on are on drugs, they get a heal bonus.
				var/list/drugs_buffs = list(
					/datum/status_effect/buff/druqks,
					/datum/status_effect/buff/ozium,
					/datum/status_effect/buff/moondust,
					/datum/status_effect/buff/weed,
					/datum/status_effect/buff/moondust_purest,
				)

				for (var/path in drugs_buffs)
					if (living_owner.has_status_effect(path) || cast_on.has_status_effect(path))
						conditional_buff = TRUE
						situational_bonus = 25
						break

	if(conditional_buff)
		to_chat(owner, span_greentext("Channeling my patron's power is easier in these conditions!"))
		base_healing += situational_bonus

	cast_on.adjustToxLoss(-base_healing)
	cast_on.adjustOxyLoss(-base_healing)
	cast_on.blood_volume += blood_restoration
	if(!iscarbon(cast_on))
		cast_on.adjustBruteLoss(-base_healing)
		cast_on.adjustFireLoss(-base_healing)
		return

	var/mob/living/carbon/C = cast_on
	var/obj/item/bodypart/affecting = C.get_bodypart(check_zone(owner.zone_selected))
	if(affecting)
		affecting.heal_damage(base_healing, base_healing)
		affecting.heal_wounds(base_healing * wound_modifier)
		C.update_damage_overlays()

