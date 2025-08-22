/datum/pet_command/gnome/tend_crops
	command_name = "Tend Crops"
	command_desc = "Automatically tend to crops in the area"
	radial_icon_state = "tend"
	speech_commands = list("tend", "farm", "crops", "garden", "agriculture")

/datum/pet_command/gnome/tend_crops/execute_action(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	controller.set_blackboard_key(BB_GNOME_CROP_MODE, TRUE)
	pawn.visible_message(span_notice("[pawn] looks around and begins tending to the crops!"))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/stop_tending
	command_name = "Stop Tending"
	command_desc = "Stop tending to crops"
	radial_icon_state = "tend-stop"
	speech_commands = list("stop tending", "stop farming", "halt farming")

/datum/pet_command/gnome/stop_tending/execute_action(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	controller.set_blackboard_key(BB_GNOME_CROP_MODE, FALSE)
	pawn.visible_message(span_notice("[pawn] stops tending crops and returns to normal behavior."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
