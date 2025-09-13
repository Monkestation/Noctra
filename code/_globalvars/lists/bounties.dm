GLOBAL_LIST_EMPTY(bounty_locations)
GLOBAL_LIST_EMPTY(bounty_boards)
GLOBAL_LIST_EMPTY(bounty_rep)  // ckey -> reputation score
GLOBAL_LIST_INIT(bounty_contract_types, list(
	"assassination" = "Assassination",
	"burial" = "Burial Job",
	"impersonation" = "Impersonation",
	"kidnapping" = "Kidnapping",
	"sabotage" = "Sabotage",
	"smuggling" = "Smuggling"
))

GLOBAL_LIST_INIT(contraband_packs, populate_contraband_packs())

/proc/populate_contraband_packs()
	. = list()
	for(var/datum/supply_pack/pack as anything in subtypesof(/datum/supply_pack))
		if(pack::contraband)
			.[pack::name] = pack