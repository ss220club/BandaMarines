/datum/preferences
	var/xeno_customization_visibility
	var/datum/xeno_customization_picker/xeno_customization_picker
	/// Stored in database
	var/xeno_customizations_string
	/// Assoc list - [caste_name][key] = datum
	var/list/xeno_customizations = list()

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "xeno_customization_visibility")
		var/choice = tgui_input_list(user, "What is your lore preference?", "Xeno Customization Visibility", GLOB.xeno_customization_visibility_options)
		if(!choice)
			return
		xeno_customization_visibility = choice
		SEND_SIGNAL(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	if(href_list["preference"] == "xeno_customization_picker")
		if(!xeno_customization_picker)
			xeno_customization_picker = new(src)
		xeno_customization_picker.tgui_interact()
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
		xeno_customizations["[option.caste]"][key] = option
	xeno_customizations_string = jointext(sanitized_list, ",")
	save_preferences()

/datum/preferences/proc/save_and_sanitize_xeno_customization()
	var/list/sanitized_list = list()
	for(var/caste in xeno_customizations)
		for(var/key in caste)
			if(!GLOB.xeno_customizations_by_key[key])
				continue
			sanitized_list += key

	xeno_customizations_string = jointext(sanitized_list, ",")
	save_preferences()
