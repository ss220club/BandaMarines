/datum/admins/proc/modular_sticky_panel_links_service()
	return list(
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_wl_panel=1'>Sticky WL</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;purge_ckey_global=1'>Очистить Sticky CKEY</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_audit=1'>Аудит Stickyban</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_normalize=1'>Нормализовать дубли Stickyban</a>"
	)

/datum/admins/proc/modular_show_sticky_whitelist_panel_service(search_ckey = "")
	var/current_filter = ckey(search_ckey)
	var/list/datum/view_record/stickyban_whitelist/entries = SSstickyban.modular_get_sticky_global_whitelists(current_filter)

	var/list/panel_links = list(
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_wl_add=1;sticky_wl_query=[current_filter]'>Добавить CKEY</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_wl_search=1;sticky_wl_query=[current_filter]'>Поиск по CKEY</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_wl_panel=1'>Сбросить фильтр</a>",
		"<a href='byond://?src=\ref[src];[HrefToken()];sticky=1'>Назад к Stickyban</a>"
	)

	var/data = {"
	<b>Глобальный whitelist Stickyban</b><br>
	[jointext(panel_links, " ")]
	<br>
	Текущий фильтр: [current_filter ? current_filter : "не задан"]
	<br><br>
	<table border=1 rules=all frame=void cellspacing=0 cellpadding=3>
	<tr>
		<th>Действие</th>
		<th>CKEY</th>
		<th>Кто добавил</th>
		<th>Дата</th>
		<th>Источник sticky id</th>
	</tr>
	"}

	if(!length(entries))
		data += "<tr><td colspan='5'>Записи whitelist не найдены.</td></tr>"
	else
		for(var/datum/view_record/stickyban_whitelist/entry as anything in entries)
			var/remove_link = "<a href='byond://?src=\ref[src];[HrefToken()];sticky=1;sticky_wl_remove=1;sticky_wl_target=[entry.ckey];sticky_wl_query=[current_filter]'>(Удалить)</a>"
			var/entry_admin = entry.admin_ckey || "-"
			var/entry_date = entry.date || "-"
			var/entry_source = entry.source_sticky_id || "-"
			data += "<tr><td>[remove_link]</td><td>[entry.ckey]</td><td>[entry_admin]</td><td>[entry_date]</td><td>[entry_source]</td></tr>"

	data += "</table>"
	show_browser(owner, data, "Stickyban Whitelist", "sticky_wl_panel", width = 980, height = 520)

/datum/admins/proc/modular_sticky_handle_wl_search(list/href_list)
	if(!href_list["sticky_wl_search"])
		return FALSE

	var/default_search = ckey(href_list["sticky_wl_query"])
	var/search_input = tgui_input_text(owner, "Введите CKEY для поиска в глобальном whitelist.", "Поиск Sticky WL", default_search)
	if(isnull(search_input))
		modular_show_sticky_whitelist_panel_service(default_search)
		return TRUE

	modular_show_sticky_whitelist_panel_service(search_input)
	return TRUE

/datum/admins/proc/modular_sticky_handle_wl_panel(list/href_list)
	if(!href_list["sticky_wl_panel"])
		return FALSE
	modular_show_sticky_whitelist_panel_service(href_list["sticky_wl_query"])
	return TRUE

/datum/admins/proc/modular_sticky_handle_wl_add(list/href_list)
	if(!href_list["sticky_wl_add"])
		return FALSE

	var/default_add = ckey(href_list["sticky_wl_query"])
	var/ckey_to_add = ckey(tgui_input_text(owner, "Какой CKEY добавить в глобальный whitelist Stickyban?", "Добавить Sticky WL", default_add))
	if(!ckey_to_add)
		modular_show_sticky_whitelist_panel_service(default_add)
		return TRUE

	var/source_sticky_id = href_list["sticky"]
	if(source_sticky_id == "1")
		source_sticky_id = null

	var/datum/entity/stickyban_whitelist/entry = SSstickyban.modular_add_sticky_global_whitelist(ckey_to_add, owner.ckey, source_sticky_id)
	if(entry)
		to_chat(owner, SPAN_ADMIN("CKEY [ckey_to_add] добавлен в глобальный whitelist Stickyban."))
		message_admins("[key_name_admin(owner)] добавил [ckey_to_add] в глобальный whitelist Stickyban.")
	else
		to_chat(owner, SPAN_WARNING("Не удалось добавить [ckey_to_add] в глобальный whitelist Stickyban."))

	modular_show_sticky_whitelist_panel_service(ckey_to_add)
	return TRUE

/datum/admins/proc/modular_sticky_handle_wl_remove(list/href_list)
	if(!href_list["sticky_wl_remove"])
		return FALSE

	var/current_filter = ckey(href_list["sticky_wl_query"])
	var/target_ckey = ckey(href_list["sticky_wl_target"])
	if(!target_ckey)
		target_ckey = ckey(tgui_input_text(owner, "Какой CKEY удалить из глобального whitelist Stickyban?", "Удаление Sticky WL", current_filter))
	if(!target_ckey)
		modular_show_sticky_whitelist_panel_service(current_filter)
		return TRUE

	var/list/remove_summary = SSstickyban.modular_remove_sticky_global_whitelist(target_ckey)
	var/removed = remove_summary["removed"] || 0
	var/status = remove_summary["status"] || "noop"

	if(status == "ok" && removed > 0)
		to_chat(owner, SPAN_ADMIN("CKEY [target_ckey] удален из глобального whitelist Stickyban. Удалено строк: [removed]."))
		message_admins("[key_name_admin(owner)] удалил [target_ckey] из глобального whitelist Stickyban (строк: [removed]).")
	else
		to_chat(owner, SPAN_WARNING("Удаление [target_ckey] из глобального whitelist Stickyban не выполнено (status=[status], removed=[removed])."))

	modular_show_sticky_whitelist_panel_service(current_filter)
	return TRUE

/datum/admins/proc/modular_sticky_handle_whitelist_cluster(list/href_list)
	if(!href_list["whitelist_ckey"])
		return FALSE

	var/sticky_id = href_list["sticky"]
	if(!sticky_id)
		return FALSE

	var/datum/entity/stickyban/sticky = DB_ENTITY(/datum/entity/stickyban, sticky_id)
	if(!sticky)
		to_chat(owner, SPAN_WARNING("Stickyban не найден, whitelist не применен."))
		return TRUE
	sticky.sync()

	var/ckey_to_whitelist = ckey(tgui_input_text(owner, "Какой CKEY добавить в whitelist для граф-кластера Stickyban '[sticky.identifier]'?", "Whitelist Stickyban"))
	if(!ckey_to_whitelist)
		return TRUE

	var/list/summary = SSstickyban.modular_whitelist_ckey_cluster(sticky.id, ckey_to_whitelist, TRUE, owner.ckey)
	if(!islist(summary))
		summary = list()

	var/status = summary["status"] || "partial"
	var/cluster_size = summary["cluster_size"] || 0
	var/roots_processed = summary["roots_processed"] || 0
	var/errors = summary["errors"] || 0
	var/global_saved = summary["global_saved"] ? "да" : "нет"

	if(status == "ok")
		to_chat(owner, SPAN_ADMIN("Whitelist применен для [ckey_to_whitelist]: кластер=[cluster_size], root обработано=[roots_processed], global_saved=[global_saved], ошибок=[errors]."))
		message_admins("[key_name_admin(owner)] применил whitelist [ckey_to_whitelist] к stickyban-кластеру '[sticky.identifier]' (кластер=[cluster_size], root=[roots_processed], global_saved=[global_saved]).")
		important_message_external("[owner] добавил [ckey_to_whitelist] в whitelist stickyban-кластера '[sticky.identifier]'.", "CKEY Whitelisted")
	else
		to_chat(owner, SPAN_WARNING("Whitelist Stickyban выполнен частично: статус=[status], кластер=[cluster_size], root обработано=[roots_processed], global_saved=[global_saved], ошибок=[errors]."))
		message_admins("[key_name_admin(owner)] попытался применить cluster-whitelist [ckey_to_whitelist] к '[sticky.identifier]' (status=[status], cluster=[cluster_size], roots=[roots_processed], global_saved=[global_saved], errors=[errors]).")

	return TRUE

/datum/admins/proc/modular_sticky_handle_audit(list/href_list)
	if(!href_list["sticky_audit"])
		return FALSE

	var/list/audit = SSstickyban.run_stickyban_audit()
	var/report_html = audit["report_html"] || "<b>Аудит Stickyban</b><br>Нет данных."
	var/candidate_rows = audit["candidate_rows"] || 0
	var/orphan_rows = audit["orphan_rows"] || 0
	var/duplicate_rows = audit["duplicate_rows"] || 0
	var/active_empty = audit["active_empty_stickies"] || 0
	var/identifier_duplicate_groups = audit["identifier_duplicate_groups"] || (audit["root_duplicate_groups"] || 0)
	var/graph_duplicate_groups = audit["graph_duplicate_groups"] || 0
	var/global_whitelist_total = audit["global_whitelist_total"] || 0

	show_browser(owner, report_html, "Аудит Stickyban", "sticky_audit", width = 950, height = 520)
	to_chat(owner, SPAN_ADMIN("Аудит Stickyban завершен: кандидаты=[candidate_rows], сироты=[orphan_rows], дубли-пар=[duplicate_rows], active-empty=[active_empty], identifier-группы=[identifier_duplicate_groups], graph-кластеры=[graph_duplicate_groups], global-whitelist=[global_whitelist_total]."))
	message_admins("[key_name_admin(owner)] запустил аудит Stickyban (кандидаты=[candidate_rows], сироты=[orphan_rows], дубли-пар=[duplicate_rows], active-empty=[active_empty], identifier-группы=[identifier_duplicate_groups], graph-кластеры=[graph_duplicate_groups], global-whitelist=[global_whitelist_total]).")
	return TRUE

/datum/admins/proc/modular_sticky_handle_purge_ckey(list/href_list)
	if(!href_list["purge_ckey_global"])
		return FALSE

	var/ckey_to_purge = ckey(tgui_input_text(owner, "Какой CKEY нужно глобально удалить из CKEY-связей stickyban?", "Очистка Sticky CKEY"))
	if(!ckey_to_purge)
		return TRUE

	var/list/purge_summary = SSstickyban.purge_ckey_globally(ckey_to_purge)
	var/purged_records = purge_summary["purged_records"] || 0
	var/touched_stickies = purge_summary["touched_stickies"] || 0
	var/deactivated_stickies = purge_summary["deactivated_stickies"] || 0
	var/preserved_whitelist = purge_summary["preserved_whitelist"] || 0
	var/global_whitelisted = purge_summary["global_whitelisted"] ? "да" : "нет"

	to_chat(owner, SPAN_ADMIN("Очистка Stickyban для [ckey_to_purge]: удалено [purged_records] CKEY-записей в [touched_stickies] stickyban, деактивировано пустых stickyban: [deactivated_stickies], сохранено whitelist-связей: [preserved_whitelist], global-whitelisted=[global_whitelisted]."))
	message_admins("[key_name_admin(owner)] выполнил глобальную очистку CKEY-связей stickyban для [ckey_to_purge] ([purged_records] строк удалено, [deactivated_stickies] stickyban деактивировано, [preserved_whitelist] whitelist-связей сохранено, global-whitelisted=[global_whitelisted]).")
	important_message_external("[owner] выполнил глобальную очистку CKEY-связей stickyban для [ckey_to_purge].", "Очистка Stickyban CKEY")
	return TRUE

/datum/admins/proc/modular_sticky_handle_normalize(list/href_list)
	if(!href_list["sticky_normalize"])
		return FALSE

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

/datum/admins/proc/modular_handle_sticky_topic_action_service(list/href_list)
	if(modular_sticky_handle_wl_search(href_list))
		return TRUE
	if(modular_sticky_handle_wl_panel(href_list))
		return TRUE
	if(modular_sticky_handle_wl_add(href_list))
		return TRUE
	if(modular_sticky_handle_wl_remove(href_list))
		return TRUE
	if(modular_sticky_handle_whitelist_cluster(href_list))
		return TRUE
	if(modular_sticky_handle_audit(href_list))
		return TRUE
	if(modular_sticky_handle_purge_ckey(href_list))
		return TRUE
	if(modular_sticky_handle_normalize(href_list))
		return TRUE

	return FALSE

