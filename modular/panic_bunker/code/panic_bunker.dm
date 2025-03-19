/datum/entity/player/proc/check_panic_bunker(adress)
	if(ckey in GLOB.panic_bunker_bypass)
		msg_admin_niche("[ckey] - Passed Panic Bunker (BYPASS)")
		return
	var/total_alive_playtime_hours = round(get_total_living_playtime(id) /60, 0.1)
	if(CONFIG_GET(number/panic_bunker_min_alive_playtime_hours) > total_alive_playtime_hours)
		var/deny_message_admins = "Panic Bunker: [ckey] - Not enough alive playtime ([total_alive_playtime_hours]h, IP: [adress])"
		log_access(deny_message_admins)
		message_admins(deny_message_admins)
		return TRUE
	else
		msg_admin_niche("[ckey] - Passed Panic Bunker ([total_alive_playtime_hours]h)")
