/datum/map_template/world_feature/flowerfield
	name = "Flower Field"
	id = "feature_flowerfield"
	mappath = "_maps/kalypso/flowerfield.dmm"

	width = 8
	height = 9
	rarity = 0.2

	ignores_z_restrictions = TRUE

	allowed_biomes = list(
		BIOME_FOREST,
		BIOME_MOUNTAIN,
	)
	biome_blacklist = list(
		BIOME_SWAMP
	)
