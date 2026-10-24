/// Thin facade: ссылки sticky-панели.
/datum/admins/proc/modular_sticky_panel_links()
	return modular_sticky_panel_links_service()

/// Thin facade: отдельная панель глобального whitelist.
/datum/admins/proc/modular_show_sticky_whitelist_panel(search_ckey = "")
	return modular_show_sticky_whitelist_panel_service(search_ckey)

/// Thin facade: обработка модульных sticky-действий из Topic().
/datum/admins/proc/modular_handle_sticky_topic_action(list/href_list)
	return modular_handle_sticky_topic_action_service(href_list)

