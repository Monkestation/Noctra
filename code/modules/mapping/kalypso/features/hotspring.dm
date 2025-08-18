/datum/map_template/world_feature/hotspring
	name = "Hotspring"
	id = "feature_hotspring"
	mappath = "_maps/kalypso/hotspring.dmm"

	width = 12
	height = 11
	rarity = 1

	allowed_biomes = list(
		BIOME_MOUNTAIN
	)

	biome_blacklist = list(
		BIOME_FOREST,
		BIOME_SWAMP,
	)
	ignores_z_restrictions = TRUE

