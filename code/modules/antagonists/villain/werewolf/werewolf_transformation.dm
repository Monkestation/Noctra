/datum/antagonist/werewolf/on_life(mob/user)
	if(!user) return
	var/mob/living/carbon/human/H = user // the werewolf is still a human subtype
	if(H.stat == DEAD) return
	if(H.advsetup) return
	if(H.mind?.has_antag_datum(/datum/antagonist/zombie)) return

	// Werewolf transforms at night AND under the sky
	if(!transformed && !transforming)
		if(GLOB.tod == "night")
			if(isturf(H.loc))
				var/turf/loc = H.loc
				if(loc.can_see_sky())
					to_chat(H, span_userdanger("The moonlight scorns me... It is too late."))
					owner.current.playsound_local(get_turf(owner.current), 'sound/music/wolfintro.ogg', 80, FALSE, pressure_affected = FALSE)
					H.flash_fullscreen("redflash3")
					transforming = world.time // timer

	if(!transformed)
		// Begin transformation
		if(transforming)
			if (world.time >= transforming + 35 SECONDS) // Stage 3
				for(var/obj/item/item as anything in H.get_equipped_items(FALSE))
					if(istype(item, /obj/item/clothing) || istype(item, /obj/item/storage/belt))
						item.take_damage(damage_amount = item.max_integrity * 0.4, sound_effect = FALSE)
					else if(istype(item, /obj/item/weapon) || istype(item, /obj/item/storage))
						H.dropItemToGround(item, silent = TRUE)

				var/mob/living/carbon/human/species/werewolf/new_werewolf = generate_werewolf(H)
				new_werewolf.apply_status_effect(/datum/status_effect/shapechange_mob/die_with_form, H, FALSE)
				new_werewolf.grant_language(/datum/language/beast)
				new_werewolf.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
				new_werewolf.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
				new_werewolf.adjust_skillrank(/datum/skill/misc/climbing, 6, TRUE)
				new_werewolf.real_name = wolfname
				new_werewolf.name = wolfname
				playsound(new_werewolf, pick('sound/combat/gib (1).ogg','sound/combat/gib (2).ogg'), 200, FALSE, 3)
				to_chat(new_werewolf, span_userdanger("I transform into a horrible beast!"))
				new_werewolf.emote("rage")

				transforming = FALSE
				transformed = TRUE // Mark as transformed

			else if (world.time >= transforming + 25 SECONDS) // Stage 2
				H.flash_fullscreen("redflash3")
				H.emote("agony", forced = TRUE)
				if(COOLDOWN_FINISHED(src, message_cooldown))
					to_chat(H, span_userdanger("UNIMAGINABLE PAIN!"))
					COOLDOWN_START(src, message_cooldown, 5 SECONDS)
				H.Stun(30)
				H.Knockdown(30)

			else if (world.time >= transforming + 10 SECONDS) // Stage 1
				H.emote("")
				if(COOLDOWN_FINISHED(src, message_cooldown))
					to_chat(H, span_warning("I can feel my muscles aching, it feels HORRIBLE..."))
					COOLDOWN_START(src, message_cooldown, 5 SECONDS)
	else
		// Werewolf reverts to human form during the day
		if(GLOB.tod != "night")
			if(!transforming)
				transforming = world.time // Start untransformation phase

			if (world.time >= transforming + 1 MINUTES) // Untransform
				transformed = FALSE
				transforming = FALSE // Reset untransforming phase

				var/datum/status_effect/shapechange_mob/status_effect = H.has_status_effect(/datum/status_effect/shapechange_mob/die_with_form)
				if(!status_effect)
					return

				var/mob/living/carbon/human/caster_mob = status_effect.caster_mob
				H.Paralyze(1, ignore_canstun = TRUE)
				H.emote("rage", forced = TRUE)
				H.spawn_gibs(FALSE)
				H.remove_status_effect(/datum/status_effect/shapechange_mob/die_with_form)
				to_chat(caster_mob, span_userdanger("The beast within returns to slumber."))
				caster_mob.fully_heal(FALSE)
				playsound(caster_mob, pick('sound/combat/gib (1).ogg','sound/combat/gib (2).ogg'), 200, FALSE, 3)
				caster_mob.Knockdown(30)
				caster_mob.Stun(30)

			else if (world.time >= transforming) // Alert player
				if(COOLDOWN_FINISHED(src, message_cooldown))
					H.flash_fullscreen("redflash1")
					to_chat(H, span_warning("Daylight shines around me... the curse begins to fade."))
					COOLDOWN_START(src, message_cooldown, 10 SECONDS)

/datum/antagonist/werewolf/proc/generate_werewolf(mob/living/user)
	var/mob/living/carbon/human/species/werewolf/W = new (get_turf(user))

	W.set_patron(user.patron)
	W.limb_destroyer = TRUE
	W.ambushable = FALSE
	W.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
	W.skin_armor = new /obj/item/clothing/armor/skin_armor/werewolf_skin(W)

	W.dna?.species.after_creation(src)

	W.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB)
	W.update_a_intents()

	W.dodgetime = 36

	W.add_spell(/datum/action/cooldown/spell/undirected/howl)
	W.add_spell(/datum/action/cooldown/spell/undirected/claws)

	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)

	ADD_TRAIT(W, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOFALLDAMAGE1, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BASHDOORS, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_ORGAN_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NASTY_EATER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_IGNORESLOWDOWN, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_HARDDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(W, TRAIT_LONGSTRIDER, TRAIT_GENERIC)

	return W
