GLOBAL_LIST_INIT(available_kinks, generate_kink_list())

/datum/kink
	abstract_type = /datum/kink
	var/name = "Unknown Kink"
	var/description = "No description available."
	var/category = "General" // General, Domination, Submission, Roleplay, Fetish, etc.
	var/intensity = 1 // 1-5 scale
	var/enabled = TRUE
	var/notes = ""
	var/kink_flags = NONE
	var/list/tracked_mobs

/datum/kink/New(kink_name, kink_desc, kink_category = "General", kink_intensity = 1)
	if(kink_name)
		name = kink_name
	if(kink_desc)
		description = kink_desc
	if(kink_category)
		category = kink_category
	if(kink_intensity)
		intensity = clamp(kink_intensity, 1, 5)
	if(kink_flags & KINK_PROCESS)
		START_PROCESSING(SSobj, src)

/datum/kink/process()
	if(!length(tracked_mobs))
		return
	var/list/sexing_mobs = list()
	for(var/datum/sex_session/session in GLOB.sex_sessions)
		if(session.user in tracked_mobs)
			sexing_mobs |= session.user
		if(session.target in tracked_mobs)
			sexing_mobs |= session.target
	for(var/mob/living/mob in sexing_mobs)
		on_process(mob)

/datum/kink/proc/apply_kink(mob/target)
	return

/datum/kink/proc/on_process(mob/living/target)
	return

/proc/save_player_kinks(ckey, list/kink_datums, character_slot = 1)
	var/datum/save_manager/SM = get_save_manager(ckey)
	if(!SM)
		return FALSE

	var/save_name = "character_[character_slot]_kinks"
	var/list/kink_save_data = list()

	for(var/datum/kink/kink in kink_datums)
		kink_save_data[kink.name] = list(
			"enabled" = kink.enabled,
			"intensity" = kink.intensity,
			"notes" = kink.notes
		)

	return SM.set_data(save_name, "kinks", kink_save_data)

/proc/load_player_kinks(ckey, character_slot = 1)
	var/datum/save_manager/SM = get_save_manager(ckey)
	if(!SM)
		return list()

	var/save_name = "character_[character_slot]_kinks"
	var/list/saved_kinks = SM.get_data(save_name, "kinks", list())
	var/list/loaded_kinks = list()

	// Create kink datums based on saved preferences
	for(var/kink_name in saved_kinks)
		var/datum/kink/base_kink = GLOB.available_kinks[kink_name]
		if(!base_kink)
			continue

		var/datum/kink/player_kink = new base_kink.type()
		var/list/kink_data = saved_kinks[kink_name]

		// Apply saved settings
		player_kink.enabled = kink_data["enabled"]
		player_kink.intensity = clamp(kink_data["intensity"], 1, 5)
		player_kink.notes = kink_data["notes"]

		loaded_kinks[kink_name] = player_kink

	return loaded_kinks

/proc/apply_player_kinks(mob/living/target, ckey, character_slot = 1)
	var/list/player_kinks = load_player_kinks(ckey, character_slot)

	for(var/kink_name in player_kinks)
		var/datum/kink/kink = player_kinks[kink_name]
		if(!kink.enabled)
			continue

		LAZYADD(kink.tracked_mobs, target)
		kink.apply_kink(target)

	return player_kinks

/proc/set_player_kink(ckey, kink_name, enabled = TRUE, intensity = 3, notes = "", character_slot = 1)
	var/datum/save_manager/SM = get_save_manager(ckey)
	if(!SM)
		return FALSE

	if(!GLOB.available_kinks[kink_name])
		return FALSE

	var/save_name = "character_[character_slot]_kinks"
	var/list/kinks = SM.get_data(save_name, "kinks", list())

	if(!kinks[kink_name])
		kinks[kink_name] = list()

	kinks[kink_name]["enabled"] = enabled
	kinks[kink_name]["intensity"] = clamp(intensity, 1, 5)
	kinks[kink_name]["notes"] = notes

	return SM.set_data(save_name, "kinks", kinks)

/proc/get_player_kink(ckey, kink_name, character_slot = 1)
	var/datum/save_manager/SM = get_save_manager(ckey)
	if(!SM)
		return null

	var/save_name = "character_[character_slot]_kinks"
	var/list/kinks = SM.get_data(save_name, "kinks", list())

	return kinks[kink_name]

/proc/get_player_kinks(ckey, character_slot = 1)
	var/datum/save_manager/SM = get_save_manager(ckey)
	if(!SM)
		return list()

	var/save_name = "character_[character_slot]_kinks"
	return SM.get_data(save_name, "kinks", list())

/proc/remove_kink_tracking(mob/living/target)
	for(var/kink_name in GLOB.available_kinks)
		var/datum/kink/kink = GLOB.available_kinks[kink_name]
		LAZYREMOVE(kink.tracked_mobs, target)

/proc/generate_kink_list()
	var/list/kinks = list()
	for(var/datum/kink/kink as anything in subtypesof(/datum/kink))
		if(is_abstract(kink))
			continue
		kinks[initial(kink.name)] = new kink
	return kinks
