/datum/plant_def/turnip
	name = "turnip patch"
	icon_state = "turnip"
	produce_type = /obj/item/reagent_containers/food/snacks/produce/vegetable/turnip
	produce_amount_min = 2
	produce_amount_max = 4
	maturation_time = FAST_GROWING
	water_drain_rate = 1 / (1 MINUTES)
	plant_family = FAMILY_ROOT
	nitrogen_requirement = 0
	phosphorus_requirement = 30
	potassium_requirement = 0
	nitrogen_production = 20
	phosphorus_production = 0
	potassium_production = 0
	seed_identity = "turnip seedlings"

/datum/plant_def/turnip/set_genetic_tendencies(datum/plant_genetics/base_genetics)
	base_genetics.cold_resistance = TRAIT_GRADE_GOOD
	base_genetics.water_efficiency = TRAIT_GRADE_GOOD
