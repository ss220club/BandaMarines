/datum/controller/subsystem/stickyban/proc/run_stickyban_audit()
	WAIT_DB_READY

	var/list/audit = list(
		"total_stickies" = 0,
		"active_stickies" = 0,
		"inactive_stickies" = 0,
		"candidate_rows" = 0,
		"orphan_rows" = 0,
		"duplicate_rows" = 0,
		"active_empty_stickies" = 0,
		"identifier_duplicate_groups" = 0,
		"identifier_duplicate_rows" = 0,
		"identifier_duplicate_duplicates" = 0,
		"graph_duplicate_groups" = 0,
		"graph_duplicate_rows" = 0,
		"graph_duplicate_duplicates" = 0,
		// Ключи совместимости для существующего UI.
		"root_duplicate_groups" = 0,
		"root_duplicate_rows" = 0,
		"report_html" = "<b>Аудит Stickyban</b><br>Нет данных.",
	)

	var/list/datum/view_record/stickyban/all_stickies = DB_VIEW(/datum/view_record/stickyban)
	audit["total_stickies"] = length(all_stickies)
	if(!length(all_stickies))
		return audit

	var/list/sticky_lookup = list()
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		sticky_lookup["[sticky.id]"] = TRUE
		if(sticky.active)
			audit["active_stickies"]++
		else
			audit["inactive_stickies"]++

	var/list/stickies_with_matches = list()
	var/list/ckey_stats = cleanup_ckey_matches(sticky_lookup, FALSE, stickies_with_matches)
	var/list/cid_stats = cleanup_pair_matches(/datum/view_record/stickyban_matched_cid, /datum/entity/stickyban_matched_cid, "cid", sticky_lookup, FALSE, stickies_with_matches)
	var/list/ip_stats = cleanup_pair_matches(/datum/view_record/stickyban_matched_ip, /datum/entity/stickyban_matched_ip, "ip", sticky_lookup, FALSE, stickies_with_matches)

	var/ckey_candidates = ckey_stats["candidates"] || 0
	var/cid_candidates = cid_stats["candidates"] || 0
	var/ip_candidates = ip_stats["candidates"] || 0
	var/ckey_orphans = ckey_stats["orphans"] || 0
	var/cid_orphans = cid_stats["orphans"] || 0
	var/ip_orphans = ip_stats["orphans"] || 0
	var/ckey_duplicates = ckey_stats["duplicates"] || 0
	var/cid_duplicates = cid_stats["duplicates"] || 0
	var/ip_duplicates = ip_stats["duplicates"] || 0

	audit["candidate_rows"] = ckey_candidates + cid_candidates + ip_candidates
	audit["orphan_rows"] = ckey_orphans + cid_orphans + ip_orphans
	audit["duplicate_rows"] = ckey_duplicates + cid_duplicates + ip_duplicates

	var/list/active_empty_examples = list()
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!sticky.active)
			continue
		if(stickies_with_matches["[sticky.id]"])
			continue

		audit["active_empty_stickies"]++
		if(length(active_empty_examples) < 20)
			active_empty_examples += "[sticky.identifier] (id=[sticky.id])"

	var/list/identifier_duplicate_examples = list()
	var/list/identifier_groups = modular_collect_root_duplicate_groups(TRUE)
	if(!islist(identifier_groups))
		identifier_groups = list()

	var/list/identifier_stats = modular_build_duplicate_stats(identifier_groups)
	audit["identifier_duplicate_groups"] = identifier_stats["groups"] || 0
	audit["identifier_duplicate_rows"] = identifier_stats["rows"] || 0
	audit["identifier_duplicate_duplicates"] = identifier_stats["duplicates"] || 0
	audit["root_duplicate_groups"] = audit["identifier_duplicate_groups"]
	audit["root_duplicate_rows"] = audit["identifier_duplicate_rows"]

	for(var/list/group_data as anything in identifier_groups)
		if(length(identifier_duplicate_examples) >= 20)
			break

		var/list/stickies = group_data["stickies"]
		if(!islist(stickies) || !length(stickies))
			continue

		var/list/group_ids = list()
		for(var/datum/view_record/stickyban/current as anything in stickies)
			group_ids += current.id
		var/group_ids_text = jointext(group_ids, ", ")
		var/group_identifier = group_data["identifier"] || ""
		identifier_duplicate_examples += "identifier=[group_identifier] -> [group_ids_text]"

	var/list/graph_duplicate_examples = list()
	var/list/graph_clusters = modular_collect_graph_clusters(TRUE, TRUE, FALSE)
	if(!islist(graph_clusters))
		graph_clusters = list()

	var/list/graph_stats = modular_build_graph_cluster_stats(graph_clusters)
	audit["graph_duplicate_groups"] = graph_stats["groups"] || 0
	audit["graph_duplicate_rows"] = graph_stats["rows"] || 0
	audit["graph_duplicate_duplicates"] = graph_stats["duplicates"] || 0

	for(var/list/cluster_data as anything in graph_clusters)
		if(length(graph_duplicate_examples) >= 20)
			break

		var/list/cluster_ids = cluster_data["cluster_ids"]
		if(!islist(cluster_ids) || length(cluster_ids) <= 1)
			continue

		var/cluster_ids_text = jointext(cluster_ids, ", ")
		graph_duplicate_examples += "кластер -> [cluster_ids_text]"

	var/total_stickies = audit["total_stickies"] || 0
	var/active_stickies = audit["active_stickies"] || 0
	var/inactive_stickies = audit["inactive_stickies"] || 0
	var/candidate_rows = audit["candidate_rows"] || 0
	var/orphan_rows = audit["orphan_rows"] || 0
	var/duplicate_rows = audit["duplicate_rows"] || 0
	var/active_empty_stickies = audit["active_empty_stickies"] || 0
	var/identifier_duplicate_groups = audit["identifier_duplicate_groups"] || 0
	var/identifier_duplicate_rows = audit["identifier_duplicate_rows"] || 0
	var/identifier_duplicate_duplicates = audit["identifier_duplicate_duplicates"] || 0
	var/graph_duplicate_groups = audit["graph_duplicate_groups"] || 0
	var/graph_duplicate_rows = audit["graph_duplicate_rows"] || 0
	var/graph_duplicate_duplicates = audit["graph_duplicate_duplicates"] || 0

	var/list/report_lines = list()
	report_lines += "<b>Аудит Stickyban</b>"
	report_lines += "Всего stickyban: [total_stickies] (active: [active_stickies], inactive: [inactive_stickies])."
	report_lines += "Кандидаты на очистку (без мутаций): [candidate_rows] (CKEY: [ckey_candidates], CID: [cid_candidates], IP: [ip_candidates])."
	report_lines += "Сиротские строки: [orphan_rows] (CKEY: [ckey_orphans], CID: [cid_orphans], IP: [ip_orphans])."
	report_lines += "Дубли строк-пар: [duplicate_rows] (CKEY: [ckey_duplicates], CID: [cid_duplicates], IP: [ip_duplicates])."
	report_lines += "Пустые active stickyban: [active_empty_stickies]."

	if(length(active_empty_examples))
		var/active_empty_text = jointext(active_empty_examples, "; ")
		report_lines += "Примеры active-empty: [active_empty_text]"

	report_lines += "Группы дублей по identifier: [identifier_duplicate_groups] / строк: [identifier_duplicate_rows] / дублей: [identifier_duplicate_duplicates]."
	if(length(identifier_duplicate_examples))
		var/identifier_examples_text = jointext(identifier_duplicate_examples, "; ")
		report_lines += "Примеры дублей по identifier: [identifier_examples_text]"

	report_lines += "Граф-кластеры дублей: [graph_duplicate_groups] / строк: [graph_duplicate_rows] / дублей: [graph_duplicate_duplicates]."
	if(length(graph_duplicate_examples))
		var/graph_examples_text = jointext(graph_duplicate_examples, "; ")
		report_lines += "Примеры граф-кластеров: [graph_examples_text]"

	audit["report_html"] = jointext(report_lines, "<br>")
	return audit
