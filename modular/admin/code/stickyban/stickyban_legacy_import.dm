/datum/controller/subsystem/stickyban/proc/modular_import_sticky(identifier, list/ban_data)
	if(!modular_legacy_expected_from_hook && !modular_cleanup_ready)
		modular_legacy_import_expected++
	modular_legacy_import_jobs++

	try
		modular_import_sticky_inner(identifier, ban_data)
	catch(var/exception/import_error)
		log_world("StickyBan import runtime for legacy identifier '[identifier]': [import_error]")

	modular_finish_legacy_import_job()

/datum/controller/subsystem/stickyban/proc/modular_import_sticky_inner(identifier, list/ban_data)
	WAIT_DB_READY

	if(!identifier || !length(ban_data))
		return

	if(ban_data["type"] != "sticky")
		handle_old_perma(identifier, ban_data)
		return

	if(!ban_data["message"])
		ban_data["message"] = "Evasion"

	var/datum/entity/stickyban/legacy_sticky = find_legacy_sticky(identifier)
	if(!legacy_sticky)
		legacy_sticky = modular_add_legacy_sticky(identifier, ban_data["reason"], ban_data["message"])

	if(!legacy_sticky)
		log_world("StickyBan import failed for legacy identifier '[identifier]': could not resolve sticky record.")
		return

	apply_legacy_import_data(legacy_sticky.id, ban_data)

	if(!clear_legacy_config(identifier))
		log_world("StickyBan import could not clear legacy config entry '[identifier]'. Reimport is idempotent and will reuse existing sticky.")

/datum/controller/subsystem/stickyban/proc/modular_add_legacy_sticky(identifier, reason, message)
	var/old_insert_state = modular_in_legacy_insert
	modular_in_legacy_insert = TRUE

	var/datum/entity/stickyban/new_legacy_sticky
	var/exception/import_error
	try
		new_legacy_sticky = add_stickyban(identifier, reason, message, override_date = "LEGACY")
	catch(var/exception/creation_error)
		import_error = creation_error

	modular_in_legacy_insert = old_insert_state

	if(import_error)
		log_world("StickyBan import runtime while creating legacy sticky '[identifier]': [import_error]")
		return null

	return new_legacy_sticky

/datum/controller/subsystem/stickyban/proc/find_legacy_sticky(identifier)
	if(!identifier)
		return null

	var/list/datum/view_record/stickyban/candidates = DB_VIEW(/datum/view_record/stickyban,
		DB_COMP("identifier", DB_EQUALS, identifier)
	)
	if(!length(candidates))
		return null

	var/selected_id
	var/selected_rank
	for(var/datum/view_record/stickyban/candidate as anything in candidates)
		var/rank = 3
		if(candidate.date == "LEGACY")
			rank = 1
		else if(candidate.active)
			rank = 2

		if(isnull(selected_id))
			selected_id = candidate.id
			selected_rank = rank
			continue

		if(rank < selected_rank)
			selected_id = candidate.id
			selected_rank = rank
			continue

		if(rank == selected_rank && text2num("[candidate.id]") < text2num("[selected_id]"))
			selected_id = candidate.id

	if(isnull(selected_id))
		return null

	var/datum/entity/stickyban/sticky_entity = DB_ENTITY(/datum/entity/stickyban, selected_id)
	if(!sticky_entity)
		return null

	sticky_entity.sync()
	return sticky_entity

/datum/controller/subsystem/stickyban/proc/apply_legacy_import_data(existing_ban_id, list/ban_data)
	if(!existing_ban_id || !length(ban_data))
		return

	var/list/whitelisted = list()
	if(ban_data["whitelist"])
		whitelisted = splittext(ban_data["whitelist"], ",")
		for(var/key in whitelisted)
			whitelist_ckey(existing_ban_id, key)

	if(ban_data["keys"])
		var/list/keys = splittext(ban_data["keys"], ",")
		keys -= whitelisted
		for(var/key in keys)
			add_matched_ckey(existing_ban_id, key)

	if(ban_data["computer_id"])
		var/list/cids = splittext(ban_data["computer_id"], ",")
		for(var/cid in cids)
			add_matched_cid(existing_ban_id, cid)

	if(ban_data["IP"])
		var/list/ips = splittext(ban_data["IP"], ",")
		for(var/ip in ips)
			add_matched_ip(existing_ban_id, ip)

/datum/controller/subsystem/stickyban/proc/clear_legacy_config(identifier)
	world.SetConfig("ban", identifier, null)
	var/list/leftover = params2list(world.GetConfig("ban", identifier))
	return !length(leftover)
