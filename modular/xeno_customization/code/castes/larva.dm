#define LARVA_REQUIRED_STATES list("", " Cuff", " Stunned", " Sleeping", " Dead")

/datum/xeno_customization_option/larva
	abstract_type = /datum/xeno_customization_option/larva
	caste = XENO_CASTE_LARVA

/datum/xeno_customization_option/larva/check_full_body_states()
	. = TRUE
	var/list/larva_types = list("Larva", "Bloody Larva")
	var/list/icon_states = icon_states(icon_path)
	var/list/subtract_icon_states = icon_states(subtract_icon_path)
	for(var/larva_type in larva_types)
		for(var/movement_state in LARVA_REQUIRED_STATES)
			var/required_icon_state = "[larva_type][movement_state]"
			if(!(required_icon_state in icon_states))
				. = FALSE
				stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' icon state! Review naming convention!")
			if(subtract_icon_path && !(required_icon_state in subtract_icon_states))
				. = FALSE
				stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' subtract icon state! Review naming convention!")
	return .

#undef LARVA_REQUIRED_STATES

/datum/xeno_customization_option/larva/mister
	name = "Мистер-лярва"
	key = "larva_mister"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/larva/mister.dmi'
	slot = CUSTOMIZATION_SLOT_ALL
	full_body_customization = TRUE
	var/total_timelock = JOB_PLAYTIME_TIER_3

/datum/xeno_customization_option/larva/mister/is_locked_with_reasons(client/user)
	. = ..()
	if(user.get_total_xeno_playtime() < total_timelock)
		var/hours = total_timelock / (1 HOURS)
		. += "Необходимое время на ксеноморфах: [hours] час[declension_ru(hours, "", "а", "ов")]. "
	return .
