/client/proc/create_custom_paper_fax()
	set name = "Create Custom Paper FResponder"
	set category = "OOC.Whitelist"

	if(!check_whitelist_status(WHITELIST_FAX_RESPONDER))
		to_chat(src, SPAN_WARNING("Только лица с вайтлистом на роль факс респондера имеют право использовать эту команду."))
		return

	if(usr.faction != FACTION_FAX)
		to_chat(src, SPAN_WARNING("Вы должны быть любым доступным факс респондером для использования этой команды."))
		return
	customise_paper()
	