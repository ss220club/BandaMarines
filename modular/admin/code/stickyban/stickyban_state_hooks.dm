/datum/controller/subsystem/stickyban
	var/modular_legacy_import_jobs = 0
	var/modular_legacy_import_expected = 0
	var/modular_legacy_import_completed = 0
	var/modular_legacy_expected_from_hook = FALSE
	var/modular_cleanup_done = FALSE
	var/modular_cleanup_ready = FALSE
	var/modular_in_legacy_insert = FALSE
	var/modular_root_dedup_in_progress = FALSE

/datum/controller/subsystem/stickyban/proc/modular_set_expected_legacy_jobs(total_jobs)
	if(!isnum(total_jobs))
		total_jobs = text2num("[total_jobs]")
	if(!isnum(total_jobs))
		total_jobs = 0

	total_jobs = max(0, round(total_jobs))
	modular_legacy_import_expected = total_jobs
	modular_legacy_expected_from_hook = TRUE

	// Инициализация уже могла завершиться, тогда cleanup можно запустить сразу.
	modular_try_run_startup_cleanup()

/datum/controller/subsystem/stickyban/proc/modular_post_initialize()
	modular_cleanup_ready = TRUE

	// Резервная ветка для совместимости, если upstream-хук не был подтянут.
	if(!modular_legacy_expected_from_hook)
		var/legacy_entries = length(world.GetConfig("ban"))
		if(legacy_entries > modular_legacy_import_expected)
			modular_legacy_import_expected = legacy_entries

	modular_try_run_startup_cleanup()

/datum/controller/subsystem/stickyban/proc/modular_try_run_startup_cleanup()
	if(modular_cleanup_done || !modular_cleanup_ready || modular_legacy_import_jobs > 0)
		return FALSE
	if(modular_legacy_import_completed < modular_legacy_import_expected)
		return FALSE

	modular_cleanup_done = TRUE
	INVOKE_ASYNC(src, PROC_REF(run_startup_cleanup))
	return TRUE

/datum/controller/subsystem/stickyban/proc/modular_finish_legacy_import_job()
	if(modular_legacy_import_jobs > 0)
		modular_legacy_import_jobs--
	else
		modular_legacy_import_jobs = 0

	modular_legacy_import_completed++
	modular_try_run_startup_cleanup()

/datum/entity_meta/stickyban/proc/modular_on_insert(datum/entity/stickyban/new_sticky)
	if(!SSstickyban || !new_sticky)
		return FALSE
	return SSstickyban.modular_in_legacy_insert
