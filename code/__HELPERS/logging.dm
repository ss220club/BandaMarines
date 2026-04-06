#define LOGSRC_CKEY "Ckey"
#define LOGSRC_MOB "Mob"

// Log header keys
#define LOG_HEADER_CATEGORY "category"
#define LOG_HEADER_INIT_TIMESTAMP "timestamp"
#define LOG_HEADER_ROUND_ID "round_id"

// Log data keys
#define LOG_ENTRY_MESSAGE "message"
#define LOG_ENTRY_TIMESTAMP "timestamp"
#define LOG_ENTRY_DATA "data"

// Log json keys
#define LOG_JSON_CATEGORY "category"
#define LOG_JSON_ENTRIES "entries"
#define LOG_JSON_LOGGING_START "log_start"

// Log categories
#define LOG_CATEGORY_NOT_FOUND "invalid_category"

// LOGIS categories
#define LOGIS_LOG_CATEGORY_ADMIN "ADMIN"
#define LOGIS_LOG_CATEGORY_ADMINSAY "ADMINSAY"
#define LOGIS_LOG_CATEGORY_ATTACK "ATTACK"
#define LOGIS_LOG_CATEGORY_DEADCHAT "DEADCHAT"
#define LOGIS_LOG_CATEGORY_DEBUG "DEBUG"
#define LOGIS_LOG_CATEGORY_EMOTE "EMOTE"
#define LOGIS_LOG_CATEGORY_GAME "GAME"
#define LOGIS_LOG_CATEGORY_LOOC "LOOC"
#define LOGIS_LOG_CATEGORY_OOC "OOC"
#define LOGIS_LOG_CATEGORY_SAY "SAY"
#define LOGIS_LOG_CATEGORY_VOTE "VOTE"
#define LOGIS_LOG_CATEGORY_WHISPER "WHISPER"
#define LOGIS_LOG_CATEGORY_WORLD "WORLD"
#define LOGIS_LOG_CATEGORY_MISC "MISC"
#define LOGIS_LOG_CATEGORY_ASSETS "ASSETS"
#define LOGIS_LOG_CATEGORY_ACCESS "ACCESS"
#define LOGIS_LOG_CATEGORY_ADMINWARN "ADMINWARN"
#define LOGIS_LOG_CATEGORY_MENTORSAY "MENTORSAY"

GLOBAL_LIST_INIT(local_to_logis_logs_map, list(
	"ADMIN" = LOGIS_LOG_CATEGORY_ADMIN,
	"DEADCHAT" = LOGIS_LOG_CATEGORY_DEADCHAT,
	"ASSET" = LOGIS_LOG_CATEGORY_ASSETS,
	"DEBUG" = LOGIS_LOG_CATEGORY_DEBUG,
	"GAME" = LOGIS_LOG_CATEGORY_GAME,
	"INTERACT" = LOGIS_LOG_CATEGORY_ATTACK,
	"OVERWATCH" = LOGIS_LOG_CATEGORY_MISC,
	"GARBLE" = LOGIS_LOG_CATEGORY_SAY,
	"ID MOD" = LOGIS_LOG_CATEGORY_ACCESS,
	"VOTE" = LOGIS_LOG_CATEGORY_VOTE,
	"ACCESS" = LOGIS_LOG_CATEGORY_ACCESS,
	"SAY" = LOGIS_LOG_CATEGORY_SAY,
	"HIVEMIND" = LOGIS_LOG_CATEGORY_SAY,
	"OOC" = LOGIS_LOG_CATEGORY_OOC,
	"LOOC" = LOGIS_LOG_CATEGORY_LOOC,
	"WHISPER" = LOGIS_LOG_CATEGORY_WHISPER,
	"EMOTE" = LOGIS_LOG_CATEGORY_EMOTE,
	"ATTACK" = LOGIS_LOG_CATEGORY_ATTACK,
	"ADMINSAY" = LOGIS_LOG_CATEGORY_ADMINSAY,
	"ADMINWARN" = LOGIS_LOG_CATEGORY_ADMINWARN,
	"MISC" = LOGIS_LOG_CATEGORY_MISC,
	"HIVE ORDER" = LOGIS_LOG_CATEGORY_MISC,
	"ANNOUNCEMENT" = LOGIS_LOG_CATEGORY_WORLD,
	"MENTORHELP" = LOGIS_LOG_CATEGORY_MENTORSAY,
	"TOPIC" = LOGIS_LOG_CATEGORY_WORLD
))

#define DIRECT_OUTPUT(A, B) A << B
#define SEND_TEXT(target, text) DIRECT_OUTPUT(target, text)
#define SEND_SOUND(target, sound) DIRECT_OUTPUT(target, sound)
#define WRITE_FILE(file, text) DIRECT_OUTPUT(file, text)

//This is an external call, "true" and "false" are how rust parses out booleans
#define WRITE_LOG(log, text) rustg_log_write(log, text, "true")
#define WRITE_LOG_NO_FORMAT(log, text) rustg_log_write(log, text, "false")

//print an error message to world.log


// On Linux/Unix systems the line endings are LF, on windows it's CRLF, admins that don't use notepad++
// will get logs that are one big line if the system is Linux and they are using notepad.  This solves it by adding CR to every line ending
// in the logs.  ascii character 13 = CR

GLOBAL_VAR_INIT(log_end, world.system_type == UNIX ? ascii2text(13) : "")

/proc/log_to_logis(local_category, text)
	if(!GLOB.world_logis_game_log)
		return

	text = logis_normalize_entry_text(text, local_category)
	var/logis_category = GLOB.local_to_logis_logs_map[local_category] || LOGIS_LOG_CATEGORY_MISC
	WRITE_LOG(GLOB.world_logis_game_log, "[logis_category]: [text]")

/proc/logis_normalize_entry_text(text, local_category = null)
	if(!istext(text))
		return text

	var/normalized_text = sanitize_control_chars("[text]")
	var/plain_text = strip_html(normalized_text)
	var/parsed_ckey = null
	var/skip_ckey_suffix = FALSE
	if(local_category in list("SAY", "WHISPER", "DEADCHAT", "HIVEMIND"))
		var/static/regex/logis_speech_prefix = regex(@"^.+\/\(.+?\) \(\d+,\d+,\d+\): ", "i")
		skip_ckey_suffix = logis_speech_prefix.Find(plain_text)
	else if(local_category == "ADMIN")
		var/static/regex/logis_strict_admin_line = regex(@"^(Mentorhelp|Adminhelp|HELP|PM): ", "i")
		skip_ckey_suffix = logis_strict_admin_line.Find(plain_text)

	var/static/regex/ckey_from_field = regex(@"\(CKEY:\s*([A-Za-z0-9_]+)\)", "i")
	if(ckey_from_field.Find(plain_text))
		parsed_ckey = ckey(ckey_from_field.group[1])

	if(!parsed_ckey)
		var/static/regex/ckey_from_deadchat = regex(@"DEAD[:/]\s*([A-Za-z0-9_]+)\/\(", "i")
		if(ckey_from_deadchat.Find(plain_text))
			parsed_ckey = ckey(ckey_from_deadchat.group[1])

	if(!parsed_ckey)
		var/static/regex/ckey_from_key_name = regex(@"(?:^|[\s:])([A-Za-z0-9_]+)\/\(")
		if(ckey_from_key_name.Find(plain_text))
			parsed_ckey = ckey(ckey_from_key_name.group[1])

	if(parsed_ckey)
		if(findtext(normalized_text, "(CKEY: "))
			var/static/regex/replace_ckey_field = regex(@"\(CKEY:\s*[A-Za-z0-9_]*\)", "i")
			normalized_text = replace_ckey_field.Replace(normalized_text, "(CKEY: [parsed_ckey])")
		else if(!skip_ckey_suffix)
			normalized_text += " (CKEY: [parsed_ckey])"

	return normalized_text

/proc/log_location(atom/source)
	if(!source)
		return "Unknown Area (?, ?, ?)"

	var/turf/source_turf = get_turf(source)
	if(!source_turf)
		return "Unknown Area (?, ?, ?)"

	var/area_name = sanitize_control_chars(strip_improper(get_area_name(source_turf) || "Unknown Area"))
	return "[area_name] ([source_turf.x],[source_turf.y],[source_turf.z])"

/proc/logis_ckey(atom/source)
	if(!ismob(source))
		return null

	var/mob/mob_source = source
	if(mob_source.ckey)
		return mob_source.ckey
	if(mob_source.key)
		return lowertext(mob_source.key)
	return null

/proc/logis_name(atom/source)
	if(!ismob(source))
		return "Unknown"

	var/mob/mob_source = source
	if(istype(mob_source, /mob/living/carbon/xenomorph))
		var/mob/living/carbon/xenomorph/xeno_source = mob_source
		if(xeno_source.nicknumber)
			return "[xeno_source.nicknumber]"
		if(xeno_source.full_designation)
			return xeno_source.full_designation
	return mob_source.real_name || mob_source.name || "Unknown"

/proc/logis_identity(atom/source)
	var/source_ckey = logis_ckey(source) || "*no key*"
	return "[source_ckey]/([logis_name(source)])"

/proc/logis_coords(atom/source)
	var/turf/source_turf = get_turf(source)
	if(!source_turf)
		return "(0,0,0)"
	return "([source_turf.x],[source_turf.y],[source_turf.z])"

/proc/logis_speech_line(atom/source, message, channel = null)
	var/prefix = "[logis_identity(source)] [logis_coords(source)]: "
	if(channel)
		prefix += "([channel]) "
	return "[prefix]'[message]'"

/proc/logis_role_name(atom/source)
	if(!ismob(source))
		return null

	var/mob/mob_source = source
	if(mob_source.job)
		return sanitize_control_chars(strip_improper("[mob_source.job]"))
	return null

/proc/logis_manifest_line(atom/source)
	var/source_ckey = logis_ckey(source)
	var/source_role = logis_role_name(source)
	if(!source_ckey || !source_role)
		return null

	return "Игрок [source_ckey] вошел в раунд с профессией [source_role] (1/-1)"

/proc/logis_adminhelp_ticket_line(client/initiator, message, heard_count)
	if(!initiator)
		return null
	return "Adminhelp: [key_name(initiator)]: [message]- heard by [heard_count] non-AFK admins."

/proc/logis_help_ticket_line(client/initiator, message, heard_count)
	if(!initiator)
		return null
	return "HELP: [key_name(initiator)]: [message]- heard by [heard_count] non-AFK admins."

/proc/logis_mentorhelp_ticket_line(client/initiator, message, heard_count)
	if(!initiator)
		return null
	return "Mentorhelp: [key_name(initiator)]: [message]- heard by [heard_count] non-AFK mentors."

/proc/error(msg)
	world.log << "## ERROR: [msg][GLOB.log_end]"
	GLOB.STUI.debug.Add("\[[time_stamp()]]DEBUG: [msg]")
	GLOB.STUI.processing |= STUI_LOG_DEBUG
#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [src] usr: [usr].")
//print a warning message to world.log
/proc/warning(msg)
	world.log << "## WARNING: [msg][GLOB.log_end]"
	GLOB.STUI.debug.Add("\[[time_stamp()]]WARNING: [msg]")
	GLOB.STUI.processing |= STUI_LOG_DEBUG
//print a testing-mode debug message to world.log
/proc/testing(msg)
	world.log << "## TESTING: [msg][GLOB.log_end]"
	GLOB.STUI.debug.Add("\[[time_stamp()]]TESTING: [msg]")
	GLOB.STUI.processing |= STUI_LOG_DEBUG

/proc/log_admin(text, logis_category = "ADMIN")
	var/time = time_stamp()
	GLOB.admin_log.Add(text)
	if (CONFIG_GET(flag/log_admin))
		WRITE_LOG(GLOB.world_game_log, "ADMIN: [text]")
		log_to_logis(logis_category, text)
		LOG_REDIS("admin", "\[[time]\] [text]")
	GLOB.STUI.admin.Add("\[[time]]ADMIN: [text]")
	GLOB.STUI.processing |= STUI_LOG_ADMIN

/proc/log_asset(text)
	GLOB.asset_log.Add(text)
	if (CONFIG_GET(flag/log_asset))
		var/time = time_stamp()
		WRITE_LOG(GLOB.world_game_log, "ASSET: [text]")
		log_to_logis("ASSET", text)
		LOG_REDIS("asset", "\[[time]\] [text]")

/proc/log_adminpm(text)
	GLOB.admin_log.Add(text)
	if (CONFIG_GET(flag/log_admin))
		WRITE_LOG(GLOB.world_game_log, "ADMIN: [text]")
		log_to_logis("ADMIN", text)
	GLOB.STUI.staff.Add("\[[time_stamp()]]ADMIN: [text]")
	GLOB.STUI.processing |= STUI_LOG_STAFF_CHAT

/proc/log_world(text)
	SEND_TEXT(world.log, text)

/proc/log_debug(text, diary_only=FALSE)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_debug))
		WRITE_LOG(GLOB.world_game_log, "DEBUG: [text]")
		log_to_logis("DEBUG", text)
		LOG_REDIS("debug", "\[[time]\] [text]")

	if(diary_only)
		return

	GLOB.STUI?.debug.Add("\[[time]]DEBUG: [text]")
	GLOB.STUI?.processing |= STUI_LOG_DEBUG
	for(var/client/client in GLOB.admins)
		if(CLIENT_IS_STAFF(client))
			if(client.prefs.toggles_chat & CHAT_DEBUGLOGS)
				to_chat(client, "DEBUG: [text]", type = MESSAGE_TYPE_DEBUG)


/proc/log_game(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_game))
		WRITE_LOG(GLOB.world_game_log, "GAME: [text]")
		log_to_logis("GAME", text)
		LOG_REDIS("game", "\[[time]\] [text]")
	GLOB.STUI.admin.Add("\[[time]]GAME: [text]")
	GLOB.STUI.processing |= STUI_LOG_ADMIN

/proc/log_interact(mob/living/carbon/origin, mob/living/carbon/target, msg)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_interact))
		WRITE_LOG(GLOB.world_game_log, "INTERACT: [msg]")
		log_to_logis("INTERACT", msg)
		LOG_REDIS("interact", "\[[time]\] [msg]")
	if(origin)
		origin.attack_log += "\[[time]\]<font color='green'> [msg] </font>"
	if(target)
		target.attack_log += "\[[time]\]<font color='green'> [msg] </font>"

	GLOB.STUI.attack.Add("\[[time]]INTERACT: [msg]")
	GLOB.STUI.processing |= STUI_LOG_ATTACK


/proc/log_overwatch(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_overwatch))
		WRITE_LOG(GLOB.world_game_log, "OVERWATCH: [text]")
		log_to_logis("OVERWATCH", text)
		LOG_REDIS("overwatch", "\[[time]\] [text]")
	GLOB.STUI.admin.Add("\[[time]]OVERWATCH: [text]")
	GLOB.STUI.processing |= STUI_LOG_ADMIN

/proc/log_garble(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_garble))
		WRITE_LOG(GLOB.world_game_log, "GARBLE: [text]")
		log_to_logis("GARBLE", text)
		LOG_REDIS("garble", "\[[time]\] [text]")
	GLOB.STUI.admin.Add("\[[time]]GARBLE: [text]")
	GLOB.STUI.processing |= STUI_LOG_ADMIN

/proc/log_idmod(obj/item/card/id/target_id, msg, changer)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_idmod))
		WRITE_LOG(GLOB.world_game_log, "ID MOD: ([changer]) [msg]")
		log_to_logis("ID MOD", "([changer]) [msg]")
		LOG_REDIS("idmod", "\[[time]\] ([changer]) [msg]")
	target_id.modification_log += "\[[time]]: [msg]"

/proc/log_vote(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_vote))
		WRITE_LOG(GLOB.world_game_log, "VOTE: [text]")
		log_to_logis("VOTE", text)
		LOG_REDIS("vote", "\[[time]\] [text]")


/proc/log_access(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_access))
		WRITE_LOG(GLOB.world_game_log, "ACCESS: [text]")
		log_to_logis("ACCESS", text)
		LOG_REDIS("access", "\[[time]\] [text]")
	GLOB.STUI.debug.Add("\[[time]]ACCESS: [text]")
	GLOB.STUI.processing |= STUI_LOG_DEBUG

/proc/log_say(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_say))
		WRITE_LOG(GLOB.world_game_log, "SAY: [text]")
		log_to_logis("SAY", text)
		LOG_REDIS("say", "\[[time]\] [text]")
	GLOB.STUI.game.Add("\[[time]]SAY: [text]")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT

/proc/log_deadchat(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_say))
		WRITE_LOG(GLOB.world_game_log, "SAY: [text]")
		log_to_logis("DEADCHAT", text)
		LOG_REDIS("say", "\[[time]\] [text]")
	GLOB.STUI.game.Add("\[[time]]SAY: [text]")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT

/proc/log_hivemind(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_hivemind))
		WRITE_LOG(GLOB.world_game_log, "HIVEMIND: [text]")
		log_to_logis("HIVEMIND", text)
		LOG_REDIS("hivemind", "\[[time]\] [text]")
	GLOB.STUI.game.Add("\[[time]]HIVEMIND: [text]")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT

/proc/log_ooc(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_ooc))
		LOG_REDIS("ooc", "\[[time]\] [text]")
		WRITE_LOG(GLOB.world_game_log, "OOC: [text]")
		log_to_logis("OOC", text)

/proc/log_looc(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_ooc))
		LOG_REDIS("ooc", "\[[time]\] (LOCAL) [text]")
		WRITE_LOG(GLOB.world_game_log, "LOOC: [text]")
		log_to_logis("LOOC", text)

/proc/log_whisper(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_whisper))
		LOG_REDIS("whisper", "\[[time]\] [text]")
		WRITE_LOG(GLOB.world_game_log, "WHISPER: [text]")
		log_to_logis("WHISPER", text)
	GLOB.STUI.game.Add("\[[time]]WHISPER: [text]")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT

/proc/log_emote(text)
	var/time = time_stamp()
	if (CONFIG_GET(flag/log_emote))
		LOG_REDIS("emote", "\[[time]\] [text]")
		WRITE_LOG(GLOB.world_game_log, "EMOTE: [text]")
		log_to_logis("EMOTE", text)
	GLOB.STUI.game.Add("\[[time]]<font color='#999999'>EMOTE: [text]</font>")
	GLOB.STUI.processing |= STUI_LOG_GAME_CHAT

/proc/log_attack(text)
	text = sanitize_control_chars(strip_improper("[text]"))

	var/time = time_stamp()
	if (CONFIG_GET(flag/log_attack))
		LOG_REDIS("attack", "\[[time]\] [text]")
		WRITE_LOG(GLOB.world_attack_log, "ATTACK: [text]")
		log_to_logis("ATTACK", text)
	GLOB.STUI.attack.Add("\[[time]]ATTACK: [text]")
	GLOB.STUI.processing |= STUI_LOG_ATTACK

/proc/log_adminsay(text)
	if (CONFIG_GET(flag/log_adminchat))
		WRITE_LOG(GLOB.world_game_log, "ADMINSAY: [text]")
		log_to_logis("ADMINSAY", text)

/proc/log_adminwarn(text)
	if (CONFIG_GET(flag/log_adminwarn))
		WRITE_LOG(GLOB.world_game_log, "ADMINWARN: [text]")
		log_to_logis("ADMINWARN", text)
	GLOB.STUI.admin.Add("\[[time_stamp()]]ADMIN: [text]")
	GLOB.STUI.processing |= STUI_LOG_ADMIN

/proc/log_misc(text)
	var/time = time_stamp()
	LOG_REDIS("misc", "\[[time]\] [text]")
	WRITE_LOG(GLOB.world_game_log, "MISC: [text]")
	log_to_logis("MISC", text)
	GLOB.STUI?.debug.Add("\[[time]]MISC: [text]")

/proc/log_strain(text)
	if(!GLOB.strain_logs)
		return
	WRITE_LOG(GLOB.strain_logs, "[text]")

/proc/log_hiveorder(text)
	var/time = time_stamp()
	LOG_REDIS("hiveorder", "\[[time]\] [text]")
	WRITE_LOG(GLOB.world_game_log, "HIVE ORDER: [text]")
	log_to_logis("HIVE ORDER", text)
	GLOB.STUI.debug.Add("\[[time]]HIVE ORDER: [text]")

/proc/log_announcement(text)
	var/time = time_stamp()
	LOG_REDIS("announcement", "\[[time]\] [text]")
	WRITE_LOG(GLOB.world_game_log, "ANNOUNCEMENT: [text]")
	log_to_logis("ANNOUNCEMENT", text)
	GLOB.STUI.admin.Add("\[[time]]ANNOUNCEMENT: [text]")

/proc/log_mhelp(text)
	var/time = time_stamp()
	LOG_REDIS("mhelp", "\[[time]\] [text]")
	WRITE_LOG(GLOB.world_game_log, "MENTORHELP: [text]")
	log_to_logis("MENTORHELP", text)
	GLOB.STUI.admin.Add("\[[time]]MENTORHELP: [text]")

/// Logging for game performance
/proc/log_perf(list/perf_info)
	. = "[perf_info.Join(",")]\n"
	WRITE_LOG_NO_FORMAT(GLOB.perf_log, .)

/* Log to the logfile only. */
/proc/log_runtime(text)
	WRITE_LOG(GLOB.world_runtime_log, text)

/**
 * Appends a tgui-related log entry. All arguments are optional.
 */
/proc/log_tgui(user, message, context,
		datum/tgui_window/window,
		datum/src_object)
	var/entry = ""
	// Insert user info
	if(!user)
		entry += "<nobody>"
	else if(istype(user, /mob))
		var/mob/mob = user
		entry += "[mob.ckey] (as [mob] at [mob.x],[mob.y],[mob.z])"
	else if(istype(user, /client))
		var/client/client = user
		entry += "[client.ckey]"
	// Insert context
	if(context)
		entry += " in [context]"
	else if(window)
		entry += " in [window.id]"
	// Resolve src_object
	if(!src_object && window?.locked_by)
		src_object = window.locked_by.src_object
	// Insert src_object info
	if(src_object)
		entry += "\nUsing: [src_object.type] [REF(src_object)]"
	// Insert message
	if(message)
		entry += "\n[message]"
	WRITE_LOG(GLOB.tgui_log, entry)
	GLOB.STUI.tgui.Add("\[[time_stamp()]]TGUI: [entry]")
	GLOB.STUI.processing |= STUI_LOG_TGUI

/proc/log_topic(text)
	WRITE_LOG(GLOB.world_game_log, "TOPIC: [text]")
	log_to_logis("TOPIC", text)

GLOBAL_VAR(config_error_log)
GLOBAL_PROTECT(config_error_log)

/* Rarely gets called; just here in case the config breaks. */
/proc/log_config(text)
	WRITE_LOG(GLOB.config_error_log, text)
	SEND_TEXT(world.log, text)

/// Logging for mapping errors
/proc/log_mapping(text, skip_world_log)
#ifdef UNIT_TESTS
	GLOB.unit_test_mapping_logs += text
#endif
	if(skip_world_log)
		return
	WRITE_LOG(GLOB.mapping_log, text)
	SEND_TEXT(world.log, text)

/proc/log_admin_private(text)
	log_admin(text)

#if defined(UNIT_TESTS) || defined(SPACEMAN_DMM)
/proc/log_test(text)
	WRITE_LOG(GLOB.test_log, text)
	SEND_TEXT(world.log, text)
#endif

#if defined(REFERENCE_DOING_IT_LIVE)
#define log_reftracker(msg) log_harddel("## REF SEARCH [msg]")

/proc/log_harddel(text)
	WRITE_LOG(GLOB.harddel_log, text)

#elif defined(REFERENCE_TRACKING) // Doing it locally
#define log_reftracker(msg) log_world("## REF SEARCH [msg]")

#else //Not tracking at all
#define log_reftracker(msg)
#endif

/proc/start_log(log)
	WRITE_LOG(log, "Starting up round ID [GLOB.round_id].\nStarting up. Round ID is [GLOB.round_id]\n-------------------------")

/proc/shutdown_logging()
	rustg_log_close_all()
	GLOB.logger.shutdown_logging()
