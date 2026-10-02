/atom/vv_do_topic(list/href_list)
	. = ..()
	if(!. || !check_rights(R_VAREDIT))
		return
	if(href_list[VV_HK_SELECT_TTS_VOICE])
		change_tts_seed(usr, TTS_OVERRIDE_GENDER | TTS_OVERRIDE_TIER)

/mob/vv_do_topic(list/href_list)
	. = ..()
	if(!. || !check_rights(R_VAREDIT))
		return
	if(href_list[VV_HK_SELECT_TTS_VOICE_PLAYER_CHOICE])
		if(!client)
			to_chat(usr, span_warning("<b>[src] has no client.</b>"))
			return
		to_chat(usr, span_notice("<b>[src] было предложено сменить TTS.</b>"))
		change_tts_seed(src, TTS_OVERRIDE_GENDER | TTS_OVERRIDE_TIER)

/atom/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SELECT_TTS_VOICE, "Сменить TTS")

/mob/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_SELECT_TTS_VOICE_PLAYER_CHOICE, "Сменить TTS - Player Choice")
