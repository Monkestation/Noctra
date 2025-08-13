/proc/generate_lava_features(list/cave_map, list/biome_map, list/elevation_map, list/chamber_locations)
	var/list/lava_flow_map = list()

	// Initialize lava flow map
	for(var/x = 1; x <= MAP_SIZE; x++)
		lava_flow_map["[x]"] = list()
		for(var/y = 1; y <= MAP_SIZE; y++)
			lava_flow_map["[x]"]["[y]"] = NORTH

	cave_map = generate_edge_to_edge_lava_rivers(cave_map, lava_flow_map, elevation_map, biome_map)
	cave_map = generate_large_lava_lakes(cave_map, lava_flow_map, biome_map, elevation_map, chamber_locations)
	cave_map = generate_lava_rivers(cave_map, lava_flow_map, biome_map, elevation_map)

	return cave_map

/proc/generate_edge_to_edge_lava_rivers(list/cave_map, list/lava_flow_map, list/elevation_map, list/biome_map)
	world.log << "Generating edge-to-edge lava river system..."

	var/river_count = rand(1, 2)

	for(var/i = 1; i <= river_count; i++)
		generate_single_edge_to_edge_lava_river(cave_map, lava_flow_map, elevation_map, biome_map)

	return cave_map

/proc/generate_single_edge_to_edge_lava_river(list/cave_map, list/lava_flow_map, list/elevation_map, list/biome_map)
	var/start_edge = rand(1, 4)
	var/end_edge = start_edge

	while(end_edge == start_edge)
		end_edge = rand(1, 4)

	var/start_x = 0
	var/start_y = 0
	var/end_x = 0
	var/end_y = 0

	switch(start_edge)
		if(1) // North edge
			start_x = rand(1, MAP_SIZE)
			start_y = MAP_SIZE
		if(2) // East edge
			start_x = MAP_SIZE
			start_y = rand(1, MAP_SIZE)
		if(3) // South edge
			start_x = rand(1, MAP_SIZE)
			start_y = 1
		if(4) // West edge
			start_x = 1
			start_y = rand(1, MAP_SIZE)

	switch(end_edge)
		if(1) // North edge
			end_x = rand(1, MAP_SIZE)
			end_y = MAP_SIZE
		if(2) // East edge
			end_x = MAP_SIZE
			end_y = rand(1, MAP_SIZE)
		if(3) // South edge
			end_x = rand(1, MAP_SIZE)
			end_y = 1
		if(4) // West edge
			end_x = 1
			end_y = rand(1, MAP_SIZE)

	var/list/river_path = trace_lava_river_path(start_x, start_y, end_x, end_y, elevation_map)

	for(var/i = 1; i <= river_path.len; i++)
		var/list/coords = river_path[i]
		var/x = coords[1]
		var/y = coords[2]

		var/flow_dir = NORTH // Default
		if(i < river_path.len)
			var/list/next_coords = river_path[i + 1]
			var/next_x = next_coords[1]
			var/next_y = next_coords[2]
			flow_dir = get_dir_from_offset(next_x - x, next_y - y)

		var/progress = i / river_path.len
		var/width_factor = sin(progress * 180)
		var/river_width = 2 + round(width_factor * 3)

		place_lava_river_segment(cave_map, lava_flow_map, x, y, river_width, flow_dir)

/proc/trace_lava_river_path(start_x, start_y, end_x, end_y, list/elevation_map)
	var/list/path = list()
	var/x = start_x
	var/y = start_y
	var/target_x = end_x
	var/target_y = end_y

	var/curve_intensity = rand(15, 35) // More curvy than surface rivers
	var/meander_frequency = rand(12, 18) // More frequent direction changes
	var/current_curve_bias_x = 0
	var/current_curve_bias_y = 0
	var/steps_since_direction_change = 0
	var/preferred_side = pick(-1, 1)

	var/max_steps = MAP_SIZE * 3
	var/steps = 0

	while(steps < max_steps)
		steps++
		path += list(list(x, y))

		if(abs(x - target_x) <= 2 && abs(y - target_y) <= 2)
			break

		steps_since_direction_change++
		if(steps_since_direction_change >= meander_frequency)
			steps_since_direction_change = 0
			if(prob(75))
				preferred_side *= -1

			// Calculate perpendicular direction to main flow for curving
			var/main_dx = target_x - x
			var/main_dy = target_y - y
			var/main_length = sqrt(main_dx*main_dx + main_dy*main_dy)

			if(main_length > 0)
				main_dx /= main_length
				main_dy /= main_length
				current_curve_bias_x = -main_dy * preferred_side * (curve_intensity / 100)
				current_curve_bias_y = main_dx * preferred_side * (curve_intensity / 100)

		// Find the best next step with curving bias
		var/best_x = x
		var/best_y = y
		var/best_score = 999999

		// Check all 8 directions
		for(var/dx = -1; dx <= 1; dx++)
			for(var/dy = -1; dy <= 1; dy++)
				if(dx == 0 && dy == 0)
					continue

				var/nx = x + dx
				var/ny = y + dy

				// Keep within bounds
				if(nx < 1 || nx > MAP_SIZE || ny < 1 || ny > MAP_SIZE)
					continue

				// Calculate base score (distance to target)
				var/distance_to_target = sqrt((nx - target_x) * (nx - target_x) + (ny - target_y) * (ny - target_y))

				// Terrain factors - lava flows better downhill
				var/elevation_penalty = 0
				if(elevation_map)
					elevation_penalty = elevation_map["[nx]"]["[ny]"] * 0.4

				var/curve_bonus = 0
				if(current_curve_bias_x != 0 || current_curve_bias_y != 0)
					curve_bonus = -(dx * current_curve_bias_x + dy * current_curve_bias_y) * 2.5

				// Anti-straightness penalty
				var/straightness_penalty = 0
				if(path.len >= 2)
					var/list/prev_coords = path[path.len]
					var/list/prev_prev_coords = path[path.len-1]
					var/prev_dx = prev_coords[1] - prev_prev_coords[1]
					var/prev_dy = prev_coords[2] - prev_prev_coords[2]

					if(dx == prev_dx && dy == prev_dy)
						straightness_penalty = 2.0 // Higher penalty for lava

				// Random noise for natural variation
				var/noise = (rand() - 0.5) * 0.7

				var/total_score = distance_to_target + elevation_penalty + curve_bonus + straightness_penalty + noise

				if(total_score < best_score)
					best_score = total_score
					best_x = nx
					best_y = ny

		// Move to best position
		x = best_x
		y = best_y

		// Reduce curve intensity as we get closer to target
		var/remaining_distance = sqrt((x - target_x) * (x - target_x) + (y - target_y) * (y - target_y))
		if(remaining_distance < MAP_SIZE * 0.15)
			curve_intensity *= 0.7

	// Ensure we end at the target
	if(!(list(target_x, target_y) in path))
		path += list(list(target_x, target_y))

	world.log << "Generated curved edge-to-edge lava river path with [path.len] segments from ([start_x],[start_y]) to ([end_x],[end_y])"
	return path

/proc/place_lava_river_segment(list/cave_map, list/lava_flow_map, center_x, center_y, width, flow_direction)
	for(var/dx = -width; dx <= width; dx++)
		for(var/dy = -width; dy <= width; dy++)
			var/rx = center_x + dx
			var/ry = center_y + dy

			if(rx >= 1 && rx <= MAP_SIZE && ry >= 1 && ry <= MAP_SIZE)
				var/distance = sqrt(dx*dx + dy*dy)
				if(distance <= width)
					if(cave_map["[rx]"]["[ry]"] == CAVE_WALL)
						cave_map["[rx]"]["[ry]"] = CAVE_EMPTY

					if(cave_map["[rx]"]["[ry]"] != CAVE_WALL)
						cave_map["[rx]"]["[ry]"] = CAVE_LAVA_RIVER
						lava_flow_map["[rx]"]["[ry]"] = flow_direction

/proc/generate_large_lava_lakes(list/cave_map, list/lava_flow_map, list/biome_map, list/elevation_map, list/chamber_locations)
	var/lake_count = rand(10, 15)
	var/lakes_created = 0

	for(var/list/chamber in chamber_locations)
		if(lakes_created >= lake_count) break

		if(prob(35))
			var/chamber_x = chamber[1]
			var/chamber_y = chamber[2]
			var/chamber_size = chamber[3]
			var/lake_size = chamber_size * rand(0.4, 0.7)
			create_large_lava_lake(cave_map, chamber_x, chamber_y, lake_size, 1)
			lakes_created++

	var/attempts = 0
	while(lakes_created < lake_count && attempts < 100)
		attempts++

		var/lake_x = rand(50, MAP_SIZE-50)
		var/lake_y = rand(50, MAP_SIZE-50)
		var/lake_size = rand(6, 12)  // Slightly smaller to avoid overwhelming the major rivers

		// Check if area is suitable (not too close to other lakes or major rivers)
		var/suitable = 1
		for(var/dx = -lake_size*2; dx <= lake_size*2; dx++)
			for(var/dy = -lake_size*2; dy <= lake_size*2; dy++)
				var/nx = lake_x + dx
				var/ny = lake_y + dy
				if(nx >= 1 && nx <= MAP_SIZE && ny >= 1 && ny <= MAP_SIZE)
					if(cave_map["[nx]"]["[ny]"] == CAVE_LAVA_LAKE)
						suitable = 0
						break
			if(!suitable) break

		if(suitable)
			create_large_lava_lake(cave_map, lake_x, lake_y, lake_size, 0)
			lakes_created++

	return cave_map

/proc/create_large_lava_lake(list/cave_map, center_x, center_y, size, in_chamber)
	var/num_circles = rand(2, 4)

	for(var/i = 1; i <= num_circles; i++)
		var/circle_x = center_x + rand(-size/2, size/2)
		var/circle_y = center_y + rand(-size/2, size/2)
		var/circle_size = size * rand(0.7, 1.3)

		for(var/dx = -circle_size; dx <= circle_size; dx++)
			for(var/dy = -circle_size; dy <= circle_size; dy++)
				var/dist = sqrt(dx*dx + dy*dy)

				var/noise_factor = simple_noise((circle_x + dx) * 0.1, (circle_y + dy) * 0.1, 3000) * 2

				if(dist <= circle_size + noise_factor)
					var/nx = circle_x + dx
					var/ny = circle_y + dy
					if(nx >= 1 && nx <= MAP_SIZE && ny >= 1 && ny <= MAP_SIZE)
						// If not in chamber, carve the space first
						if(!in_chamber && cave_map["[nx]"]["[ny]"] == CAVE_WALL)
							cave_map["[nx]"]["[ny]"] = CAVE_EMPTY

						// Then place lava (can overwrite cave floor but not major rivers)
						if(cave_map["[nx]"]["[ny]"] != CAVE_WALL && cave_map["[nx]"]["[ny]"] != CAVE_LAVA_RIVER)
							cave_map["[nx]"]["[ny]"] = CAVE_LAVA_LAKE
	world.log << "Generated lake at ([center_x],[center_y])"

/proc/generate_lava_rivers(list/cave_map, list/lava_flow_map, list/biome_map, list/elevation_map)
	var/tributary_count = 0
	var/max_tributaries = 8

	var/list/unique_lakes = find_unique_lava_lakes_simple(cave_map)

	world.log << "Found [unique_lakes.len] unique lava lakes"

	for(var/list/lake_center in unique_lakes)
		if(tributary_count >= max_tributaries)
			break

		var/lake_x = lake_center[1]
		var/lake_y = lake_center[2]

		tributary_count++

		var/list/nearest_river = find_nearest_major_river(cave_map, lake_x, lake_y)

		if(nearest_river)
			var/target_x = nearest_river[1]
			var/target_y = nearest_river[2]

			generate_tributary_path(cave_map, lava_flow_map, lake_x, lake_y, target_x, target_y, elevation_map)

			world.log << "Generated tributary from lake at ([lake_x],[lake_y]) to major river at ([target_x],[target_y])"
		else
			world.log << "No major river found for lake at ([lake_x],[lake_y])"

	return cave_map

/proc/find_unique_lava_lakes_simple(list/cave_map)
	var/list/unique_lakes = list()

	for(var/x = 1; x <= MAP_SIZE; x += 10)
		for(var/y = 1; y <= MAP_SIZE; y += 10)
			if(cave_map["[x]"]["[y]"] == CAVE_LAVA_LAKE)
				var/too_close = 0
				for(var/list/existing_lake in unique_lakes)
					var/dist = sqrt((x - existing_lake[1]) * (x - existing_lake[1]) + (y - existing_lake[2]) * (y - existing_lake[2]))
					if(dist < 20)
						too_close = 1
						break

				if(!too_close)
					var/list/lake_center = find_lake_center_nearby(cave_map, x, y)
					if(lake_center)
						unique_lakes += list(lake_center)
						world.log << "Found unique lake centered at ([lake_center[1]],[lake_center[2]])"

	return unique_lakes

/proc/find_lake_center_nearby(list/cave_map, start_x, start_y)
	var/total_x = 0
	var/total_y = 0
	var/tile_count = 0
	var/search_radius = 15

	for(var/dx = -search_radius; dx <= search_radius; dx++)
		for(var/dy = -search_radius; dy <= search_radius; dy++)
			var/x = start_x + dx
			var/y = start_y + dy

			if(x >= 1 && x <= MAP_SIZE && y >= 1 && y <= MAP_SIZE)
				if(cave_map["[x]"]["[y]"] == CAVE_LAVA_LAKE)
					total_x += x
					total_y += y
					tile_count++

	if(tile_count > 0)
		var/center_x = round(total_x / tile_count)
		var/center_y = round(total_y / tile_count)
		return list(center_x, center_y)
	else
		return null

/proc/find_nearest_major_river(list/cave_map, start_x, start_y)
	var/best_distance = 999999
	var/best_x = 0
	var/best_y = 0
	var/found_river = 0

	for(var/radius = 10; radius <= 200; radius += 10)
		for(var/angle = 0; angle < 360; angle += 10)
			var/search_x = start_x + round(cos(angle * 0.0174533) * radius)
			var/search_y = start_y + round(sin(angle * 0.0174533) * radius)

			if(search_x >= 1 && search_x <= MAP_SIZE && search_y >= 1 && search_y <= MAP_SIZE)
				if(cave_map["[search_x]"]["[search_y]"] == CAVE_LAVA_RIVER)
					var/river_width = count_nearby_river_tiles(cave_map, search_x, search_y)

					if(river_width >= 3)  // Major rivers are wider
						var/distance = sqrt((search_x - start_x) * (search_x - start_x) + (search_y - start_y) * (search_y - start_y))
						if(distance < best_distance)
							best_distance = distance
							best_x = search_x
							best_y = search_y
							found_river = 1

		if(found_river)
			break

	if(found_river)
		return list(best_x, best_y)
	else
		return null

/proc/count_nearby_river_tiles(list/cave_map, center_x, center_y)
	var/count = 0
	for(var/dx = -2; dx <= 2; dx++)
		for(var/dy = -2; dy <= 2; dy++)
			var/nx = center_x + dx
			var/ny = center_y + dy
			if(nx >= 1 && nx <= MAP_SIZE && ny >= 1 && ny <= MAP_SIZE)
				if(cave_map["[nx]"]["[ny]"] == CAVE_LAVA_RIVER)
					count++
	return count

/proc/generate_tributary_path(list/cave_map, list/lava_flow_map, start_x, start_y, end_x, end_y, list/elevation_map)
	var/x = start_x
	var/y = start_y
	var/steps = 0
	var/max_steps = 200

	while((abs(x - end_x) > 2 || abs(y - end_y) > 2) && steps < max_steps)
		steps++

		// Carve tributary river (width 1-2, narrower than major rivers)
		var/river_width = rand(1, 2)
		for(var/dx = -river_width; dx <= river_width; dx++)
			for(var/dy = -river_width; dy <= river_width; dy++)
				var/dist = sqrt(dx*dx + dy*dy)
				if(dist <= river_width)
					var/nx = x + dx
					var/ny = y + dy
					if(nx >= 1 && nx <= MAP_SIZE && ny >= 1 && ny <= MAP_SIZE)
						// Carve through rock if needed
						if(cave_map["[nx]"]["[ny]"] == CAVE_WALL)
							cave_map["[nx]"]["[ny]"] = CAVE_EMPTY

						// Place tributary lava (don't overwrite major rivers or lakes)
						if(cave_map["[nx]"]["[ny]"] != CAVE_WALL && cave_map["[nx]"]["[ny]"] != CAVE_LAVA_RIVER && cave_map["[nx]"]["[ny]"] != CAVE_LAVA_LAKE)
							cave_map["[nx]"]["[ny]"] = CAVE_LAVA_RIVER

		// Move toward target with strong directional bias
		var/dx = end_x - x
		var/dy = end_y - y
		var/distance = sqrt(dx*dx + dy*dy)

		if(distance > 0)
			dx = dx / distance
			dy = dy / distance

		if(elevation_map)
			var/elevation_here = elevation_map["[x]"]["[y]"]
			var/best_elevation = elevation_here
			var/best_dx = dx
			var/best_dy = dy

			for(var/test_dx = -1; test_dx <= 1; test_dx++)
				for(var/test_dy = -1; test_dy <= 1; test_dy++)
					if(test_dx == 0 && test_dy == 0) continue
					var/test_x = x + test_dx
					var/test_y = y + test_dy
					if(test_x >= 1 && test_x <= MAP_SIZE && test_y >= 1 && test_y <= MAP_SIZE)
						var/test_elevation = elevation_map["[test_x]"]["[test_y]"]
						if(test_elevation < best_elevation)
							best_elevation = test_elevation
							best_dx = test_dx
							best_dy = test_dy

			dx = (dx * 0.7) + (best_dx * 0.3)  // Stronger directional bias for tributaries
			dy = (dy * 0.7) + (best_dy * 0.3)

		dx += rand(-0.2, 0.2)
		dy += rand(-0.2, 0.2)

		distance = sqrt(dx*dx + dy*dy)
		if(distance > 0)
			dx = dx / distance
			dy = dy / distance

		x += round(dx * 2)
		y += round(dy * 2)

		x = max(1, min(MAP_SIZE, x))
		y = max(1, min(MAP_SIZE, y))

/proc/generate_lava_river_path(list/cave_map, list/lava_flow_map, start_x, start_y, end_x, end_y, list/elevation_map)
	var/x = start_x
	var/y = start_y
	var/steps = 0
	var/max_steps = 150

	while((abs(x - end_x) > 3 || abs(y - end_y) > 3) && steps < max_steps)
		steps++

		var/river_width = rand(1, 2)
		for(var/dx = -river_width; dx <= river_width; dx++)
			for(var/dy = -river_width; dy <= river_width; dy++)
				var/dist = sqrt(dx*dx + dy*dy)
				if(dist <= river_width)
					var/nx = x + dx
					var/ny = y + dy
					if(nx >= 1 && nx <= MAP_SIZE && ny >= 1 && ny <= MAP_SIZE)
						if(cave_map["[nx]"]["[ny]"] == CAVE_WALL)
							cave_map["[nx]"]["[ny]"] = CAVE_EMPTY

						// Place lava (but don't overwrite major rivers)
						if(cave_map["[nx]"]["[ny]"] != CAVE_WALL && cave_map["[nx]"]["[ny]"] != CAVE_LAVA_RIVER)
							cave_map["[nx]"]["[ny]"] = CAVE_LAVA_RIVER

		var/dx = end_x - x
		var/dy = end_y - y
		var/distance = sqrt(dx*dx + dy*dy)

		if(distance > 0)
			dx = dx / distance
			dy = dy / distance

		if(elevation_map)
			var/elevation_here = elevation_map["[x]"]["[y]"]
			var/best_elevation = elevation_here
			var/best_dx = dx
			var/best_dy = dy

			for(var/test_dx = -1; test_dx <= 1; test_dx++)
				for(var/test_dy = -1; test_dy <= 1; test_dy++)
					if(test_dx == 0 && test_dy == 0) continue
					var/test_x = x + test_dx
					var/test_y = y + test_dy
					if(test_x >= 1 && test_x <= MAP_SIZE && test_y >= 1 && test_y <= MAP_SIZE)
						var/test_elevation = elevation_map["[test_x]"]["[test_y]"]
						if(test_elevation < best_elevation)
							best_elevation = test_elevation
							best_dx = test_dx
							best_dy = test_dy

			dx = (dx * 0.6) + (best_dx * 0.4)
			dy = (dy * 0.6) + (best_dy * 0.4)

		dx += rand(-0.4, 0.4)
		dy += rand(-0.4, 0.4)

		distance = sqrt(dx*dx + dy*dy)
		if(distance > 0)
			dx = dx / distance
			dy = dy / distance

		x += round(dx * 2)
		y += round(dy * 2)

		x = max(1, min(MAP_SIZE, x))
		y = max(1, min(MAP_SIZE, y))
