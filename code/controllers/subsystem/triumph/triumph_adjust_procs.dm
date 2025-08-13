/proc/adjust_triumphs(datum/key_holder, amount, counted = TRUE, reason, silent = FALSE)
	if(!key_holder)
		return

	if(!amount)
		return

	if(!ismob(key_holder) && !ismind(key_holder) && !isclient(key_holder))
		return
	var/key = key_holder:key
	var/ckey = ckey(key)
	if(!key)
		return

	SStriumphs.triumph_adjust(amount, ckey)
	SStriumphs.adjust_leaderboard(key)

	var/adjustment_verb
	if(amount > 0)
		adjustment_verb = "awarded"
		if(counted)
			record_round_statistic(STATS_TRIUMPHS_AWARDED, amount)
	else
		adjustment_verb = "lost"
		if(counted)
			record_round_statistic(STATS_TRIUMPHS_STOLEN, amount)

	var/final_text = "[abs(amount)] TRIUMPH\s [adjustment_verb]."
	if(reason)
		final_text += " REASON: [reason]"

	if(!silent)
		to_chat(key_holder, span_purple("[final_text]"))

/datum/mind/proc/adjust_triumphs(amt, counted = TRUE, reason, silent = FALSE)
	if(!key)
		return
	global.adjust_triumphs(src, amt, counted, reason, silent)

/client/proc/adjust_triumphs(amt, counted = TRUE, reason, silent = FALSE)
	global.adjust_triumphs(src, amt, counted, reason, silent)

/mob/proc/adjust_triumphs(amt, counted = TRUE, reason, silent = FALSE)
	if(!key)
		return
	global.adjust_triumphs(src, amt, counted, reason, silent)
