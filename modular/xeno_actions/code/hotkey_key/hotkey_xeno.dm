/datum/action/xeno_action/give_to(mob/living/L)
	. = ..()
	initialize_hotkey_visual()

/datum/action/xeno_action/remove_from(mob/L)
	. = ..()
	if(owner)
		UnregisterSignal(owner, COMSIG_MOB_LOGGED_IN)

/datum/action/xeno_action/onclick/choose_resin/update_button_icon(selected_type, to_chat)
	. = ..()
	if(!selected_type)
		return
	update_hotkey_visual()

/datum/action/xeno_action/proc/initialize_hotkey_visual()
	// Register keybind changes, on login changes
	RegisterSignal(owner, COMSIG_MOB_LOGGED_IN, PROC_REF(update_hotkey_visual))
	update_hotkey_visual()

/datum/action/xeno_action/proc/update_hotkey_visual()
	SIGNAL_HANDLER

	if(!owner?.client)
		return

	var/hotkey = null

	// Get list of all player's keybinds
	var/list/user_binds = list()
	var/list/user_binds_full_name = list()
	for(var/key in owner.client.prefs.key_bindings)
		for(var/kb_name in owner.client.prefs.key_bindings[key])
			var/datum/keybinding/instance = GLOB.keybindings_by_name[kb_name]
			user_binds[kb_name] += list(key)
			user_binds_full_name[instance.full_name] += list(key)

	// Try to get using unique name
	hotkey = get_hotkey_on_full_name(user_binds_full_name)

	// If no unique key, use standart keys
	if(!hotkey && ability_primacy > XENO_NOT_PRIMARY_ACTION)
		hotkey = get_hotkey_on_primacy(user_binds)

	if(!hotkey)
		button.set_maptext_hotkey()
		return
	button.set_maptext_hotkey(SMALL_FONTS(7, hotkey), 4, 20)

/datum/action/xeno_action/proc/get_hotkey_on_full_name(list/user_binds)
	if(!length(user_binds[name]))
		return null
	for(var/keybind in user_binds[name])
		if(keybind == "Unbound")
			continue
		return keybind

/datum/action/xeno_action/proc/get_hotkey_on_primacy(list/user_binds)
	var/static/list/primacy_keybinds_to_name = list(
		"[XENO_PRIMARY_ACTION_1]" = "primary_attack_one",
		"[XENO_PRIMARY_ACTION_2]" = "primary_attack_two",
		"[XENO_PRIMARY_ACTION_3]" = "primary_attack_three",
		"[XENO_PRIMARY_ACTION_4]" = "primary_attack_four",
		"[XENO_PRIMARY_ACTION_5]" = "primary_attack_five",
		"[XENO_TECH_SECRETE_RESIN]" = /datum/keybinding/xenomorph/tech_secrete_resin::name,
		"[XENO_CORROSIVE_ACID]" = /datum/keybinding/xenomorph/corrosive_acid::name,
		"[XENO_SCREECH]" = /datum/keybinding/xenomorph/screech::name,
		"[XENO_TAIL_STAB]" = /datum/keybinding/xenomorph/tail_stab::name,
		"[XENO_BECOME_SEETHROUGH]" = /datum/keybinding/xenomorph/toggle_seethrough::name,
	)

	if(!length(user_binds[primacy_keybinds_to_name["[ability_primacy]"]]))
		return null
	return user_binds[primacy_keybinds_to_name["[ability_primacy]"]][1]
