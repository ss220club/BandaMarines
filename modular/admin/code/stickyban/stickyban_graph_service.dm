/datum/controller/subsystem/stickyban/proc/modular_build_graph_cache_key(include_inactive = TRUE, use_ip_gated = TRUE, include_whitelisted_ckey = FALSE)
	return "[include_inactive ? 1 : 0]|[use_ip_gated ? 1 : 0]|[include_whitelisted_ckey ? 1 : 0]"

/datum/controller/subsystem/stickyban/proc/modular_invalidate_graph_cache(reason = "unknown")
	modular_graph_cache = list()
	modular_graph_cache_stamp = world.time
	modular_graph_cache_rev++
	modular_graph_cache_reason = "[reason]"

/datum/controller/subsystem/stickyban/proc/modular_get_graph_index_cached(include_inactive = TRUE, use_ip_gated = TRUE, include_whitelisted_ckey = FALSE)
	if(!islist(modular_graph_cache))
		modular_graph_cache = list()

	var/cache_key = modular_build_graph_cache_key(include_inactive, use_ip_gated, include_whitelisted_ckey)
	var/list/cache_entry = modular_graph_cache[cache_key]
	var/current_time = world.time

	if(islist(cache_entry))
		var/cached_rev = text2num("[cache_entry["rev"]]")
		var/cached_stamp = text2num("[cache_entry["stamp"]]")
		var/rev_is_actual = (cached_rev == modular_graph_cache_rev)
		var/ttl_is_actual = ((current_time - cached_stamp) <= STICKY_GRAPH_CACHE_TTL_DS)
		if(rev_is_actual && ttl_is_actual)
			var/list/cached_index = cache_entry["index"]
			if(islist(cached_index))
				return cached_index

	var/list/graph_index = modular_build_graph_index(include_inactive, use_ip_gated, include_whitelisted_ckey)
	modular_graph_cache[cache_key] = list(
		"index" = graph_index,
		"rev" = modular_graph_cache_rev,
		"stamp" = current_time,
	)
	modular_graph_cache_stamp = current_time
	return graph_index

/datum/controller/subsystem/stickyban/proc/modular_collect_graph_clusters_from_index(list/graph_index, include_singletons = FALSE)
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

/datum/controller/subsystem/stickyban/proc/modular_collect_component_ids_from_graph_index(list/graph_index, list/seed_ids)
	var/list/result_ids = list()
	if(!islist(graph_index) || !length(seed_ids))
		return result_ids

	var/list/sticky_by_id = graph_index["sticky_by_id"]
	var/list/target_ids = graph_index["target_ids"]
	var/list/neighbors = graph_index["neighbors"]
	if(!islist(sticky_by_id) || !islist(target_ids) || !islist(neighbors))
		return result_ids

	var/list/target_set = list()
	for(var/id_key in target_ids)
		target_set[id_key] = TRUE

	var/list/seed_set = list()
	for(var/seed_id in seed_ids)
		if(isnull(seed_id) || seed_id == "")
			continue
		var/seed_key = "[seed_id]"
		if(!target_set[seed_key])
			continue
		seed_set[seed_key] = TRUE

	if(!length(seed_set))
		return result_ids

	var/list/visited = list()
	var/list/stack = list()
	for(var/seed_key in seed_set)
		stack += seed_key
		visited[seed_key] = TRUE

	while(length(stack))
		var/current_key = stack[length(stack)]
		stack.len--

		var/datum/view_record/stickyban/current_sticky = sticky_by_id[current_key]
		if(current_sticky)
			result_ids += current_sticky.id
		else
			var/current_id_num = text2num(current_key)
			if(current_id_num)
				result_ids += current_id_num
			else
				result_ids += current_key

		var/list/current_neighbors = neighbors[current_key]
		if(!islist(current_neighbors) || !length(current_neighbors))
			continue

		for(var/neighbor_key in current_neighbors)
			if(visited[neighbor_key])
				continue
			visited[neighbor_key] = TRUE
			stack += neighbor_key

	return modular_dedupe_ids(result_ids)
