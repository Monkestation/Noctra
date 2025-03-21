/obj/effect/proc_holder/spell/self/primalsavagery5e
	name = "Primal Savagery"
	desc = "For a short duration you develop the ability to inject targets with poisons with each bite."
	clothes_req = FALSE
	range = 8
	overlay_state = "null"
	sound = list('sound/magic/whiteflame.ogg')
	active = FALSE

	releasedrain = 50
	chargedrain = 1
	chargetime = 3
	charge_max = 60 SECONDS //cooldown

	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	antimagic_allowed = FALSE //can you use it if you are antimagicked?
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/druidic //can be arcane, druidic, blood, holy
	cost = 1

	attunements = list(
		/datum/attunement/earth = 0.3,
	)

	miracle = FALSE

	invocation = "Teeth of a serpent."
	invocation_type = "whisper" //can be none, whisper, emote and shout
// Notes: Bard, Sorcerer, Warlock, Wizard

/obj/effect/proc_holder/spell/self/primalsavagery5e/cast(mob/user = usr)
	var/mob/living/target = user
	target.apply_status_effect(/datum/status_effect/buff/primalsavagery5e)
	ADD_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	user.visible_message(span_info("[user] looks more primal!"), span_info("You feel more primal."))
	return TRUE

/datum/status_effect/buff/primalsavagery5e
	id = "primal savagery"
	alert_type = /atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/primalsavagery5e
	name = "Primal Savagery"
	desc = "I have grown venomous fangs inject my victims with poison."
	icon_state = "buff"

/datum/status_effect/buff/primalsavagery5e/on_remove()
	var/mob/living/target = owner
	REMOVE_TRAIT(target, TRAIT_POISONBITE, TRAIT_GENERIC)
	. = ..()
