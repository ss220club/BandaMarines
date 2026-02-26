/datum/controller/subsystem/stickyban
	var/modular_cleanup_done = FALSE
	var/modular_root_dedup_in_progress = FALSE

/datum/controller/subsystem/stickyban/proc/modular_post_initialize()
	if(modular_cleanup_done)
		return

	modular_cleanup_done = TRUE
	INVOKE_ASYNC(src, PROC_REF(run_startup_cleanup))

/datum/entity_meta/stickyban/proc/modular_on_insert(datum/entity/stickyban/new_sticky)
	// Всегда перехватываем legacy on_insert логику из хардкода.
	return TRUE
