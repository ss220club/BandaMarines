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
	var/datum/xeno_customization_option/choosen_customization = GLOB.xeno_customizations[caste.caste_type][choice]

	var/list/datum/component/xeno_customization/applied_customizations = GetComponents(/datum/component/xeno_customization)
	var/list/conflicting_names = list()
	for(var/datum/component/xeno_customization/applied_customization in applied_customizations)
		if(applied_customization.option.name == choice)
			to_chat(usr, SPAN_NOTICE("This customization is already applied!"))
			return
		if(choosen_customization.slot & applied_customization.option.slot)
			conflicting_names += "[applied_customization.option.name]"
	if(length(conflicting_names))
		to_chat(usr, SPAN_WARNING("У [choosen_customization.name] конфликт с: [english_list(conflicting_names)]"))
		return

	AddComponent(/datum/component/xeno_customization, choosen_customization)

/mob/living/carbon/xenomorph/verb/remove_skin()
	set name = "Remove Customization"
	set category = "Alien.Customization"

	var/list/datum/component/xeno_customization/applied_customizations = GetComponents(/datum/component/xeno_customization)
	if(!length(applied_customizations))
		to_chat(usr, SPAN_WARNING("You have no applied customizations."))
		return
	var/list/options = list()
	for(var/datum/component/xeno_customization/applied_customization in applied_customizations)
		options["[applied_customization.option.name]"] = applied_customization
	var/choice = tgui_input_list(usr, "What customization to remove?", "Xeno Customization", options)
	if(!choice)
		return
	qdel(options["[choice]"])
