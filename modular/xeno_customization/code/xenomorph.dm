/mob/living/carbon/xenomorph/Initialize(mapload, mob/living/carbon/xenomorph/old_xeno, hivenumber)
	. = ..()
	AddComponent(/datum/component/xeno_customization, XENO_CUSTOMIZATION_NON_LORE_FRIENDLY, 'modular/xeno_customization/icons/test.dmi')

/mob/living/carbon/xenomorph/update_icons()
	. = ..()
	SEND_SIGNAL(src, COMSIG_XENO_UPDATE_ICONS, icon_state)
