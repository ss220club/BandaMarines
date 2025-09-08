#ifndef OVERRIDE_BAN_SYSTEM
GLOBAL_LIST_EMPTY(stickybanadminexemptions) //stores a list of ckeys exempted from a stickyban (workaround for a bug)
GLOBAL_LIST_EMPTY(stickybanadmintexts) //stores the entire stickyban list temporarily
GLOBAL_VAR(stickbanadminexemptiontimerid) //stores the timerid of the callback that restores all stickybans after an admin joins

//Blocks an attempt to connect before even creating our client datum thing.
/world/IsBanned(key,address,computer_id, type, real_bans_only=FALSE, is_telemetry = FALSE, guest_bypass_with_ext_auth = TRUE)
	var/admin = FALSE
	var/ckey = ckey(key)

	// This is added siliently. Thanks to MSO for this fix. You will see it when/if we go OS
	if (type == "world")
		return ..() //shunt world topic banchecks to purely to byond's internal ban system

	var/client/C = GLOB.directory[ckey]
	if (C && ckey == C.ckey && computer_id == C.computer_id && address == C.address)
		return //don't recheck connected clients.

	//Guest Checking
	if(!real_bans_only && CONFIG_GET(flag/guest_ban) && IsGuestKey(key))
		log_access("Failed Login: [key] - Guests not allowed")
		message_admins("Failed Login: [key] - Guests not allowed")
		return list("reason"="guest", "desc"="\nReason: Guests not allowed. Please sign in with a byond account.")

	// wait for database to be ready
	WAIT_DB_READY
	if(GLOB.admin_datums[ckey] && (GLOB.admin_datums[ckey].rights & R_MOD))
		admin = TRUE

	if(CONFIG_GET(number/limit_players) && CONFIG_GET(number/limit_players) < length(GLOB.clients))
		return list("reason"="POP CAPPED", "desc"="\nReason: Server is pop capped at the moment at [CONFIG_GET(number/limit_players)] players. Attempt reconnection in 2-3 minutes.")

	// When a user is logging in as a guest, and we're authenticating them externally, they should bypass this for now
	// so we can check them when they log in with their real login
	if(guest_bypass_with_ext_auth && IsGuestKey(key) && length(CONFIG_GET(keyed_list/auth_urls)))
		return ..()

	var/datum/entity/player/P = get_player_from_key(ckey)

	//BANDAMARINES ADD start
	if(!is_telemetry && CONFIG_GET(flag/panic_bunker_enabled) && P.check_panic_bunker(address))
		return list("reason"="PANIC BUNKER", "desc"="\nСервер сейчас находится в режиме бункера. Вам нужно наиграть больше часов, когда бункер отключен, либо обратиться к администрации за пропуском в дискорде [CONFIG_GET(string/discordurl)]")
	//BANDAMARINES ADD end

	if (admin)
		if (GLOB.directory[ckey])
			return

		//oh boy, so basically, because of a bug in byond, sometimes stickyban matches don't trigger here, so we can't exempt admins.
		// Whitelisting the ckey with the byond whitelist field doesn't work.
		// So we instead have to remove every stickyban than later re-add them.
		if (!length(GLOB.stickybanadminexemptions))
			for (var/banned_ckey in world.GetConfig("ban"))
				GLOB.stickybanadmintexts[banned_ckey] = world.GetConfig("ban", banned_ckey)
				world.SetConfig("ban", banned_ckey, null)
		if (!SSstickyban.initialized)
			return
		GLOB.stickybanadminexemptions[ckey] = world.time
		stoplag() // sleep a byond tick
		GLOB.stickbanadminexemptiontimerid = addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(restore_stickybans)), 5 SECONDS, TIMER_STOPPABLE|TIMER_UNIQUE|TIMER_OVERRIDE)
		return

	. = P.check_ban(computer_id, address, is_telemetry)

/proc/restore_stickybans()
	for (var/banned_ckey in GLOB.stickybanadmintexts)
		world.SetConfig("ban", banned_ckey, GLOB.stickybanadmintexts[banned_ckey])
	GLOB.stickybanadminexemptions = list()
	GLOB.stickybanadmintexts = list()
	if (GLOB.stickbanadminexemptiontimerid)
		deltimer(GLOB.stickbanadminexemptiontimerid)
	GLOB.stickbanadminexemptiontimerid = null

#endif
