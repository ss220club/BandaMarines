/// Возвращает модульные ссылки для sticky-панели.
/datum/admins/proc/modular_sticky_panel_links()
	return list(
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;purge_ckey_global=1'>Очистить Sticky CKEY</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_audit=1'>Аудит Stickyban</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_normalize=1'>Нормализовать дубли Stickyban</a>"
	)

/// Обрабатывает модульные sticky-действия из Topic().
/// Возвращает TRUE, если действие полностью обработано модулем.
/datum/admins/proc/modular_handle_sticky_topic_action(list/href_list)
	if(href_list["whitelist_ckey"])
		var/sticky_id = href_list["sticky"]
		if(!sticky_id)
			return FALSE

		var/datum/entity/stickyban/sticky = DB_ENTITY(/datum/entity/stickyban, sticky_id)
		if(!sticky)
			to_chat(owner, SPAN_WARNING("Stickyban не найден, whitelist не применен."))
			return TRUE
		sticky.sync()

		var/ckey_to_whitelist = ckey(tgui_input_text(owner, "Какой CKEY добавить в белый список для граф-кластера Stickyban '[sticky.identifier]'?", "Белый список Stickyban"))
		if(!ckey_to_whitelist)
			return TRUE

		var/list/summary = SSstickyban.modular_whitelist_ckey_cluster(sticky.id, ckey_to_whitelist, TRUE)
		if(!islist(summary))
			summary = list()

		var/status = summary["status"] || "partial"
		var/cluster_size = summary["cluster_size"] || 0
		var/roots_processed = summary["roots_processed"] || 0
		var/errors = summary["errors"] || 0

		if(status == "ok")
			to_chat(owner, SPAN_ADMIN("Whitelist применен для [ckey_to_whitelist]: кластер=[cluster_size], root обработано=[roots_processed], ошибок=[errors]."))
			message_admins("[key_name_admin(owner)] применил whitelist [ckey_to_whitelist] к stickyban-кластеру '[sticky.identifier]' (кластер=[cluster_size], root=[roots_processed]).")
			important_message_external("[owner] добавил [ckey_to_whitelist] в whitelist stickyban-кластера '[sticky.identifier]'.", "CKEY Whitelisted")
		else
			to_chat(owner, SPAN_WARNING("Whitelist Stickyban выполнен частично: статус=[status], кластер=[cluster_size], root обработано=[roots_processed], ошибок=[errors]."))
			message_admins("[key_name_admin(owner)] попытался применить cluster-whitelist [ckey_to_whitelist] к '[sticky.identifier]' (status=[status], cluster=[cluster_size], roots=[roots_processed], errors=[errors]).")

		return TRUE

	if(href_list["sticky_audit"])
		var/list/audit = SSstickyban.run_stickyban_audit()
		var/report_html = audit["report_html"] || "<b>Аудит Stickyban</b><br>Нет данных."
		var/candidate_rows = audit["candidate_rows"] || 0
		var/orphan_rows = audit["orphan_rows"] || 0
		var/duplicate_rows = audit["duplicate_rows"] || 0
		var/active_empty = audit["active_empty_stickies"] || 0
		var/identifier_duplicate_groups = audit["identifier_duplicate_groups"] || (audit["root_duplicate_groups"] || 0)
		var/graph_duplicate_groups = audit["graph_duplicate_groups"] || 0

		show_browser(owner, report_html, "Аудит Stickyban", "sticky_audit", width = 950, height = 520)
		to_chat(owner, SPAN_ADMIN("Аудит Stickyban завершен: кандидаты=[candidate_rows], сироты=[orphan_rows], дубли-пар=[duplicate_rows], active-empty=[active_empty], identifier-группы=[identifier_duplicate_groups], graph-кластеры=[graph_duplicate_groups]."))
		message_admins("[key_name_admin(owner)] запустил аудит Stickyban (кандидаты=[candidate_rows], сироты=[orphan_rows], дубли-пар=[duplicate_rows], active-empty=[active_empty], identifier-группы=[identifier_duplicate_groups], graph-кластеры=[graph_duplicate_groups]).")
		return TRUE

	if(href_list["purge_ckey_global"])
		var/ckey_to_purge = ckey(tgui_input_text(owner, "Какой CKEY нужно глобально удалить из всех CKEY-связей stickyban?", "Очистка Sticky CKEY"))
		if(!ckey_to_purge)
			return TRUE

		var/list/purge_summary = SSstickyban.purge_ckey_globally(ckey_to_purge)
		var/purged_records = purge_summary["purged_records"] || 0
		var/touched_stickies = purge_summary["touched_stickies"] || 0
		var/deactivated_stickies = purge_summary["deactivated_stickies"] || 0

		to_chat(owner, SPAN_ADMIN("Очистка Stickyban для [ckey_to_purge]: удалено [purged_records] CKEY-записей в [touched_stickies] stickyban, деактивировано пустых stickyban: [deactivated_stickies]."))
		message_admins("[key_name_admin(owner)] выполнил глобальную очистку CKEY-связей stickyban для [ckey_to_purge] ([purged_records] строк удалено, [deactivated_stickies] stickyban деактивировано).")
		important_message_external("[owner] выполнил глобальную очистку CKEY-связей stickyban для [ckey_to_purge].", "Очистка Stickyban CKEY")
		return TRUE

	if(href_list["sticky_normalize"])
		var/list/normalize_summary = SSstickyban.modular_normalize_root_duplicates(TRUE)
		if(!islist(normalize_summary))
			normalize_summary = list()

		var/status = normalize_summary["status"] || "noop"
		var/id_before = normalize_summary["before_identifier_duplicates"] || (normalize_summary["before_duplicates"] || (normalize_summary["duplicates_found"] || 0))
		var/id_after = normalize_summary["after_identifier_duplicates"] || (normalize_summary["after_duplicates"] || 0)
		var/graph_groups = normalize_summary["before_graph_clusters"] || 0
		var/graph_before = normalize_summary["before_graph_duplicates"] || 0
		var/graph_after = normalize_summary["after_graph_duplicates"] || 0
		var/roots_deleted = normalize_summary["duplicates_deleted"] || 0
		var/matches_moved = normalize_summary["matches_moved"] || 0
		var/errors = normalize_summary["errors"] || 0

		to_chat(owner, SPAN_ADMIN("Нормализация Stickyban завершена: статус=[status], id-дубли до=[id_before], id-дубли после=[id_after], graph-кластеров=[graph_groups], graph-дублей до=[graph_before], graph-дублей после=[graph_after], root удалено=[roots_deleted], связей перенесено=[matches_moved], ошибок=[errors]."))
		message_admins("[key_name_admin(owner)] запустил нормализацию Stickyban (статус=[status], id-дубли до=[id_before], id-дубли после=[id_after], graph-кластеров=[graph_groups], graph-дублей до=[graph_before], graph-дублей после=[graph_after], root удалено=[roots_deleted], связей перенесено=[matches_moved], ошибок=[errors]).")
		important_message_external("[owner] запустил нормализацию Stickyban (identifier + graph).", "Нормализация Stickyban")

		stickypanel()
		return TRUE

	return FALSE
