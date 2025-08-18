/datum/map_template/world_feature/strawberry
	name = "Strawberry Farm"
	id = "feature_strawberry"
	mappath = "_maps/kalypso/strawberrypatch.dmm"

	width = 11
	height = 10
	rarity = 0.3

	ignores_z_restrictions = TRUE

	allowed_biomes = list(
		BIOME_FOREST,
		BIOME_MOUNTAIN,
	)
	biome_blacklist = list(
		BIOME_SWAMP
	)
