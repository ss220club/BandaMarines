/datum/controller/subsystem/stickyban
	var/modular_cleanup_done = FALSE
	var/modular_root_dedup_in_progress = FALSE

	// Кэш граф-индекса stickyban для hot-path на логине.
	var/list/modular_graph_cache = list()
	var/modular_graph_cache_stamp = 0
	var/modular_graph_cache_rev = 0
	var/modular_graph_cache_reason = "initial"

/datum/controller/subsystem/stickyban/proc/modular_post_initialize()
	if(modular_cleanup_done)
		return

	modular_cleanup_done = TRUE
	INVOKE_ASYNC(src, PROC_REF(run_startup_cleanup))

/datum/entity_meta/stickyban/proc/modular_on_insert(datum/entity/stickyban/new_sticky)
	// Перехватываем legacy on_insert и инвалидиуем кеш графа.
	if(hascall(SSstickyban, "modular_invalidate_graph_cache"))
		SSstickyban.modular_invalidate_graph_cache("sticky_insert")
	return TRUE

