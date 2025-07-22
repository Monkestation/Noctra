/obj/item/organ/tongue
	name = "tongue"
	desc = ""
	icon_state = "tongue"
	zone = BODY_ZONE_PRECISE_MOUTH
	slot = ORGAN_SLOT_TONGUE
	attack_verb = list("licked", "slobbered", "slapped", "frenched", "tongued")
	var/list/languages_possible
	var/say_mod = null
	var/taste_sensitivity = 15 // lower is more sensitive.
	var/modifies_speech = FALSE
	var/static/list/languages_possible_base = typecacheof(list(
		/datum/language/common,
		/datum/language/dwarvish,
		/datum/language/elvish,
		/datum/language/oldpsydonic,
		/datum/language/zalad,
		/datum/language/celestial,
		/datum/language/hellspeak,
		/datum/language/beast,
		/datum/language/thievescant,
		/datum/language/orcish,
		/datum/language/deepspeak
	))

/obj/item/organ/tongue/Initialize(mapload)
	. = ..()
	languages_possible = languages_possible_base

/obj/item/organ/tongue/proc/handle_speech(datum/source, list/speech_args)

/obj/item/organ/tongue/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(say_mod && M.dna && M.dna.species)
		M.dna.species.say_mod = say_mod
	if (modifies_speech)
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	M.UnregisterSignal(M, COMSIG_MOB_SAY)
	for(var/datum/wound/facial/tongue/tongue_wound in M.get_wounds())
		qdel(tongue_wound)

/obj/item/organ/tongue/Remove(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	. = ..()
	if(say_mod && M.dna && M.dna.species)
		M.dna.species.say_mod = initial(M.dna.species.say_mod)
	UnregisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	M.RegisterSignal(M, COMSIG_MOB_SAY, TYPE_PROC_REF(/mob/living/carbon, handle_tongueless_speech))

/obj/item/organ/tongue/could_speak_in_language(datum/language/dt)
	return is_type_in_typecache(dt, languages_possible)
