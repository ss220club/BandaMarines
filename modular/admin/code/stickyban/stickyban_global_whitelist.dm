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

/datum/controller/subsystem/stickyban/proc/modular_is_sticky_ckey_globally_whitelisted(key)
	key = ckey(key)
	if(!key)
		return FALSE

	var/list/datum/view_record/stickyban_whitelist/records = DB_VIEW(/datum/view_record/stickyban_whitelist,
		DB_COMP("ckey", DB_EQUALS, key)
	)
	return !!length(records)

/datum/controller/subsystem/stickyban/proc/modular_add_sticky_global_whitelist(key, admin_ckey = null, source_sticky_id = null)
	key = ckey(key)
	if(!key)
		return null

	admin_ckey = ckey(admin_ckey)

	var/id_to_select
	var/list/datum/view_record/stickyban_whitelist/existing = DB_VIEW(/datum/view_record/stickyban_whitelist,
		DB_COMP("ckey", DB_EQUALS, key)
	)
	if(length(existing))
		var/datum/view_record/stickyban_whitelist/current = existing[1]
		id_to_select = current.id

	var/datum/entity/stickyban_whitelist/entry = DB_ENTITY(/datum/entity/stickyban_whitelist, id_to_select)
	if(!entry)
		return null

	if(id_to_select)
		entry.sync()

	entry.ckey = key
	entry.admin_ckey = admin_ckey
	entry.date = "[time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")]"
	entry.source_sticky_id = source_sticky_id
	entry.save()
	entry.sync()
	return entry

/datum/controller/subsystem/stickyban/proc/modular_remove_sticky_global_whitelist(key)
	var/list/summary = list(
		"removed" = 0,
		"status" = "noop",
	)

	key = ckey(key)
	if(!key)
		return summary

	var/list/datum/view_record/stickyban_whitelist/records = DB_VIEW(/datum/view_record/stickyban_whitelist,
		DB_COMP("ckey", DB_EQUALS, key)
	)
	if(!length(records))
		return summary

	var/list/datum/entity/stickyban_whitelist/to_sync = list()
	for(var/datum/view_record/stickyban_whitelist/row as anything in records)
		var/datum/entity/stickyban_whitelist/entity = DB_ENTITY(/datum/entity/stickyban_whitelist, row.id)
		if(!entity)
			continue
		entity.delete()
		to_sync += entity

	for(var/datum/entity/stickyban_whitelist/entity as anything in to_sync)
		entity.sync()
		summary["removed"]++

	summary["status"] = summary["removed"] > 0 ? "ok" : "partial"
	return summary

/datum/controller/subsystem/stickyban/proc/modular_get_sticky_global_whitelists(search_ckey = "")
	var/list/datum/view_record/stickyban_whitelist/results = list()
	var/list/datum/view_record/stickyban_whitelist/all_records = DB_VIEW(/datum/view_record/stickyban_whitelist)
	if(!length(all_records))
		return results

	var/search_key = ckey(search_ckey)
	for(var/datum/view_record/stickyban_whitelist/entry as anything in all_records)
		var/current_key = ckey(entry.ckey)
		if(search_key && !findtext(current_key, search_key))
			continue
		results += entry

	return results

/datum/controller/subsystem/stickyban/proc/modular_sync_global_whitelist_from_local_rows()
	var/list/summary = list(
		"scanned" = 0,
		"synced" = 0,
		"errors" = 0,
		"status" = "noop",
	)

	var/list/datum/view_record/stickyban_matched_ckey/legacy_rows = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_COMP("whitelisted", DB_EQUALS, TRUE)
	)
	if(!length(legacy_rows))
		return summary

	for(var/datum/view_record/stickyban_matched_ckey/row as anything in legacy_rows)
		summary["scanned"]++
		var/datum/entity/stickyban_whitelist/entry = modular_add_sticky_global_whitelist(row.ckey, null, row.linked_stickyban)
		if(entry)
			summary["synced"]++
		else
			summary["errors"]++

	if(summary["errors"] > 0)
		summary["status"] = summary["synced"] > 0 ? "partial" : "error"
	else if(summary["scanned"] > 0)
		summary["status"] = "ok"

	return summary
