/datum/triumph_buy/communal/preround/orphanage_renovation
	name = "Orphanage Renovation Fund"
	desc = "Contribute to renovate the local orphanage. Only available pre-round. If not fully funded when round starts, all contributions will be refunded."
	triumph_buy_id = TRIUMPH_BUY_ORPHANAGE_RENOVATION
	maximum_pool = 60

/datum/triumph_buy/communal/preround/orphanage_renovation/on_activate()
	. = ..()
	SSmapping.add_world_trait(/datum/world_trait/orphanage_renovated)
