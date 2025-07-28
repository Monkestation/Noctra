/proc/check_roundstart_gods_rankings()
	var/json_file = file("data/god_rankings.json")
	if(!fexists(json_file))
		return

	var/list/json = json_decode(file2text(json_file))
	var/modified = FALSE

	for(var/god_name in json)
		if(json[god_name] >= 100)
			json[god_name] = 0
			modified = TRUE
			for(var/storyteller_name in SSgamemode.storytellers)
				var/datum/storyteller/S = SSgamemode.storytellers[storyteller_name]
				if(S && S.name == god_name)
					adjust_storyteller_influence(S.name, 500)
					break

	if(modified)
		fdel(json_file)
		WRITE_FILE(json_file, json_encode(json))

/proc/get_god_rankings()
	var/json_file = file("data/god_rankings.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
		return list()

	var/list/json = json_decode(file2text(json_file))
	return json

/proc/update_god_rankings()
	var/most_influential
	var/highest_influence = -1

	for(var/storyteller_name in SSgamemode.storytellers)
		var/datum/storyteller/S = SSgamemode.storytellers[storyteller_name]
		if(!S)
			continue

		var/influence = SSgamemode.calculate_storyteller_influence(S.type)
		if(influence > highest_influence)
			highest_influence = influence
			most_influential = S.name

	if(!most_influential)
		return

	var/json_file = file("data/god_rankings.json")
	if(!fexists(json_file))
		WRITE_FILE(json_file, "{}")
	var/list/json = json_decode(file2text(json_file))

	var/current_points = json[most_influential] || 0
	json[most_influential] = current_points + 1

	fdel(json_file)
	WRITE_FILE(json_file, json_encode(json))

/proc/create_god_ranking_entry(god_name, points, color_theme)
	var/percentage = min(points, 100)

	return {"
	<div style='margin-bottom: 6px;'>
		<div style='display: flex; align-items: center;'>
			<div style='width: 150px; color: [color_theme];'>[god_name]</div>
			<div style='flex-grow: 1; background: #333; height: 20px; margin-right: 10px;'>
				<div style='width: [percentage]%; height: 100%; background: [color_theme];'></div>
			</div>
			<div style='width: 50px; text-align: right;'>[points]/100</div>
		</div>
	</div>
	"}
