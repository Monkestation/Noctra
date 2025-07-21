/datum/customizer/organ/neck_feature
	abstract_type = /datum/customizer/organ/neck_feature
	name = "Neck"

/datum/customizer_choice/organ/neck_feature
	abstract_type = /datum/customizer_choice/organ/neck_feature
	name = "Neck"
	organ_type = /obj/item/organ/feature/neck
	organ_slot = ORGAN_SLOT_NECK_FEATURE

/datum/customizer/organ/neck_feature/medicator
	customizer_choices = list(/datum/customizer_choice/organ/neck_feature/medicator)

/datum/customizer_choice/organ/neck_feature/medicator
	name = "Medicator Fluff"
	allows_accessory_color_customization = FALSE
	organ_type = /obj/item/organ/feature/neck/medicator
	sprite_accessories = list(
		/datum/sprite_accessory/neck_feature/fluff/medicator
	)
