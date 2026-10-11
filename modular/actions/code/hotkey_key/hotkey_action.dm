/datum/action/proc/get_hotkey_combo()
	if(listen_signal)
		. = get_hotkey_on_signal()
	if(!.)
		. = get_hotkey_on_full_name()
	return .

/datum/action/proc/update_hotkey_visual()
	if(!owner?.client)
		return

	if(!owner.client.prefs.show_hotkeys)
		button.set_maptext_hotkey()
		return

	if(!length(owner.user_binds))
		owner.update_keybinds()

	var/hotkey = get_hotkey_combo()

	if(!hotkey)
		button.set_maptext_hotkey()
		return
	hotkey = replacetext_char(hotkey, "+", "")
	hotkey = replacetext_char(hotkey, "Shift", "Sft")
	hotkey = replacetext_char(hotkey, "Space", "Spc")
	button.set_maptext_hotkey(SMALL_FONTS(7, hotkey), 4, 20)

/datum/action/proc/get_hotkey_on_signal()
	if(!length(owner.user_binds_signal[listen_signal]))
		return null
	return get_first_unbound_hotkey(owner.user_binds_signal[listen_signal])

/datum/action/proc/get_hotkey_on_full_name()
	if(!length(owner.user_binds_full_name[name]))
		return null
	return get_first_unbound_hotkey(owner.user_binds_full_name[name])

/datum/action/proc/get_first_unbound_hotkey(list/hotkeys)
	for(var/keybind in hotkeys)
		if(keybind == "Unbound")
			continue
		return keybind
	return null

/datum/action/give_to(mob/L)
	. = ..()
	update_hotkey_visual()
