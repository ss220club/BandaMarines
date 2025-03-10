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

/datum/xeno_customization_option/boiler_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/boiler/socks.dmi'
	caste = XENO_CASTE_BOILER

/datum/xeno_customization_option/carrier_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/carrier/socks.dmi'
	caste = XENO_CASTE_CARRIER

/datum/xeno_customization_option/defender_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/defender/socks.dmi'
	caste = XENO_CASTE_DEFENDER

/datum/xeno_customization_option/drone_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/drone/socks.dmi'
	caste = XENO_CASTE_DRONE

/datum/xeno_customization_option/hivelord_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/hivelord/socks.dmi'
	caste = XENO_CASTE_HIVELORD

/datum/xeno_customization_option/lurker_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/lurker/socks.dmi'
	caste = XENO_CASTE_LURKER

/datum/xeno_customization_option/ravager_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/ravager/socks.dmi'
	caste = XENO_CASTE_RAVAGER

/datum/xeno_customization_option/spitter_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/spitter/socks.dmi'
	caste = XENO_CASTE_SPITTER

/datum/xeno_customization_option/warrior_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/warrior/socks.dmi'
	caste = XENO_CASTE_BOILER
