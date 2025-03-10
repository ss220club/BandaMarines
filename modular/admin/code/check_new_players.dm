/client/proc/check_new_players()
	set name = "Check New Players TGUI"
	set category = "Admin"

	if(admin_holder)
		admin_holder.check_new_players()
	return

/datum/admins/proc/check_new_players()
	var/datum/check_new_players/check_new_players = new
	check_new_players.tgui_interact(owner.mob)

/datum/check_new_players
	var/search_age
	var/search_hours

/datum/check_new_players/tgui_interact(mob/user, datum/tgui/ui)
	. = ..()

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "CheckNewPlayers", "Check New Players")
		ui.open()

/datum/check_new_players/ui_state(mob/user)
	return GLOB.admin_state

/datum/check_new_players/ui_data(mob/user)
	. = ..()

	.["new_players"] = list()
	for(var/client/client in GLOB.clients)
		var/time_first_join = text2time(client.player_data.first_join_date)
		var/days_first_join = floor(days_from_time(time_first_join))
		var/client_hours = round(client.get_total_human_playtime() DECISECONDS_TO_HOURS, 0.1) + round(client.get_total_xeno_playtime() DECISECONDS_TO_HOURS, 0.1)
		.["new_players"] += list(
			"ckey" = client.ckey,
			"client_hours" = client_hours,
			"first_join" = client.player_data.first_join_date,
			"days_first_join" = days_first_join,
			"byond_account_age" = client.player_data.byond_account_age,
		)
	.["search"] = list(
		"search_age" = search_age,
		"search_hours" = search_hours,
	)

/datum/check_new_players/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	// var/mob/user = ui.user

	switch(action)
		if("change_search")
			var/new_age_search = params["age_search"]
			var/new_hours_search = params["hours_search"]
			if(!length(new_age_search) || !length(new_hours_search))
				return
			search_age = new_age_search
			search_hours = new_hours_search
			return TRUE
