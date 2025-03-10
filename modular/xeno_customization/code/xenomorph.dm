/mob/living/carbon/xenomorph
	var/list/applied_skins = list()

/mob/living/carbon/xenomorph/update_icons()
	. = ..()
	SEND_SIGNAL(src, COMSIG_XENO_UPDATE_ICONS, icon_state)

/mob/living/carbon/xenomorph/verb/apply_skin()
	set name = "Apply Customization"
	set category = "Alien.Customization"

	var/list/available_skins = GLOB.xeno_customizations[caste.caste_type]
	if(!length(available_skins))
		to_chat(usr, SPAN_NOTICE("Sorry, no customizations available!"))
		return
	var/choice = tgui_input_list(usr, "What customization to apply?", "Xeno Customization", available_skins)
	if(!choice)
		return
	if(choice in applied_skins)
		to_chat(usr, SPAN_NOTICE("This customization is already applied!"))
		return
	applied_skins += choice
	AddComponent(/datum/component/xeno_customization, GLOB.xeno_customizations[caste.caste_type][choice])

/mob/living/carbon/xenomorph/verb/remove_skin()
	set name = "Remove Customization"
	set category = "Alien.Customization"

	if(!length(applied_skins))
		to_chat(usr, SPAN_NOTICE("You have no applied customizations."))
		return
	var/choice = tgui_input_list(usr, "What customization to remove?", "Xeno Customization", applied_skins)
	if(!choice)
		return
	var/list/datum/component/customizations = GetComponents(/datum/component/xeno_customization)
	if(!length(customizations))
		to_chat(usr, SPAN_WARNING("Something gone wrong - you have no component!"))
		return
	for(var/datum/component/xeno_customization/customization in customizations)
		if(customization.option.name == choice)
			qdel(customization)
			return
	to_chat(usr, SPAN_WARNING("Something gone wrong - we couldn't find it!"))
