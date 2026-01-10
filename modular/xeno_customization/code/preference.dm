/datum/preferences
	var/xeno_customization_visibility
	var/datum/xeno_customization_picker/xeno_customization_picker
	/// Stored in database
	var/xeno_customizations_string
	/// Assoc list - [caste_name][key] = datum
	var/list/xeno_customizations = list()

	var/mob/living/carbon/xenomorph/preview_dummy_xeno
	var/selected_caste = XENO_CASTE_RAVAGER
	var/selected_strain
	var/selected_position
	var/selected_dir = SOUTH

	var/atom/movable/screen/preview/preview_front_xeno
	var/atom/movable/screen/rotate/alt/rotate_left_xeno
	var/atom/movable/screen/rotate/rotate_right_xeno
	var/atom/movable/screen/preview/background_xeno

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
	var/bad_detected = FALSE
	var/list/sanitized_list = list()
	var/list/xeno_customization_list = splittext_char(xeno_customizations_string, ",")
	for(var/key in xeno_customization_list)
		var/datum/xeno_customization_option/option = GLOB.xeno_customizations_by_key[key]
		if(isnull(option))
			to_chat(owner, SPAN_ALERTWARNING("Кастомизация с ключём '[key]' была убрана у вас! Она больше не существует!"))
			bad_detected = TRUE
			continue
		var/is_locked_reasons = option.is_locked_with_reasons(owner)
		if(is_locked_reasons)
			to_chat(owner, SPAN_ALERTWARNING("Кастомизация '[option.name]' у '[option.caste]' была убрана у вас! Причина: [is_locked_reasons]"))
			bad_detected = TRUE
			continue
		sanitized_list += key
		xeno_customizations["[option.caste]"] += list(option.key = option)
	xeno_customizations_string = jointext(sanitized_list, ",")
	if(bad_detected)
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
	selected_dir = preview_dummy_xeno?.dir || selected_dir
	QDEL_NULL(preview_dummy_xeno)

/datum/preferences/update_preview_icon(refresh_limb_status)
	if(current_menu != "xeno")
		owner.remove_from_screen(preview_front_xeno)
		owner.remove_from_screen(rotate_left_xeno)
		owner.remove_from_screen(rotate_right_xeno)
		owner.remove_from_screen(background_xeno)
		return ..()
	owner.remove_from_screen(preview_front)
	owner.remove_from_screen(rotate_left)
	owner.remove_from_screen(rotate_right)
	if(preview_dummy_xeno?.caste_type != selected_caste)
		clear_xeno_dummy()
	if(isnull(preview_dummy_xeno))
		switch(selected_caste)
			if(XENO_CASTE_PREDALIEN)
				preview_dummy_xeno = new /mob/living/carbon/xenomorph/predalien/tutorial(null, null, XENO_HIVE_TUTORIAL)
			else
				var/mob/living/carbon/xenomorph/xeno = GLOB.RoleAuthority.get_caste_by_text(selected_caste)
				preview_dummy_xeno = new xeno(null, null, XENO_HIVE_TUTORIAL)
		preview_dummy_xeno.previewfy()
		preview_dummy_xeno.setDir(selected_dir)
		reset_xeno_customizations_for_preview()

	apply_xeno_customizations_to_preview()

	if(isnull(preview_front_xeno))
		preview_front_xeno = new()
		preview_front_xeno.screen_loc = "preview:0,-2:16"
	preview_front_xeno.vis_contents.Cut()
	preview_front_xeno.vis_contents += preview_dummy_xeno
	preview_front_xeno.icon_state = null
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

	if(isnull(background_xeno))
		background_xeno = new()
		background_xeno.screen_loc = "preview:-1,-1:-16 to 1,0:-16"
		background_xeno.name = "background"
	background_xeno.icon_state = bg_state
	owner.add_to_screen(background_xeno)

/datum/preferences/proc/apply_xeno_customizations_to_preview()
	var/list/previous_customizations = preview_dummy_xeno.GetComponents(/datum/component/xeno_customization)
	QDEL_LIST(previous_customizations)
	for(var/datum/xeno_customization_option/option_by_caste in selected_preview_customizations)
		preview_dummy_xeno.apply_xeno_customization(owner.mob, to_apply = option_by_caste, force = TRUE, override_viewers = list(owner.mob))

/datum/preferences/proc/reset_xeno_customizations_for_preview()
	selected_position = "Ходьба"
	selected_strain = preview_dummy_xeno.strain?.name || "Normal"
	selected_preview_customizations = list()
	for(var/option_key in xeno_customizations[selected_caste])
		var/datum/xeno_customization_option/option_by_caste = GLOB.xeno_customizations_by_key[option_key]
		selected_preview_customizations += option_by_caste

/datum/preferences/proc/add_xeno_customization_for_preview(customization_key)
	var/datum/xeno_customization_option/new_customization = GLOB.xeno_customizations_by_key[customization_key]
	if(isnull(new_customization))
		to_chat(owner.mob, SPAN_WARNING("Кастомизации с ключём '[customization_key]' не существует."))
		return
	if(new_customization in selected_preview_customizations)
		selected_preview_customizations -= new_customization
		if(xeno_customizations[new_customization.caste])
			xeno_customizations[new_customization.caste] -= new_customization.key
		save_and_sanitize_xeno_customization()
		update_preview_icon()
		return
	if(!preview_dummy_xeno.apply_xeno_customization(owner.mob, to_apply = new_customization, force = TRUE, override_viewers = list(owner.mob)))
		return
	selected_preview_customizations += new_customization
	if(!new_customization.is_locked_with_reasons(owner))
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

/datum/preferences/proc/change_preview_xeno_strain(strain)
	if(strain == "Normal")
		if(selected_strain != strain)
			selected_strain = strain
			clear_xeno_dummy()
			update_preview_icon()
		return
	var/datum/xeno_strain/strain_to_apply
	for(var/strain_path in preview_dummy_xeno.caste.available_strains)
		var/datum/xeno_strain/strain_to_check = strain_path
		if(strain_to_check::name == strain)
			strain_to_apply = new strain_to_check()
			break
	if(!strain_to_apply)
		to_chat(owner, SPAN_WARNING("Подвид [strain] не найден для [preview_dummy_xeno.caste.caste_type]!"))
		return
	if(strain_to_apply._add_to_xeno(preview_dummy_xeno))
		selected_strain = strain
		update_preview_icon()

/datum/preferences/proc/change_preview_xeno_positions(new_position)
	preview_dummy_xeno.rejuvenate()
	preview_dummy_xeno.previewfy()
	preview_dummy_xeno.body_position = STANDING_UP
	REMOVE_TRAIT(preview_dummy_xeno, TRAIT_FLOORED, "preview")
	switch(new_position)
		if("Ходьба")
			selected_position = "Ходьба"
		if("Отдых")
			selected_position = "Отдых"
			preview_dummy_xeno.body_position = LYING_DOWN
		if("Оглушение")
			selected_position = "Оглушение"
			ADD_TRAIT(preview_dummy_xeno, TRAIT_FLOORED, "preview")
		if("Мёртв")
			selected_position = "Мёртв"
			preview_dummy_xeno.death()
		else
			to_chat(owner, SPAN_WARNING("Неизвестная позиция ксеноморфа: [new_position]"))
	preview_dummy_xeno.update_icons()
