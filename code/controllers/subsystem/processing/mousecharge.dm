// Smooth HUD updates, but low priority
PROCESSING_SUBSYSTEM_DEF(mousecharge)
	name = "mouse charging prog"
	wait = 1
	priority = FIRE_PRIORITY_MOUSECHARGE
	stat_tag = "MOUSE"
