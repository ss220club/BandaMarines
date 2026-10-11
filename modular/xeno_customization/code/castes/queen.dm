/datum/xeno_customization_option/queen
	abstract_type = /datum/xeno_customization_option/queen
	caste = XENO_CASTE_QUEEN

/datum/xeno_customization_option/queen/socks
	name = "Носки"
	key = "queen_socks"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/queen/socks.dmi'
	slot = CUSTOMIZATION_SLOT_LEGS
	donation_level = 5

/datum/xeno_customization_option/queen/dress
	name = "Платье"
	key = "queen_dress"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/queen/dress.dmi'
	slot = CUSTOMIZATION_SLOT_LEGS|CUSTOMIZATION_SLOT_BODY|CUSTOMIZATION_SLOT_ARMS|CUSTOMIZATION_SLOT_HEAD
	donation_level = 5
