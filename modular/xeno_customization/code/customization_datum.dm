GLOBAL_LIST_EMPTY(xeno_customizations_by_key)
/// Assoc list: Caste Name - (Customization Key - Customization Datum)
GLOBAL_LIST_INIT(xeno_customizations_by_caste, setup_all_xeno_customizations())

/proc/setup_all_xeno_customizations()
	var/list/data = list()
	for(var/customization_path in subtypesof(/datum/xeno_customization_option))
		var/datum/xeno_customization_option/select = new customization_path()
		if(select.abstract_type == customization_path)
			qdel(select)
			continue
		if(!select.is_correctly_configured())
			continue
		data["[select.caste]"] += list("[select.key]" = select)
		if(GLOB.xeno_customizations_by_key["[select.key]"])
			stack_trace("Xeno Customization [select.type] has a duplicate key!")
			continue
		GLOB.xeno_customizations_by_key["[select.key]"] = select
	return data

/*
	Icon States for universal customizations (strains included) must include ONLY the "state":
		*Walking
		*Running
		*Knocked Down
		*Sleeping
		*Dead
		...etc
	Full body replacement must include FULL ICON STATE name:
		*Normal Runner Walking
		*Normal Runner Running
		*Normal Runner Knocked Down
		*Normal Runner Sleeping
		*Normal Runner Dead
		...etc
*/

/datum/xeno_customization_option
	/// The abstract parent of this customization option, to determine which options to not instantiate
	var/abstract_type = /datum/xeno_customization_option
	/// UI name
	var/name = "Call a coder!"
	/// Stored in database
	var/key
	/// Whom to show this customization to
	var/customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	/// Icon Path for the customization
	var/icon_path
	/// Icon Path for substracting from the original icon; Any color is fine
	var/subtract_icon_path
	/// Caste this customization restricted to
	var/caste
	/// Strain this customization restricted to
	var/strain
	/// Slots this customization uses; can't use multiple customizations with the same slot.
	var/slot
	/// Do we completely replace the original icon; these icon states need to fully replicate icon state name, ie "Normal Runner Walking"
	var/full_body_customization = FALSE
	// Restrictions
	/// Required time played as that caste
	var/timelock = JOB_PLAYTIME_TIER_0
	/// Required donation tier
	var/donation_level = 0

/datum/xeno_customization_option/proc/is_locked_with_reasons(client/user)
	. = null
	// Do it later when SSCentral is active
	if(donation_level)
		. += "Необходим уровень подписки: [donation_level]. "
	if(timelock)
		if(get_job_playtime(user, caste) < timelock)
			var/hours = timelock / (1 HOURS)
			. += "Необходимое время на этой касте: [hours] час[declension_ru(hours, "", "а", "ов")]. "
	return .

/datum/xeno_customization_option/proc/is_correctly_configured()
	. = TRUE
	if(!caste)
		. = FALSE
		stack_trace("Xeno Customization [type] doesn't have a caste!")
	if(!icon_path)
		. = FALSE
		stack_trace("Xeno Customization [type] doesn't have an icon path!")
	if(!key)
		. = FALSE
		stack_trace("Xeno Customization [type] doesn't have a key!")

	if(!.)
		return .

	if(full_body_customization)
		return check_full_body_states()
	return check_states()

/datum/xeno_customization_option/proc/check_states()
	. = TRUE
	for(var/movement_state in REQUIRED_ICON_STATES)
		if(movement_state in icon_states(icon_path))
			continue
		. = FALSE
		stack_trace("Xeno Customization [type] doesn't contain '[movement_state]' icon state! Review naming convention!")
	return .

/datum/xeno_customization_option/proc/check_full_body_states()
	. = TRUE
	var/datum/caste_datum/caste_datum = GLOB.xeno_datum_list[caste]
	var/list/strains = list("Normal")
	if(strain)
		strains = list(strain)
	else
		if(length(caste_datum.available_strains))
			for(var/datum/xeno_strain/xeno_strain_type in caste_datum.available_strains)
				strains += xeno_strain_type::name

	for(var/strain_type in strains)
		var/list/icon_states = icon_states(icon_path)
		var/list/subtract_icon_states = icon_states(subtract_icon_path)
		for(var/movement_state in REQUIRED_ICON_STATES)
			var/required_icon_state = "[strain_type] [caste] [movement_state]"
			if(!(required_icon_state in icon_states))
				. = FALSE
				stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' icon state! Review naming convention!")
			if(subtract_icon_path && !(required_icon_state in subtract_icon_states))
				. = FALSE
				stack_trace("Xeno Customization [type] doesn't contain '[required_icon_state]' subtract icon state! Review naming convention!")
	return .
