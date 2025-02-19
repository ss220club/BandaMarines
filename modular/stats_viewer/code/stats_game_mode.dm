
/datum/game_mode/show_end_statistics(icon_state)
	. = ..()
	for(var/mob/M in GLOB.player_list)
		if(M.client)
			M.view_round_stats()
