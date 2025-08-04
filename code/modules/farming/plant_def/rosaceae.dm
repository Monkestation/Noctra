/datum/plant_def/jacksberry
	name = "jacksberry bush"
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 35
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 25

/datum/plant_def/jacksberry/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.yield_trait = TRAIT_GRADE_GOOD
	base_genetics.quality_trait = TRAIT_GRADE_GOOD

/datum/plant_def/jacksberry_poison
	name = "jacksberry bush"
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry/poison
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 0
	potassium_requirement = 35
	nitrogen_production = 0
	phosphorus_production = 25
	potassium_production = 0

/datum/plant_def/jacksberry_poison/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.disease_resistance = TRAIT_GRADE_EXCELLENT  // Poisonous = pest resistant
	base_genetics.yield_trait = TRAIT_GRADE_AVERAGE

/datum/plant_def/strawberry
	name = "strawberry bush"
	icon_state = "strawberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/strawberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 40
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 25

/datum/plant_def/strawberry/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.yield_trait = TRAIT_GRADE_GOOD

/datum/plant_def/blackberry
	name = "blackberry bush"
	icon_state = "blackberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/blackberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 28
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 0
	potassium_production = 25

/datum/plant_def/blackberry/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.disease_resistance = TRAIT_GRADE_GOOD  // Thorny = pest resistant
	base_genetics.cold_resistance = TRAIT_GRADE_EXCELLENT

/datum/plant_def/raspberry
	name = "raspberry bush"
	icon_state = "raspberry"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/raspberry
	uproot_loot = list(/obj/item/grown/log/tree/stick)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 0
	potassium_requirement = 38
	nitrogen_production = 20
	phosphorus_production = 0
	potassium_production = 0

/datum/plant_def/raspberry/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD

/datum/plant_def/apple
	name = "apple tree"
	icon_state = "apple"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/apple
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 0
	potassium_requirement = 50
	nitrogen_production = 0
	phosphorus_production = 30
	potassium_production = 0


/datum/plant_def/apple/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.yield_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD

/datum/plant_def/pear
	name = "pear tree"
	icon_state = "pear"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/pear
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 0
	phosphorus_requirement = 0
	potassium_requirement = 48
	nitrogen_production = 32
	phosphorus_production = 0
	potassium_production = 0

/datum/plant_def/pear/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.quality_trait = TRAIT_GRADE_EXCELLENT
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD

/datum/plant_def/plum
	name = "plum tree"
	icon_state = "plumtree"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/fruit/plum
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_nutrition = HUNGRINESS_DEMANDING
	plant_family = FAMILY_ROSACEAE
	nitrogen_requirement = 45
	phosphorus_requirement = 0
	potassium_requirement = 0
	nitrogen_production = 0
	phosphorus_production = 32
	potassium_production = 0
