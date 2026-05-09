/datum/action/xeno_action/onclick/choose_resin/update_button_icon(selected_type, to_chat)
	. = ..()
	if(!selected_type)
		return
	update_hotkey_visual()
