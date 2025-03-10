/mob/new_player/Topic(href, href_list)
	if(src != usr)
		return

	if(!client)
		return

	if(href_list["observe"] || href_list["ready"] || href_list["late_join"])
		if(CONFIG_GET(string/central_api_url) && CONFIG_GET(flag/force_discord_verification))
			if(!SScentral.is_player_discord_linked(client))
				to_chat(usr, SPAN_BOLDWARNING(span_danger("Вам необходимо привязать дискорд-профиль к аккаунту!<br>") + span_warning("<br>Перейдите во вкладку '<b>Special Verbs</b>', она справа сверху, и нажмите '<b>Привязка Discord</b>' для получения инструкций.<br>") + span_notice("Если вы уверены, что ваш аккаунт уже привязан, подождите синхронизации и попробуйте снова.")))
				return FALSE

	. = ..()
