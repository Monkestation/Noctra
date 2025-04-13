//used for holding information about unique properties of maps
//feed it json files that match the datum layout
//defaults to box
//  -Cyberboss

///Default travel maps loaded if no travel maps are specified. If other maps are specified, should be a list of paths in .json. Turned off with "disabled"
#define OTHER_Z_DEFAULT_LIST list("map_files/roguetown/otherz/smallforest.json", "map_files/roguetown/otherz/smalldecap.json", "map_files/roguetown/otherz/smallswamp.json")
///Default underworld loaded in. Other maps can be specified in .json with a path or turned off with "disabled"
#define UNDERWORLD_DEFAULT_PATH "map_files/roguetown/otherz/underworld.json"
///Default dungeon loaded in. Other maps can be specified in .json with a path or turned off with "disabled"
#define DUNGEON_DEFAULT_PATH "map_files/vanderlin/otherz/dungeon.json"

/datum/map_config
	// Metadata
	var/config_filename = "_maps/vanderlin.json"
	var/defaulted = TRUE  // set to FALSE by LoadConfig() succeeding
	// Config from maps.txt
	var/config_max_users = 0
	var/config_min_users = 0
	var/voteweight = 1
	var/votable = FALSE

	// Config actually from the JSON - should default to Vanderlin
	var/map_name = "Vanderlin"
	var/map_path = "map_files/vanderlin"
	var/map_file = "vanderlin.dmm"
	var/list/other_z = null //We do not want to initialize the list here. No reason to keep it in memory.
	var/underworld_z = UNDERWORLD_DEFAULT_PATH
	var/dungeon_z = DUNGEON_DEFAULT_PATH

	var/traits = null
	var/space_ruin_levels = 7
	var/space_empty_levels = 1

/proc/load_map_config(filename = "data/next_map.json", default_to_box, delete_after, error_if_missing = TRUE)
	testing("loading map config [filename]")
	var/datum/map_config/config = new
	if (default_to_van)
		return config
	if (!config.LoadConfig(filename, error_if_missing))
		qdel(config)
		if(default_to_van)
			config = new /datum/map_config
	if (delete_after)
		fdel(filename)
	if(config)
		return config

#define CHECK_EXISTS(X) if(!istext(json[X])) { log_world("[##X] missing from json!"); return; }
/datum/map_config/proc/LoadConfig(filename, error_if_missing)
	if(!fexists(filename))
		if(error_if_missing)
			log_world("map_config not found: [filename]")
		return

	var/json = file(filename)
	if(!json)
		log_world("Could not open map_config: [filename]")
		return

	json = file2text(json)
	if(!json)
		log_world("map_config is not text: [filename]")
		return

	json = json_decode(json)
	if(!json)
		log_world("map_config is not json: [filename]")
		return

	config_filename = filename

	CHECK_EXISTS("map_name")
	map_name = json["map_name"]
	CHECK_EXISTS("map_path")
	map_path = json["map_path"]

	map_file = json["map_file"]
	if (istext(map_file))
		if (!fexists("_maps/[map_path]/[map_file]"))
			log_world("Map file ([map_path]/[map_file]) does not exist!")
			return

	// "map_file": ["Lower.dmm", "Upper.dmm"]
	else if (islist(map_file))
		for (var/file in map_file)
			if (!fexists("_maps/[map_path]/[file]"))
				log_world("Map file ([map_path]/[file]) does not exist!")
				return
	else
		log_world("map_file missing from json!")
		return

	var/temp = json["other_z"]
	if(islist(temp))
		var/list/final_z
		for(var/map_path in temp)
			if(!fexists("_maps/[map_path]")) //fexists might be better here since the file is not being manipulated/outputted.
				stack_trace("Tried to add [map_path] z-level that does not exist. Skipping.")
				continue
			if(map_path in final_z)
				stack_trace("Tried to add [map_path] z-level, which is already added. Skipping.")
				continue
			LAZYOR(final_z, map_path)
		other_z = final_z //It should be either a populated list or null. nulled entries should not be possible.
	else //Not a list. It either doesn't exist as a definition or is disabled.
		if(temp != "disabled") //If we didn't manually disable this, defaults to Roguetown travel maps.
			other_z = OTHER_Z_DEFAULT_LIST

	temp = json["underworld_z"]
	if(istext(temp)) //We only care about this if it changed.
		if(temp != "disabled")
			if(!fexists("_maps/[temp]"))
				stack_trace("The underworld [temp] z-level does not exist. Running default.")
			else
				underworld_z = temp
		else //If we disabled it.
			underworld_z = null

	temp = json["dungeon_z"]
	if(istext(temp))
		if(temp != "disabled")
			if(!fexists("_maps/[temp]"))
				stack_trace("The dungeon [temp] z-level does not exist. Running default.")
			else
				dungeon_z = temp
		else //If we disabled it.
			dungeon_z = null

	traits = json["traits"]
	// "traits": [{"Linkage": "Cross"}, {"Space Ruins": true}]
	if (islist(traits))
		// "Station" is set by default, but it's assumed if you're setting
		// traits you want to customize which level is cross-linked
		for (var/level in traits)
			if (!(ZTRAIT_STATION in level))
				level[ZTRAIT_STATION] = TRUE
	// "traits": null or absent -> default
	else if (!isnull(traits))
		log_world("map_config traits is not a list!")
		return

	temp = json["space_ruin_levels"]
	if (isnum(temp))
		space_ruin_levels = temp
	else if (!isnull(temp))
		log_world("map_config space_ruin_levels is not a number!")
		return

	temp = json["space_empty_levels"]
	if (isnum(temp))
		space_empty_levels = temp
	else if (!isnull(temp))
		log_world("map_config space_empty_levels is not a number!")
		return

	var/soundTemp = json["custom_area_sound"]
	if (istext(soundTemp))
		if(!findtextEx(soundTemp, new /regex("\\.ogg$"))) //makes sure this is an ogg file
			log_world("map_config [soundTemp] is not a valid .ogg file!")
			return
		var/soundFile = file(soundTemp)
		if(!soundFile)
			log_world("map_config custom_area_sound not found at [soundTemp]!")
			return
		custom_area_sound = soundFile
	else if (!isnull(soundTemp))
		log_world("map_config custom_area_sound is not a string!")
		return
	defaulted = FALSE
	return TRUE
#undef CHECK_EXISTS

/datum/map_config/proc/GetFullMapPaths()
	if (istext(map_file))
		return list("_maps/[map_path]/[map_file]")
	. = list()
	for (var/file in map_file)
		. += "_maps/[map_path]/[file]"

/datum/map_config/proc/MakeNextMap()
	return config_filename == "data/next_map.json" || fcopy(config_filename, "data/next_map.json")

#undef OTHER_Z_DEFAULT_LIST
#undef UNDERWORLD_DEFAULT_PATH
#undef DUNGEON_DEFAULT_PATH
