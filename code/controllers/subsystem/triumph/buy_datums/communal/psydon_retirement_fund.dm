/datum/triumph_buy/communal/psydon_retirement_fund
	name = "Psydon's Retirement Fund"
	desc = "Contribute to a fund that will be redistributed to the poorest players when its full or when the round ends."
	triumph_buy_id = TRIUMPH_BUY_PSYDON_RETIREMENT
	maximum_pool = 1000

/datum/triumph_buy/communal/psydon_retirement_fund/on_activate()
	var/total_pool = SStriumphs.communal_pools[type]
	if(total_pool <= 0)
		return

	var/list/eligible = list()
	for(var/client/C in GLOB.clients)
		if(C?.ckey)
			eligible += C

	if(length(eligible) == 1)
		var/client/C = eligible[1]
		to_chat(C, "<br>")
		adjust_triumphs(C, total_pool, FALSE, "Psydon's Retirement Fund")

		to_chat(C, "<br>")
		to_chat(C, span_reallybig("The total of [SStriumphs.communal_pools[type]] triumph\s have been redistributed from the Psydon's Retirement Fund!"))
		to_chat(C, "<br>")

		SStriumphs.communal_pools[type] = 0
		SStriumphs.communal_contributions[type] = list()
		return

	var/list/client_data = list()
	for(var/client/C in eligible)
		client_data += list(list(
			"client" = C,
			"triumphs" = SStriumphs.get_triumphs(C.ckey)
		))

	sortTim(client_data, GLOBAL_PROC_REF(cmp_client_triumphs))

	var/list/distribution = list()
	var/remaining = total_pool
	var/safety_counter = 1000
	var/distribution_reason = "Psydon's Retirement Fund"

	while(remaining > 0 && safety_counter > 0)
		safety_counter--

		var/current_min = client_data[1]["triumphs"]
		var/list/current_group = list()

		for(var/list/data in client_data)
			if(data["triumphs"] == current_min)
				current_group += data["client"]
			else
				break

		if(!length(current_group))
			break

		var/per_player = max(1, FLOOR(remaining / length(current_group), 1))
		for(var/client/C in current_group)
			if(remaining <= 0)
				break

			var/give = min(per_player, remaining)
			distribution[C] += give
			remaining -= give

			for(var/list/data in client_data)
				if(data["client"] == C)
					data["triumphs"] += give
					break

		sortTim(client_data, GLOBAL_PROC_REF(cmp_client_triumphs))

	for(var/client/C in distribution)
		if(distribution[C] > 0)
			to_chat(C, "<br>")
			adjust_triumphs(C, distribution[C], TRUE, distribution_reason)

	to_chat(world, "<br>")
	to_chat(world, span_reallybig("The total of [SStriumphs.communal_pools[type]] triumph\s have been redistributed from the Psydon's Retirement Fund!"))
	to_chat(world, "<br>")

	SStriumphs.communal_pools[type] = 0
	SStriumphs.communal_contributions[type] = list()

/proc/cmp_client_triumphs(list/a, list/b)
	return a["triumphs"] - b["triumphs"]
