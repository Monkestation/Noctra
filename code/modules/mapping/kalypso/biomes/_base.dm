GLOBAL_LIST_INIT(biome_registry, list(
	BIOME_FOREST = new /datum/biome/forest(),
	BIOME_MOUNTAIN = new /datum/biome/mountain(),
	BIOME_SWAMP = new /datum/biome/swamp()
))

/proc/get_biome_datum(biome_id)
	return GLOB.biome_registry[biome_id]

/datum/biome
	var/name = "Unknown Biome"
	var/id = "unknown"

	// Terrain generation properties
	var/flora_density_base = 0.3

	// Environmental preferences
	var/temp_preference = 0.5      // Ideal temperature (0-1 scale)
	var/temp_tolerance = 0.3       // How much deviation from ideal is acceptable
	var/temp_falloff = 0.3         // How harshly to penalize temp deviation

	/// Flora %'s
	var/understory_chance = 40
	var/wild_crop = 10
	var/wild_herb = 8
	var/tree = 70

	var/list/trees = list()

/datum/biome/proc/calculate_height(elevation, x, y)
	// Default implementation - override in subclasses
	return 0

/datum/biome/proc/apply_height_noise(height, elevation, x, y)
	// Default implementation - override in subclasses
	return height

/datum/biome/proc/calculate_suitability_score(temp, moisture, elevation)
	return 0

/datum/biome/proc/get_flora_density(temp, moisture, elevation)
	var/temp_modifier = 1 - abs(temp - temp_preference) * 0.5
	var/moisture_modifier = max(0.2, moisture + 0.5)
	var/elevation_modifier = max(0.1, 1 - elevation * 0.7)

	return flora_density_base * temp_modifier * moisture_modifier * elevation_modifier

/datum/biome/proc/generate_ground_terrain(turf/T, temp, moisture, elevation, x, y)
	// Override in subclasses for specific terrain generation
	return

/datum/biome/proc/generate_elevated_terrain(turf/T, temp, moisture, elevation, relative_height, x, y)
	// Override in subclasses for elevated terrain
	return

/datum/biome/proc/generate_structural_terrain(turf/T, elevation, relative_height, x, y)
	// Override in subclasses for walls/cliffs
	return

/datum/biome/proc/place_ecosystem(turf/T, temp, moisture, elevation, x, y)
	// Main ecosystem placement logic
	var/tree_noise = simple_noise(x * 0.04, y * 0.04, 4000)

	// Tree placement
	if(tree_noise > 0.2)
		var/tree_type = select_tree(temp, moisture, elevation)
		if(tree_type && prob(tree))
			new tree_type(T)
			return

	// Understory vegetation
	if(prob(understory_chance))
		var/understory_type = select_understory(temp, moisture, elevation)
		if(understory_type)
			new understory_type(T)
			return

	// Wild crops
	if(prob(wild_crop))
		var/crop_type = select_wild_crops(temp, moisture, elevation)
		if(crop_type)
			new crop_type(T)
			return

	// Wild herbs
	if(prob(wild_herb))
		var/herb_type = select_herbs(temp, moisture, elevation)
		if(herb_type)
			new herb_type(T)
			return

	if(prob(understory_chance)) // round 2
		var/understory_type = select_understory(temp, moisture, elevation)
		if(understory_type)
			new understory_type(T)
			return

/datum/biome/proc/select_tree(temp, moisture, elevation)
	return pick(trees)

/datum/biome/proc/select_understory(temp, moisture, elevation)
	return null

/datum/biome/proc/select_wild_crops(temp, moisture, elevation)
	return null

/datum/biome/proc/select_herbs(temp, moisture, elevation)
	return null
