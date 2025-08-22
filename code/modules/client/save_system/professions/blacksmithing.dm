/datum/profession/blacksmith
	name = "Blacksmith"
	description = "A profession dedicated to turning ores into useful weapons and armor."

/datum/profession/blacksmith/initialize_unlocks()
	level_unlocks[1] = list(
		PASSIVE_KEY = list(
			/datum/passive/smelting,
			/datum/passive/repair,
			/datum/passive/sharpening,
			),
		RECIPE_KEY = list(
			/datum/anvil_recipe/weapons/copper,
		)
	)
