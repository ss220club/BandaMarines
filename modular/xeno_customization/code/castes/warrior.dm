/datum/xeno_customization_option/warrior
	abstract_type = /datum/xeno_customization_option/warrior
	caste = XENO_CASTE_WARRIOR

/datum/xeno_customization_option/warrior/socks
	name = "Носки"
	key = "warrior_socks"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/warrior/socks.dmi'
	slot = CUSTOMIZATION_SLOT_LEGS
	donation_level = 5

/datum/xeno_customization_option/warrior/rouny
	name = "Rouny"
	key = "warrior_rouny"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/warrior/rouny.dmi'
	slot = CUSTOMIZATION_SLOT_ALL
	full_body_customization = TRUE
	donation_level = 5

// Author: @piromage
/datum/xeno_customization_option/warrior/beast
	name = "Бестия"
	key = "warrior_beast"
	customization_type = XENO_CUSTOMIZATION_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/warrior/beast.dmi'
	subtract_icon_path = 'modular/xeno_customization/icons/warrior/beast_subtract.dmi'
	slot = CUSTOMIZATION_SLOT_ARMS|CUSTOMIZATION_SLOT_BODY|CUSTOMIZATION_SLOT_HEAD|CUSTOMIZATION_SLOT_TAIL
	timelock = JOB_PLAYTIME_TIER_2
	strain = "Normal"
