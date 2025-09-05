/obj/item/organ/genitals/vagina
	name = "vagina"
	icon_state = "severedtail" //placeholder
	visible_organ = TRUE
	zone = BODY_ZONE_PRECISE_GROIN
	slot = ORGAN_SLOT_VAGINA
	var/fertility = TRUE

/obj/item/organ/genitals/vagina/Insert(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	M.add_hole(ORGAN_SLOT_VAGINA, /datum/component/storage/concrete/grid/hole/vagina)
	SEND_SIGNAL(M, COMSIG_HOLE_MODIFY_HOLE, ORGAN_SLOT_BREASTS, 3, CEILING(breast_size / 4, 1))

/obj/item/organ/genitals/vagina/Remove(mob/living/carbon/M, special, drop_if_replaced)
	. = ..()
	SEND_SIGNAL(M, COMSIG_HOLE_REMOVE_HOLE, ORGAN_SLOT_VAGINA)
