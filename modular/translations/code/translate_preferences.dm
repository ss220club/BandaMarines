/datum/preferences
	var/declined_name

/datum/preferences/copy_appearance_to(mob/living/carbon/human/character, safety)
	. = ..()
	if(!declined_name || read_declined_name(NOMINATIVE) != real_name)
		return
	character.ru_names_rename(ru_names_list(
		base = real_name,
		nominative = read_declined_name(NOMINATIVE),
		genitive = read_declined_name(GENITIVE),
		dative = read_declined_name(DATIVE),
		accusative = read_declined_name(ACCUSATIVE),
		instrumental = read_declined_name(INSTRUMENTAL),
		prepositional = read_declined_name(PREPOSITIONAL),
		gender = gender,
	))

/datum/preferences/copy_all_to(mob/living/carbon/human/character, job_title, is_late_join, check_datacore)
	. = ..()
	if(!declined_name || read_declined_name(NOMINATIVE) != real_name)
		return
	character.ru_names_rename(ru_names_list(
		base = real_name,
		nominative = read_declined_name(NOMINATIVE),
		genitive = read_declined_name(GENITIVE),
		dative = read_declined_name(DATIVE),
		accusative = read_declined_name(ACCUSATIVE),
		instrumental = read_declined_name(INSTRUMENTAL),
		prepositional = read_declined_name(PREPOSITIONAL),
		gender = gender,
	))

/datum/preferences/proc/read_declined_name(decline = NOMINATIVE)
	if(!declined_name)
		return ""
	var/list/declines = splittext_char(declined_name, ",")
	if(length(declines) != 6)
		return ""
	switch(decline)
		if(NOMINATIVE)
			return declines[1]
		if(GENITIVE)
			return declines[2]
		if(DATIVE)
			return declines[3]
		if(ACCUSATIVE)
			return declines[4]
		if(INSTRUMENTAL)
			return declines[5]
		if(PREPOSITIONAL)
			return declines[6]

/datum/preferences/proc/sanitize_declined_name()
	var/list/declines = splittext_char(declined_name, ",")
	if(length(declines) != 6)
		return ""
	if(read_declined_name(NOMINATIVE) != real_name)
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
	data["nominative"] = user.client.prefs.read_declined_name(NOMINATIVE)
	data["genitive"] = user.client.prefs.read_declined_name(GENITIVE)
	data["dative"] = user.client.prefs.read_declined_name(DATIVE)
	data["accusative"] = user.client.prefs.read_declined_name(ACCUSATIVE)
	data["instrumental"] = user.client.prefs.read_declined_name(INSTRUMENTAL)
	data["prepositional"] = user.client.prefs.read_declined_name(PREPOSITIONAL)
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
			usr.client.prefs.declined_name = "[declined_names[1]],[declined_names[2]],[declined_names[3]],[declined_names[4]],[declined_names[5]],[declined_names[6]]"
			to_chat(usr, SPAN_NOTICE("Успешно обновлено склонение вашего имени по падежам!"))
			ui.close()
