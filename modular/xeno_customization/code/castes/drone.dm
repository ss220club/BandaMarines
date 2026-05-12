/datum/xeno_customization_option/drone
	abstract_type = /datum/xeno_customization_option/drone
	caste = XENO_CASTE_DRONE

/datum/xeno_customization_option/drone/socks
	name = "Носки"
	key = "drone_socks"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/drone/socks.dmi'
	slot = CUSTOMIZATION_SLOT_LEGS
	donation_level = 5

/datum/xeno_customization_option/drone/flashlight_tail
	name = "Фонарик на хвосте"
	key = "drone_flashlight_tail"
	customization_type = XENO_CUSTOMIZATION_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/drone/flashlight.dmi'
	slot = CUSTOMIZATION_SLOT_TAIL
	timelock = JOB_PLAYTIME_TIER_2
