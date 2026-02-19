CLIENT_VERB(create_custom_paper_fax)
	set name = "Create Custom Paper FResponder"
	set category = "OOC"

	if(usr.faction != FACTION_FAX)
		to_chat(src, SPAN_WARNING("Вы должны быть любым доступным факс респондером для использования этой команды."))
		return

	if(!check_whitelist_status(WHITELIST_FAX_RESPONDER))
		to_chat(src, SPAN_WARNING("Только лица с вайтлистом на роль факс респондера имеют право использовать эту команду."))
		return
	customise_paper()