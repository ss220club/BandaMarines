/datum/xeno_customization_option/larva_mister
	name = "Мистер-лярва"
	key = "larva_mister"
	customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY
	icon_path = 'modular/xeno_customization/icons/larva/mister.dmi'
	caste = XENO_CASTE_LARVA
	slot = CUSTOMIZATION_SLOT_ALL
	full_body_customization = TRUE
	var/total_timelock = JOB_PLAYTIME_TIER_3

/datum/xeno_customization_option/larva_mister/is_locked_with_reasons(client/user)
	. = ..()
	if(user.get_total_xeno_playtime() < total_timelock)
		var/hours = total_timelock / (1 HOURS)
		. += "Необходимое время на ксеноморфах: [hours] час[declension_ru(hours, "", "а", "ов")]. "
	return .
