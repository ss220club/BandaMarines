/// Is TTS enabled
/datum/config_entry/flag/tts_enabled
	config_entry_value = FALSE
	protection = CONFIG_ENTRY_HIDDEN

// /datum/config_entry/flag/tts_enabled/New()
// 	. = ..()
// 	tts_enabled = CONFIG_GET(string/tts_token_silero) && SStts220.is_enabled


/// TTS API token for silero provider
/datum/config_entry/string/tts_token_silero
	config_entry_value = ""
	protection = CONFIG_ENTRY_HIDDEN

/// TTS API url for silero provide
/datum/config_entry/string/tts_api_url_silero
	config_entry_value = "http://s2.ss220.club:9999/voice"
	protection = CONFIG_ENTRY_HIDDEN

/// Should oggs be cached
/datum/config_entry/flag/tts_cache_enabled
	config_entry_value = FALSE
	protection = CONFIG_ENTRY_HIDDEN

/// What cpu threads should ffmpeg use
/datum/config_entry/string/ffmpeg_cpuaffinity
	config_entry_value = ""
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/ffmpeg_cpuaffinity/New()
	. = ..()
	var/sanitized = regex(@"[^0-9,-]", "g").Replace(config_entry_value, "")
	if(config_entry_value != sanitized)
		log_config("Wrong value for ffmpeg_cpuaffinity. Check out taskset man page.")
