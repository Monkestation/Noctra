/datum/triumph_buy/psydon_favourite
	name = "Psydon's Favourite"
	desc = "Have a guaranteed place as a notable person of the Realm if you make it through the week!"
	triumph_buy_id = TRIUMPH_BUY_PSYDON_FAVOURITE
	triumph_cost = 3
	category = TRIUMPH_CAT_MISC
	visible_on_active_menu = TRUE
	limited = TRUE
	stock = 1
	allow_multiple_buys = FALSE

/datum/triumph_buy/psydon_favourite/on_activate()
	. = ..()
	SSgamemode.refresh_alive_stats()
