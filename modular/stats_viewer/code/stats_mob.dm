/mob/verb/view_round_stats()
	set name = "View My Stats"
	set category = "OOC"

	if(!client)
		return
	if(stat != DEAD && SSticker.current_state != GAME_STATE_FINISHED)
		to_chat(src, SPAN_WARNING("Вы можете посмотреть статистику только будучи мертвым, или когда раунд закончился!"))
		return
	var/datum/round_stats/round_stats = new()
	round_stats.tgui_interact(src)
