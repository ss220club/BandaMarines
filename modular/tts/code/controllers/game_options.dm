/datum/config_entry/string/tts_http_url
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/tts_http_token
	protection = CONFIG_ENTRY_LOCKED|CONFIG_ENTRY_HIDDEN

/datum/config_entry/number/tts_max_concurrent_requests
	default = 4
	min_val = 1

/datum/config_entry/str_list/tts_voice_blacklist
