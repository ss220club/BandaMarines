/datum/controller/subsystem/stickyban/proc/modular_count_signal_bits(signal_mask)
	var/signal_count = 0
	if(signal_mask & STICKY_SIGNAL_CKEY)
		signal_count++
	if(signal_mask & STICKY_SIGNAL_CID)
		signal_count++
	if(signal_mask & STICKY_SIGNAL_IP)
		signal_count++
	return signal_count

/datum/controller/subsystem/stickyban/proc/modular_collect_whitelisted_cluster_ids_for_ckey(list/seed_ids, key, include_inactive = TRUE)
	var/list/exempt_ids = list()
	if(!length(seed_ids))
		return exempt_ids

	key = ckey(key)
	if(!key)
		return exempt_ids

	// Сначала берем все локальные whitelist-строки для ckey.
	var/list/datum/view_record/stickyban_matched_ckey/whitelisted_records = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_AND(
			DB_COMP("ckey", DB_EQUALS, key),
			DB_COMP("whitelisted", DB_EQUALS, TRUE)
		)
	)
	if(!length(whitelisted_records))
		return exempt_ids

	var/list/seed_set = list()
	for(var/seed_id in seed_ids)
		if(isnull(seed_id) || seed_id == "")
			continue
		seed_set["[seed_id]"] = TRUE
	if(!length(seed_set))
		return exempt_ids

	var/list/whitelisted_root_ids = list()
	for(var/datum/view_record/stickyban_matched_ckey/record as anything in whitelisted_records)
		whitelisted_root_ids += record.linked_stickyban

	// Для whitelist-логики нужен расширенный граф (включая whitelisted CKEY-связи).
	var/list/whitelist_cluster_ids = modular_collect_graph_cluster_ids_for_seed_ids(whitelisted_root_ids, include_inactive, TRUE, TRUE, TRUE)
	whitelist_cluster_ids = modular_dedupe_ids(whitelist_cluster_ids)
	if(!length(whitelist_cluster_ids))
		return exempt_ids

	// Исключаем только если whitelist-кластер реально пересекается с seed-веткой текущих кандидатов.
	for(var/cluster_id in whitelist_cluster_ids)
		if(seed_set["[cluster_id]"])
			return whitelist_cluster_ids

	return exempt_ids

/datum/controller/subsystem/stickyban/proc/modular_check_for_sticky_ban(ckey, address, computer_id)
	ckey = ckey(ckey)
	if(ckey && modular_is_sticky_ckey_globally_whitelisted(ckey))
		return FALSE

	var/list/signal_mask_by_id = list()
	var/list/sticky_id_by_key = list()
	var/list/stickyban_id_set = list()

	for(var/datum/view_record/stickyban_matched_ckey/matched_ckey as anything in get_impacted_ckey_records(ckey))
		var/id_key = "[matched_ckey.linked_stickyban]"
		sticky_id_by_key[id_key] = matched_ckey.linked_stickyban
		var/current_mask = signal_mask_by_id[id_key] || 0
		signal_mask_by_id[id_key] = current_mask | STICKY_SIGNAL_CKEY

	for(var/datum/view_record/stickyban_matched_cid/matched_cid as anything in get_impacted_cid_records(computer_id))
		var/id_key = "[matched_cid.linked_stickyban]"
		sticky_id_by_key[id_key] = matched_cid.linked_stickyban
		var/current_mask = signal_mask_by_id[id_key] || 0
		signal_mask_by_id[id_key] = current_mask | STICKY_SIGNAL_CID

	if(!SSipcheck.is_whitelisted(ckey))
		for(var/datum/view_record/stickyban_matched_ip/matched_ip as anything in get_impacted_ip_records(address))
			var/id_key = "[matched_ip.linked_stickyban]"
			sticky_id_by_key[id_key] = matched_ip.linked_stickyban
			var/current_mask = signal_mask_by_id[id_key] || 0
			signal_mask_by_id[id_key] = current_mask | STICKY_SIGNAL_IP

	for(var/id_key in signal_mask_by_id)
		var/current_mask = signal_mask_by_id[id_key] || 0
		var/has_direct_ckey_hit = !!(current_mask & STICKY_SIGNAL_CKEY)
		var/signal_count = modular_count_signal_bits(current_mask)
		if(!has_direct_ckey_hit && signal_count < 2)
			continue
		stickyban_id_set[id_key] = sticky_id_by_key[id_key]

	if(!length(stickyban_id_set))
		return FALSE

	var/list/stickyban_ids = list()
	for(var/id_key in stickyban_id_set)
		stickyban_ids += stickyban_id_set[id_key]

	var/list/datum/view_record/stickyban/stickies = DB_VIEW(/datum/view_record/stickyban,
		DB_AND(
			DB_COMP("id", DB_IN, stickyban_ids),
			DB_COMP("active", DB_EQUALS, TRUE)
		)
	)
	if(!length(stickies))
		return FALSE

	if(ckey)
		var/list/seed_ids = list()
		for(var/datum/view_record/stickyban/current_sticky as anything in stickies)
			seed_ids += current_sticky.id

		var/list/exempt_cluster_ids = modular_collect_whitelisted_cluster_ids_for_ckey(seed_ids, ckey, TRUE)
		exempt_cluster_ids = modular_dedupe_ids(exempt_cluster_ids)
		if(length(exempt_cluster_ids))
			var/list/exempt_set = list()
			for(var/exempt_id in exempt_cluster_ids)
				exempt_set["[exempt_id]"] = TRUE

			for(var/datum/view_record/stickyban/current_sticky as anything in stickies.Copy())
				if(exempt_set["[current_sticky.id]"])
					stickies -= current_sticky

	if(!length(stickies))
		return FALSE

	return stickies

/datum/controller/subsystem/stickyban/proc/modular_match_sticky(existing_ban_id, ckey, address, computer_id)
	if(!existing_ban_id)
		return

	ckey = ckey(ckey)
	if(ckey && modular_is_sticky_ckey_globally_whitelisted(ckey))
		return

	if(ckey)
		var/list/exempt_cluster_ids = modular_collect_whitelisted_cluster_ids_for_ckey(list(existing_ban_id), ckey, TRUE)
		if(length(exempt_cluster_ids))
			return

	// Сохраняем anti-bloat политику: не создаем авто-связь по CKEY на логине.
	var/wrote_rows = FALSE
	if(address)
		add_matched_ip(existing_ban_id, address)
		wrote_rows = TRUE

	if(computer_id)
		add_matched_cid(existing_ban_id, computer_id)
		wrote_rows = TRUE

	if(wrote_rows)
		modular_invalidate_graph_cache("match_sticky")

/datum/controller/subsystem/stickyban/proc/modular_get_impacted_ckey_records(key)
	key = ckey(key)
	if(!key)
		return list()

	return DB_VIEW(/datum/view_record/stickyban_matched_ckey,
		DB_AND(
			DB_COMP("ckey", DB_EQUALS, key),
			DB_COMP("whitelisted", DB_EQUALS, FALSE)
		)
	)

/datum/controller/subsystem/stickyban/proc/modular_get_impacted_cid_records(cid)
	if(!cid)
		return list()

	var/list/ignored_cids = CONFIG_GET(str_list/ignored_cids)
	if(islist(ignored_cids))
		if(cid in ignored_cids)
			return list()

	return DB_VIEW(/datum/view_record/stickyban_matched_cid,
		DB_COMP("cid", DB_EQUALS, cid)
	)

/datum/controller/subsystem/stickyban/proc/modular_get_impacted_ip_records(ip)
	if(!ip)
		return list()

	return DB_VIEW(/datum/view_record/stickyban_matched_ip,
		DB_COMP("ip", DB_EQUALS, ip)
	)
