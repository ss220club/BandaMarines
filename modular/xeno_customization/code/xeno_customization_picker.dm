/datum/xeno_customization_picker
	var/client/holder

/datum/xeno_customization_picker/New(user)
	. = ..()
	if(user)
		setup(user)

/datum/xeno_customization_picker/proc/setup(user)
	if(isclient(user))
		holder = user
	else
		var/mob/user_mob = user
		holder = user_mob.client
	tgui_interact(holder.mob)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	qdel(src)

/datum/xeno_customization_picker/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoCustomizationPicker", "Xeno Customization")
		ui.open()
		ui.set_autoupdate(FALSE)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	holder.prefs.xeno_customization_picker = null
	qdel(src)

/datum/xeno_customization_picker/ui_static_data(mob/user)
	var/list/data = list()
	data["castes"] = ALL_XENO_CASTES
	data["positions"] = list("Ходьба", "Отдых", "Оглушение", "Мёртв")
	data["slots"] = list(
		list("name" = "Все", "bitflag" = CUSTOMIZATION_SLOT_ALL),
		list("name" = "Ноги", "bitflag" = CUSTOMIZATION_SLOT_LEGS),
		list("name" = "Туловище", "bitflag" = CUSTOMIZATION_SLOT_BODY),
		list("name" = "Руки", "bitflag" = CUSTOMIZATION_SLOT_ARMS),
		list("name" = "Голова", "bitflag" = CUSTOMIZATION_SLOT_HEAD),
		list("name" = "Хвост", "bitflag" = CUSTOMIZATION_SLOT_TAIL))
	return data

/datum/xeno_customization_picker/ui_data(mob/user)
	var/list/data = list()
	data["selected_caste"] = holder.prefs.selected_caste
	data["selected_customizations_for_caste"] = list()
	data["used_slots_for_caste"] = 0
	for(var/datum/xeno_customization_option/option in holder.prefs.selected_preview_customizations)
		data["selected_customizations_for_caste"] += list(option.key)
		data["used_slots_for_caste"] |= option.slot
	data["available_customizations_for_caste"] = list()
	for(var/option_key in GLOB.xeno_customizations_by_caste[holder.prefs.selected_caste])
		var/datum/xeno_customization_option/option = GLOB.xeno_customizations_by_key[option_key]
		var/list/option_data = list()
		option_data["name"] = option.name
		option_data["caste"] = option.caste
		option_data["key"] = option.key
		option_data["no_access_text"] = option.is_locked_with_reasons(user.client)
		option_data["slot_bitflag"] = option.slot
		option_data["customization_type"] = option.customization_type
		data["available_customizations_for_caste"] += list(option_data)
	data["selected_strain"] = holder.prefs.selected_strain
	data["available_strains_for_caste"] = list("Normal")
	for(var/strain_path in user.client.prefs.preview_dummy_xeno.caste.available_strains)
		var/datum/xeno_strain/strain = strain_path
		data["available_strains_for_caste"] += strain::name
	data["selected_position"] = holder.prefs.selected_position
	return data

/datum/xeno_customization_picker/ui_state(mob/user)
	return GLOB.always_state

/datum/xeno_customization_picker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("add_to_preview")
			holder.prefs.add_xeno_customization_for_preview(params["new_customization"])
		if("change_caste")
			holder.prefs.change_preview_xeno(params["new_caste"])
		if("change_strain")
			holder.prefs.change_preview_xeno_strain(params["new_strain"])
		if("change_position")
			holder.prefs.change_preview_xeno_positions(params["new_position"])
	return TRUE
