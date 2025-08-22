/datum/pet_command/gnome/select_recipe
	command_name = "Select Recipe"
	command_desc = "Choose an alchemy recipe to focus on"
	radial_icon_state = "recipe"
	speech_commands = list("recipe", "brew", "make", "alchemy")

/datum/pet_command/gnome/select_recipe/try_activate_command(mob/living/commander, radial_command)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = weak_parent.resolve()
	var/datum/ai_controller/controller = gnome.ai_controller

	if(!commander)
		return

	var/list/recipe_names = list()
	var/list/recipe_paths = list()

	for(var/recipe_path in subtypesof(/datum/alch_cauldron_recipe))
		var/datum/alch_cauldron_recipe/recipe = new recipe_path
		recipe_names += recipe.recipe_name
		recipe_paths[recipe.recipe_name] = recipe_path
		qdel(recipe)

	var/chosen_recipe = input(commander, "Select a recipe for the gnome to focus on:", "Alchemy Recipe") as null|anything in recipe_names

	if(!chosen_recipe)
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	var/recipe_path = recipe_paths[chosen_recipe]
	controller.set_blackboard_key(BB_GNOME_CURRENT_RECIPE, recipe_path)
	gnome.visible_message(span_notice("[gnome] looks and commits the [chosen_recipe] recipe to memory."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/start_alchemy
	command_name = "Start Alchemy"
	command_desc = "Begin automated alchemy process"
	radial_icon_state = "alch"
	speech_commands = list("start alchemy", "begin brewing", "automate", "start brewing")
	requires_pointing = TRUE
	pointed_reaction = "and begins analyzing the alchemy setup"

/datum/pet_command/gnome/start_alchemy/execute_action(datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_CURRENT_PET_TARGET]
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn

	if(!istype(target, /obj/machinery/light/fueled/cauldron) && target)
		gnome.visible_message(span_warning("[gnome] looks confusedly - that's not a cauldron!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	if(!controller.blackboard[BB_GNOME_CURRENT_RECIPE])
		gnome.visible_message(span_warning("[gnome] looks confusedly - no recipe selected!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	var/obj/structure/well = locate(/obj/structure/well) in range(20, gnome)
	if(!well)
		gnome.visible_message(span_warning("[gnome] looks confusedly - no well found nearby!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	controller.set_blackboard_key(BB_GNOME_ALCHEMY_MODE, TRUE)
	controller.set_blackboard_key(BB_GNOME_TARGET_CAULDRON, target)
	controller.set_blackboard_key(BB_GNOME_TARGET_WELL, well)
	controller.set_blackboard_key(BB_GNOME_BOTTLE_STORAGE, controller.blackboard[BB_GNOME_WAYPOINT_A])

	gnome.visible_message(span_notice("[gnome] looks eagerly and begins the alchemy automation process!"))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/stop_alchemy
	command_name = "Stop Alchemy"
	command_desc = "Stop automated alchemy process"
	radial_icon_state = "alch-stop"
	speech_commands = list("stop alchemy", "stop brewing", "halt alchemy", "end brewing")

/datum/pet_command/gnome/stop_alchemy/execute_action(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn

	controller.set_blackboard_key(BB_GNOME_ALCHEMY_MODE, FALSE)
	controller.clear_blackboard_key(BB_GNOME_TARGET_CAULDRON)
	controller.clear_blackboard_key(BB_GNOME_TARGET_WELL)

	gnome.visible_message(span_notice("[gnome] looks and stops the alchemy process."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
