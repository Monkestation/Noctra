/datum/hover_data/gnome_status
	var/list/waypoint_overlays = list()
	var/list/range_overlays = list()
	var/list/target_overlays = list()

/datum/hover_data/gnome_status/setup_data(atom/source, mob/enterer)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = source
	if(!istype(gnome) || !enterer.client)
		return

	var/datum/ai_controller/basic_controller/gnome_homunculus/controller = gnome.ai_controller
	if(!controller)
		return

	clear_data(source, enterer) // Clear any existing overlays first
	create_waypoint_overlays(controller, enterer.client)
	create_range_overlays(controller, enterer.client)
	create_target_overlays(controller, enterer.client)

/datum/hover_data/gnome_status/clear_data(atom/source, mob/leaver)
	. = ..()
	waypoint_overlays.Cut()
	range_overlays.Cut()
	target_overlays.Cut()

/datum/hover_data/gnome_status/proc/create_waypoint_overlays(datum/ai_controller/basic_controller/gnome_homunculus/controller, client/viewer)
	var/turf/waypoint_a = controller.blackboard[BB_GNOME_WAYPOINT_A]
	var/turf/waypoint_b = controller.blackboard[BB_GNOME_WAYPOINT_B]
	var/turf/home_turf = controller.blackboard[BB_GNOME_HOME_TURF]

	if(waypoint_a)
		var/image/waypoint_image = image('icons/effects/overlays.dmi', waypoint_a, "waypoint_a")
		waypoint_image.plane = SEETHROUGH_PLANE
		waypoint_image.color = "#00FF00" // Green for waypoint A
		waypoint_image.layer++
		waypoint_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		add_client_image(waypoint_image, viewer)
		waypoint_overlays += waypoint_image

	if(waypoint_b)
		var/image/waypoint_image = image('icons/effects/overlays.dmi', waypoint_b, "waypoint_b")
		waypoint_image.plane = SEETHROUGH_PLANE
		waypoint_image.color = "#0000FF" // Blue for waypoint B
		waypoint_image.layer++
		waypoint_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		add_client_image(waypoint_image, viewer)
		waypoint_overlays += waypoint_image

	if(home_turf)
		var/image/home_image = image('icons/effects/overlays.dmi', home_turf, "home_marker")
		home_image.plane = SEETHROUGH_PLANE
		home_image.color = "#FFD700" // Gold for home
		home_image.layer++
		home_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		add_client_image(home_image, viewer)
		waypoint_overlays += home_image

/datum/hover_data/gnome_status/proc/create_range_overlays(datum/ai_controller/basic_controller/gnome_homunculus/controller, client/viewer)
	var/range = controller.blackboard[BB_GNOME_SEARCH_RANGE] || 1

	if(controller.blackboard[BB_GNOME_TRANSPORT_MODE])
		var/turf/source = controller.blackboard[BB_GNOME_TRANSPORT_SOURCE]
		if(source)
			create_range_box(source, range, "#00FFFF", "transport_source", viewer) // Cyan

	if(controller.blackboard[BB_GNOME_CROP_MODE])
		var/mob/living/pawn = controller.pawn
		if(pawn)
			create_range_box(get_turf(pawn), 7, "#00FF00", "farming_range", viewer) // Green

			for(var/obj/structure/soil/soil in oview(7, pawn))
				var/soil_color = "#90EE90"
				if(soil.produce_ready)
					soil_color = "#FFD700"
				else if(soil.weeds > 25)
					soil_color = "#8B4513"
				else if(soil.plant && soil.water < 150 * 0.3)
					soil_color = "#87CEEB"
				else if(!soil.plant)
					soil_color = "#DEB887"

				var/image/soil_image = image('icons/effects/overlays.dmi', soil, "soil_status")
				soil_image.color = soil_color
				soil_image.alpha = 150
				soil_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
				add_client_image(soil_image, viewer)
				range_overlays += soil_image

	if(controller.blackboard[BB_GNOME_SPLITTER_MODE])
		var/turf/source = controller.blackboard[BB_GNOME_WAYPOINT_A]
		if(source)
			create_range_box(source, range, "#FF00FF", "splitter_source", viewer) // Magenta

	if(controller.blackboard[BB_GNOME_ALCHEMY_MODE])
		var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
		var/obj/structure/well/well = controller.blackboard[BB_GNOME_TARGET_WELL]

		if(cauldron)
			create_range_box(get_turf(cauldron), 3, "#800080", "cauldron_area", viewer) // Purple
		if(well)
			create_range_box(get_turf(well), 3, "#4169E1", "well_area", viewer) // Royal blue

/datum/hover_data/gnome_status/proc/create_target_overlays(datum/ai_controller/basic_controller/gnome_homunculus/controller, client/viewer)
	var/obj/machinery/essence/splitter/splitter = controller.blackboard[BB_GNOME_TARGET_SPLITTER]
	if(splitter)
		var/image/splitter_image = image('icons/effects/overlays.dmi', splitter, "target_marker")
		splitter_image.color = "#FF00FF" // Magenta
		splitter_image.plane = SEETHROUGH_PLANE
		splitter_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
		add_client_image(splitter_image, viewer)
		target_overlays += splitter_image

	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	if(cauldron)
		var/image/cauldron_image = image('icons/effects/overlays.dmi', cauldron, "target_marker")
		cauldron_image.color = "#800080" // Purple
		cauldron_image.plane = SEETHROUGH_PLANE
		add_client_image(cauldron_image, viewer)
		target_overlays += cauldron_image

	var/obj/structure/well/well = controller.blackboard[BB_GNOME_TARGET_WELL]
	if(well)
		var/image/well_image = image('icons/effects/overlays.dmi', well, "target_marker")
		well_image.color = "#4169E1" // Royal blue
		well_image.plane = SEETHROUGH_PLANE
		add_client_image(well_image, viewer)
		target_overlays += well_image

/datum/hover_data/gnome_status/proc/create_range_box(turf/center, range, color, icon_state, client/viewer)
	if(!center || range <= 0)
		return

	var/start_x = center.x - range
	var/end_x = center.x + range
	var/start_y = center.y - range
	var/end_y = center.y + range

	for(var/x = start_x to end_x)
		for(var/y = start_y to end_y)
			var/turf/target_turf = locate(x, y, center.z)
			if(!target_turf)
				continue

			var/image/fill_image = image('icons/effects/overlays.dmi', target_turf, "range_fill")
			fill_image.color = color
			fill_image.plane = SEETHROUGH_PLANE
			fill_image.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
			add_client_image(fill_image, viewer)
			range_overlays += fill_image
