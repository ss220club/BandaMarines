/datum/xeno_customization_picker
	var/datum/preferences/user_preferences
	/// Reference list for previewing
	var/list/xeno_customizations_list = list()
	/// What caste to show in UI
	var/selected_caste = XENO_CASTE_RAVAGER
	var/list/datum/xeno_customization_option/selected_preview_customizations = list()

/datum/xeno_customization_picker/New(datum/preferences/user_preferences)
	. = ..()
	src.user_preferences = user_preferences
	xeno_customizations_list = user_preferences.xeno_customizations

/datum/xeno_customization_picker/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoCustomizationPicker", "Xeno Customization")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/xeno_customization_picker/ui_static_data(mob/user)
	var/list/data = list()
	data["all_customizations"]
	return data

/datum/xeno_customization_picker/ui_data(mob/user)
	var/list/data = list()
	data["selected_customizations"] = xeno_customizations_list[selected_caste]
	return data

/datum/xeno_customization_picker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("save")
			user_preferences.save_and_sanitize_xeno_customization()
		if("preview")
			return
