/datum/config_entry/flag/panic_bunker_enabled

/datum/config_entry/number/panic_bunker_min_alive_playtime_hours
	config_entry_value = 1

/client/proc/toggle_panic_bunker()
	set name = "Toggle Panic Bunker"
	set desc = "Enables/Disables Panic Bunker"
	set category = "Server.Panic"

	if(!check_rights(R_SERVER))
		return

	var/confirm = tgui_alert(usr, "Вы уверены, что хотите [CONFIG_GET(flag/panic_bunker_enabled) ? "выключить" : "включить"] Panic Bunker?", "Toggle Panic Bunker", list("Да", "Нет"))
	if(confirm != "Да")
		return

	CONFIG_SET(flag/panic_bunker_enabled, !CONFIG_GET(flag/panic_bunker_enabled))
	log_admin("[key_name(usr)] toggled Panic Bunker. New value - [CONFIG_GET(flag/panic_bunker_enabled)]")
	message_admins("[key_name(usr)] toggled Panic Bunker. New value - [CONFIG_GET(flag/panic_bunker_enabled)]")

/client/proc/change_panic_bunker_time()
	set name = "Change Panic Bunker Time"
	set desc = "Changes Panic Bunker Time"
	set category = "Server.Panic"

	if(!check_rights(R_SERVER))
		return

	var/confirm = tgui_alert(usr, "Вы уверены, что хотите сменить минимальное количество часов для прохождения Panic Bunker? Текущее - [CONFIG_GET(number/panic_bunker_min_alive_playtime_hours)]", "Change Panic Bunker Hours", list("Да", "Нет"))
	if(confirm != "Да")
		return

	var/new_hours = tgui_input_number(usr,"Введите новое количество часов", "Change Panic Bunker Hours", CONFIG_GET(number/panic_bunker_min_alive_playtime_hours), 100, 1)
	if(!new_hours)
		return

	CONFIG_SET(number/panic_bunker_min_alive_playtime_hours, new_hours)
	log_admin("[key_name(usr)] changed Panic Bunker hours. New value - [CONFIG_GET(number/panic_bunker_min_alive_playtime_hours)] hours")
	message_admins("[key_name(usr)] changed Panic Bunker hours. New value - [CONFIG_GET(number/panic_bunker_min_alive_playtime_hours)] hours")

/client/proc/check_panic_bunker()
	if(CLIENT_IS_STAFF(src))
		return
	var/total_alive_playtime = round(src.get_total_human_playtime(TRUE) DECISECONDS_TO_HOURS, 0.1) + round(src.get_total_xeno_playtime(TRUE) DECISECONDS_TO_HOURS, 0.1)
	if(CONFIG_GET(flag/panic_bunker_enabled) && CONFIG_GET(number/panic_bunker_min_alive_playtime_hours) HOURS > total_alive_playtime)
		log_access("Panic Bunker: [key] - Not enough alive playtime ([total_alive_playtime]h)")
		message_admins("Panic Bunker: [key] - Not enough alive playtime ([total_alive_playtime]h)")
		to_chat_forced(src, SPAN_LARGE("PANIC BUNKER: You need to have at least [CONFIG_GET(number/panic_bunker_min_alive_playtime_hours)] hours of alive playtime to play on server."))
		QDEL_NULL(src)
