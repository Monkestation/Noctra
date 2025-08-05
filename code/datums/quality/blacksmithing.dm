/datum/quality_calculator/blacksmithing
	name = "Blacksmithing Quality"

/datum/quality_calculator/blacksmithing/calculate_final_quality()
	var/avg_material = floor(material_quality / num_components) - 2
	var/avg_skill = floor((skill_quality / num_components) / 1500) + avg_material
	var/final_performance = avg_skill - floor(performance_quality * 0.25) // performance_quality = number of hits

	return final_performance
