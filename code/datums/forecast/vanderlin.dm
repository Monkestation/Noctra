/datum/forecast/vanderlin
	day_weather = list(/datum/particle_weather/rain_gentle = 10)
	dawn_weather = list(/datum/particle_weather/rain_gentle = 10)
	dusk_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/fog = 4)
	night_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/fog = 4)

	temp_ranges = list(
		"dawn" = list(5, 15),
		"day" = list(15, 22),
		"dusk" = list(10, 22),
		"night" = list(5, 10),
	)
