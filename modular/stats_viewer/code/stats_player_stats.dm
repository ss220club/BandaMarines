// Per faction player's stats for who participated in the round. Linked to a specific player
/datum/entity/player_stats/proc/get_player_stat()
	var/list/data = list()
	data["title"] = "CALL THE CODER"
	data["total_kills"] = total_kills
	data["total_deaths"] = total_deaths
	data["steps_walked"] = steps_walked
	data["humans_killed"] = length(humans_killed)
	data["xenos_killed"] = length(xenos_killed)
	if(length(niche_stats))
		for(var/key in niche_stats)
			var/datum/entity/statistic/stat = niche_stats[key]
			data["niche_stats"] += list("[stat.name]" = stat.value)
	return data

/datum/entity/player_stats/human/get_player_stat()
	var/list/data = ..()
	data["title"] = "Человек"
	data["total_friendly_fire"] = total_friendly_fire
	data["total_revives"] = total_revives
	data["total_lives_saved"] = total_lives_saved
	data["total_shots"] = total_shots
	data["total_shots_hit"] = total_shots_hit
	// TODO220: Show per job (mob)
	return data

/datum/entity/player_stats/xeno/get_player_stat()
	var/list/data = ..()
	data["title"] = "Ксеноморф"
	data["total_hits"] = total_hits
	if(length(caste_stats_list))
		for(var/caste_name in caste_stats_list)
			var/datum/entity/player_stats/caste/caste = caste_stats_list[caste_name]
			data["castes"] += list("[declent_ru_initial(caste_name, NOMINATIVE, caste_name)]" = caste.get_player_stat())
	return data

/datum/entity/player_stats/caste/get_player_stat()
	var/list/data = ..()
	data["total_hits"] = total_hits
	if(length(abilities_used))
		for(var/ability_name in abilities_used)
			var/datum/entity/statistic/stat = abilities_used[ability_name]
			data["abilities_used"] += list("[stat.name]" = stat.value)
	return data
