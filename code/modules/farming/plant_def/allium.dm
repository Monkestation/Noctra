/datum/plant_def/onion
	name = "onion patch"
	icon_state = "onion"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/onion
	produce_amount_min = 3
	produce_amount_max = 4
	maturation_time = FAST_GROWING
	plant_family = FAMILY_ALLIUM
	nitrogen_requirement = 0
	phosphorus_requirement = 30  // Root development
	potassium_requirement = 0
	nitrogen_production = 20
	phosphorus_production = 0
	potassium_production = 0

/datum/plant_def/onion/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.disease_resistance = TRAIT_GRADE_EXCELLENT  // Onions repel pests
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD
