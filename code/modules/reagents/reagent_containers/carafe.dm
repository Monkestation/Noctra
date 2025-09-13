/obj/item/reagent_containers/glass/carafe
	name = "glass carafe"
	desc = "A slightly grimey glass container with a flared lip, most often used for serving water and wine"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "glass_carafe"
	w_class = WEIGHT_CLASS_SMALL
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = list(10)
	volume = 100 // Four full cups
	fill_icon_thresholds = list(0, 25, 50, 75, 100)
	dropshrink = 0.7
	obj_flags = CAN_BE_HIT
	spillable = TRUE
	reagent_flags = OPENCONTAINER
	w_class = WEIGHT_CLASS_NORMAL
	drinksounds = list('sound/items/drink_gen (2).ogg','sound/items/drink_gen (3).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	poursounds = list('sound/items/fillbottle.ogg')
	sellprice = 5
	gripped_intents = list(INTENT_POUR)

/obj/item/reagent_containers/glass/carafe/silver
	name = "silver carafe"
	desc = "A shining silver container with a flared lip, most often used for serving water and wine"
	icon_state = "silver_carafe"
	fill_icon_thresholds = null
	dropshrink = 0.8
	sellprice = 45
	last_used = 0

/obj/item/reagent_containers/glass/carafe/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

/obj/item/reagent_containers/glass/carafe/silver/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna && H.dna.species)
			if(istype(H.dna.species, /datum/species/werewolf))
				return FALSE
	if(M.mind && M.mind.has_antag_datum(/datum/antagonist/vampire))
		return FALSE

/obj/item/reagent_containers/glass/carafe/gold
	name = "golden carafe"
	desc = "An opulent golden container with a flared lip, most often used for serving water and wine"
	icon_state = "gold_carafe"
	fill_icon_thresholds = null
	dropshrink = 0.8
	sellprice = 65

/obj/item/reagent_containers/glass/carafe/gold/teapot
	name = "golden teapot"
	desc = "A dainty golden teapot. The perfect item for a noble's tea party."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "teapot_gold"
	fill_icon_thresholds = null
	dropshrink = 1.0
	smeltresult = /obj/item/ingot/gold
	sellprice = 65

/obj/item/reagent_containers/glass/carafe/silver/teapot
	name = "silver teapot"
	desc = "A dainty silver teapot. The perfect item for a noble's tea party."
	icon = 'icons/roguetown/items/precious_objects.dmi'
	icon_state = "teapot_silv"
	fill_icon_thresholds = null
	dropshrink = 1.0
	smeltresult = /obj/item/ingot/silver
	sellprice = 35

/* Spawning full */

/obj/item/reagent_containers/glass/carafe/water
	list_reagents = list(/datum/reagent/water = 96)

/obj/item/reagent_containers/glass/carafe/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)

/obj/item/reagent_containers/glass/carafe/silver/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)

/obj/item/reagent_containers/glass/carafe/gold/redwine
	list_reagents = list(/datum/reagent/consumable/ethanol/redwine = 96)
