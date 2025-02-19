/mob/new_player/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "LobbyMenu220", window = lobby_window)
		ui.closeable = FALSE
		ui.open(preinitialized = TRUE)
