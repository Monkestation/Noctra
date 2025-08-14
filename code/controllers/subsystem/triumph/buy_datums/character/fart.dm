/datum/triumph_buy/fart
	name = "Fart Ability"
	desc = "Gain an ability to loudly fart to everyone around you!"
	triumph_buy_id = TRIUMPH_BUY_FART
	triumph_cost = 4
	category = TRIUMPH_CAT_CHARACTER
	visible_on_active_menu = TRUE
	manual_activation = TRUE
	allow_multiple_buys = FALSE
	limited = TRUE
	stock = 1

/datum/triumph_buy/fart/on_after_spawn(mob/living/carbon/human/H)
	. = ..()
	H.add_spell(/datum/action/cooldown/spell/undirected/fart)
	on_activate()
