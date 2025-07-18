/mob/living/carbon/human/proc/vampire_telepathy()
	set name = "Telepathy"
	set category = "VAMPIRE"

	if(!mind)
		return

	var/datum/antagonist/vampire/vamp_datum = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!vamp_datum)
		return

	var/datum/team/vampires/vamp_team = vamp_datum.team
	if(!vamp_team)
		return


	var/msg = browser_input_text(src, "Send a message", "COMMAND", max_length = MAX_MESSAGE_LEN, multiline = TRUE)
	if(!msg)
		return
	if(stat > CONSCIOUS)
		return

	var/message = span_narsie("<B>A message from <span style='color:#[voice_color]'>[real_name]</span>: [msg]</B>")
	to_chat(vamp_team.members, message)

/mob/living/carbon/human/proc/disguise_button()
	set name = "Disguise"
	set category = "VAMPIRE"

	var/datum/antagonist/vampire/VD = mind?.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(world.time < VD.last_transform + 30 SECONDS)
		var/timet2 = (VD.last_transform + 30 SECONDS) - world.time
		to_chat(src, "<span class='warning'>No.. not yet. [round(timet2/10)]s</span>")
		return
	if(VD.disguised)
		VD.last_transform = world.time
		vampire_undisguise(VD)
	else
		if(VD.vitae < 100)
			to_chat(src, "<span class='warning'>I don't have enough Vitae!</span>")
			return
		VD.last_transform = world.time
		vampire_disguise(VD)

/mob/living/carbon/human/proc/vampire_disguise(datum/antagonist/vampire/VD)
	if(!VD)
		return
	VD.disguised = TRUE
	skin_tone = VD.cache_skin
	var/obj/item/organ/eyes/eyes = getorganslot(ORGAN_SLOT_EYES)

	set_hair_color(VD.cache_hair, FALSE)
	set_facial_hair_color(VD.cache_hair, FALSE)
	eyes.eye_color = VD.cache_eyes
	mob_biotypes = MOB_ORGANIC
	update_body()
	update_body_parts(redraw = TRUE)
	to_chat(src, span_notice("My true form is hidden."))

/mob/living/carbon/human/proc/vampire_undisguise(datum/antagonist/vampire/VD)
	if(!VD)
		return
	VD.disguised = FALSE

	var/obj/item/organ/eyes/eyes = getorganslot(ORGAN_SLOT_EYES)

	mob_biotypes = MOB_UNDEAD
	skin_tone = "c9d3de"
	set_hair_color("#181a1d", FALSE)
	set_facial_hair_color("#181a1d", FALSE)
	eyes.eye_color = "#ff0000"
	update_body()
	update_body_parts(redraw = TRUE)
	to_chat(src, span_danger("My true form is revealed."))


/mob/living/carbon/human/proc/blood_strength()
	set name = "Night Muscles"
	set category = "VAMPIRE"

	var/ability_name = "Night Muscles"

	var/cooldown_time = 3000 // Five minutes cooldown

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(has_status_effect(/datum/status_effect/buff/bloodstrength))
		to_chat(src, span_warning("Already active."))
		return
	if(!VD.check_vampire_cooldown(src, ability_name, cooldown_time))
		return
	if(VD.disguised)
		to_chat(src, span_warning("My curse is hidden."))
		return
	if(VD.vitae < 500)
		to_chat(src, span_warning("Not enough vitae."))
		return


	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/bloodstrength)
	to_chat(src, "<span class='greentext'>! NIGHT MUSCLES !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)

/datum/status_effect/buff/bloodstrength
	id = "bloodstrength"
	alert_type = /atom/movable/screen/alert/status_effect/buff/bloodstrength
	effectedstats = list(STATKEY_STR = 6)
	duration = 1 MINUTES

/atom/movable/screen/alert/status_effect/buff/bloodstrength
	name = "Night Muscles"
	desc = ""
	icon_state = "bleed1"

/mob/living/carbon/human/proc/blood_celerity()
	set name = "Quickening"
	set category = "VAMPIRE"

	var/ability_name = "Quickening"

	var/cooldown_time = 3000 // Five minutes cooldown

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(has_status_effect(/datum/status_effect/buff/celerity))
		to_chat(src, "<span class='warning'>Already active.</span>")
		return
	if(!VD.check_vampire_cooldown(src, ability_name, cooldown_time))
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return

	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/celerity)
	to_chat(src, "<span class='greentext'>! QUICKENING !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)


/datum/status_effect/buff/celerity
	id = "celerity"
	alert_type = /atom/movable/screen/alert/status_effect/buff/celerity
	effectedstats = list(STATKEY_SPD = 15, STATKEY_PER = 10)
	duration = 30 SECONDS

/datum/status_effect/buff/celerity/nextmove_modifier()
	return 0.60

/atom/movable/screen/alert/status_effect/buff/celerity
	name = "Quickening"
	desc = ""
	icon_state = "bleed1"

/mob/living/carbon/human/proc/blood_fortitude()
	set name = "Armor of Darkness"
	set category = "VAMPIRE"
	var/cooldown_time = 6000 // Ten minutes cooldown, you get an anticrit 100 melee armor for free with the stats.

	var/ability_name = "Armor of Darkness"

	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(has_status_effect(/datum/status_effect/buff/fortitude))
		to_chat(src, "<span class='warning'>Already active.</span>")
		return
	if(!VD.check_vampire_cooldown(src, ability_name, cooldown_time))
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return

	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	VD.adjust_vitae(-500)
	apply_status_effect(/datum/status_effect/buff/fortitude)
	to_chat(src, "<span class='greentext'>! ARMOR OF DARKNESS !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)


/datum/status_effect/buff/fortitude
	id = "fortitude"
	alert_type = /atom/movable/screen/alert/status_effect/buff/fortitude
	effectedstats = list(STATKEY_END = 20, STATKEY_CON = 20)
	duration = 30 SECONDS

/atom/movable/screen/alert/status_effect/buff/fortitude
	name = "Armor of Darkness"
	desc = ""
	icon_state = "bleed1"

/datum/status_effect/buff/fortitude/on_apply()
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		QDEL_NULL(H.skin_armor)
		H.skin_armor = new /obj/item/clothing/armor/skin_armor/vampire_fortitude(H)
	owner.add_stress(/datum/stressevent/weed)

/datum/status_effect/buff/fortitude/on_remove()
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		if(istype(H.skin_armor, /obj/item/clothing/armor/skin_armor/vampire_fortitude))
			QDEL_NULL(H.skin_armor)
	. = ..()

/obj/item/clothing/armor/skin_armor/vampire_fortitude
	slot_flags = null
	name = "vampire's skin"
	desc = ""
	icon_state = null
	body_parts_covered = FULL_BODY
	armor = list("blunt" = 100, "slash" = 100, "stab" = 100,  "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_STAB, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = SOFTHIT
	blade_dulling = DULLING_BASHCHOP
	sewrepair = TRUE
	max_integrity = 0



/mob/living/carbon/human/proc/vamp_regenerate()
	set name = "Regenerate"
	set category = "VAMPIRE"

	var/ability_name = "Regenerate"

	var/cooldown_time = 600 // 1 minute

	var/silver_curse_status = FALSE
	for(var/datum/status_effect/debuff/silver_curse/SC in status_effects)
		silver_curse_status = TRUE
		break
	var/datum/antagonist/vampire/VD = mind.has_antag_datum(/datum/antagonist/vampire)
	if(!VD)
		return
	if(!VD.check_vampire_cooldown(src, ability_name, cooldown_time))
		return
	if(VD.disguised)
		to_chat(src, "<span class='warning'>My curse is hidden.</span>")
		return
	if(silver_curse_status)
		to_chat(src, "<span class='warning'>My BANE is not letting me REGENERATE!.</span>")
		return
	if(VD.vitae < 500)
		to_chat(src, "<span class='warning'>Not enough vitae.</span>")
		return


	to_chat(src, "<span class='greentext'>! REGENERATE !</span>")
	src.playsound_local(get_turf(src), 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
	VD.adjust_vitae(-500)
	// Gain experience towards blood magic
	var/mob/living/carbon/human/licker = usr
	var/boon = usr.get_learning_boon(/datum/skill/magic/blood)
	var/amt2raise = licker.STAINT*2
	usr.adjust_experience(/datum/skill/magic/blood, floor(amt2raise * boon), FALSE)
	fully_heal(admin_revive = TRUE)
	licker.grant_undead_eyes()

