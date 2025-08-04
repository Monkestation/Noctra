GLOBAL_LIST_EMPTY(trader_location)

/obj/effect/landmark/stall
	name = "trader stall location"
	var/claimed_by_trader = FALSE

/obj/effect/landmark/stall/Initialize()
	. = ..()
	GLOB.trader_location += src

/obj/effect/landmark/stall/Destroy()
	. = ..()
	GLOB.trader_location -= src
