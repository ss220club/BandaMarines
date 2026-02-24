/datum/controller/subsystem/stickyban/proc/modular_build_sticky_strict_key(identifier, reason, message)
	// Строгий ключ дубля: identifier + reason + message.
	return "[identifier]\x1E[reason]\x1E[message]"

/datum/controller/subsystem/stickyban/proc/modular_pick_canonical_sticky_id(list/datum/view_record/stickyban/stickies)
	if(!length(stickies))
		return null

	var/canonical_id
	var/canonical_active = FALSE
	var/canonical_id_num = 0

	for(var/datum/view_record/stickyban/sticky as anything in stickies)
		if(!sticky)
			continue

		var/current_id_num = text2num("[sticky.id]")
		var/current_active = !!sticky.active

		if(isnull(canonical_id))
			canonical_id = sticky.id
			canonical_active = current_active
			canonical_id_num = current_id_num
			continue

		if(current_active && !canonical_active)
			canonical_id = sticky.id
			canonical_active = TRUE
			canonical_id_num = current_id_num
			continue

		if(current_active == canonical_active && current_id_num < canonical_id_num)
			canonical_id = sticky.id
			canonical_id_num = current_id_num

	return canonical_id

/datum/controller/subsystem/stickyban/proc/modular_collect_root_duplicate_groups()
	WAIT_DB_READY

	var/list/duplicate_groups = list()
	var/list/grouped_by_key = list()
	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)

	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		var/strict_key = modular_build_sticky_strict_key(sticky.identifier, sticky.reason, sticky.message)
		if(!islist(grouped_by_key[strict_key]))
			grouped_by_key[strict_key] = list()

		var/list/current_group = grouped_by_key[strict_key]
		current_group += sticky

	for(var/strict_key in grouped_by_key)
		var/list/current_group = grouped_by_key[strict_key]
		if(length(current_group) <= 1)
			continue

		var/list/group_data = list(
			"stickies" = current_group,
		)
		duplicate_groups[length(duplicate_groups) + 1] = group_data

	return duplicate_groups

/datum/controller/subsystem/stickyban/proc/modular_collect_match_record_ids_for_stickies(view_type, list/sticky_ids, chunk_size = 500)
	var/list/record_ids = list()
	if(!length(sticky_ids))
		return record_ids

	if(!isnum(chunk_size))
		chunk_size = 500
	chunk_size = max(1, round(chunk_size))

	var/list/unique_sticky_ids = modular_dedupe_ids(sticky_ids)
	if(!length(unique_sticky_ids))
		return record_ids

	var/list/current_chunk = list()
	var/total_ids = length(unique_sticky_ids)

	for(var/i in 1 to total_ids)
		var/sticky_id = unique_sticky_ids[i]
		if(isnull(sticky_id) || sticky_id == "")
			continue

		current_chunk += sticky_id
		if(length(current_chunk) < chunk_size && i < total_ids)
			continue

		var/list/datum/view_record/matches = DB_VIEW(view_type,
			DB_COMP("linked_stickyban", DB_IN, current_chunk)
		)
		for(var/datum/view_record/match as anything in matches)
			record_ids += match.vars["id"]

		current_chunk = list()
		stoplag()

	return modular_dedupe_ids(record_ids)

/datum/controller/subsystem/stickyban/proc/modular_resolve_stickyban_for_add(identifier, reason, message, datum/entity/player/banning_admin, override_date)
	if(isnull(identifier) || isnull(reason) || isnull(message))
		return null

	var/list/datum/view_record/stickyban/candidates = DB_VIEW(/datum/view_record/stickyban,
		DB_AND(
			DB_COMP("identifier", DB_EQUALS, "[identifier]"),
			DB_COMP("reason", DB_EQUALS, "[reason]"),
			DB_COMP("message", DB_EQUALS, "[message]"),
			DB_COMP("active", DB_EQUALS, TRUE)
		)
	)
	if(!length(candidates))
		return null

	var/canonical_id = modular_pick_canonical_sticky_id(candidates)
	if(isnull(canonical_id))
		return null

	var/datum/entity/stickyban/existing_sticky = DB_ENTITY(/datum/entity/stickyban, canonical_id)
	if(!existing_sticky)
		return null

	existing_sticky.sync()
	return existing_sticky

/datum/controller/subsystem/stickyban/proc/modular_move_matches_to_canonical(canonical_id, duplicate_id)
	var/list/summary = list(
		"source_rows" = 0,
		"deleted_rows" = 0
	)
	if(!canonical_id || !duplicate_id || "[canonical_id]" == "[duplicate_id]")
		return summary

	var/list/datum/view_record/stickyban_matched_ckey/ckey_rows = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_COMP("linked_stickyban", DB_EQUALS, duplicate_id)
	)
	var/list/whitelist_ckeys = list()
	var/list/regular_ckeys = list()
	var/list/ckey_delete_ids = list()
	for(var/datum/view_record/stickyban_matched_ckey/row as anything in ckey_rows)
		ckey_delete_ids += row.id

		var/key = ckey(row.ckey)
		if(!key)
			continue

		if(row.whitelisted)
			whitelist_ckeys[key] = TRUE
		else
			regular_ckeys[key] = TRUE

	for(var/key in whitelist_ckeys)
		whitelist_ckey(canonical_id, key)

	for(var/key in regular_ckeys)
		if(whitelist_ckeys[key])
			continue
		add_matched_ckey(canonical_id, key)

	summary["source_rows"] += length(ckey_delete_ids)
	summary["deleted_rows"] += delete_specific_match_records(/datum/entity/stickyban_matched_ckey, ckey_delete_ids)

	var/list/datum/view_record/stickyban_matched_cid/cid_rows = DB_VIEW(/datum/view_record/stickyban_matched_cid,
		DB_COMP("linked_stickyban", DB_EQUALS, duplicate_id)
	)
	var/list/cid_values = list()
	var/list/cid_delete_ids = list()
	for(var/datum/view_record/stickyban_matched_cid/row as anything in cid_rows)
		cid_delete_ids += row.id
		if(row.cid)
			cid_values["[row.cid]"] = row.cid

	for(var/cid_key in cid_values)
		add_matched_cid(canonical_id, cid_values[cid_key])

	summary["source_rows"] += length(cid_delete_ids)
	summary["deleted_rows"] += delete_specific_match_records(/datum/entity/stickyban_matched_cid, cid_delete_ids)

	var/list/datum/view_record/stickyban_matched_ip/ip_rows = DB_VIEW(/datum/view_record/stickyban_matched_ip,
		DB_COMP("linked_stickyban", DB_EQUALS, duplicate_id)
	)
	var/list/ip_values = list()
	var/list/ip_delete_ids = list()
	for(var/datum/view_record/stickyban_matched_ip/row as anything in ip_rows)
		ip_delete_ids += row.id
		if(row.ip)
			ip_values["[row.ip]"] = row.ip

	for(var/ip_key in ip_values)
		add_matched_ip(canonical_id, ip_values[ip_key])

	summary["source_rows"] += length(ip_delete_ids)
	summary["deleted_rows"] += delete_specific_match_records(/datum/entity/stickyban_matched_ip, ip_delete_ids)

	return summary

/datum/controller/subsystem/stickyban/proc/modular_normalize_root_duplicates(perform_mutation = TRUE)
	WAIT_DB_READY

	var/list/summary = list(
		"groups" = 0,
		"duplicates_found" = 0,
		"duplicates_deleted" = 0,
		"matches_moved" = 0,
		"errors" = 0
	)

	var/list/duplicate_groups = modular_collect_root_duplicate_groups()
	if(!length(duplicate_groups))
		return summary

	for(var/list/group_data as anything in duplicate_groups)
		var/list/stickies = group_data["stickies"]
		if(!islist(stickies) || length(stickies) <= 1)
			continue

		var/canonical_id = modular_pick_canonical_sticky_id(stickies)
		if(isnull(canonical_id))
			summary["errors"]++
			continue

		summary["groups"]++
		var/canonical_key = "[canonical_id]"

		for(var/datum/view_record/stickyban/sticky as anything in stickies)
			if("[sticky.id]" == canonical_key)
				continue

			summary["duplicates_found"]++
			if(!perform_mutation)
				continue

			try
				var/list/move_summary = modular_move_matches_to_canonical(canonical_id, sticky.id)
				summary["matches_moved"] += (move_summary["source_rows"] || 0)

				var/datum/entity/stickyban/duplicate = DB_ENTITY(/datum/entity/stickyban, sticky.id)
				if(!duplicate)
					summary["errors"]++
					continue

				duplicate.delete()
				duplicate.sync()
				summary["duplicates_deleted"]++
			catch(var/exception/normalization_error)
				summary["errors"]++
				log_world("StickyBan root dedup runtime: canonical=[canonical_id], duplicate=[sticky.id], error=[normalization_error]")

			if(!(summary["duplicates_deleted"] % 100))
				stoplag()

	return summary

/datum/controller/subsystem/stickyban/proc/modular_delete_stickyban_cluster(source_sticky_id, include_inactive = TRUE)
	WAIT_DB_READY

	var/list/summary = list(
		"cluster_size" = 0,
		"roots_deleted" = 0,
		"matches_deleted" = 0
	)
	if(!source_sticky_id)
		return summary

	var/datum/entity/stickyban/source_sticky = DB_ENTITY(/datum/entity/stickyban, source_sticky_id)
	if(!source_sticky)
		return summary
	source_sticky.sync()

	var/list/datum/view_record/stickyban/cluster_records
	if(include_inactive)
		cluster_records = DB_VIEW(/datum/view_record/stickyban,
			DB_AND(
				DB_COMP("identifier", DB_EQUALS, source_sticky.identifier),
				DB_COMP("reason", DB_EQUALS, source_sticky.reason),
				DB_COMP("message", DB_EQUALS, source_sticky.message)
			)
		)
	else
		cluster_records = DB_VIEW(/datum/view_record/stickyban,
			DB_AND(
				DB_COMP("identifier", DB_EQUALS, source_sticky.identifier),
				DB_COMP("reason", DB_EQUALS, source_sticky.reason),
				DB_COMP("message", DB_EQUALS, source_sticky.message),
				DB_COMP("active", DB_EQUALS, TRUE)
			)
		)

	var/list/cluster_ids = list()
	for(var/datum/view_record/stickyban/sticky as anything in cluster_records)
		cluster_ids += sticky.id

	if(!length(cluster_ids))
		cluster_ids += source_sticky.id

	cluster_ids = modular_dedupe_ids(cluster_ids)
	summary["cluster_size"] = length(cluster_ids)
	if(!length(cluster_ids))
		return summary

	var/list/ckey_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_ckey, cluster_ids)
	var/list/cid_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_cid, cluster_ids)
	var/list/ip_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_ip, cluster_ids)

	summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_ckey, ckey_match_ids)
	summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_cid, cid_match_ids)
	summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_ip, ip_match_ids)

	var/list/datum/entity/stickyban/roots_to_sync = list()
	for(var/sticky_id in cluster_ids)
		var/datum/entity/stickyban/sticky_to_delete = DB_ENTITY(/datum/entity/stickyban, sticky_id)
		if(!sticky_to_delete)
			continue

		sticky_to_delete.delete()
		roots_to_sync += sticky_to_delete

	for(var/i in 1 to length(roots_to_sync))
		var/datum/entity/stickyban/sticky_to_sync = roots_to_sync[i]
		if(!sticky_to_sync)
			continue

		sticky_to_sync.sync()
		summary["roots_deleted"]++

		if(!(i % 100))
			stoplag()

	return summary
