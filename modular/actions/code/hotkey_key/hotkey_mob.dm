/mob
	var/list/user_binds = list()
	var/list/user_binds_full_name = list()
	var/list/user_binds_signal = list()

/mob/Login()
	. = ..()
	update_keybinds()

/mob/proc/update_keybinds()
	user_binds = list()
	user_binds_full_name = list()
	user_binds_signal = list()
	for(var/key in client.prefs.key_bindings)
		for(var/kb_name in client.prefs.key_bindings[key])
			var/datum/keybinding/instance = GLOB.keybindings_by_name[kb_name]
			user_binds[kb_name] += list(key)
			if(instance.full_name)
				user_binds_full_name[instance.full_name] += list(key)
			if(instance.keybind_signal)
				user_binds_signal[instance.keybind_signal] += list(key)
	for(var/datum/action/action in actions)
		action.update_hotkey_visual()
