/datum/xeno_customization_picker
	var/client/holder
	/// Reference list for previewing
	var/list/datum/xeno_customization_option/selected_preview_customizations = list()

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
	selected_preview_customizations = holder.prefs.xeno_customizations
	tgui_interact(holder.mob)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	qdel(src)

/datum/xeno_customization_picker/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoCustomizationPicker", "Xeno Customization")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	holder.prefs.xeno_customization_picker = null
	qdel(src)

/datum/xeno_customization_picker/ui_static_data(mob/user)
	var/list/data = list()
	// get all customizations
	data["castes"] = ALL_XENO_CASTES
	return data

/datum/xeno_customization_picker/ui_data(mob/user)
	var/list/data = list()
	data["selected_customizations"] = selected_preview_customizations[holder.prefs.selected_caste]
	data["selected_caste"] = holder.prefs.selected_caste
	return data

/datum/xeno_customization_picker/ui_state(mob/user)
	return GLOB.always_state

/datum/xeno_customization_picker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("save")
			holder.prefs.save_and_sanitize_xeno_customization()
		if("preview")
			return
		if("change_caste")
			holder.prefs.selected_caste = params["new_caste"]
			holder.prefs.update_preview_icon()

/mob/living/carbon/xenomorph/proc/previewfy()
	GLOB.xeno_mob_list -= src
	GLOB.mob_list -= src
	GLOB.dead_mob_list -= src
	GLOB.alive_mob_list -= src
	change_real_name(src, "Test Dummy")
	status_flags = GODMODE|CANPUSH
	vis_flags = null
	plane = 91
