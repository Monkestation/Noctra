// Note: tails only work in humans. They use human-specific parameters and rely on human code for displaying.
/obj/item/organ/tail
	name = "tail"
	desc = "A severed tail. What did you cut this off of?"
	icon_state = "severedtail"
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_TAIL
	var/can_wag = TRUE
	var/wagging = FALSE

/obj/item/organ/tail/Remove(mob/living/carbon/human/H,  special = 0)
	. = ..()
	if(H && H.dna && H.dna.species)
		H.dna.species.stop_wagging_tail(H)

/obj/item/organ/tail/cat
	name = "cat tail"

/obj/item/organ/tail/harpy
	name = "harpy plumage"
	accessory_type = /datum/sprite_accessory/tail/hawk

/obj/item/organ/tail/medicator
	name = "medicator plumage"
	accessory_type = /datum/sprite_accessory/tail/medicator

/obj/item/organ/tail/kobold
	name = "small lizard tail"
	accessory_type = /datum/sprite_accessory/tail/kobold

/obj/item/organ/tail/triton
	name = "triton bell"
	accessory_type = /datum/sprite_accessory/tail/triton
