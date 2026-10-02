/datum/action/predator_action/leap/process(delta_time)
	return update_cooldown_visual()

/datum/action/predator_action/leap/proc/update_cooldown_visual()
	var/time_left = max(ability_used_time - world.time, 0)
	if(!owner || time_left <= 0)
		if(button)
			button.set_maptext()
		return PROCESS_KILL
	else
		button.set_maptext(SMALL_FONTS(7, round(time_left / 10, 0.1)), 4, 4)

/datum/action/predator_action/proc/action_deselect()
	var/mob/living/carbon/human/user = owner
	if(!user)
		return
	if(user.selected_ability == src)
		user.set_selected_ability(null)
	update_button_icon()
