/datum/preferences
	var/xeno_customization_visibility
	var/datum/xeno_customization_picker/xeno_customization_picker
	/// Stored in database
	var/xeno_customizations_string
	/// Assoc list - [caste_name][key] = datum
	var/list/xeno_customizations = list()

	var/mob/living/carbon/xenomorph/preview_dummy_xeno
	var/selected_caste = XENO_CASTE_RAVAGER

	var/atom/movable/screen/preview/preview_front_xeno
	var/atom/movable/screen/rotate/alt/rotate_left_xeno
	var/atom/movable/screen/rotate/rotate_right_xeno

	/// Reference list for previewing
	var/list/datum/xeno_customization_option/selected_preview_customizations = list()

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "xeno_customization_visibility")
		var/choice = tgui_input_list(user, "What is your lore preference?", "Xeno Customization Visibility", GLOB.xeno_customization_visibility_options)
		if(!choice)
			return
		xeno_customization_visibility = choice
		SEND_SIGNAL(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	if(href_list["preference"] == "xeno_customization_picker")
		if(!xeno_customization_picker)
			xeno_customization_picker = new(user.client)
	. = ..()

/datum/preferences/proc/read_and_sanitize_xeno_customization()
	xeno_customizations = list()
	var/list/sanitized_list = list()
	var/list/xeno_customization_list = splittext_char(xeno_customizations_string, ",")
	for(var/key in xeno_customization_list)
		var/datum/xeno_customization_option/option = GLOB.xeno_customizations_by_key[key]
		if(isnull(option))
			continue
		sanitized_list += key
		xeno_customizations["[option.caste]"] += list(key = option)
	xeno_customizations_string = jointext(sanitized_list, ",")
	save_preferences()

/// Is not updating Database values! Only for in-round customizations. Save Preferences button WILL save to DataBase.
/datum/preferences/proc/save_and_sanitize_xeno_customization()
	var/list/sanitized_list = list()
	for(var/caste in xeno_customizations)
		for(var/key in xeno_customizations[caste])
			if(!GLOB.xeno_customizations_by_key[key])
				continue
			sanitized_list += key

	xeno_customizations_string = jointext(sanitized_list, ",")

/datum/preferences/proc/clear_xeno_dummy()
	SIGNAL_HANDLER
	QDEL_NULL(preview_dummy_xeno)

/datum/preferences/update_preview_icon(refresh_limb_status)
	if(current_menu != "xeno")
		owner.remove_from_screen(preview_front_xeno)
		owner.remove_from_screen(rotate_left_xeno)
		owner.remove_from_screen(rotate_right_xeno)
		return ..()
	owner.remove_from_screen(preview_front)
	owner.remove_from_screen(rotate_left)
	owner.remove_from_screen(rotate_right)
	if(preview_dummy_xeno?.caste_type != selected_caste)
		QDEL_NULL(preview_dummy_xeno)
	if(isnull(preview_dummy_xeno))
		reset_xeno_customizations_for_preview()
		switch(selected_caste)
			if(XENO_CASTE_PREDALIEN)
				preview_dummy_xeno = new /mob/living/carbon/xenomorph/predalien/tutorial(null, null, XENO_HIVE_TUTORIAL)
			else
				var/mob/living/carbon/xenomorph/xeno = GLOB.RoleAuthority.get_caste_by_text(selected_caste)
				preview_dummy_xeno = new xeno(null, null, XENO_HIVE_TUTORIAL)
		preview_dummy_xeno.previewfy()

	apply_xeno_customizations_to_preview()

	if(isnull(preview_front_xeno))
		preview_front_xeno = new()
		preview_front_xeno.screen_loc = "preview:0,-2:16"
	preview_front_xeno.vis_contents.Cut()
	preview_front_xeno.vis_contents += preview_dummy_xeno
	preview_front_xeno.icon_state = bg_state
	owner.remove_from_screen(preview_front_xeno)
	owner.add_to_screen(preview_front_xeno)

	var/matrix/increased_button = new()
	increased_button.Scale(3,3)
	if(isnull(rotate_left_xeno))
		rotate_left_xeno = new(null, preview_dummy_xeno)
		rotate_left_xeno.screen_loc = "preview:-2,-1"
		rotate_left_xeno.transform = increased_button
	rotate_left_xeno.assigned_atom = preview_dummy_xeno
	owner.add_to_screen(rotate_left_xeno)

	if(isnull(rotate_right_xeno))
		rotate_right_xeno = new(null, preview_dummy_xeno)
		rotate_right_xeno.screen_loc = "preview:2,-1"
		rotate_right_xeno.transform = increased_button
	rotate_right_xeno.assigned_atom = preview_dummy_xeno
	owner.add_to_screen(rotate_right_xeno)

/datum/preferences/proc/apply_xeno_customizations_to_preview()
	var/list/previous_customizations = preview_dummy_xeno.GetComponents(/datum/component/xeno_customization)
	QDEL_LIST(previous_customizations)
	for(var/datum/xeno_customization_option/option_by_caste as anything in selected_preview_customizations)
		preview_dummy_xeno.apply_xeno_customization(owner.mob, option_by_caste, force = TRUE)

/datum/preferences/proc/reset_xeno_customizations_for_preview()
	selected_preview_customizations = list()
	for(var/option_key as anything in xeno_customizations[selected_caste])
		var/datum/xeno_customization_option/option_by_caste = xeno_customizations[selected_caste][option_key]
		selected_preview_customizations += option_by_caste

/datum/preferences/proc/add_xeno_customization_for_preview(customization_key)
	var/datum/xeno_customization_option/new_customization = GLOB.xeno_customizations_by_key[customization_key]
	if(isnull(new_customization))
		to_chat(owner.mob, SPAN_WARNING("Кастомизации с ключём '[customization_key]' не существует."))
		return
	if(new_customization in selected_preview_customizations)
		selected_preview_customizations -= new_customization
		xeno_customizations[new_customization.caste] -= new_customization.key
		save_and_sanitize_xeno_customization()
		update_preview_icon()
		return
	if(!preview_dummy_xeno.apply_xeno_customization(owner.mob, new_customization, force = TRUE))
		return
	selected_preview_customizations += new_customization
	if(!new_customization.is_locked_with_reasons(owner.mob))
		var/list/new_entry = list(new_customization.key = new_customization)
		xeno_customizations[new_customization.caste] += new_entry
		save_and_sanitize_xeno_customization()
	update_preview_icon()

/datum/preferences/proc/change_preview_xeno(caste)
	if(!(caste in ALL_XENO_CASTES))
		to_chat(owner.mob, SPAN_WARNING("Каста '[caste]' не существует!"))
		return
	selected_caste = caste
	update_preview_icon()
