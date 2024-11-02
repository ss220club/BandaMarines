/client/view_var_Topic(href, href_list, hsrc)
	. = ..()
	if(href_list[VV_HK_MODIFY_TRAITS])
		if(!check_rights(R_VAREDIT))
			return
		var/atom/A = locate(href_list[VV_HK_MODIFY_TRAITS])
		A.change_tts_seed(src.mob, TRUE, TRUE)

/atom/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION(VV_HK_MODIFY_TRAITS, "Change TTS")
