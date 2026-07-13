/datum/action/predator_action/leap/process(delta_time)
	return update_cooldown_visual()

/datum/action/predator_action/leap/proc/update_cooldown_visual()
	var/time_left = max(ability_used_time - world.time, 0)
	if(!owner || time_left <= 0)
		button.set_maptext()
		return PROCESS_KILL
	else
		button.set_maptext(SMALL_FONTS(7, round(time_left / 10, 0.1)), 4, 4)
