/datum/triumph_buy/leprosy
	name = "Leprosy"
	desc = "Become a leper. You will be hated, you will be shunned, you will bleed and you will be weak. But Pestra will be always on your side."
	triumph_buy_id = TRIUMPH_BUY_LEPROSY
	triumph_cost = 4
	category = TRIUMPH_CAT_CHARACTER
	visible_on_active_menu = TRUE
	manual_activation = TRUE
	allow_multiple_buys = FALSE
	limited = TRUE
	stock = 2

/datum/triumph_buy/leprosy/on_after_spawn(mob/living/carbon/human/H)
	. = ..()
	ADD_TRAIT(H, TRAIT_LEPROSY, TRAIT_GENERIC)

	var/obj/item/clothing/face/facemask/iron_mask = new()
	if(!H.equip_to_slot_if_possible(iron_mask, ITEM_SLOT_MASK, disable_warning = TRUE))
		if(!H.put_in_active_hand(iron_mask))
			iron_mask.forceMove(H.drop_location())

	on_activate()
