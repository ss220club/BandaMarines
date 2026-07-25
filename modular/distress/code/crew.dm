/datum/crew_manifest/proc/is_upp_mode()
	return istype(SSticker.mode, /datum/game_mode/colonialmarines/upp)

/datum/crew_manifest/proc/get_departments()
	if(is_upp_mode())
		return list(
			"Command" = GLOB.ROLES_CIC_ANTAG,
			"Auxiliary" = GLOB.ROLES_AUXIL_SUPPORT_ANTAG,
			"Security" = GLOB.ROLES_POLICE_ANTAG,
			"Engineering" = GLOB.ROLES_ENGINEERING_ANTAG,
			"Requisitions" = GLOB.ROLES_REQUISITION_ANTAG,
			"Medical" = GLOB.ROLES_MEDICAL_ANTAG,
			"Miscellaneous" = GLOB.ROLES_MISC_ANTAG
		)

	return list(
		"Command" = GLOB.ROLES_CIC,
		"Auxiliary" = GLOB.ROLES_AUXIL_SUPPORT,
		"Security" = GLOB.ROLES_POLICE,
		"Engineering" = GLOB.ROLES_ENGINEERING,
		"Requisitions" = GLOB.ROLES_REQUISITION,
		"Medical" = GLOB.ROLES_MEDICAL,
		"Miscellaneous" = GLOB.ROLES_MISC
	)
