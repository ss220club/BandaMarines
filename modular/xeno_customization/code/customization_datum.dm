/// Assoc list: Caste Name - (Customization Name - Customization Datum)
GLOBAL_LIST_INIT(xeno_customizations_by_caste, setup_all_xeno_customizations())
GLOBAL_LIST_EMPTY(xeno_customizations_by_key)

/proc/setup_all_xeno_customizations()
	var/list/data = list()
	for(var/customization in subtypesof(/datum/xeno_customization_option))
		var/datum/xeno_customization_option/select = new customization
		if(!select.caste)
			stack_trace("Xeno Customization [select.type] doesn't have a caste!")
			continue
		if(!select.icon_path)
			stack_trace("Xeno Customization [select.type] doesn't have an icon path!")
			continue
		if(!select.key)
			stack_trace("Xeno Customization [select.type] doesn't have a key!")
			continue
		data["[select.caste]"] += list("[select.name]" = select)
		if(GLOB.xeno_customizations_by_key["[select.key]"])
			stack_trace("Xeno Customization [select.type] has a duplicate key!")
		GLOB.xeno_customizations_by_key["[select.key]"] = select
	return data

/datum/xeno_customization_option
	var/name = "Call a coder!"
	/// Stored in database
	var/key
	var/customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	var/icon_path
	var/caste
	var/slot
	var/donation_level
	var/full_body_customization = FALSE

/datum/xeno_customization_option/proc/is_locked(mob/user)
	// Do it later when SSCentral is active
	if(donation_level)
		to_chat(user, SPAN_WARNING("У вас не хватает уровня подписки!"))
		return TRUE
	return FALSE
