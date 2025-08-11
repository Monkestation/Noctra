/proc/generate_height_map(list/biome_map, list/elevation_map)
	world.log << "Generating enhanced height map for multi-level terrain..."
	var/list/height_map = list()

	for(var/x = 1; x <= MAP_SIZE; x++)
		height_map["[x]"] = list()
		for(var/y = 1; y <= MAP_SIZE; y++)
			var/biome_id = biome_map["[x]"]["[y]"]
			var/elevation = elevation_map["[x]"]["[y]"]

			var/datum/biome/biome_datum = get_biome_datum(biome_id)
			if(!biome_datum)
				height_map["[x]"]["[y]"] = 0
				continue

			var/height = biome_datum.calculate_height(elevation, x, y)

			height = biome_datum.apply_height_noise(height, elevation, x, y)

			var/fine_noise = dot_point_noise_octaves(x * 0.05, y * 0.05, 5000 + text2num(biome_id) * 100, 2, 0.3)
			if(fine_noise > 0.3 && height > 0)
				height = max(0, height + (fine_noise > 0.6 ? 1 : 0))

			height_map["[x]"]["[y]"] = height

	return height_map
