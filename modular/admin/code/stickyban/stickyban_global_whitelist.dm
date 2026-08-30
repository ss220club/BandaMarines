/datum/entity/stickyban_whitelist
	var/ckey
	var/admin_ckey
	var/date
	var/source_sticky_id

/datum/entity_meta/stickyban_whitelist
	entity_type = /datum/entity/stickyban_whitelist
	table_name = "stickyban_whitelist"
	field_types = list(
		"ckey" = DB_FIELDTYPE_STRING_MEDIUM,
		"admin_ckey" = DB_FIELDTYPE_STRING_MEDIUM,
		"date" = DB_FIELDTYPE_STRING_LARGE,
		"source_sticky_id" = DB_FIELDTYPE_BIGINT,
	)

/datum/view_record/stickyban_whitelist
	var/id
	var/ckey
	var/admin_ckey
	var/date
	var/source_sticky_id

/datum/entity_view_meta/stickyban_whitelist
	root_record_type = /datum/entity/stickyban_whitelist
	destination_entity = /datum/view_record/stickyban_whitelist
	fields = list(
		"id",
		"ckey",
		"admin_ckey",
		"date",
		"source_sticky_id",
	)

// Thin facade: публичный modular-контракт для hardcode и других модульных файлов.
/datum/controller/subsystem/stickyban/proc/modular_is_sticky_ckey_globally_whitelisted(key)
	return stickyban_whitelist_service_is_globally_whitelisted(key)

/datum/controller/subsystem/stickyban/proc/modular_add_sticky_global_whitelist(key, admin_ckey = null, source_sticky_id = null)
	return stickyban_whitelist_service_add(key, admin_ckey, source_sticky_id)

/datum/controller/subsystem/stickyban/proc/modular_remove_sticky_global_whitelist(key)
	return stickyban_whitelist_service_remove(key)

/datum/controller/subsystem/stickyban/proc/modular_get_sticky_global_whitelists(search_ckey = "")
	return stickyban_whitelist_service_get(search_ckey)

/datum/controller/subsystem/stickyban/proc/modular_sync_global_whitelist_from_local_rows()
	return stickyban_whitelist_service_sync_from_local()

