/// Assoc list: Caste Name - (Customization Name - Customization Datum)
GLOBAL_LIST_INIT_TYPED(xeno_customizations, /datum/xeno_customization_option, setup_all_xeno_customizations())

/proc/setup_all_xeno_customizations()
	var/list/data = list()
	for(var/customization in subtypesof(/datum/xeno_customization_option))
		var/datum/xeno_customization_option/select = new customization
		if(!select.caste)
			continue
		data["[select.caste]"] += list("[select.name]" = select)
	return data

/datum/xeno_customization_option
	var/name = "Call a coder!"
	var/customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	var/icon_path
	var/caste

/datum/xeno_customization_option/test
	name = "Test"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/test.dmi'
	caste = XENO_CASTE_CARRIER
