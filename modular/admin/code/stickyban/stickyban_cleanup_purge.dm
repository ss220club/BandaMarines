/datum/controller/subsystem/stickyban/proc/purge_ckey_globally(key)
	var/list/summary = list(
		"purged_records" = 0,
		"touched_stickies" = 0,
		"deactivated_stickies" = 0,
		"preserved_whitelist" = 0,
		"global_whitelisted" = FALSE,
	)

	key = ckey(key)
	if(!key)
		return summary

	summary["global_whitelisted"] = modular_is_sticky_ckey_globally_whitelisted(key)

	var/list/datum/view_record/stickyban_matched_ckey/matches = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_COMP("ckey", DB_EQUALS, key)
	)
	if(!length(matches))
		return summary

	var/list/sticky_set = list()
	var/list/ids_to_delete = list()
	for(var/datum/view_record/stickyban_matched_ckey/match as anything in matches)
		// Если CKEY защищен глобальным whitelist, не трогаем whitelist-связи.
		if(summary["global_whitelisted"] && match.whitelisted)
			summary["preserved_whitelist"]++
			continue

		sticky_set["[match.linked_stickyban]"] = match.linked_stickyban
		ids_to_delete += match.id

	if(!length(ids_to_delete))
		return summary

	var/list/touched_sticky_ids = list()
	for(var/sticky_id in sticky_set)
		touched_sticky_ids += sticky_set[sticky_id]

	summary["purged_records"] = delete_specific_match_records(/datum/entity/stickyban_matched_ckey, ids_to_delete)
	summary["touched_stickies"] = length(touched_sticky_ids)
	summary["deactivated_stickies"] = deactivate_empty_stickies(touched_sticky_ids)
	return summary

/datum/controller/subsystem/stickyban/proc/run_startup_cleanup()
	WAIT_DB_READY

	var/list/global_sync_summary = modular_sync_global_whitelist_from_local_rows()
	if(islist(global_sync_summary))
		var/global_sync_status = global_sync_summary["status"] || "noop"
		var/global_sync_scanned = global_sync_summary["scanned"] || 0
		var/global_sync_synced = global_sync_summary["synced"] || 0
		var/global_sync_skipped = global_sync_summary["skipped_existing"] || 0
		var/global_sync_errors = global_sync_summary["errors"] || 0
		if(global_sync_scanned || global_sync_synced || global_sync_skipped || global_sync_errors || global_sync_status != "noop")
			log_world("StickyBan startup whitelist sync: status=[global_sync_status], scanned=[global_sync_scanned], synced=[global_sync_synced], skipped_existing=[global_sync_skipped], errors=[global_sync_errors].")

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)

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
