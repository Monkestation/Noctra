/datum/plant_def/tangerine
	name = "tangerine tree"
	icon_state = "tangerinetree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/tangerine
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_RUTACEAE  // Citrus family
	nitrogen_requirement = 55
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 32
	seed_identity = "tangerine seeds"
	see_through = TRUE

/datum/plant_def/tangerine/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_GOOD
	base_genetics.water_efficiency = TRAIT_GRADE_POOR  // Citrus needs lots of water

/datum/plant_def/lime
	name = "lime tree"
	icon_state = "limetree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/lime
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_RUTACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 52
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 32
	seed_identity = "lime seeds"
	see_through = TRUE

/datum/plant_def/lime/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_GOOD
	base_genetics.cold_resistance = TRAIT_GRADE_POOR  // Tropical citrus

/datum/plant_def/lemon
	name = "lemon tree"
	icon_state = "lemontree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/lemon
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_RUTACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 0
	potassium_requirement = 58
	nitrogen_production = 0
	phosphorus_production = 40
	potassium_production = 0
	seed_identity = "lemon seeds"
	see_through = TRUE

/datum/plant_def/lemon/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.disease_resistance = TRAIT_GRADE_GOOD  // Citric acid repels some pests
