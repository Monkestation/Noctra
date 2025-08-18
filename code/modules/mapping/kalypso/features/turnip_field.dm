/datum/map_template/world_feature/turnip
	name = "Turnip Field"
	id = "feature_turnip"
	mappath = "_maps/kalypso/turnip.dmm"

	width = 11
	height = 11
	rarity = 0.3

	ignores_z_restrictions = TRUE

	allowed_biomes = list(
		BIOME_FOREST,
		BIOME_SWAMP,
	)
	biome_blacklist = list(
		BIOME_MOUNTAIN
	)
