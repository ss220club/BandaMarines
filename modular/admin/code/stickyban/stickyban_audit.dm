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
		"root_duplicate_groups" = 0,
		"root_duplicate_rows" = 0,
		"report_html" = "<b>Stickyban Audit</b><br>No data."
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

	audit["candidate_rows"] = (ckey_stats["candidates"] || 0) + (cid_stats["candidates"] || 0) + (ip_stats["candidates"] || 0)
	audit["orphan_rows"] = (ckey_stats["orphans"] || 0) + (cid_stats["orphans"] || 0) + (ip_stats["orphans"] || 0)
	audit["duplicate_rows"] = (ckey_stats["duplicates"] || 0) + (cid_stats["duplicates"] || 0) + (ip_stats["duplicates"] || 0)

	var/list/active_empty_examples = list()
	for(var/datum/view_record/stickyban/sticky as anything in all_stickies)
		if(!sticky.active)
			continue
		if(stickies_with_matches["[sticky.id]"])
			continue

		audit["active_empty_stickies"]++
		if(length(active_empty_examples) < 20)
			active_empty_examples += "[sticky.identifier] (id=[sticky.id])"

	var/list/root_duplicate_examples = list()
	var/list/root_duplicate_groups = modular_collect_root_duplicate_groups(TRUE, TRUE)
	if(!islist(root_duplicate_groups))
		root_duplicate_groups = list()

	audit["root_duplicate_groups"] = length(root_duplicate_groups)
	for(var/list/group_data as anything in root_duplicate_groups)
		var/list/stickies = group_data["stickies"]
		if(!islist(stickies) || !length(stickies))
			continue

		audit["root_duplicate_rows"] += length(stickies)
		if(length(root_duplicate_examples) >= 20)
			continue

		var/datum/view_record/stickyban/sample = stickies[1]
		var/list/group_ids = list()
		for(var/datum/view_record/stickyban/current as anything in stickies)
			group_ids += current.id
		var/strict_key = group_data["strict_key"] || modular_build_normalized_strict_key(sample.identifier, sample.reason, sample.message)
		var/strict_key_view = replacetext("[strict_key]", "\x1E", " | ")
		root_duplicate_examples += "[sample.identifier] | [sample.reason] | [sample.message] | key=[strict_key_view] -> [jointext(group_ids, ", ")]"

	var/list/report_lines = list()
	report_lines += "<b>Stickyban Audit</b>"
	report_lines += "Stickies total: [audit["total_stickies"]] (active: [audit["active_stickies"]], inactive: [audit["inactive_stickies"]])."
	report_lines += "Rows flagged for cleanup (no mutation): [audit["candidate_rows"]] (CKEY: [ckey_stats["candidates"] || 0], CID: [cid_stats["candidates"] || 0], IP: [ip_stats["candidates"] || 0])."
	report_lines += "Detected orphan rows: [audit["orphan_rows"]] (CKEY: [ckey_stats["orphans"] || 0], CID: [cid_stats["orphans"] || 0], IP: [ip_stats["orphans"] || 0])."
	report_lines += "Detected duplicate pairs: [audit["duplicate_rows"]] (CKEY: [ckey_stats["duplicates"] || 0], CID: [cid_stats["duplicates"] || 0], IP: [ip_stats["duplicates"] || 0])."
	report_lines += "Active empty stickies (kept intact): [audit["active_empty_stickies"]]."

	if(length(active_empty_examples))
		report_lines += "Active-empty examples: [jointext(active_empty_examples, "; ")]"

	report_lines += "Root strict-key duplicates (report-only): [audit["root_duplicate_groups"]] groups / [audit["root_duplicate_rows"]] rows."
	if(length(root_duplicate_examples))
		report_lines += "Root duplicate examples: [jointext(root_duplicate_examples, "; ")]"

	audit["report_html"] = jointext(report_lines, "<br>")
	return audit
