/datum/map_template/world_feature
	var/list/allowed_biomes = list(
		BIOME_FOREST,
		BIOME_MOUNTAIN,
		BIOME_SWAMP,
	)                                // Preferred biomes (BIOME_FOREST, BIOME_SWAMP, etc.)
	var/list/biome_blacklist = list() // Biomes to avoid
	var/min_elevation = 0             // Minimum elevation requirement
	var/max_elevation = 1             // Maximum elevation requirement
	var/min_moisture = -1             // Minimum moisture requirement
	var/max_moisture = 1              // Maximum moisture requirement
	var/min_temperature = -1          // Minimum temperature requirement
	var/max_temperature = 1           // Maximum temperature requirement
	var/rarity = 0.01                 // Spawn chance (0.0 to 1.0)
	var/avoid_rivers = TRUE           // Whether to avoid river tiles
	var/spawn_on_rivers = FALSE       // Whether to spawn EXCLUSIVELY on river tiles
	var/avoid_walls = TRUE            // Whether to avoid solid walls
	var/avoid_water = TRUE            // Whether to avoid water tiles
	var/min_distance_from_features = 5 // Minimum distance from other features
	var/max_per_biome = 3             // Maximum instances per biome area
	var/max_total = 0                 // Maximum total instances (0 = unlimited)
	var/ignores_z_restrictions = FALSE // Do we ignore spawn_on_z_level
	var/spawn_on_z_level = Z_GROUND   // Which Z level to spawn on
	var/blocks_flora = TRUE           // Whether flora should avoid this area
	var/flora_block_radius = 2        // Radius around feature to block flora
	var/list/blocked_tiles = list()   // List of coordinates that block flora spawning
