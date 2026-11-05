/datum/weather_event/lv733/light_rain
	name = "Light Rain"
	display_name = "Light Rain"
	length = 8 MINUTES

	turf_overlay_icon_state = "strata_storm"
	turf_overlay_alpha = 50

	effect_message = null
	damage_per_tick = 0

	ambience = 'sound/ambience/rainforest.ogg'

	fire_smothering_strength = 1

/datum/weather_event/lv733/snow
	name = "Snow"
	display_name = "Snow"
	length = 10 MINUTES
	turf_overlay_icon_state = "strata_snowing"

	effect_message = "You feel the icy winds chill you!"
	damage_per_tick = 0

	ambience = 'sound/ambience/strata/strata_snow.ogg'

	fire_smothering_strength = 3
