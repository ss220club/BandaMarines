/datum/controller/subsystem/stickyban/proc/modular_normalize_identifier(identifier)
	if(isnull(identifier))
		return ""
	return ckey(trim("[identifier]"))

/datum/controller/subsystem/stickyban/proc/modular_collect_stickies_for_identifier(identifier, include_inactive = TRUE)
	var/list/matches = list()
	var/normalized_identifier = modular_normalize_identifier(identifier)
	if(!normalized_identifier)
		return matches

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!include_inactive && !sticky.active)
			continue

		if(modular_normalize_identifier(sticky.identifier) != normalized_identifier)
			continue

		matches += sticky

	return matches

/datum/controller/subsystem/stickyban/proc/modular_pick_canonical_sticky_id(list/datum/view_record/stickyban/stickies)
	if(!length(stickies))
		return null

	var/canonical_id
	var/canonical_active = FALSE
	var/canonical_id_num = -1

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

		if(current_active == canonical_active && current_id_num > canonical_id_num)
			canonical_id = sticky.id
			canonical_id_num = current_id_num

	return canonical_id

/datum/controller/subsystem/stickyban/proc/modular_pick_newest_sticky_id(list/datum/view_record/stickyban/stickies)
	var/newest_id
	var/newest_id_num = -1

	for(var/datum/view_record/stickyban/sticky as anything in stickies)
		if(!sticky)
			continue

		var/current_id_num = text2num("[sticky.id]")
		if(current_id_num <= newest_id_num)
			continue

		newest_id = sticky.id
		newest_id_num = current_id_num

	return newest_id

/datum/controller/subsystem/stickyban/proc/modular_pick_cluster_identifier(list/datum/view_record/stickyban/stickies, canonical_id)
	var/newest_identifier = ""
	var/newest_id_num = -1
	var/fallback_identifier = ""
	var/fallback_id_num = -1

	for(var/datum/view_record/stickyban/sticky as anything in stickies)
		if(!sticky)
			continue

		var/current_id_num = text2num("[sticky.id]")
		var/normalized_identifier = modular_normalize_identifier(sticky.identifier)

		if(current_id_num > newest_id_num)
			newest_id_num = current_id_num
			newest_identifier = normalized_identifier

		if(normalized_identifier && current_id_num > fallback_id_num)
			fallback_id_num = current_id_num
			fallback_identifier = normalized_identifier

	if(newest_identifier)
		return newest_identifier

	if(fallback_identifier)
		return fallback_identifier

	return "legacy_empty_[canonical_id]"

/datum/controller/subsystem/stickyban/proc/modular_apply_cluster_fields_to_canonical(canonical_id, list/datum/view_record/stickyban/stickies)
	var/datum/entity/stickyban/canonical_sticky = DB_ENTITY(/datum/entity/stickyban, canonical_id)
	if(!canonical_sticky)
		return FALSE

	var/newest_id = modular_pick_newest_sticky_id(stickies)
	var/datum/view_record/stickyban/newest_view
	for(var/datum/view_record/stickyban/sticky as anything in stickies)
		if("[sticky.id]" == "[newest_id]")
			newest_view = sticky
			break

	var/new_identifier = modular_pick_cluster_identifier(stickies, canonical_id)
	var/new_admin_id = null
	if(newest_id)
		var/datum/entity/stickyban/newest_entity = DB_ENTITY(/datum/entity/stickyban, newest_id)
		if(newest_entity)
			newest_entity.sync()
			new_admin_id = newest_entity.adminid

	canonical_sticky.sync()
	canonical_sticky.identifier = new_identifier
	canonical_sticky.active = TRUE
	if(newest_view)
		canonical_sticky.reason = newest_view.reason
		canonical_sticky.message = newest_view.message
		canonical_sticky.date = newest_view.date
	canonical_sticky.adminid = new_admin_id
	canonical_sticky.save()
	canonical_sticky.sync()
	return TRUE

/datum/controller/subsystem/stickyban/proc/modular_collect_root_duplicate_groups(include_inactive = TRUE)
	WAIT_DB_READY

	var/list/duplicate_groups = list()
	var/list/grouped_by_identifier = list()
	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)

	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!include_inactive && !sticky.active)
			continue

		var/identifier_key = modular_normalize_identifier(sticky.identifier)
		if(!identifier_key)
			continue

		if(!islist(grouped_by_identifier[identifier_key]))
			grouped_by_identifier[identifier_key] = list()

		var/list/current_group = grouped_by_identifier[identifier_key]
		current_group += sticky

	for(var/identifier_key in grouped_by_identifier)
		var/list/current_group = grouped_by_identifier[identifier_key]
		if(length(current_group) <= 1)
			continue

		duplicate_groups[length(duplicate_groups) + 1] = list(
			"identifier" = identifier_key,
			"stickies" = current_group,
		)

	return duplicate_groups

/datum/controller/subsystem/stickyban/proc/modular_build_duplicate_stats(list/duplicate_groups)
	var/list/stats = list(
		"groups" = 0,
		"duplicates" = 0,
		"rows" = 0,
	)

	for(var/list/group_data as anything in duplicate_groups)
		var/list/stickies = group_data["stickies"]
		if(!islist(stickies) || length(stickies) <= 1)
			continue

		var/group_size = length(stickies)
		stats["groups"]++
		stats["rows"] += group_size
		stats["duplicates"] += max(0, group_size - 1)

	return stats

/datum/controller/subsystem/stickyban/proc/modular_add_graph_edge(list/neighbors, left_id_key, right_id_key)
	if(!left_id_key || !right_id_key || left_id_key == right_id_key)
		return

	if(!islist(neighbors[left_id_key]))
		neighbors[left_id_key] = list()
	if(!islist(neighbors[right_id_key]))
		neighbors[right_id_key] = list()

	var/list/left_neighbors = neighbors[left_id_key]
	var/list/right_neighbors = neighbors[right_id_key]
	left_neighbors[right_id_key] = TRUE
	right_neighbors[left_id_key] = TRUE

/datum/controller/subsystem/stickyban/proc/modular_connect_graph_group(list/neighbors, list/group_id_keys)
	if(length(group_id_keys) <= 1)
		return

	var/anchor_key = group_id_keys[1]
	for(var/i in 2 to length(group_id_keys))
		modular_add_graph_edge(neighbors, anchor_key, group_id_keys[i])

/datum/controller/subsystem/stickyban/proc/modular_build_graph_index(include_inactive = TRUE, use_ip_gated = TRUE)
	WAIT_DB_READY

	var/list/graph_index = list(
		"sticky_by_id" = list(),
		"target_ids" = list(),
		"neighbors" = list(),
		"strong_signal_by_id" = list(),
		"identifier_key_by_id" = list(),
	)

	var/list/sticky_by_id = graph_index["sticky_by_id"]
	var/list/target_ids = graph_index["target_ids"]
	var/list/neighbors = graph_index["neighbors"]
	var/list/strong_signal_by_id = graph_index["strong_signal_by_id"]
	var/list/identifier_key_by_id = graph_index["identifier_key_by_id"]

	var/list/target_set = list()
	var/list/identifier_to_ids = list()
	var/list/ckey_to_ids = list()
	var/list/cid_to_ids = list()
	var/list/ip_to_ids = list()

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!include_inactive && !sticky.active)
			continue

		var/id_key = "[sticky.id]"
		target_ids += id_key
		target_set[id_key] = TRUE
		sticky_by_id[id_key] = sticky
		identifier_key_by_id[id_key] = modular_normalize_identifier(sticky.identifier)
		if(!islist(neighbors[id_key]))
			neighbors[id_key] = list()

		var/identifier_key = identifier_key_by_id[id_key]
		if(identifier_key)
			if(!islist(identifier_to_ids[identifier_key]))
				identifier_to_ids[identifier_key] = list()
			var/list/identifier_id_set = identifier_to_ids[identifier_key]
			identifier_id_set[id_key] = TRUE

	if(!length(target_ids))
		return graph_index

	var/list/datum/view_record/stickyban_matched_ckey/ckey_rows = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_COMP("whitelisted", DB_EQUALS, FALSE)
	)
	for(var/datum/view_record/stickyban_matched_ckey/row as anything in ckey_rows)
		var/id_key = "[row.linked_stickyban]"
		if(!target_set[id_key])
			continue

		var/key = ckey(row.ckey)
		if(!key)
			continue

		if(!islist(ckey_to_ids[key]))
			ckey_to_ids[key] = list()
		var/list/ckey_id_set = ckey_to_ids[key]
		ckey_id_set[id_key] = TRUE

	var/list/datum/view_record/stickyban_matched_cid/cid_rows = DB_VIEW(/datum/view_record/stickyban_matched_cid)
	for(var/datum/view_record/stickyban_matched_cid/row as anything in cid_rows)
		var/id_key = "[row.linked_stickyban]"
		if(!target_set[id_key])
			continue

		var/cid_value = "[row.cid]"
		if(!cid_value)
			continue

		if(!islist(cid_to_ids[cid_value]))
			cid_to_ids[cid_value] = list()
		var/list/cid_id_set = cid_to_ids[cid_value]
		cid_id_set[id_key] = TRUE

	var/list/datum/view_record/stickyban_matched_ip/ip_rows = DB_VIEW(/datum/view_record/stickyban_matched_ip)
	for(var/datum/view_record/stickyban_matched_ip/row as anything in ip_rows)
		var/id_key = "[row.linked_stickyban]"
		if(!target_set[id_key])
			continue

		var/ip_value = "[row.ip]"
		if(!ip_value)
			continue

		if(!islist(ip_to_ids[ip_value]))
			ip_to_ids[ip_value] = list()
		var/list/ip_id_set = ip_to_ids[ip_value]
		ip_id_set[id_key] = TRUE

	for(var/identifier_key in identifier_to_ids)
		var/list/identifier_id_set = identifier_to_ids[identifier_key]
		if(length(identifier_id_set) <= 1)
			continue

		var/list/group_id_keys = list()
		for(var/id_key in identifier_id_set)
			group_id_keys += id_key
			strong_signal_by_id[id_key] = TRUE
		modular_connect_graph_group(neighbors, group_id_keys)

	for(var/key in ckey_to_ids)
		var/list/ckey_id_set = ckey_to_ids[key]
		if(length(ckey_id_set) <= 1)
			continue

		var/list/group_id_keys = list()
		for(var/id_key in ckey_id_set)
			group_id_keys += id_key
			strong_signal_by_id[id_key] = TRUE
		modular_connect_graph_group(neighbors, group_id_keys)

	for(var/cid_value in cid_to_ids)
		var/list/cid_id_set = cid_to_ids[cid_value]
		if(length(cid_id_set) <= 1)
			continue

		var/list/group_id_keys = list()
		for(var/id_key in cid_id_set)
			group_id_keys += id_key
			strong_signal_by_id[id_key] = TRUE
		modular_connect_graph_group(neighbors, group_id_keys)

	for(var/ip_value in ip_to_ids)
		var/list/ip_id_set = ip_to_ids[ip_value]
		if(length(ip_id_set) <= 1)
			continue

		var/list/group_id_keys = list()
		for(var/id_key in ip_id_set)
			if(!use_ip_gated || strong_signal_by_id[id_key])
				group_id_keys += id_key
		if(length(group_id_keys) <= 1)
			continue

		modular_connect_graph_group(neighbors, group_id_keys)

	return graph_index

/datum/controller/subsystem/stickyban/proc/modular_collect_graph_clusters(include_inactive = TRUE, use_ip_gated = TRUE, include_singletons = FALSE)
	var/list/graph_index = modular_build_graph_index(include_inactive, use_ip_gated)
	var/list/sticky_by_id = graph_index["sticky_by_id"]
	var/list/target_ids = graph_index["target_ids"]
	var/list/neighbors = graph_index["neighbors"]

	var/list/visited = list()
	var/list/clusters = list()

	for(var/id_key in target_ids)
		if(visited[id_key])
			continue

		var/list/stack = list(id_key)
		visited[id_key] = TRUE
		var/list/cluster_id_keys = list()

		while(length(stack))
			var/current_key = stack[length(stack)]
			stack.len--
			cluster_id_keys += current_key

			var/list/current_neighbors = neighbors[current_key]
			if(!islist(current_neighbors) || !length(current_neighbors))
				continue

			for(var/neighbor_key in current_neighbors)
				if(visited[neighbor_key])
					continue
				visited[neighbor_key] = TRUE
				stack += neighbor_key

		if(!include_singletons && length(cluster_id_keys) <= 1)
			continue

		var/list/datum/view_record/stickyban/stickies = list()
		var/list/cluster_ids = list()
		for(var/node_key in cluster_id_keys)
			var/datum/view_record/stickyban/sticky = sticky_by_id[node_key]
			if(!sticky)
				continue
			stickies += sticky
			cluster_ids += sticky.id

		clusters[length(clusters) + 1] = list(
			"stickies" = stickies,
			"cluster_ids" = modular_dedupe_ids(cluster_ids),
		)

	return clusters

/datum/controller/subsystem/stickyban/proc/modular_build_graph_cluster_stats(list/graph_clusters)
	var/list/stats = list(
		"groups" = 0,
		"duplicates" = 0,
		"rows" = 0,
	)

	for(var/list/cluster_data as anything in graph_clusters)
		var/list/cluster_ids = cluster_data["cluster_ids"]
		if(!islist(cluster_ids))
			continue

		var/cluster_size = length(cluster_ids)
		if(cluster_size <= 1)
			continue

		stats["groups"]++
		stats["rows"] += cluster_size
		stats["duplicates"] += max(0, cluster_size - 1)

	return stats

/datum/controller/subsystem/stickyban/proc/modular_collect_graph_cluster_ids_for_seed_ids(list/seed_ids, include_inactive = TRUE, use_ip_gated = TRUE)
	var/list/result_ids = list()
	if(!length(seed_ids))
		return result_ids

	var/list/seed_set = list()
	for(var/seed_id in seed_ids)
		if(isnull(seed_id) || seed_id == "")
			continue
		seed_set["[seed_id]"] = TRUE

	if(!length(seed_set))
		return result_ids

	var/list/graph_clusters = modular_collect_graph_clusters(include_inactive, use_ip_gated, TRUE)
	for(var/list/cluster_data as anything in graph_clusters)
		var/list/cluster_ids = cluster_data["cluster_ids"]
		if(!islist(cluster_ids) || !length(cluster_ids))
			continue

		var/has_seed = FALSE
		for(var/cluster_id in cluster_ids)
			if(seed_set["[cluster_id]"])
				has_seed = TRUE
				break

		if(!has_seed)
			continue

		result_ids += cluster_ids

	return modular_dedupe_ids(result_ids)

/datum/controller/subsystem/stickyban/proc/modular_collect_match_record_ids_for_stickies(view_type, list/sticky_ids, chunk_size = 500)
	var/list/record_ids = list()
	if(!length(sticky_ids))
		return record_ids

	var/list/datum/view_record/matches = modular_collect_match_rows_for_sticky_ids(view_type, sticky_ids, chunk_size)
	for(var/datum/view_record/match as anything in matches)
		record_ids += match.vars["id"]

	return modular_dedupe_ids(record_ids)

/datum/controller/subsystem/stickyban/proc/modular_resolve_stickyban_for_add(identifier, reason, message, datum/entity/player/banning_admin, override_date)
	var/normalized_identifier = modular_normalize_identifier(identifier)
	if(!normalized_identifier)
		return null

	var/list/datum/view_record/stickyban/matched_candidates = modular_collect_stickies_for_identifier(normalized_identifier, TRUE)
	if(!length(matched_candidates))
		return null

	var/canonical_id = modular_pick_canonical_sticky_id(matched_candidates)
	if(isnull(canonical_id))
		return null

	var/datum/entity/stickyban/existing_sticky = DB_ENTITY(/datum/entity/stickyban, canonical_id)
	if(!existing_sticky)
		return null

	existing_sticky.sync()
	existing_sticky.identifier = normalized_identifier
	existing_sticky.reason = reason
	existing_sticky.message = message
	existing_sticky.active = TRUE
	if(banning_admin)
		existing_sticky.adminid = banning_admin.id
	existing_sticky.date = override_date ? override_date : "[time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")]"
	existing_sticky.save()
	existing_sticky.sync()
	return existing_sticky

/datum/controller/subsystem/stickyban/proc/modular_move_matches_to_canonical(canonical_id, duplicate_id)
	var/list/summary = list(
		"source_rows" = 0,
		"deleted_rows" = 0,
		"errors" = 0,
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
		"before_identifier_groups" = 0,
		"before_identifier_duplicates" = 0,
		"after_identifier_groups" = 0,
		"after_identifier_duplicates" = 0,
		"before_graph_clusters" = 0,
		"before_graph_duplicates" = 0,
		"after_graph_clusters" = 0,
		"after_graph_duplicates" = 0,
		"graph_clusters_processed" = 0,
		"status" = "noop",
	)

	var/list/identifier_groups_before = modular_collect_root_duplicate_groups(TRUE)
	var/list/identifier_stats_before = modular_build_duplicate_stats(identifier_groups_before)
	var/list/graph_clusters_before = modular_collect_graph_clusters(TRUE, TRUE, FALSE)
	var/list/graph_stats_before = modular_build_graph_cluster_stats(graph_clusters_before)

	summary["before_identifier_groups"] = identifier_stats_before["groups"] || 0
	summary["before_identifier_duplicates"] = identifier_stats_before["duplicates"] || 0
	summary["before_graph_clusters"] = graph_stats_before["groups"] || 0
	summary["before_graph_duplicates"] = graph_stats_before["duplicates"] || 0

	summary["before_groups"] = summary["before_identifier_groups"]
	summary["before_duplicates"] = summary["before_identifier_duplicates"]
	summary["groups"] = summary["before_identifier_groups"]
	summary["duplicates_found"] = summary["before_identifier_duplicates"]

	if(!summary["before_graph_duplicates"])
		summary["after_identifier_groups"] = summary["before_identifier_groups"]
		summary["after_identifier_duplicates"] = summary["before_identifier_duplicates"]
		summary["after_graph_clusters"] = summary["before_graph_clusters"]
		summary["after_graph_duplicates"] = summary["before_graph_duplicates"]
		summary["after_groups"] = summary["after_identifier_groups"]
		summary["after_duplicates"] = summary["after_identifier_duplicates"]
		return summary

	if(!perform_mutation)
		summary["status"] = "preview"
		summary["after_identifier_groups"] = summary["before_identifier_groups"]
		summary["after_identifier_duplicates"] = summary["before_identifier_duplicates"]
		summary["after_graph_clusters"] = summary["before_graph_clusters"]
		summary["after_graph_duplicates"] = summary["before_graph_duplicates"]
		summary["after_groups"] = summary["after_identifier_groups"]
		summary["after_duplicates"] = summary["after_identifier_duplicates"]
		return summary

	if(modular_root_dedup_in_progress)
		summary["status"] = "busy"
		summary["after_identifier_groups"] = summary["before_identifier_groups"]
		summary["after_identifier_duplicates"] = summary["before_identifier_duplicates"]
		summary["after_graph_clusters"] = summary["before_graph_clusters"]
		summary["after_graph_duplicates"] = summary["before_graph_duplicates"]
		summary["after_groups"] = summary["after_identifier_groups"]
		summary["after_duplicates"] = summary["after_identifier_duplicates"]
		return summary

	modular_root_dedup_in_progress = TRUE
	var/list/roots_to_delete = list()
	var/processed_clusters = 0

	try
		for(var/list/cluster_data as anything in graph_clusters_before)
			var/list/datum/view_record/stickyban/stickies = cluster_data["stickies"]
			if(!islist(stickies) || length(stickies) <= 1)
				continue

			var/canonical_id = modular_pick_canonical_sticky_id(stickies)
			if(isnull(canonical_id))
				summary["errors"]++
				continue

			if(!modular_apply_cluster_fields_to_canonical(canonical_id, stickies))
				summary["errors"]++

			var/canonical_key = "[canonical_id]"
			for(var/datum/view_record/stickyban/sticky as anything in stickies)
				if("[sticky.id]" == canonical_key)
					continue

				var/list/move_summary = modular_move_matches_to_canonical(canonical_id, sticky.id)
				summary["matches_moved"] += move_summary["source_rows"] || 0
				summary["errors"] += move_summary["errors"] || 0
				roots_to_delete += sticky.id

			processed_clusters++
			if(!(processed_clusters % 25))
				stoplag()

		summary["graph_clusters_processed"] = processed_clusters
		summary["duplicates_deleted"] = modular_delete_root_records_batch(roots_to_delete)
	catch(var/exception/normalization_error)
		summary["errors"]++
		log_world("StickyBan graph normalize runtime error: [normalization_error]")

	modular_root_dedup_in_progress = FALSE

	var/list/identifier_groups_after = modular_collect_root_duplicate_groups(TRUE)
	var/list/identifier_stats_after = modular_build_duplicate_stats(identifier_groups_after)
	var/list/graph_clusters_after = modular_collect_graph_clusters(TRUE, TRUE, FALSE)
	var/list/graph_stats_after = modular_build_graph_cluster_stats(graph_clusters_after)

	summary["after_identifier_groups"] = identifier_stats_after["groups"] || 0
	summary["after_identifier_duplicates"] = identifier_stats_after["duplicates"] || 0
	summary["after_graph_clusters"] = graph_stats_after["groups"] || 0
	summary["after_graph_duplicates"] = graph_stats_after["duplicates"] || 0

	summary["after_groups"] = summary["after_identifier_groups"]
	summary["after_duplicates"] = summary["after_identifier_duplicates"]

	if(summary["after_graph_duplicates"] <= 0 && summary["errors"] <= 0)
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
		"identifier" = "",
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

	summary["identifier"] = modular_normalize_identifier(source_sticky.identifier)

	var/list/seed_ids = list(source_sticky.id)
	var/list/cluster_ids = modular_collect_graph_cluster_ids_for_seed_ids(seed_ids, include_inactive, TRUE)
	cluster_ids = modular_dedupe_ids(cluster_ids)
	if(!length(cluster_ids))
		cluster_ids += source_sticky.id

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
