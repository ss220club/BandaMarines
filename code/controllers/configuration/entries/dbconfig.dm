/datum/config_entry/flag/sql_enabled // for sql switching
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_provider
	config_entry_value = "native"
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_address
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/number/db_port
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_database
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_username
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_password
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/feedback_tableprefix
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/datum/config_entry/flag/db_debug_mode
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/number/db_min_threads
	config_entry_value = 1
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/number/db_max_threads
	config_entry_value = 100
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/string/db_filename
	config_entry_value = "data/local.db"
	protection = CONFIG_ENTRY_HIDDEN|CONFIG_ENTRY_LOCKED

/datum/config_entry/number/async_query_timeout
	default = 10
	min_val = 0
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/number/blocking_query_timeout
	default = 5
	min_val = 0
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/number/pooling_min_sql_connections
	default = 1
	min_val = 1

/datum/config_entry/number/pooling_max_sql_connections
	default = 25
	min_val = 1

/// The exe for mariadbd.exe.
/// Shouldn't really be set on production servers, primarily for EZDB.
/datum/config_entry/string/db_daemon
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
