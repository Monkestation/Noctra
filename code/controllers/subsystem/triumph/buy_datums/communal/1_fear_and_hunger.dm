/datum/triumph_buy/communal/preround/fear_and_hunger
	name = "Fear & Hunger"
	desc = "Nutrition and hydration depletes faster, negative mood hits harder and stat debuffs are more powerful. Automatically refunds if it does not reach its goal before the round starts."
	triumph_buy_id = TRIUMPH_BUY_FEAR_AND_HUNGER
	maximum_pool = 100

/datum/triumph_buy/communal/preround/fear_and_hunger/on_activate()
	. = ..()
	SSmapping.add_world_trait(/datum/world_trait/fear_and_hunger, 0)

	to_chat(world, "<br>")
	to_chat(world, span_reallybig("The Realm is crippled by fear and hunger! People are ravenous and suspicious!"))
	to_chat(world, "<br>")

	for(var/client/C in GLOB.clients)
		if(!C?.mob)
			continue
		C.mob.playsound_local(C.mob, 'sound/misc/gods/zizo_omen.ogg', 100)
