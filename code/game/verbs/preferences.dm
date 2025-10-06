CLIENT_VERB(edit_characters)
	set category = "Preferences"
	set name = "Редактирование персонажа"
	set desc = "Настрой своего персонажа и его внешность."

	to_chat(usr, SPAN_WARNING("Note that changes may not take place until respawn."))
	prefs.ShowChoices(mob)
