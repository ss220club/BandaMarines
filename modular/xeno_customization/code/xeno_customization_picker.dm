/datum/xeno_customization_picker
	var/datum/preferences/user_preferences
	/// Reference list for previewing
	var/list/xeno_customizations_list = list()
	/// What caste to show in UI
	var/selected_caste = XENO_CASTE_RAVAGER
	var/list/datum/xeno_customization_option/selected_preview_customizations = list()
	var/atom/movable/screen/preview/preview_screen
	var/mob/living/carbon/xenomorph/preview_dummy_xeno
	var/mutable_appearance/current_xeno_appearance

/datum/xeno_customization_picker/New(datum/preferences/user_preferences)
	. = ..()
	src.user_preferences = user_preferences
	xeno_customizations_list = user_preferences.xeno_customizations
	update_preview_icon()

/datum/xeno_customization_picker/proc/update_preview_icon()
	if(preview_dummy_xeno?.caste_type != selected_caste)
		clear_xeno()
	if(isnull(preview_dummy_xeno))
		switch(selected_caste)
			if(XENO_CASTE_PREDALIEN)
				preview_dummy_xeno = new /mob/living/carbon/xenomorph/predalien/tutorial(null, null, XENO_HIVE_TUTORIAL)
			else
				var/mob/living/carbon/xenomorph/xeno = GLOB.RoleAuthority.get_caste_by_text(selected_caste)
				preview_dummy_xeno = new xeno(null, null, XENO_HIVE_TUTORIAL)
		preview_dummy_xeno.dummify()

	if(!preview_screen)
		preview_screen = new()
		preview_screen.name = "screen"
		preview_screen.assigned_map = "xeno_customization_preview_[REF(user_preferences.owner)]_map"
		preview_screen.del_on_map_removal = FALSE
		preview_screen.screen_loc = "[preview_screen.assigned_map]:1,1"
		preview_screen.icon_state = "sterile"
		user_preferences.owner.register_map_obj(preview_screen)

	// Apply modifications here

	if(!current_xeno_appearance)
		current_xeno_appearance = new(preview_dummy_xeno)
		preview_screen.vis_contents += preview_dummy_xeno

/datum/xeno_customization_picker/proc/clear_xeno()
	if(preview_screen?.assigned_map)
		user_preferences.owner.clear_map(preview_screen.assigned_map)
	QDEL_NULL(preview_screen)
	QDEL_NULL(preview_dummy_xeno)
	QDEL_NULL(current_xeno_appearance)

/datum/xeno_customization_picker/tgui_interact(mob/user, datum/tgui/ui)
	update_preview_icon()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "XenoCustomizationPicker", "Xeno Customization")
		ui.open()
		ui.set_autoupdate(TRUE)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	if(!user.client)
		return
	user.client.clear_map(preview_screen.assigned_map)

/datum/xeno_customization_picker/ui_static_data(mob/user)
	var/list/data = list()
	// get all customizations
	return data

/datum/xeno_customization_picker/ui_data(mob/user)
	var/list/data = list()
	data["selected_customizations"] = xeno_customizations_list[selected_caste]
	data["selected_caste"] = selected_caste
	data["assigned_map"] = preview_screen.assigned_map
	return data

/datum/xeno_customization_picker/ui_state(mob/user)
	return GLOB.always_state

/datum/xeno_customization_picker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("save")
			user_preferences.save_and_sanitize_xeno_customization()
		if("preview")
			return

/mob/living/carbon/xenomorph/proc/dummify()
	GLOB.xeno_mob_list -= src
	GLOB.mob_list -= src
	GLOB.dead_mob_list -= src
	GLOB.alive_mob_list -= src
	change_real_name(src, "Test Dummy")
	status_flags = GODMODE|CANPUSH
