/datum/map_template/world_feature/wishtree
	name = "Wish Tree"
	id = "feature_wishtree"
	mappath = "_maps/kalypso/wishtree.dmm"

	width = 11
	height = 12
	rarity = 0.2
	max_per_biome = 1

	spawn_on_z_level = list(Z_AIR, Z_HIGH_AIR)
	allowed_biomes = list(
		BIOME_MOUNTAIN,
		BIOME_FOREST
	)

