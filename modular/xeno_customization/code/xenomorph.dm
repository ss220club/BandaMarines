/mob/living/carbon/xenomorph/update_icons()
	. = ..()
	SEND_SIGNAL(src, COMSIG_XENO_UPDATE_ICONS, icon_state)

/mob/living/carbon/xenomorph/verb/apply_skin()
	set name = "Добавить кастомизацию"
	set category = "Alien.Customization"

	var/list/available_skins = GLOB.xeno_customizations[caste.caste_type]
	if(!length(available_skins))
		to_chat(src, SPAN_NOTICE("Извините, нет доступных кастомизаций!"))
		return

	var/choice = tgui_input_list(src, "Какую кастомизацию добавить?", "Кастомизация Ксеноморфа", available_skins)
	if(!choice)
		return
	var/datum/xeno_customization_option/choosen_customization = GLOB.xeno_customizations[caste.caste_type][choice]
	if(choosen_customization.is_locked(src))
		return

	var/list/datum/component/xeno_customization/applied_customizations = GetComponents(/datum/component/xeno_customization)
	var/list/conflicting_names = list()
	for(var/datum/component/xeno_customization/applied_customization in applied_customizations)
		if(applied_customization.option.name == choice)
			to_chat(src, SPAN_NOTICE("Эта кастомизация уже имеется!"))
			return
		if(choosen_customization.slot & applied_customization.option.slot)
			conflicting_names += "[applied_customization.option.name]"
	if(length(conflicting_names))
		to_chat(src, SPAN_WARNING("У [choosen_customization.name] конфликт с: [english_list(conflicting_names)]"))
		return

	AddComponent(/datum/component/xeno_customization, choosen_customization)

/mob/living/carbon/xenomorph/verb/remove_skin()
	set name = "Убрать кастомизацию"
	set category = "Alien.Customization"

	var/list/datum/component/xeno_customization/applied_customizations = GetComponents(/datum/component/xeno_customization)
	if(!length(applied_customizations))
		to_chat(src, SPAN_WARNING("У вас нет задейственных кастомизаций."))
		return
	var/list/options = list()
	for(var/datum/component/xeno_customization/applied_customization in applied_customizations)
		options["[applied_customization.option.name]"] = applied_customization
	var/choice = tgui_input_list(src, "Какую кастомизацию убрать?", "Кастомизация Ксеноморфа", options)
	if(!choice)
		return
	qdel(options["[choice]"])
