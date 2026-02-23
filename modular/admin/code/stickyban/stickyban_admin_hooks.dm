/// Возвращает модульные ссылки для sticky-панели.
/datum/admins/proc/modular_sticky_panel_links()
	return list(
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;purge_ckey_global=1'>Purge Sticky CKEY</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_audit=1'>Stickyban Audit</a>"
	)

/// Обрабатывает модульные sticky-действия из Topic().
/// Возвращает TRUE, если действие полностью обработано модулем.
/datum/admins/proc/modular_handle_sticky_topic_action(list/href_list)
	if(href_list["sticky_audit"])
		var/list/audit = SSstickyban.run_stickyban_audit()
		var/report_html = audit["report_html"] || "<b>Stickyban Audit</b><br>No data."
		var/candidate_rows = audit["candidate_rows"] || 0
		var/orphan_rows = audit["orphan_rows"] || 0
		var/duplicate_rows = audit["duplicate_rows"] || 0
		var/active_empty = audit["active_empty_stickies"] || 0
		var/root_duplicate_groups = audit["root_duplicate_groups"] || 0

		show_browser(owner, report_html, "Stickyban Audit", "sticky_audit", width = 950, height = 520)
		to_chat(owner, SPAN_ADMIN("Stickyban audit completed: candidates=[candidate_rows], orphans=[orphan_rows], duplicates=[duplicate_rows], active-empty=[active_empty], root-duplicate-groups=[root_duplicate_groups]."))
		message_admins("[key_name_admin(owner)] ran Stickyban Audit (candidates=[candidate_rows], orphans=[orphan_rows], duplicates=[duplicate_rows], active-empty=[active_empty], root-duplicate-groups=[root_duplicate_groups]).")
		return TRUE

	if(href_list["purge_ckey_global"])
		var/ckey_to_purge = ckey(tgui_input_text(owner, "Which CKEY should be globally removed from all stickyban CKEY matches?", "PurgeStickyCkey"))
		if(!ckey_to_purge)
			return TRUE

		var/list/purge_summary = SSstickyban.purge_ckey_globally(ckey_to_purge)
		var/purged_records = purge_summary["purged_records"] || 0
		var/touched_stickies = purge_summary["touched_stickies"] || 0
		var/deactivated_stickies = purge_summary["deactivated_stickies"] || 0

		to_chat(owner, SPAN_ADMIN("Stickyban purge for [ckey_to_purge]: removed [purged_records] CKEY entries across [touched_stickies] stickybans, deactivated [deactivated_stickies] empty stickybans."))
		message_admins("[key_name_admin(owner)] has globally purged stickyban CKEY matches for [ckey_to_purge] ([purged_records] rows removed, [deactivated_stickies] stickybans deactivated).")
		important_message_external("[owner] has globally purged stickyban CKEY matches for [ckey_to_purge].", "Stickyban CKEY Purged")
		return TRUE

	return FALSE
