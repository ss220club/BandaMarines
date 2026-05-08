/datum/weather_ss_map_holder/lv773_aegis_ridge
	name = "LV-773 Aegis Ridge Map Holder"

	warn_time = 1 MINUTES
	min_time_between_events = 12 MINUTES
	min_time_between_checks = 0
	min_check_variance = 0

	no_weather_turf_icon_state = "strata_clearsky"

	potential_weather_events = list(
		/datum/weather_event/aegis_light_rain,
		/datum/weather_event/aegis_very_light_rain,
	)

/datum/weather_ss_map_holder/lv773_aegis_ridge/should_affect_area(area/target_area)
	return !CEILING_IS_PROTECTED(target_area.ceiling, CEILING_GLASS)

/datum/weather_ss_map_holder/lv773_aegis_ridge/should_start_event()
	return prob(PROB_WEATHER_LV759)
