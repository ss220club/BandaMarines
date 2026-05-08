/mob/living/carbon/xenomorph
	var/list/user_binds = list()
	var/list/user_binds_full_name = list()

/mob/living/carbon/xenomorph/proc/update_keybinds()
	user_binds = list()
	user_binds_full_name = list()
	for(var/key in client.prefs.key_bindings)
		for(var/kb_name in client.prefs.key_bindings[key])
			var/datum/keybinding/instance = GLOB.keybindings_by_name[kb_name]
			user_binds[kb_name] += list(key)
			user_binds_full_name[instance.full_name] += list(key)

/datum/action/xeno_action/give_to(mob/living/L)
	. = ..()
	initialize_hotkey_visual()

/datum/action/xeno_action/remove_from(mob/L)
	. = ..()
	if(owner)
		UnregisterSignal(owner, list(COMSIG_MOB_LOGGED_IN, COMSIG_MOB_PREFERENCES_SAVED))

/datum/action/xeno_action/onclick/choose_resin/update_button_icon(selected_type, to_chat)
	. = ..()
	if(!selected_type)
		return
	update_hotkey_visual()

/datum/action/xeno_action/proc/initialize_hotkey_visual()
	// Register keybind changes, on login changes
	RegisterSignal(owner, list(COMSIG_MOB_LOGGED_IN, COMSIG_MOB_PREFERENCES_SAVED), PROC_REF(reset_hotkeys))
	update_hotkey_visual()

/datum/action/xeno_action/proc/reset_hotkeys()
	SIGNAL_HANDLER

	var/mob/living/carbon/xenomorph/xeno_owner = owner
	xeno_owner.update_keybinds()
	update_hotkey_visual()

/datum/action/xeno_action/proc/update_hotkey_visual()
	if(!owner?.client)
		return

	if(!owner.client.prefs.xeno_show_hotkeys)
		button.set_maptext_hotkey()
		return

	var/mob/living/carbon/xenomorph/xeno_owner = owner
	if(!length(xeno_owner.user_binds))
		xeno_owner.update_keybinds()

	var/hotkey = null

	// Try to get using unique name
	hotkey = get_hotkey_on_full_name(xeno_owner.user_binds_full_name)

	// If no unique key, use standart keys
	if(!hotkey && ability_primacy > XENO_NOT_PRIMARY_ACTION)
		hotkey = get_hotkey_on_primacy(xeno_owner.user_binds)

	if(!hotkey)
		button.set_maptext_hotkey()
		return
	hotkey = replacetext_char(hotkey, "+", "")
	hotkey = replacetext_char(hotkey, "Shift", "Shft")
	button.set_maptext_hotkey(SMALL_FONTS(7, hotkey), 4, 20)

/datum/action/xeno_action/proc/get_hotkey_on_full_name(list/user_binds)
	if(!length(user_binds[name]))
		return null
	return get_first_unbound_hotkey(user_binds[name])

/datum/action/xeno_action/proc/get_hotkey_on_primacy(list/user_binds)
	var/static/list/primacy_keybinds_to_name = list(
		"[XENO_PRIMARY_ACTION_1]" = /datum/keybinding/xenomorph/primary_attack_one::name,
		"[XENO_PRIMARY_ACTION_2]" = /datum/keybinding/xenomorph/primary_attack_two::name,
		"[XENO_PRIMARY_ACTION_3]" = /datum/keybinding/xenomorph/primary_attack_three::name,
		"[XENO_PRIMARY_ACTION_4]" = /datum/keybinding/xenomorph/primary_attack_four::name,
		"[XENO_PRIMARY_ACTION_5]" = /datum/keybinding/xenomorph/primary_attack_five::name,
		"[XENO_TECH_SECRETE_RESIN]" = /datum/keybinding/xenomorph/tech_secrete_resin::name,
		"[XENO_CORROSIVE_ACID]" = /datum/keybinding/xenomorph/corrosive_acid::name,
		"[XENO_SCREECH]" = /datum/keybinding/xenomorph/screech::name,
		"[XENO_TAIL_STAB]" = /datum/keybinding/xenomorph/tail_stab::name,
		"[XENO_BECOME_SEETHROUGH]" = /datum/keybinding/xenomorph/toggle_seethrough::name,
	)

	if(!length(user_binds[primacy_keybinds_to_name["[ability_primacy]"]]))
		return null
	return get_first_unbound_hotkey(user_binds[primacy_keybinds_to_name["[ability_primacy]"]])

/datum/action/xeno_action/proc/get_first_unbound_hotkey(list/hotkeys)
	for(var/keybind in hotkeys)
		if(keybind == "Unbound")
			continue
		return keybind
	return null
