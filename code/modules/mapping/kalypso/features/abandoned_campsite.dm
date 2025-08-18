/datum/map_template/world_feature/abandoned_campsite
	name = "Abanonded Campsite"
	id = "feature_abandoned_campsite"
	mappath = "_maps/kalypso/abandonedcampsite.dmm"

	width = 8
	height = 8
	rarity = 0.3

	ignores_z_restrictions = TRUE

	allowed_biomes = list(
		BIOME_MOUNTAIN,
	)

	biome_blacklist = list(
		BIOME_SWAMP,
		BIOME_FOREST,
	)

