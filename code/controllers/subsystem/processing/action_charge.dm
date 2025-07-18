// This only matters for deducting charge costs as the actual
// charging is a world.time check
PROCESSING_SUBSYSTEM_DEF(action_charge)
	name = "action charge"
	wait = 4 DECISECONDS
	stat_tag = "ACT_CHARG"
