// Per faction player's stats for who participated in the round. Linked to a specific player
/datum/entity/player_stats/proc/get_player_stat()
	var/list/data = list()
	data["title"] = "CALL THE CODER"
	data["total_kills"] = total_kills
	data["total_deaths"] = total_deaths
	data["steps_walked"] = steps_walked
	data["humans_killed"] = length(humans_killed)
	data["xenos_killed"] = length(xenos_killed)
	return data

/datum/entity/player_stats/human/get_player_stat()
	var/list/data = ..()
	data["title"] = "Human"
	data["total_friendly_fire"] = total_friendly_fire
	data["total_revives"] = total_revives
	data["total_lives_saved"] = total_lives_saved
	data["total_shots"] = total_shots
	data["total_shots_hit"] = total_shots_hit
	// TODO220: Show per job (mob)
	return data

/datum/entity/player_stats/xeno/get_player_stat()
	var/list/data = ..()
	data["title"] = "Xeno"
	data["total_hits"] = total_hits
	// TODO220: Show per caste (mob)
	return data
