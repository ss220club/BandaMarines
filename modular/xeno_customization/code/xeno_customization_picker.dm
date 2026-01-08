/datum/xeno_customization_picker
	var/client/holder
	/// Reference list for previewing
	var/list/datum/xeno_customization_option/selected_preview_customizations = list()
	/// What caste to show in UI
	var/selected_caste = XENO_CASTE_RAVAGER
	var/atom/movable/screen/preview/preview_screen
	var/atom/movable/screen/preview/preview_background
	var/mob/living/carbon/xenomorph/preview_dummy_xeno
	var/map_name

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
	init_map()
	selected_preview_customizations = holder.prefs.xeno_customizations
	update_preview_icon()
	tgui_interact(holder.mob)

/datum/xeno_customization_picker/proc/init_map()
	map_name = "xeno_customization_preview_[REF(src)]_map"

	preview_screen = new()
	preview_screen.name = "screen"
	preview_screen.assigned_map = map_name
	preview_screen.screen_loc = "[map_name]:0:32,0:0"
	preview_screen.appearance_flags |= TILE_BOUND

	preview_background = new()
	preview_background.name = "background"
	preview_background.assigned_map = map_name
	preview_background.icon_state = "sterile"
	preview_background.fill_rect(0,0,2,1)
	preview_background.appearance_flags |= TILE_BOUND

	holder.register_map_obj(preview_background)
	holder.register_map_obj(preview_screen)

/datum/xeno_customization_picker/ui_close(mob/user)
	. = ..()
	holder?.clear_map(map_name)
	QDEL_NULL(preview_screen)
	QDEL_NULL(preview_background)
	QDEL_NULL(preview_dummy_xeno)
	qdel(src)

/datum/xeno_customization_picker/proc/update_preview_icon()
	if(preview_dummy_xeno?.caste_type != selected_caste)
		QDEL_NULL(preview_dummy_xeno)
	if(isnull(preview_dummy_xeno))
		switch(selected_caste)
			if(XENO_CASTE_PREDALIEN)
				preview_dummy_xeno = new /mob/living/carbon/xenomorph/predalien/tutorial(null, null, XENO_HIVE_TUTORIAL)
			else
				var/mob/living/carbon/xenomorph/xeno = GLOB.RoleAuthority.get_caste_by_text(selected_caste)
				preview_dummy_xeno = new xeno()
		preview_dummy_xeno.previewfy()

	// Apply modifications here

	preview_screen.vis_contents.Cut()
	preview_screen.vis_contents += preview_dummy_xeno

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
	data["selected_customizations"] = selected_preview_customizations[selected_caste]
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
			holder.prefs.save_and_sanitize_xeno_customization()
		if("preview")
			return
		if("change_caste")
			selected_caste = params["new_caste"]
			update_preview_icon()

/mob/living/carbon/xenomorph/proc/previewfy()
	GLOB.xeno_mob_list -= src
	GLOB.mob_list -= src
	GLOB.dead_mob_list -= src
	GLOB.alive_mob_list -= src
	change_real_name(src, "Test Dummy")
	status_flags = GODMODE|CANPUSH
	vis_flags = null
	plane = 91
