/obj/structure/redstone/dust
	name = "redstone dust"
	desc = "Magical dust that can transmit power signals."
	icon_state = "dust"
	power_level = 0

/obj/structure/redstone/dust/receive_power(incoming_power, obj/structure/redstone/source, mob/user)
	// Dust reduces power by 1 per tile, but only if it's not already powered higher
	var/new_power = max(0, incoming_power - 1)
	set_power(new_power, user, source)

/obj/structure/redstone/dust/update_overlays()
	. = ..()

	// Update dust brightness based on power level
	if(power_level > 0)
		var/brightness = power_level / 15.0
		color = rgb(255 * brightness, 0, 0)
	else
		color = "#8B4513"
