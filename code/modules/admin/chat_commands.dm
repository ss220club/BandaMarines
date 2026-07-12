// Commands that are able to be executed via TGS, for more details see `code/__DEFINES/tgs.dm`

/datum/tgs_chat_command/sdql
	name = "sdql"
	help_text = "Runs an SDQL query. Disabled. Use in-game SDQL instead."
	admin_only = TRUE

/datum/tgs_chat_command/sdql/Run(datum/tgs_chat_user/sender, params)
	/*
	var/list/results = HandleUserlessSDQL(sender.friendly_name, params)
	if(!results)
		return new /datum/tgs_message_content("Query produced no output")
	var/list/text_res = results.Copy(1, 3)
	var/list/refs = length(results) > 3 ? results.Copy(4) : null
	return new /datum/tgs_message_content("[text_res.Join("\n")][refs ? "\nRefs: [refs.Join(" ")]" : ""]")
	*/
	return new /datum/tgs_message_content("SDQL command is disabled and no longer functional. Use in-game SDQL instead.") //SS220 - EDIT

/datum/tgs_chat_command/tgscheck
	name = "check"
	help_text = "Gets the playercount, gamemode, and address of the server"

/datum/tgs_chat_command/tgscheck/Run(datum/tgs_chat_user/sender, params)
	var/server = CONFIG_GET(string/server)
	return new /datum/tgs_message_content("[GLOB.round_id ? "Round #[GLOB.round_id]: " : ""][GLOB.clients.len] players. Ship map: [SSmapping.configs[SHIP_MAP].map_name]; Ground map: [SSmapping.configs[GROUND_MAP].map_name]; Round [SSticker.HasRoundStarted() ? (SSticker.IsRoundInProgress() ? "Active" : "Finishing") : "Starting"] -- [server ? server : "[world.internet_address]:[world.port]"]")

/datum/tgs_chat_command/adminwho
	name = "adminwho"
	help_text = "Lists administrators currently on the server"
	admin_only = TRUE

/datum/tgs_chat_command/adminwho/Run(datum/tgs_chat_user/sender, params)
	var/list/adm = get_admin_counts()
	var/list/allmins = adm["total"]
	var/status = "Admins: [allmins.len] (Active: [english_list(adm["present"])] AFK: [english_list(adm["afk"])] Stealth: [english_list(adm["stealth"])] Skipped: [english_list(adm["noflags"])]). "
	return new /datum/tgs_message_content(status)
