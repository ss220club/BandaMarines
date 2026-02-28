/proc/modular_stickyban_build_index(name, list/fields, hints = 0)
	var/datum/db/index/index = new
	index.name = name
	index.fields = fields
	index.hints = hints
	return index

/proc/modular_stickyban_merge_indexes(datum/entity_meta/meta, list/new_indexes)
	if(!meta || !length(new_indexes))
		return

	if(!islist(meta.indexes))
		meta.indexes = list()

	var/list/existing_names = list()
	for(var/datum/db/index/existing_index as anything in meta.indexes)
		if(!existing_index || !existing_index.name)
			continue
		existing_names["[existing_index.name]"] = TRUE

	for(var/datum/db/index/new_index as anything in new_indexes)
		if(!new_index || !new_index.name)
			continue

		var/name_key = "[new_index.name]"
		if(existing_names[name_key])
			continue

		meta.indexes += new_index
		existing_names[name_key] = TRUE

/datum/controller/subsystem/stickyban/proc/modular_resync_stickyban_indexes()
	var/list/summary = list(
		"attempted" = 0,
		"synced" = 0,
		"errors" = 0,
		"status" = "noop",
	)

	if(!SSentity_manager || !SSentity_manager.adapter || !islist(SSentity_manager.tables))
		summary["status"] = "unavailable"
		return summary

	var/list/target_entity_types = list(
		/datum/entity/stickyban,
		/datum/entity/stickyban_matched_ckey,
		/datum/entity/stickyban_matched_cid,
		/datum/entity/stickyban_matched_ip,
		/datum/entity/stickyban_whitelist,
	)
	var/list/target_index_names = list(
		"stickyban_identifier_unique_idx" = TRUE,
		"stickyban_ckey_pair_unique_idx" = TRUE,
		"stickyban_cid_pair_unique_idx" = TRUE,
		"stickyban_ip_pair_unique_idx" = TRUE,
		"stickyban_whitelist_ckey_unique_idx" = TRUE,
		"stickyban_whitelist_date_idx" = TRUE,
	)

	for(var/entity_type in target_entity_types)
		var/datum/entity_meta/meta = SSentity_manager.tables[entity_type]
		if(!meta || !islist(meta.indexes))
			continue

		for(var/datum/db/index/index as anything in meta.indexes)
			if(!index || !target_index_names[index.name])
				continue

			summary["attempted"]++
			var/sync_ok = FALSE
			try
				sync_ok = SSentity_manager.adapter.sync_index(
					index.name,
					meta.table_name,
					index.fields,
					index.hints & DB_INDEXHINT_UNIQUE,
					index.hints & DB_INDEXHINT_CLUSTER,
				)
			catch(var/exception/sync_error)
				log_world("StickyBan index sync runtime error for [index.name]: [sync_error]")
				summary["errors"]++
				continue

			if(sync_ok)
				summary["synced"]++
			else
				summary["errors"]++

	if(summary["errors"] > 0)
		summary["status"] = summary["synced"] > 0 ? "partial" : "error"
	else if(summary["attempted"] > 0)
		summary["status"] = "ok"

	return summary

/datum/entity_meta/stickyban/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_active_idx", list("active")),
		modular_stickyban_build_index("stickyban_identifier_date_idx", list("identifier", "date")),
		modular_stickyban_build_index("stickyban_identifier_unique_idx", list("identifier"), DB_INDEXHINT_UNIQUE)
	))

/datum/entity_meta/stickyban_matched_ckey/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_ckey_lookup_idx", list("ckey")),
		modular_stickyban_build_index("stickyban_ckey_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_ckey_whitelist_idx", list("ckey", "whitelisted")),
		modular_stickyban_build_index("stickyban_ckey_pair_unique_idx", list("linked_stickyban", "ckey"), DB_INDEXHINT_UNIQUE)
	))

/datum/entity_meta/stickyban_matched_cid/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_cid_lookup_idx", list("cid")),
		modular_stickyban_build_index("stickyban_cid_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_cid_pair_unique_idx", list("linked_stickyban", "cid"), DB_INDEXHINT_UNIQUE)
	))

/datum/entity_meta/stickyban_matched_ip/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_ip_lookup_idx", list("ip")),
		modular_stickyban_build_index("stickyban_ip_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_ip_pair_unique_idx", list("linked_stickyban", "ip"), DB_INDEXHINT_UNIQUE)
	))

/datum/entity_meta/stickyban_whitelist/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_whitelist_ckey_unique_idx", list("ckey"), DB_INDEXHINT_UNIQUE),
		modular_stickyban_build_index("stickyban_whitelist_date_idx", list("date")),
	))
