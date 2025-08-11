/proc/generate_biome_map()
	world.log << "Generating harmonious biome map with modular scoring..."
	var/list/biome_map = list()
	var/list/temperature_map = list()
	var/list/moisture_map = list()
	var/list/elevation_map = list()

	for(var/x = 1; x <= MAP_SIZE; x++)
		biome_map["[x]"] = list()
		temperature_map["[x]"] = list()
		moisture_map["[x]"] = list()
		elevation_map["[x]"] = list()
		for(var/y = 1; y <= MAP_SIZE; y++)
			// Temperature - latitude-based with variation
			var/base_temp = 0.5 + (y - MAP_SIZE/2) / MAP_SIZE * 0.3
			var/temp_noise = dot_point_noise(x * 0.003, y * 0.003, 123) * 0.4
			temp_noise += dot_point_noise(x * 0.008, y * 0.008, 124) * 0.1
			temperature_map["[x]"]["[y]"] = base_temp + temp_noise

			var/moisture = 0.2  // Start neutral
			moisture += dot_point_noise(x * 0.01, y * 0.01, 456) * 0.3      // Medium regions
			moisture += dot_point_noise(x * 0.025, y * 0.025, 789) * 0.2    // Smaller regions
			moisture += dot_point_noise(x * 0.05, y * 0.05, 790) * 0.1      // Local patches
			moisture += dot_point_noise(x * 0.08, y * 0.08, 791) * 0.05     // Fine detail
			moisture_map["[x]"]["[y]"] = max(0, min(1, moisture))

			var/elevation = 0.5  // Low base elevation
			elevation += dot_point_noise(x * 0.008, y * 0.008, 999) * 0.3   // Main terrain
			elevation += dot_point_noise(x * 0.02, y * 0.02, 777) * 0.2     // Hills
			elevation += dot_point_noise(x * 0.04, y * 0.04, 778) * 0.15    // Local variation
			elevation += dot_point_noise(x * 0.07, y * 0.07, 779) * 0.1     // Fine detail

			// Add some scattered high peaks using different seed
			var/peak_noise = dot_point_noise(x * 0.015, y * 0.015, 1500)
			if(peak_noise > 0.6)
				elevation += (peak_noise - 0.6) * 0.8

			elevation_map["[x]"]["[y]"] = max(0, min(1, elevation))

	for(var/x = 1; x <= MAP_SIZE; x++)
		for(var/y = 1; y <= MAP_SIZE; y++)
			var/temp = temperature_map["[x]"]["[y]"]
			var/moisture = moisture_map["[x]"]["[y]"]
			var/elevation = elevation_map["[x]"]["[y]"]

			var/best_biome = null
			var/best_score = -1
			for(var/biome_id in GLOB.biome_registry)
				var/datum/biome/biome_datum = GLOB.biome_registry[biome_id]
				var/score = biome_datum.calculate_suitability_score(temp, moisture, elevation)
				if(score > best_score)
					best_score = score
					best_biome = biome_id

			biome_map["[x]"]["[y]"] = best_biome || BIOME_FOREST  // Fallback to forest

	var/list/biome_counts = list()
	for(var/x = 1; x <= MAP_SIZE; x++)
		for(var/y = 1; y <= MAP_SIZE; y++)
			var/biome = biome_map["[x]"]["[y]"]
			biome_counts["[biome]"] = (biome_counts["[biome]"] || 0) + 1

	world.log << "Modular biome distribution: Forest=[biome_counts[BIOME_FOREST]] Swamp=[biome_counts[BIOME_SWAMP]] Mountain=[biome_counts[BIOME_MOUNTAIN]]"
	return list("biomes" = biome_map, "temperature" = temperature_map,
			"moisture" = moisture_map, "elevation" = elevation_map)
