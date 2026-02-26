/datum/controller/subsystem/stickyban/proc/purge_ckey_globally(key)
	var/list/summary = list(
		"purged_records" = 0,
		"touched_stickies" = 0,
		"deactivated_stickies" = 0,
	)

	key = ckey(key)
	if(!key)
		return summary

	var/list/datum/view_record/stickyban_matched_ckey/matches = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_COMP("ckey", DB_EQUALS, key)
	)
	if(!length(matches))
		return summary

	var/list/sticky_set = list()
	var/list/ids_to_delete = list()
	for(var/datum/view_record/stickyban_matched_ckey/match as anything in matches)
		sticky_set["[match.linked_stickyban]"] = match.linked_stickyban
		ids_to_delete += match.id

	var/list/touched_sticky_ids = list()
	for(var/sticky_id in sticky_set)
		touched_sticky_ids += sticky_set[sticky_id]

	summary["purged_records"] = delete_specific_match_records(/datum/entity/stickyban_matched_ckey, ids_to_delete)
	summary["touched_stickies"] = length(touched_sticky_ids)
	summary["deactivated_stickies"] = deactivate_empty_stickies(touched_sticky_ids)
	return summary

/datum/controller/subsystem/stickyban/proc/delete_specific_match_records(entity_type, list/ids_to_delete)
	if(!length(ids_to_delete))
		return 0

	var/list/unique_ids_to_delete = modular_dedupe_ids(ids_to_delete)
	var/list/datum/entity/entities_to_sync = list()
	var/const/sync_chunk_size = 100

	// Фаза 1: ставим все удаления в очередь.
	for(var/id in unique_ids_to_delete)
		var/datum/entity/to_delete = DB_ENTITY(entity_type, id)
		if(!to_delete)
			continue

		to_delete.delete()
		entities_to_sync += to_delete

	// Фаза 2: синхронизируемся для консистентности БД.
	var/deleted = 0
	for(var/i in 1 to length(entities_to_sync))
		var/datum/entity/to_sync = entities_to_sync[i]
		if(!to_sync)
			continue

		to_sync.sync()
		deleted++

		if(!(i % sync_chunk_size))
			stoplag()

	return deleted

/datum/controller/subsystem/stickyban/proc/modular_dedupe_ids(list/raw_ids)
	var/list/deduped_ids = list()
	var/list/seen_ids = list()

	for(var/id in raw_ids)
		if(isnull(id) || id == "")
			continue

		var/id_key = "[id]"
		if(seen_ids[id_key])
			continue

		seen_ids[id_key] = TRUE
		deduped_ids += id

	return deduped_ids

/datum/controller/subsystem/stickyban/proc/modular_collect_match_rows_for_sticky_ids(view_type, list/sticky_ids, chunk_size = 500)
	var/list/datum/view_record/matches = list()
	if(!length(sticky_ids))
		return matches

	if(!isnum(chunk_size))
		chunk_size = 500
	chunk_size = max(1, round(chunk_size))

	var/list/unique_sticky_ids = modular_dedupe_ids(sticky_ids)
	if(!length(unique_sticky_ids))
		return matches

	var/list/current_chunk = list()
	var/total_ids = length(unique_sticky_ids)
	for(var/i in 1 to total_ids)
		var/sticky_id = unique_sticky_ids[i]
		if(isnull(sticky_id) || sticky_id == "")
			continue

		current_chunk += sticky_id
		if(length(current_chunk) < chunk_size && i < total_ids)
			continue

		var/list/datum/view_record/chunk_matches = DB_VIEW(view_type,
			DB_COMP("linked_stickyban", DB_IN, current_chunk)
		)
		matches += chunk_matches
		current_chunk = list()
		stoplag()

	return matches

/datum/controller/subsystem/stickyban/proc/modular_collect_sticky_match_presence(list/target_set, view_type, list/sticky_ids, chunk_size = 500)
	if(!islist(target_set) || !length(sticky_ids))
		return

	var/list/datum/view_record/matches = modular_collect_match_rows_for_sticky_ids(view_type, sticky_ids, chunk_size)
	for(var/datum/view_record/match as anything in matches)
		target_set["[match.vars["linked_stickyban"]]"] = TRUE

/datum/controller/subsystem/stickyban/proc/run_startup_cleanup()
	WAIT_DB_READY

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)
	if(!length(all_stickies))
		return

	var/list/sticky_lookup = list()
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		sticky_lookup["[sticky.id]"] = TRUE

	var/list/ckey_stats = cleanup_ckey_matches(sticky_lookup, TRUE)
	var/list/cid_stats = cleanup_pair_matches(/datum/view_record/stickyban_matched_cid, /datum/entity/stickyban_matched_cid, "cid", sticky_lookup, TRUE)
	var/list/ip_stats = cleanup_pair_matches(/datum/view_record/stickyban_matched_ip, /datum/entity/stickyban_matched_ip, "ip", sticky_lookup, TRUE)

	var/candidate_total = (ckey_stats["candidates"] || 0) + (cid_stats["candidates"] || 0) + (ip_stats["candidates"] || 0)
	var/deleted_total = (ckey_stats["deleted"] || 0) + (cid_stats["deleted"] || 0) + (ip_stats["deleted"] || 0)
	if(candidate_total || deleted_total)
		log_world("StickyBan startup cleanup: candidates=[candidate_total], deleted=[deleted_total] (CKEY=[ckey_stats["deleted"] || 0], CID=[cid_stats["deleted"] || 0], IP=[ip_stats["deleted"] || 0]).")

	// После базового cleanup запускаем графовую нормализацию root.
	var/list/dedup_summary = modular_normalize_root_duplicates(TRUE)
	if(!islist(dedup_summary))
		dedup_summary = list()

	var/dedup_status = dedup_summary["status"] || "noop"
	var/id_before = dedup_summary["before_identifier_duplicates"] || 0
	var/id_after = dedup_summary["after_identifier_duplicates"] || 0
	var/graph_before = dedup_summary["before_graph_duplicates"] || 0
	var/graph_after = dedup_summary["after_graph_duplicates"] || 0
	var/graph_clusters = dedup_summary["before_graph_clusters"] || 0
	var/roots_deleted = dedup_summary["duplicates_deleted"] || 0
	var/matches_moved = dedup_summary["matches_moved"] || 0
	var/dedup_errors = dedup_summary["errors"] || 0
	if(id_before || id_after || graph_before || graph_after || graph_clusters || roots_deleted || matches_moved || dedup_errors || dedup_status != "noop")
		log_world("StickyBan startup normalize: status=[dedup_status], id_before=[id_before], id_after=[id_after], graph_clusters=[graph_clusters], graph_before=[graph_before], graph_after=[graph_after], roots_deleted=[roots_deleted], matches_moved=[matches_moved], errors=[dedup_errors].")

	var/list/index_sync_summary = modular_resync_stickyban_indexes()
	if(islist(index_sync_summary))
		var/index_status = index_sync_summary["status"] || "noop"
		var/index_attempted = index_sync_summary["attempted"] || 0
		var/index_synced = index_sync_summary["synced"] || 0
		var/index_errors = index_sync_summary["errors"] || 0
		if(index_attempted || index_synced || index_errors || index_status != "noop")
			log_world("StickyBan index resync: status=[index_status], attempted=[index_attempted], synced=[index_synced], errors=[index_errors].")

/datum/controller/subsystem/stickyban/proc/cleanup_ckey_matches(list/sticky_lookup, perform_deletes = TRUE, list/stickies_with_matches = null)
	var/list/datum/view_record/stickyban_matched_ckey/all_records = DB_VIEW(/datum/view_record/stickyban_matched_ckey)
	if(!length(all_records))
		return list("candidates" = 0, "deleted" = 0, "orphans" = 0, "duplicates" = 0)

	var/list/keep_by_pair = list()
	var/list/ids_to_delete = list()
	var/orphan_count = 0
	var/duplicate_count = 0

	for(var/datum/view_record/stickyban_matched_ckey/record as anything in all_records)
		var/sticky_id = "[record.linked_stickyban]"
		if(!sticky_lookup[sticky_id])
			ids_to_delete += record.id
			orphan_count++
			continue

		if(stickies_with_matches)
			stickies_with_matches[sticky_id] = TRUE

		var/pair_key = "[sticky_id]|[record.ckey]"
		var/datum/view_record/stickyban_matched_ckey/current_keep = keep_by_pair[pair_key]
		if(!current_keep)
			keep_by_pair[pair_key] = record
			continue

		duplicate_count++
		var/replace_keep = FALSE
		if(record.whitelisted && !current_keep.whitelisted)
			replace_keep = TRUE
		else if(record.whitelisted == current_keep.whitelisted && text2num("[record.id]") < text2num("[current_keep.id]"))
			replace_keep = TRUE

		if(replace_keep)
			ids_to_delete += current_keep.id
			keep_by_pair[pair_key] = record
		else
			ids_to_delete += record.id

	var/list/unique_ids_to_delete = modular_dedupe_ids(ids_to_delete)
	var/candidate_rows = length(unique_ids_to_delete)
	var/deleted_rows = perform_deletes ? delete_specific_match_records(/datum/entity/stickyban_matched_ckey, unique_ids_to_delete) : 0

	return list(
		"candidates" = candidate_rows,
		"deleted" = deleted_rows,
		"orphans" = orphan_count,
		"duplicates" = duplicate_count,
	)

/datum/controller/subsystem/stickyban/proc/cleanup_pair_matches(view_type, entity_type, field_name, list/sticky_lookup, perform_deletes = TRUE, list/stickies_with_matches = null)
	var/list/datum/view_record/all_records = DB_VIEW(view_type)
	if(!length(all_records))
		return list("candidates" = 0, "deleted" = 0, "orphans" = 0, "duplicates" = 0)

	var/list/keep_by_pair = list()
	var/list/ids_to_delete = list()
	var/orphan_count = 0
	var/duplicate_count = 0

	for(var/datum/view_record/record as anything in all_records)
		var/sticky_id = "[record.vars["linked_stickyban"]]"
		if(!sticky_lookup[sticky_id])
			ids_to_delete += record.vars["id"]
			orphan_count++
			continue

		if(stickies_with_matches)
			stickies_with_matches[sticky_id] = TRUE

		var/value = "[record.vars[field_name]]"
		var/pair_key = "[sticky_id]|[value]"
		var/datum/view_record/current_keep = keep_by_pair[pair_key]
		if(!current_keep)
			keep_by_pair[pair_key] = record
			continue

		duplicate_count++
		if(text2num("[record.vars["id"]]") < text2num("[current_keep.vars["id"]]"))
			ids_to_delete += current_keep.vars["id"]
			keep_by_pair[pair_key] = record
		else
			ids_to_delete += record.vars["id"]

	var/list/unique_ids_to_delete = modular_dedupe_ids(ids_to_delete)
	var/candidate_rows = length(unique_ids_to_delete)
	var/deleted_rows = perform_deletes ? delete_specific_match_records(entity_type, unique_ids_to_delete) : 0

	return list(
		"candidates" = candidate_rows,
		"deleted" = deleted_rows,
		"orphans" = orphan_count,
		"duplicates" = duplicate_count,
	)

/datum/controller/subsystem/stickyban/proc/deactivate_empty_stickies(list/sticky_ids)
	if(!length(sticky_ids))
		return 0

	var/list/unique_sticky_ids = modular_dedupe_ids(sticky_ids)
	if(!length(unique_sticky_ids))
		return 0

	var/list/stickies_with_matches = list()
	var/const/match_query_chunk_size = 500
	modular_collect_sticky_match_presence(stickies_with_matches, /datum/view_record/stickyban_matched_ckey, unique_sticky_ids, match_query_chunk_size)
	modular_collect_sticky_match_presence(stickies_with_matches, /datum/view_record/stickyban_matched_cid, unique_sticky_ids, match_query_chunk_size)
	modular_collect_sticky_match_presence(stickies_with_matches, /datum/view_record/stickyban_matched_ip, unique_sticky_ids, match_query_chunk_size)

	var/deactivated = 0
	for(var/i in 1 to length(unique_sticky_ids))
		var/sticky_id = unique_sticky_ids[i]
		if(stickies_with_matches["[sticky_id]"])
			continue

		var/datum/entity/stickyban/sticky = DB_ENTITY(/datum/entity/stickyban, sticky_id)
		if(!sticky)
			continue

		sticky.sync()
		if(!sticky.active)
			continue

		sticky.active = FALSE
		sticky.save()
		sticky.sync()
		deactivated++

		if(!(i % 100))
			stoplag()

	return deactivated
