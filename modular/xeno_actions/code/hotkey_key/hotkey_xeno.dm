/datum/action/xeno_action/give_to(mob/living/L)
	. = ..()
	initialize_hotkey_visual()

/datum/action/xeno_action/remove_from(mob/L)
	. = ..()
	UnregisterSignal(owner, list(COMSIG_MOB_LOGGED_IN))

/datum/action/xeno_action/proc/initialize_hotkey_visual()
	// Register keybind changes, on login changes
	RegisterSignal(owner, list(COMSIG_MOB_LOGGED_IN), PROC_REF(update_hotkey_visual))
	update_hotkey_visual()

/datum/action/xeno_action/proc/update_hotkey_visual()
	SIGNAL_HANDLER

	if(!owner?.client)
		return

	var/hotkey = null

	// Get list of all player's keybinds
	var/list/user_binds = list()
	for(var/key in owner.client.prefs.key_bindings)
		for(var/kb_name in owner.client.prefs.key_bindings[key])
			user_binds[kb_name] += list(key)

	// Try to get using unique name
	hotkey = get_hotkey_on_name(user_binds)

	// If no unique key, use standart keys
	if(!hotkey && ability_primacy)
		hotkey = get_hotkey_on_primacy(user_binds)

	if(!hotkey)
		button.set_maptext_hotkey()
		return
	button.set_maptext_hotkey(SMALL_FONTS(7, hotkey), 4, 28)

/datum/action/xeno_action/proc/get_hotkey_on_name(list/user_binds)
	if(!length(user_binds[name]))
		return null
	return user_binds[name][1]

/datum/action/xeno_action/proc/get_hotkey_on_primacy(list/user_binds)
	var/static/list/primacy_keybinds_to_name = list(
		XENO_PRIMARY_ACTION_1 = "primary_attack_one",
		XENO_PRIMARY_ACTION_2 = "primary_attack_two",
		XENO_PRIMARY_ACTION_3 = "primary_attack_three",
		XENO_PRIMARY_ACTION_4 = "primary_attack_four",
		XENO_PRIMARY_ACTION_5 = "primary_attack_five",
	)

	if(!length(user_binds[primacy_keybinds_to_name[ability_primacy]]))
		return null
	return user_binds[primacy_keybinds_to_name[ability_primacy]][1]
