/client/proc/check_panic_bunker()
	if(!CONFIG_GET(flag/panic_bunker_enabled))
		return
	if(CLIENT_IS_STAFF(src))
		msg_admin_niche("[key] - Passed Panic Bunker (STAFF)")
		return
	if(ckey in GLOB.panic_bunker_bypass)
		msg_admin_niche("[key] - Passed Panic Bunker (BYPASS)")
		return
	var/total_alive_playtime_hours = round(src.get_total_human_playtime(TRUE) DECISECONDS_TO_HOURS, 0.1) + round(src.get_total_xeno_playtime(TRUE) DECISECONDS_TO_HOURS, 0.1)
	if(CONFIG_GET(number/panic_bunker_min_alive_playtime_hours) > total_alive_playtime_hours)
		var/deny_message_admins = "Panic Bunker: [key] - Not enough alive playtime ([total_alive_playtime_hours]h, IP: [player_data.last_known_ip])"
		log_access(deny_message_admins)
		message_admins(deny_message_admins)
		to_chat_forced(src, SPAN_LARGE("PANIC BUNKER: Сервер сейчас находится в режиме бункера. Вам нужно нужно иметь больше отыгранных часов, чтобы зайти."))
		QDEL_NULL(src)
	else
		msg_admin_niche("[key] - Passed Panic Bunker ([total_alive_playtime_hours]h)")
