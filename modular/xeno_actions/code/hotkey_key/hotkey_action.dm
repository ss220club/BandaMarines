/datum/action/proc/get_hotkey_combo()
	if(listen_signal)
		. = get_hotkey_on_signal()
	if(!.)
		. = get_hotkey_on_full_name()
	return .

/datum/action/xeno_action/get_hotkey_combo()
	. = ..()
	if(!. && ability_primacy > XENO_NOT_PRIMARY_ACTION)
		. = get_hotkey_on_primacy()
	return .

/datum/action/update_hotkey_visual()
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
	hotkey = replacetext_char(hotkey, "Shift", "Shft")
	button.set_maptext_hotkey(SMALL_FONTS(7, hotkey), 4, 20)

/datum/action/proc/get_hotkey_on_signal()
	if(!length(owner.user_binds_signal[listen_signal]))
		return null
	return get_first_unbound_hotkey(owner.user_binds_signal[listen_signal])

/datum/action/proc/get_hotkey_on_full_name()
	if(!length(owner.user_binds_full_name[name]))
		return null
	return get_first_unbound_hotkey(owner.user_binds_full_name[name])

/datum/action/xeno_action/proc/get_hotkey_on_primacy()
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

	if(!length(owner.user_binds[primacy_keybinds_to_name["[ability_primacy]"]]))
		return null
	return get_first_unbound_hotkey(owner.user_binds[primacy_keybinds_to_name["[ability_primacy]"]])

/datum/action/proc/get_first_unbound_hotkey(list/hotkeys)
	for(var/keybind in hotkeys)
		if(keybind == "Unbound")
			continue
		return keybind
	return null
