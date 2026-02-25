/datum/controller/subsystem/stickyban/proc/modular_normalize_identifier(identifier)
	if(isnull(identifier))
		return ""
	return ckey(trim("[identifier]"))

/datum/controller/subsystem/stickyban/proc/modular_normalize_text_field(value)
	var/text_value = isnull(value) ? "" : "[value]"
	text_value = replacetext(text_value, "\t", " ")
	text_value = replacetext(text_value, ascii2text(13), " ")
	text_value = replacetext(text_value, "\n", " ")
	text_value = trim(text_value)

	while(findtext(text_value, "  "))
		text_value = replacetext(text_value, "  ", " ")

	return text_value

/datum/controller/subsystem/stickyban/proc/modular_build_normalized_strict_key(identifier, reason, message)
	return "[modular_normalize_identifier(identifier)]\x1E[modular_normalize_text_field(reason)]\x1E[modular_normalize_text_field(message)]"

/datum/controller/subsystem/stickyban/proc/modular_build_sticky_strict_key(identifier, reason, message)
	// Совместимость со старым именем: используем нормализованный strict-key.
	return modular_build_normalized_strict_key(identifier, reason, message)

/datum/controller/subsystem/stickyban/proc/modular_collect_stickies_for_normalized_key(strict_key, include_inactive = TRUE)
	var/list/matches = list()
	if(!strict_key)
		return matches

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!include_inactive && !sticky.active)
			continue

		if(modular_build_normalized_strict_key(sticky.identifier, sticky.reason, sticky.message) != strict_key)
			continue

		matches += sticky

	return matches

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

/datum/controller/subsystem/stickyban/proc/modular_collect_root_duplicate_groups(normalized = TRUE, include_inactive = TRUE)
	WAIT_DB_READY

	var/list/duplicate_groups = list()
	var/list/grouped_by_key = list()
	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)

	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!include_inactive && !sticky.active)
			continue

		var/strict_key
		if(normalized)
			strict_key = modular_build_normalized_strict_key(sticky.identifier, sticky.reason, sticky.message)
		else
			strict_key = "[sticky.identifier]\x1E[sticky.reason]\x1E[sticky.message]"

		if(!islist(grouped_by_key[strict_key]))
			grouped_by_key[strict_key] = list()

		var/list/current_group = grouped_by_key[strict_key]
		current_group += sticky

	for(var/strict_key in grouped_by_key)
		var/list/current_group = grouped_by_key[strict_key]
		if(length(current_group) <= 1)
			continue

		var/list/group_data = list(
			"strict_key" = strict_key,
			"stickies" = current_group,
		)
		duplicate_groups[length(duplicate_groups) + 1] = group_data

	return duplicate_groups

/datum/controller/subsystem/stickyban/proc/modular_build_duplicate_stats(list/duplicate_groups)
	var/list/stats = list(
		"groups" = 0,
		"duplicates" = 0
	)

	for(var/list/group_data as anything in duplicate_groups)
		var/list/stickies = group_data["stickies"]
		if(!islist(stickies) || length(stickies) <= 1)
			continue

		stats["groups"]++
		stats["duplicates"] += max(0, length(stickies) - 1)

	return stats

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
	var/normalized_identifier = modular_normalize_identifier(identifier)
	if(!normalized_identifier)
		return null

	var/target_key = modular_build_normalized_strict_key(normalized_identifier, reason, message)
	var/list/datum/view_record/stickyban/candidates = DB_VIEW(/datum/view_record/stickyban,
		DB_COMP("active", DB_EQUALS, TRUE)
	)
	if(!length(candidates))
		return null

	var/list/datum/view_record/stickyban/matched_candidates = list()
	for(var/datum/view_record/stickyban/candidate as anything in candidates)
		if(modular_build_normalized_strict_key(candidate.identifier, candidate.reason, candidate.message) != target_key)
			continue
		matched_candidates += candidate

	if(!length(matched_candidates))
		return null

	var/canonical_id = modular_pick_canonical_sticky_id(matched_candidates)
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
		"deleted_rows" = 0,
		"errors" = 0
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

/datum/controller/subsystem/stickyban/proc/modular_delete_root_records_batch(list/root_ids, sync_chunk_size = 100)
	if(!length(root_ids))
		return 0

	var/list/unique_root_ids = modular_dedupe_ids(root_ids)
	var/list/datum/entity/stickyban/entities_to_sync = list()
	for(var/root_id in unique_root_ids)
		var/datum/entity/stickyban/root_entity = DB_ENTITY(/datum/entity/stickyban, root_id)
		if(!root_entity)
			continue

		root_entity.delete()
		entities_to_sync += root_entity

	var/deleted = 0
	for(var/i in 1 to length(entities_to_sync))
		var/datum/entity/stickyban/to_sync = entities_to_sync[i]
		if(!to_sync)
			continue

		to_sync.sync()
		deleted++

		if(!(i % sync_chunk_size))
			stoplag()

	return deleted

/datum/controller/subsystem/stickyban/proc/modular_normalize_root_duplicates(perform_mutation = TRUE)
	WAIT_DB_READY

	var/list/summary = list(
		"groups" = 0,
		"duplicates_found" = 0,
		"duplicates_deleted" = 0,
		"matches_moved" = 0,
		"errors" = 0,
		"before_groups" = 0,
		"before_duplicates" = 0,
		"after_groups" = 0,
		"after_duplicates" = 0,
		"status" = "noop",
	)

	var/list/initial_groups = modular_collect_root_duplicate_groups(TRUE, TRUE)
	var/list/initial_stats = modular_build_duplicate_stats(initial_groups)
	summary["before_groups"] = initial_stats["groups"] || 0
	summary["before_duplicates"] = initial_stats["duplicates"] || 0
	summary["groups"] = summary["before_groups"]
	summary["duplicates_found"] = summary["before_duplicates"]

	if(!summary["before_duplicates"])
		summary["after_groups"] = 0
		summary["after_duplicates"] = 0
		return summary

	if(!perform_mutation)
		summary["after_groups"] = summary["before_groups"]
		summary["after_duplicates"] = summary["before_duplicates"]
		return summary

	if(modular_root_dedup_in_progress)
		summary["status"] = "busy"
		summary["after_groups"] = summary["before_groups"]
		summary["after_duplicates"] = summary["before_duplicates"]
		return summary

	modular_root_dedup_in_progress = TRUE
	var/list/roots_to_delete = list()
	var/group_counter = 0

	try
		for(var/list/group_data as anything in initial_groups)
			var/list/stickies = group_data["stickies"]
			if(!islist(stickies) || length(stickies) <= 1)
				continue

			var/canonical_id = modular_pick_canonical_sticky_id(stickies)
			if(isnull(canonical_id))
				summary["errors"]++
				continue

			var/canonical_key = "[canonical_id]"
			for(var/datum/view_record/stickyban/sticky as anything in stickies)
				if("[sticky.id]" == canonical_key)
					continue

				var/list/move_summary = modular_move_matches_to_canonical(canonical_id, sticky.id)
				summary["matches_moved"] += move_summary["source_rows"] || 0
				summary["errors"] += move_summary["errors"] || 0
				roots_to_delete += sticky.id

			group_counter++
			if(!(group_counter % 25))
				stoplag()

		summary["duplicates_deleted"] = modular_delete_root_records_batch(roots_to_delete)
	catch(var/exception/normalization_error)
		summary["errors"]++
		log_world("StickyBan root dedup runtime error: [normalization_error]")

	modular_root_dedup_in_progress = FALSE

	var/list/final_groups = modular_collect_root_duplicate_groups(TRUE, TRUE)
	var/list/final_stats = modular_build_duplicate_stats(final_groups)
	summary["after_groups"] = final_stats["groups"] || 0
	summary["after_duplicates"] = final_stats["duplicates"] || 0

	if(summary["after_duplicates"] <= 0 && summary["errors"] <= 0)
		summary["status"] = "ok"
	else
		summary["status"] = "partial"

	return summary

/datum/controller/subsystem/stickyban/proc/modular_delete_stickyban_cluster(source_sticky_id, include_inactive = TRUE)
	WAIT_DB_READY

	var/list/summary = list(
		"cluster_size" = 0,
		"roots_deleted" = 0,
		"matches_deleted" = 0,
		"errors" = 0,
		"status" = "noop",
		"strict_key" = "",
	)
	if(!source_sticky_id)
		return summary

	if(modular_root_dedup_in_progress)
		summary["status"] = "busy"
		return summary

	var/datum/entity/stickyban/source_sticky = DB_ENTITY(/datum/entity/stickyban, source_sticky_id)
	if(!source_sticky)
		return summary
	source_sticky.sync()

	var/strict_key = modular_build_normalized_strict_key(source_sticky.identifier, source_sticky.reason, source_sticky.message)
	summary["strict_key"] = strict_key
	if(!strict_key)
		return summary

	var/list/datum/view_record/stickyban/cluster_records = modular_collect_stickies_for_normalized_key(strict_key, include_inactive)
	var/list/cluster_ids = list()
	for(var/datum/view_record/stickyban/sticky as anything in cluster_records)
		cluster_ids += sticky.id

	cluster_ids = modular_dedupe_ids(cluster_ids)
	summary["cluster_size"] = length(cluster_ids)
	if(!summary["cluster_size"])
		return summary

	modular_root_dedup_in_progress = TRUE
	try
		var/list/ckey_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_ckey, cluster_ids)
		var/list/cid_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_cid, cluster_ids)
		var/list/ip_match_ids = modular_collect_match_record_ids_for_stickies(/datum/view_record/stickyban_matched_ip, cluster_ids)

		summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_ckey, ckey_match_ids)
		summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_cid, cid_match_ids)
		summary["matches_deleted"] += delete_specific_match_records(/datum/entity/stickyban_matched_ip, ip_match_ids)

		summary["roots_deleted"] = modular_delete_root_records_batch(cluster_ids)
	catch(var/exception/cluster_error)
		summary["errors"]++
		log_world("StickyBan cluster delete runtime error for [source_sticky_id]: [cluster_error]")

	modular_root_dedup_in_progress = FALSE

	if(summary["roots_deleted"] >= summary["cluster_size"] && summary["errors"] <= 0)
		summary["status"] = "ok"
	else
		summary["status"] = "partial"
		summary["errors"] += max(0, summary["cluster_size"] - summary["roots_deleted"])

	return summary
