/datum/preferences
	var/declined_name

/datum/preferences/copy_appearance_to(mob/living/carbon/human/character, safety)
	. = ..()
	apply_declined_name(character)

/datum/preferences/copy_all_to(mob/living/carbon/human/character, job_title, is_late_join, check_datacore)
	. = ..()
	apply_declined_name(character)

/datum/preferences/proc/apply_declined_name(mob/living/carbon/human/character)
	if(!declined_name)
		return
	var/list/declined_list = declined_name_to_list()
	if(declined_list[NOMINATIVE] != real_name)
		return
	character.ru_names_rename(ru_names_list(
		base = real_name,
		nominative = declined_list[NOMINATIVE],
		genitive = declined_list[GENITIVE],
		dative = declined_list[DATIVE],
		accusative = declined_list[ACCUSATIVE],
		instrumental = declined_list[INSTRUMENTAL],
		prepositional = declined_list[PREPOSITIONAL],
		gender = gender,
	))

/datum/preferences/proc/declined_name_to_list()
	var/list/assoc_list = list()
	assoc_list[NOMINATIVE] = ""
	assoc_list[GENITIVE] = ""
	assoc_list[DATIVE] = ""
	assoc_list[ACCUSATIVE] = ""
	assoc_list[INSTRUMENTAL] = ""
	assoc_list[PREPOSITIONAL] = ""
	. = assoc_list
	if(!declined_name)
		return assoc_list
	var/list/declines = splittext_char(declined_name, ",")
	if(length(declines) != 6)
		return assoc_list
	assoc_list[NOMINATIVE] = declines[1]
	assoc_list[GENITIVE] = declines[2]
	assoc_list[DATIVE] = declines[3]
	assoc_list[ACCUSATIVE] = declines[4]
	assoc_list[INSTRUMENTAL] = declines[5]
	assoc_list[PREPOSITIONAL] = declines[6]
	return assoc_list

/datum/preferences/proc/sanitize_declined_name()
	var/list/declines = splittext_char(declined_name, ",")
	if(length(declines) != 6)
		return ""
	var/list/declined_list = declined_name_to_list()
	if(declined_list[NOMINATIVE] != real_name)
		return ""
	return declined_name

/datum/decline_name_editor
	var/name = "Редактор склонений имени"

/datum/decline_name_editor/ui_state(mob/user)
	return GLOB.always_state

/datum/decline_name_editor/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DeclineNameEditor", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/decline_name_editor/ui_data(mob/user)
	var/list/data = list()
	var/list/declined_list = user.client.prefs.declined_name_to_list()
	data["nominative"] = declined_list[NOMINATIVE]
	data["genitive"] = declined_list[GENITIVE]
	data["dative"] = declined_list[DATIVE]
	data["accusative"] = declined_list[ACCUSATIVE]
	data["instrumental"] = declined_list[INSTRUMENTAL]
	data["prepositional"] = declined_list[PREPOSITIONAL]
	return data

/datum/decline_name_editor/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	if(..())
		return
	. = TRUE

	switch(action)
		if("confirm")
			var/list/declined_names = params["declinedNames"]
			if(length(declined_names) != 6)
				to_chat(usr, SPAN_WARNING("Не было выбрано склонение для всех имён!"))
				return
			if(declined_names[1] != usr.client.prefs.real_name)
				to_chat(usr, SPAN_WARNING("Именительный падеж не совпадает с именем персонажа!"))
				return
			usr.client.prefs.declined_name = jointext(declined_names, ",")
			to_chat(usr, SPAN_NOTICE("Успешно обновлено склонение вашего имени по падежам!"))
			ui.close()
