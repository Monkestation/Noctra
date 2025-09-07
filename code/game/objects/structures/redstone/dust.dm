/obj/structure/redstone/dust
	name = "redstone dust"
	desc = "Magical dust that can transmit power signals."
	icon_state = "dust"
	power_level = 0

/obj/structure/redstone/dust/calculate_received_power(obj/structure/redstone/source_obj)
	// Dust receives source power - 1 (minimum 0)
	return max(0, source_obj.power_level - 1)

/obj/structure/redstone/dust/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	set_power(incoming_power, user, source)
	maptext = "[power_level]"

/obj/structure/redstone/dust/update_overlays()
	. = ..()

	// Update dust brightness based on power level
	if(power_level > 0)
		var/brightness = 0.3 + (power_level / 15.0) * 0.7
		color = rgb(255 * brightness, 0, 0)
	else
		color = "#8B4513"
