/proc/check_roundstart_gods_rankings()
	var/json_file = file("data/gods_rankings.json")
	if(!fexists(json_file))
		return

	var/list/json = json_decode(file2text(json_file))
	var/modified = FALSE

	var/list/storytellers = list()
	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller_name]
		if(initialized_storyteller)
			storytellers += initialized_storyteller

	sortTim(storytellers, GLOBAL_PROC_REF(cmp_storyteller_ranking))

	for(var/i in 1 to length(storytellers))
		var/datum/storyteller/initialized_storyteller = storytellers[i]

		// Top 3 penalties
		if(i == 1)
			initialized_storyteller.influence_modifier = 0.875
		else if(i == 2)
			initialized_storyteller.influence_modifier = 0.925
		else if(i == 3)
			initialized_storyteller.influence_modifier = 0.95

		// Bottom 3 bonuses
		else if(i == length(storytellers))
			initialized_storyteller.influence_modifier = 1.125
		else if(i == (length(storytellers) - 1))
			initialized_storyteller.influence_modifier = 1.075
		else if(i == (length(storytellers) - 2))
			initialized_storyteller.influence_modifier = 1.05

		// Handle ascension
		var/points = json[initialized_storyteller.name] || 0
		if(points >= 100)
			json[initialized_storyteller.name] = 0
			modified = TRUE
			initialized_storyteller.ascendant = TRUE
			adjust_storyteller_influence(initialized_storyteller.name, 500)

	if(modified)
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))

/proc/get_god_rankings()
	var/json_file = file("data/gods_rankings.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
		return list()

	var/list/json = json_decode(file2text(json_file))
	return json

/proc/update_god_rankings()
	var/most_influential
	var/most_frequent
	var/highest_influence = -1
	var/highest_chosen = -1
	var/ascendant_round = FALSE

	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/initialized_storyteller = SSgamemode.storytellers[storyteller_name]
		if(!initialized_storyteller)
			continue

		if(initialized_storyteller.ascendant)
			ascendant_round = TRUE

		var/influence = SSgamemode.calculate_storyteller_influence(initialized_storyteller.type)
		if(influence > highest_influence)
			highest_influence = influence
			most_influential = initialized_storyteller.name

		if(initialized_storyteller.times_chosen > highest_chosen)
			highest_chosen = initialized_storyteller.times_chosen
			most_frequent = initialized_storyteller.name

	if(!most_influential || !most_frequent || ascendant_round)
		return

	var/json_file = file("data/gods_rankings.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	var/current_points_influential = json[most_influential] || 0
	var/current_points_frequent = json[most_frequent] || 0
	if(most_influential == most_frequent)
		json[most_influential] = current_points_influential + 2
	else
		json[most_influential] = current_points_influential + 1
		json[most_frequent] = current_points_frequent + 1

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

/proc/cmp_god_ranking(list/a, list/b)
	return b["points"] - a["points"]

/proc/cmp_storyteller_ranking(datum/storyteller/a, datum/storyteller/b)
	var/list/json = get_god_rankings()
	return (json[b.name] || 0) - (json[a.name] || 0)

/proc/create_god_ranking_entry(god_name, points, color_theme)
	var/percentage = min(points, 100)

	return {"
	<div style='margin-bottom: 8px;'>
		<div style='display: flex; align-items: center; gap: 8px;'>
			<div style='width: 80px; margin-left: 40px; color: [color_theme];'>[god_name]</div>
			<div style='flex-grow: 1; background: #333; height: 20px;'>
				<div style='width: [percentage]%; height: 100%; background: [color_theme];'></div>
			</div>
			<div style='width: 50px; text-align: right;'>[points]/100</div>
		</div>
	</div>
	"}
