/mob/proc/view_round_stats()
	set name = "View My Stats"
	set category = "OOC"

	_view_round_stats()

/mob/proc/_view_round_stats()
	var/list/datum/entity/statistic/death/death_list = list()
	// Find all our deaths
	if(length(GLOB.round_statistics.death_stats_list))
		var/datum/entity/player/player = get_player_from_key("[ckey]")
		for(var/datum/entity/statistic/death/death in GLOB.round_statistics.death_stats_list)
			if(death.player_id != player.id)
				continue
			death_list += death

	var/list/data = list()
	if(length(death_list))
		for(var/datum/entity/statistic/death/death in death_list)
			data["[death.mob_name]"] = death.get_round_stats(data["[death.mob_name]"])

		to_chat(src, "Your death stats are:")
		for(var/key in data)
			to_chat(src, "Character: [key]")
			to_chat(src, "Total steps: [data[key]["total_steps"]]")
			to_chat(src, "Total kills: [data[key]["total_kills"]]")
			to_chat(src, "Total time alive: [data[key]["total_time_alive"]]")
			to_chat(src, "Total damage taken: [data[key]["total_damage_taken"]]")
			to_chat(src, "Total revives done: [data[key]["total_revives_done"]]")
			to_chat(src, "Total ib fixed: [data[key]["total_ib_fixed"]]")

	get_living_round_stats()

/datum/entity/statistic/death/proc/get_round_stats(list/append_data = list())
	var/list/data = list()
	data["total_steps"] = total_steps + append_data["total_steps"]
	data["total_kills"] = total_kills + append_data["total_kills"]
	data["total_time_alive"] = total_time_alive + append_data["total_time_alive"]
	data["total_damage_taken"] = total_damage_taken + append_data["total_damage_taken"]
	data["total_revives_done"] = total_revives_done + append_data["total_revives_done"]
	data["total_ib_fixed"] = total_ib_fixed + append_data["total_ib_fixed"]
	return data

/mob/proc/get_living_round_stats()
	return

/mob/living/carbon/human/get_living_round_stats()
	to_chat(src, "Your living stats are:")
	to_chat(src, "Character: [real_name]")
	to_chat(src, "Total steps: [life_steps_total]")
	to_chat(src, "Total kills: [life_kills_total]")
	to_chat(src, "Total time alive: [world.time - life_time_start]")
	to_chat(src, "Total damage taken: [life_damage_taken_total]")
	to_chat(src, "Total revives done: [life_revives_total]")
	to_chat(src, "Total ib fixed: [life_ib_total]")

/mob/living/carbon/xenomorph/get_living_round_stats()
	to_chat(src, "Your living stats are:")
	to_chat(src, "Character: [real_name]")
	to_chat(src, "Total steps: [life_steps_total]")
	to_chat(src, "Total kills: [life_kills_total]")
	to_chat(src, "Total time alive: [world.time - life_time_start]")
	to_chat(src, "Total damage taken: [life_damage_taken_total]")
	to_chat(src, "Total revives done: [life_revives_total]")
	to_chat(src, "Total ib fixed: [life_ib_total]")

// show_end_statistics
