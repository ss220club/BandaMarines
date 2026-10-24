/datum/xeno_customization_option/ravager
	abstract_type = /datum/xeno_customization_option/ravager
	caste = XENO_CASTE_RAVAGER

/datum/xeno_customization_option/ravager/socks
	name = "Носки"
	key = "ravager_socks"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/ravager/socks.dmi'
	slot = CUSTOMIZATION_SLOT_LEGS
	donation_level = 5

/datum/xeno_customization_option/ravager/berserker_veteran
	name = "(Берсерк) Ветеран второй ксеновской"
	key = "ravager_berserker_veteran"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/ravager/berserker_veteran.dmi'
	subtract_icon_path = 'modular/xeno_customization/icons/ravager/berserker_veteran_subtract.dmi'
	strain = RAVAGER_BERSERKER
	slot = CUSTOMIZATION_SLOT_TAIL | CUSTOMIZATION_SLOT_ARMS
	timelock = JOB_PLAYTIME_TIER_2
