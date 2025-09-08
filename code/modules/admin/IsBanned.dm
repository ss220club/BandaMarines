#ifndef OVERRIDE_BAN_SYSTEM
GLOBAL_LIST_EMPTY(stickybanadminexemptions) //stores a list of ckeys exempted from a stickyban (workaround for a bug)
GLOBAL_LIST_EMPTY(stickybanadmintexts) //stores the entire stickyban list temporarily
GLOBAL_VAR(stickbanadminexemptiontimerid) //stores the timerid of the callback that restores all stickybans after an admin joins

GLOBAL_LIST_EMPTY(clientmessages)
//GLOBAL_LIST_EMPTY(deadmins) //all ckeys who have used the de-admin verb.
//GLOBAL_LIST_EMPTY(joined_player_list) //all ckeys that have joined the game at round-start or as a latejoin.



GLOBAL_VAR_INIT(Debug2, FALSE)
#define debug_world_log(msg) if (GLOB.Debug2) log_world("DEBUG: [msg]")
#define STICKYBAN_ROGUE_CHECK_TIME 5
#define STICKYBAN_MAX_MATCHES 15
#define STICKYBAN_MAX_EXISTING_USER_MATCHES 3 //ie, users who were connected before the ban triggered
#define STICKYBAN_MAX_ADMIN_MATCHES 1

//Blocks an attempt to connect before even creating our client datum thing.
/world/IsBanned(key,address,computer_id, type, real_bans_only=FALSE, is_telemetry = FALSE, guest_bypass_with_ext_auth = TRUE)
	debug_world_log("isbanned(): '[args.Join("', '")]'")
	if (!key || (!real_bans_only && (!address || !computer_id)))
		if(real_bans_only)
			return FALSE
		log_access("Failed Login (invalid data): [key] [address]-[computer_id]")
		return list("reason"="invalid login data", "desc"="Error: Could not check ban status, Please try again. Error message: Your computer provided invalid or blank information to the server on connection (byond username, IP, and Computer ID.) Provided information for reference: Username:'[key]' IP:'[address]' Computer ID:'[computer_id]'. (If you continue to get this error, please restart byond or contact byond support.)")

	if (type == "world")
		return ..() //shunt world topic banchecks to purely to byond's internal ban system

	var/admin = FALSE
	var/ckey = ckey(key)

	var/client/C = GLOB.directory[ckey]
	if (C && ckey == C.ckey && computer_id == C.computer_id && address == C.address)
		return //don't recheck connected clients.

	//IsBanned can get re-called on a user in certain situations, this prevents that leading to repeated messages to admins.
	var/static/list/checkedckeys = list()
	//magic voodo to check for a key in a list while also adding that key to the list without having to do two associated lookups
	var/message = !checkedckeys[ckey]++

	if(GLOB.admin_datums[ckey]) //|| GLOB.deadmins[ckey])
		admin = TRUE

	if(!real_bans_only && !admin && CONFIG_GET(flag/panic_bunker) && !CONFIG_GET(flag/panic_bunker_interview))
		var/datum/db_query/query_client_in_db = SSdbcore.NewQuery(
			"SELECT 1 FROM [format_table_name("player")] WHERE ckey = :ckey",
			list("ckey" = ckey)
		)
		if(!query_client_in_db.Execute())
			qdel(query_client_in_db)
			return

		var/client_is_in_db = query_client_in_db.NextRow()
		if(!client_is_in_db)
			var/reject_message = "Failed Login: [ckey] [address]-[computer_id] - New Account attempting to connect during panic bunker, but was rejected due to no prior connections to game servers (no database entry)"
			log_access(reject_message)
			if (message)
				message_admins(SPAN_ADMINNOTICE("[reject_message]"))
			qdel(query_client_in_db)
			return list("reason"="panicbunker", "desc" = "Sorry but the server is currently not accepting connections from never before seen players")

		qdel(query_client_in_db)

	//Guest Checking
	if(!real_bans_only && !C && is_guest_key(key))
		if (CONFIG_GET(flag/guest_ban))
			log_access("Failed Login: [ckey] - Guests not allowed")
			return list("reason"="guest", "desc"="\nReason: Guests not allowed. Please sign in with a byond account.")
		if (CONFIG_GET(flag/panic_bunker) && SSdbcore.Connect())
			log_access("Failed Login: [ckey] - Guests not allowed during panic bunker")
			return list("reason"="guest", "desc"="\nReason: Sorry but the server is currently not accepting connections from never before seen players or guests. If you have played on this server with a byond account before, please log in to the byond account you have played from.")

	if(CONFIG_GET(flag/sql_enabled))
		if(!SSdbcore.Connect())
			var/msg = "Ban database connection failure. Key [ckey] not checked"
			log_world(msg)
			if (message)
				message_admins(msg)
		else
			var/list/ban_details = is_banned_from_with_details(ckey, address, computer_id, "Server")
			for(var/i in ban_details)
				if(admin)
					if(text2num(i["applies_to_admins"]))
						var/msg = "Admin [ckey] is admin banned, and has been disallowed access."
						log_admin(msg)
						if (message)
							message_admins(msg)
					else
						var/msg = "Admin [ckey] has been allowed to bypass a matching non-admin ban on [ckey(i["key"])] [i["ip"]]-[i["computerid"]]."
						log_admin(msg)
						if (message)
							message_admins(msg)
							addclientmessage(ckey,SPAN_ADMINNOTICE("Admin [ckey] has been allowed to bypass a matching non-admin ban on [i["key"]] [i["ip"]]-[i["computerid"]]."))
						continue
				var/expires = "This is a permanent ban."
				if(i["expiration_time"])
					expires = " The ban is for [DisplayTimeText(text2num(i["duration"]) MINUTES)] and expires on [i["expiration_time"]] (server time)."
				var/desc = {"You, or another user of this computer or connection ([i["key"]]) is banned from playing here.
				The ban reason is: [i["reason"]]
				This ban (BanID #[i["id"]]) was applied by [i["admin_key"]] on [i["bantime"]] during round ID [i["round_id"]].
				[expires]"}
				//log_suspicious_login("Failed Login: [ckey] [computer_id] [address] - Banned (#[i["id"]])")
				return list("reason"="Banned","desc"="[desc]")
	if (admin) // SS220 BANDASTATION BANS
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

	var/list/ban = ..() //default pager ban stuff
	if (ban)
		if (!admin)
			. = ban
		if (real_bans_only)
			return
		var/bannedckey = "ERROR"
		if (ban["ckey"])
			bannedckey = ban["ckey"]

		var/newmatch = FALSE
		var/list/cachedban = SSstickyban.cache[bannedckey]
		//rogue ban in the process of being reverted.
		if (cachedban && (cachedban["reverting"] || cachedban["timeout"]))
			world.SetConfig("ban", bannedckey, null)
			return null

		if (cachedban && ckey != bannedckey)
			newmatch = TRUE
			if (cachedban["keys"])
				if (cachedban["keys"][ckey])
					newmatch = FALSE
			if (cachedban["matches_this_round"][ckey])
				newmatch = FALSE

		if (newmatch && cachedban)
			var/list/newmatches = cachedban["matches_this_round"]
			var/list/pendingmatches = cachedban["matches_this_round"]
			var/list/newmatches_connected = cachedban["existing_user_matches_this_round"]
			var/list/newmatches_admin = cachedban["admin_matches_this_round"]

			if (C)
				newmatches_connected[ckey] = ckey
				newmatches_connected = cachedban["existing_user_matches_this_round"]
				pendingmatches[ckey] = ckey
				sleep(STICKYBAN_ROGUE_CHECK_TIME)
				pendingmatches -= ckey
			if (admin)
				newmatches_admin[ckey] = ckey

			if (cachedban["reverting"] || cachedban["timeout"])
				return null

			newmatches[ckey] = ckey


			if (\
				newmatches.len+pendingmatches.len > STICKYBAN_MAX_MATCHES || \
				newmatches_connected.len > STICKYBAN_MAX_EXISTING_USER_MATCHES || \
				newmatches_admin.len > STICKYBAN_MAX_ADMIN_MATCHES \
			)

				var/action
				if (ban["fromdb"])
					cachedban["timeout"] = TRUE
					action = "putting it on timeout for the remainder of the round"
				else
					cachedban["reverting"] = TRUE
					action = "reverting to its roundstart state"

				world.SetConfig("ban", bannedckey, null)

				//we always report this
				log_game("Stickyban on [bannedckey] detected as rogue, [action]")
				message_admins("Stickyban on [bannedckey] detected as rogue, [action]")
				//do not convert to timer.
				spawn (5)
					world.SetConfig("ban", bannedckey, null)
					sleep(1 TICKS)
					world.SetConfig("ban", bannedckey, null)
					if (!ban["fromdb"])
						cachedban = cachedban.Copy() //so old references to the list still see the ban as reverting
						cachedban["matches_this_round"] = list()
						cachedban["existing_user_matches_this_round"] = list()
						cachedban["admin_matches_this_round"] = list()
						cachedban -= "reverting"
						SSstickyban.cache[bannedckey] = cachedban
						world.SetConfig("ban", bannedckey, list2stickyban(cachedban))
				return null

		if (ban["fromdb"])
			if(SSdbcore.Connect())
				INVOKE_ASYNC(SSdbcore, TYPE_PROC_REF(/datum/controller/subsystem/dbcore, QuerySelect), list(
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_ckey")] (matched_ckey, stickyban) VALUES (:ckey, :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("ckey" = ckey, "bannedckey" = bannedckey)
					),
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_ip")] (matched_ip, stickyban) VALUES (INET_ATON(:address), :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("address" = address, "bannedckey" = bannedckey)
					),
					SSdbcore.NewQuery(
						"INSERT INTO [format_table_name("stickyban_matched_cid")] (matched_cid, stickyban) VALUES (:computer_id, :bannedckey) ON DUPLICATE KEY UPDATE last_matched = now()",
						list("computer_id" = computer_id, "bannedckey" = bannedckey)
					)
				), FALSE, TRUE)


		//byond will not trigger isbanned() for "global" host bans,
		//ie, ones where the "apply to this game only" checkbox is not checked (defaults to not checked)
		//So it's safe to let admins walk thru host/sticky bans here
		if (admin)
			log_admin("The admin [ckey] has been allowed to bypass a matching host/sticky ban on [bannedckey]")
			if (message)
				message_admins(SPAN_ADMINNOTICE("The admin [ckey] has been allowed to bypass a matching host/sticky ban on [bannedckey]"))
				addclientmessage(ckey,SPAN_ADMINNOTICE("You have been allowed to bypass a matching host/sticky ban on [bannedckey]"))
			return null

		if (C) //user is already connected!.
			to_chat(C, SPAN_WARNING("You are about to get disconnected for matching a sticky ban after you connected. If this turns out to be the ban evasion detection system going haywire, we will automatically detect this and revert the matches. if you feel that this is the case, please wait EXACTLY 6 seconds then reconnect using file -> reconnect to see if the match was automatically reversed."), confidential = TRUE)

		var/desc = "\nReason:(StickyBan) You, or another user of this computer or connection ([bannedckey]) is banned from playing here. The ban reason is:\n[ban["message"]]\nThis ban was applied by [ban["admin"]]\nThis is a BanEvasion Detection System ban, if you think this ban is a mistake, please wait EXACTLY 6 seconds, then try again before filing an appeal.\n"
		. = list("reason" = "Stickyban", "desc" = desc)
		//log_suspicious_login("Failed Login: [ckey] [computer_id] [address] - StickyBanned [ban["message"]] Target Username: [bannedckey] Placed by [ban["admin"]]")

		return .

	//. = P.check_ban(computer_id, address, is_telemetry)

/proc/addclientmessage(ckey, message)
	ckey = ckey(ckey)
	if (!ckey || !message)
		return
	var/list/L = GLOB.clientmessages[ckey]
	if(!L)
		GLOB.clientmessages[ckey] = L = list()
	L += message

/proc/is_guest_key(key)
	if(findtext(key, "Guest-", 1, 7) != 1) //was findtextEx
		return FALSE

	var/i, ch, len = length(key)

	for(i = 7, i <= len, ++i) //we know the first 6 chars are Guest-
		ch = text2ascii(key, i)
		if (ch < 48 || ch > 57) //0-9
			return FALSE
	return TRUE

/proc/is_banned_from_with_details(player_ckey, player_ip, player_cid, role)
	if(!player_ckey && !player_ip && !player_cid)
		return
	var/datum/db_query/query_check_ban = SSdbcore.NewQuery({"
		SELECT
			id,
			bantime,
			round_id,
			expiration_time,
			TIMESTAMPDIFF(MINUTE, bantime, expiration_time),
			applies_to_admins,
			reason,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("ban")].ckey), ckey),
			INET_NTOA(ip),
			computerid,
			IFNULL((SELECT byond_key FROM [format_table_name("player")] WHERE [format_table_name("player")].ckey = [format_table_name("ban")].a_ckey), a_ckey)
		FROM [format_table_name("ban")]
		WHERE role = :role
			AND (ckey = :ckey OR ip = INET_ATON(:ip) OR computerid = :computerid)
			AND unbanned_datetime IS NULL
			AND (expiration_time IS NULL OR expiration_time > NOW())
		ORDER BY bantime DESC
	"}, list("role" = role, "ckey" = player_ckey, "ip" = player_ip, "computerid" = player_cid))
	if(!query_check_ban.warn_execute())
		qdel(query_check_ban)
		return
	. = list()
	while(query_check_ban.NextRow())
		. += list(list("id" = query_check_ban.item[1], "bantime" = query_check_ban.item[2], "round_id" = query_check_ban.item[3], "expiration_time" = query_check_ban.item[4], "duration" = query_check_ban.item[5], "applies_to_admins" = query_check_ban.item[6], "reason" = query_check_ban.item[7], "key" = query_check_ban.item[8], "ip" = query_check_ban.item[9], "computerid" = query_check_ban.item[10], "admin_key" = query_check_ban.item[11]))
	qdel(query_check_ban)

/proc/restore_stickybans()
	for (var/banned_ckey in GLOB.stickybanadmintexts)
		world.SetConfig("ban", banned_ckey, GLOB.stickybanadmintexts[banned_ckey])
	GLOB.stickybanadminexemptions = list()
	GLOB.stickybanadmintexts = list()
	if (GLOB.stickbanadminexemptiontimerid)
		deltimer(GLOB.stickbanadminexemptiontimerid)
	GLOB.stickbanadminexemptiontimerid = null

#endif
