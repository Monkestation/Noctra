GLOBAL_LIST_EMPTY(profession_types)
/datum/profession
	var/name = "Unknown"
	var/description = "A mysterious profession"
	var/max_level = 99
	var/xp_multiplier = 1.0
	var/icon_state = "profession_unknown"

	// Define what unlocks at each level
	var/alist/level_unlocks = list()
	// Format: level_unlocks[level] = list("recipes" = list(/datum/recipe/type), "passives" = list(/datum/passive/type), "abilities" = list(/datum/action/cooldown/type))

/datum/profession/New()
	..()
	initialize_unlocks()

/datum/profession/proc/initialize_unlocks()
	// Override in subclasses to define level progression
	return

/datum/profession/proc/get_unlocks_at_level(level)
	if(level in level_unlocks)
		return level_unlocks[level]
	return list(RECIPE_KEY = list(), PASSIVE_KEY = list(), ABILITY_KEY = list())

/datum/profession/proc/get_xp_for_level(level)
	// Exponential XP curve: base 100 * level^1.5
	return round(100 * (level ** 1.5) * xp_multiplier)

/datum/profession/proc/get_level_from_xp(xp)
	for(var/i = 1 to max_level)
		if(xp < get_xp_for_level(i))
			return max(1, i - 1)
	return max_level


/proc/get_profession_datum(profession_name)
	if(!profession_name || !(profession_name in GLOB.profession_types))
		return null

	return GLOB.profession_types[profession_name]

/proc/register_profession(datum/profession/prof)
	if(!prof || !prof.name)
		return FALSE

	GLOB.profession_types[prof.name] = prof
	return TRUE
