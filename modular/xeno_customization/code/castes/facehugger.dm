#define FACEHUGGER_REQUIRED_STATES list(" Running", " Knocked Down", " Thrown", " Sleeping", " Dead")

/datum/xeno_customization_option/facehugger
	abstract_type = /datum/xeno_customization_option/facehugger
	caste = XENO_CASTE_FACEHUGGER
	var/huglock = 0

/datum/xeno_customization_option/facehugger/check_full_body_states()
	. = TRUE
	var/list/icon_states = icon_states(icon_path)
	var/list/subtract_icon_states = icon_states(subtract_icon_path)
	for(var/movement_state in FACEHUGGER_REQUIRED_STATES)
		var/required_icon_state = "Normal Facehugger[movement_state]"
		if(!(required_icon_state in icon_states))
			. = FALSE
			stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' icon state! Review naming convention!")
		if(subtract_icon_path && !(required_icon_state in subtract_icon_states))
			. = FALSE
			stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' subtract icon state! Review naming convention!")
	return .

#undef FACEHUGGER_REQUIRED_STATES

/datum/xeno_customization_option/facehugger/is_locked_with_reasons(client/user)
	. = ..()
	if(get_client_stat(user, PLAYER_STAT_FACEHUGS) < huglock)
		. += "Необходимо следующее количество обнимашек: [huglock]. "
	return .

/datum/xeno_customization_option/facehugger/golden
	name = "Золотой сын"
	key = "facehugger_golden"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/facehugger/golden.dmi'
	huglock = FACEHUG_TIER_3
	full_body_customization = TRUE
	slot = CUSTOMIZATION_SLOT_ALL
