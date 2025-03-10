/// Assoc list: Caste Name - (Customization Name - Customization Datum)
GLOBAL_LIST_INIT_TYPED(xeno_customizations, /datum/xeno_customization_option, setup_all_xeno_customizations())

#define CUSTOMIZATION_SLOT_LEGS (1<<0)
#define CUSTOMIZATION_SLOT_BODY (1<<1)
#define CUSTOMIZATION_SLOT_ARMS (1<<2)
#define CUSTOMIZATION_SLOT_HEAD (1<<3)
#define CUSTOMIZATION_SLOT_TAIL (1<<4)

/proc/setup_all_xeno_customizations()
	var/list/data = list()
	for(var/customization in subtypesof(/datum/xeno_customization_option))
		var/datum/xeno_customization_option/select = new customization
		if(!select.caste)
			continue
		if(!select.icon_path)
			continue
		data["[select.caste]"] += list("[select.name]" = select)
	return data

/datum/xeno_customization_option
	var/name = "Call a coder!"
	var/customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	var/icon_path
	var/caste
	var/slot

/datum/xeno_customization_option/boiler_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/boiler/socks.dmi'
	caste = XENO_CASTE_BOILER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/carrier_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/carrier/socks.dmi'
	caste = XENO_CASTE_CARRIER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/defender_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/defender/socks.dmi'
	caste = XENO_CASTE_DEFENDER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/drone_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/drone/socks.dmi'
	caste = XENO_CASTE_DRONE
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/hivelord_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/hivelord/socks.dmi'
	caste = XENO_CASTE_HIVELORD
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/lurker_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/lurker/socks.dmi'
	caste = XENO_CASTE_LURKER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/praetorian_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/praetorian/socks.dmi'
	caste = XENO_CASTE_PRAETORIAN
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/queen_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/queen/socks.dmi'
	caste = XENO_CASTE_QUEEN
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/queen_dress
	name = "Платье"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/queen/dress.dmi'
	caste = XENO_CASTE_QUEEN
	slot = CUSTOMIZATION_SLOT_LEGS|CUSTOMIZATION_SLOT_BODY|CUSTOMIZATION_SLOT_ARMS|CUSTOMIZATION_SLOT_HEAD

/datum/xeno_customization_option/ravager_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/ravager/socks.dmi'
	caste = XENO_CASTE_RAVAGER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/spitter_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/spitter/socks.dmi'
	caste = XENO_CASTE_SPITTER
	slot = CUSTOMIZATION_SLOT_LEGS

/datum/xeno_customization_option/warrior_socks
	name = "Чулочки"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/warrior/socks.dmi'
	caste = XENO_CASTE_BOILER
	slot = CUSTOMIZATION_SLOT_LEGS

#undef CUSTOMIZATION_SLOT_LEGS
#undef CUSTOMIZATION_SLOT_BODY
#undef CUSTOMIZATION_SLOT_ARMS
#undef CUSTOMIZATION_SLOT_HEAD
#undef CUSTOMIZATION_SLOT_TAIL
