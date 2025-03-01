/mob/living/carbon/xenomorph/recalculate_actions()
	. = ..()
	for(var/datum/action/xeno_action/action in actions)
		action.update_desc()

/datum/action/xeno_action/give_to(mob/living/L)
	. = ..()
	update_desc()

/// Helper proc for replacing text
/datum/action/xeno_action/proc/replace_in_desc(what_to_replace, replace_with, type)
	switch(type)
		if(DESCRIPTION_REPLACEMENT_TIME)
			desc = replacetext_char(desc, what_to_replace, "<b>[round(replace_with, 0.1)] сек.</b>")
		if(DESCRIPTION_REPLACEMENT_DISTANCE)
			desc = replacetext_char(desc, what_to_replace, "<b>[replace_with] кл.</b>")
		else
			desc = replacetext_char(desc, what_to_replace, "<b>[replace_with]</b>")

/// Called when something changes and we need to reconstruct description
/datum/action/xeno_action/proc/update_desc()
	desc = initial(desc)
	apply_replaces_in_desc()
	post_desc()
	button.desc = desc

/// Override this to replace %TEXT% in desc with actual values
/datum/action/xeno_action/proc/apply_replaces_in_desc()
	return

/// Adds misc info post action's desc, like cooldown
/datum/action/xeno_action/proc/post_desc()
	if(xeno_cooldown)
		desc += "<br>Перезарядка: <b>[round(xeno_cooldown / 10, 0.1)] сек.</b>"
	if(charge_time)
		desc += "<br>Задержка перед активацией: <b>[round(charge_time / 10, 0.1)] сек.</b>"

/// Helper proc to make time make sense
/proc/convert_effect_time(amount, status)
	switch(status)
		if(STUN, DAZE, WEAKEN)
			return amount * GLOBAL_STATUS_MULTIPLIER / 10
		if(SLOW, SUPERSLOW, SLUR, STUTTER)
			// SLOW STATUS EFFECT IS DIFFERENT. It uses deciseconds.
			return amount * /datum/controller/subsystem/human::wait / 10
	return amount

// Show cooldown on abilities
/datum/action/xeno_action/Destroy()
	STOP_PROCESSING(SSfasteffects, src)
	. = ..()

/datum/action/xeno_action/apply_cooldown(cooldown_modifier)
	. = ..()
	if(cooldown_timer_id == TIMER_ID_NULL)
		return
	START_PROCESSING(SSfasteffects, src)

/datum/action/xeno_action/apply_cooldown_override(cooldown_duration)
	. = ..()
	if(cooldown_timer_id == TIMER_ID_NULL)
		return
	START_PROCESSING(SSfasteffects, src)

/datum/action/xeno_action/process(delta_time)
	return update_cooldown_visual()

/datum/action/xeno_action/proc/update_cooldown_visual()
	var/time_left = max(current_cooldown_start_time + current_cooldown_duration - world.time, 0)
	if(!owner || time_left <= 0 || time_left >= 180 SECONDS || cooldown_timer_id == TIMER_ID_NULL)
		button.set_maptext()
		return PROCESS_KILL
	else
		button.set_maptext(SMALL_FONTS_COLOR(7, round(time_left/10, 0.1), "#e69d00"), 4, 4)
