
// Advanced creature spawning with ecological balance
/proc/spawn_ecological_creatures(list/env_data)
	world.log << "Spawning creatures with ecological balance..."
	var/list/biome_map = env_data["biomes"]
	var/list/elevation_map = env_data["elevation"]

	// Create creature territories
	var/list/territories = generate_creature_territories(biome_map)

	// Spawn creatures based on territories and ecological niches
	for(var/territory in territories)
		spawn_territory_creatures(territory, biome_map, elevation_map)

/proc/generate_creature_territories(list/biome_map)
	var/list/territories = list()

	// Generate territories using watershed algorithm
	for(var/i = 1; i <= 100; i++)
		var/center_x = rand(1, MAP_SIZE)
		var/center_y = rand(1, MAP_SIZE)
		var/biome = biome_map["[center_x]"]["[center_y]"]

		var/territory_size = rand(20, 80)
		var/list/territory = list("center" = list(center_x, center_y), "biome" = biome, "size" = territory_size, "creatures" = list())

		territories += list(territory)

	return territories

/proc/spawn_territory_creatures(list/territory, list/biome_map, list/elevation_map)
	var/list/center = territory["center"]
	var/biome = territory["biome"]
	var/size = territory["size"]

	// Determine creature types for this territory
	var/list/creature_types = get_biome_creatures(biome)

	var/creature_count = rand(3, 8)

	for(var/i = 1; i <= creature_count; i++)
		var/spawn_x = center[1] + rand(-size/2, size/2)
		var/spawn_y = center[2] + rand(-size/2, size/2)

		spawn_x = max(1, min(MAP_SIZE, spawn_x))
		spawn_y = max(1, min(MAP_SIZE, spawn_y))

		var/spawn_z = prob(30) ? Z_UNDERGROUND : Z_GROUND
		var/turf/spawn_turf = locate(spawn_x, spawn_y, spawn_z)

		if(spawn_turf && !spawn_turf.density)
			var/creature_type = pick(creature_types)
			new creature_type(spawn_turf)

			// Add creature grouping behavior
			if(prob(40))
				spawn_creature_group(spawn_turf, creature_type, 2, 4)

/proc/get_biome_creatures(biome)
	switch(biome)
		if(BIOME_FOREST)
			return list(/mob/living/simple_animal/hostile/retaliate/wolf, /obj/structure/flora/grass/maneater/real, /mob/living/simple_animal/hostile/retaliate/saiga)

		if(BIOME_SWAMP)
			return list(/mob/living/simple_animal/hostile/retaliate/troll/bog, /mob/living/simple_animal/hostile/retaliate/gator,
					   /mob/living/simple_animal/hostile/retaliate/spider, /mob/living/simple_animal/hostile/retaliate/bigrat, /mob/living/simple_animal/hostile/retaliate/frog)

		if(BIOME_MOUNTAIN)
			return list(/mob/living/carbon/human/species/goblin/npc, /mob/living/simple_animal/hostile/retaliate/troll/cave,
					   /mob/living/simple_animal/hostile/retaliate/spider, /mob/living/simple_animal/hostile/retaliate/goat)

		else
			return list(/mob/living/simple_animal/hostile/retaliate/wolf)

/proc/spawn_creature_group(turf/center_turf, creature_type, min_size, max_size)
	var/group_size = rand(min_size, max_size)

	for(var/i = 1; i <= group_size; i++)
		var/spawn_x = center_turf.x + rand(-3, 3)
		var/spawn_y = center_turf.y + rand(-3, 3)
		var/spawn_z = center_turf.z

		var/turf/spawn_turf = locate(spawn_x, spawn_y, spawn_z)
		if(spawn_turf && !spawn_turf.density)
			new creature_type(spawn_turf)
