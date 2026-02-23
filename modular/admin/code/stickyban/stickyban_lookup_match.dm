/datum/controller/subsystem/stickyban/proc/modular_check_for_sticky_ban(ckey, address, computer_id)
	var/list/stickyban_id_set = list()

	for(var/datum/view_record/stickyban_matched_ckey/matched_ckey as anything in get_impacted_ckey_records(ckey))
		stickyban_id_set["[matched_ckey.linked_stickyban]"] = matched_ckey.linked_stickyban

	for(var/datum/view_record/stickyban_matched_cid/matched_cid as anything in get_impacted_cid_records(computer_id))
		stickyban_id_set["[matched_cid.linked_stickyban]"] = matched_cid.linked_stickyban

	if(!SSipcheck.is_whitelisted(ckey))
		for(var/datum/view_record/stickyban_matched_ip/matched_ip as anything in get_impacted_ip_records(address))
			stickyban_id_set["[matched_ip.linked_stickyban]"] = matched_ip.linked_stickyban

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

	ckey = ckey(ckey)
	if(ckey)
		var/list/sticky_ids = list()
		for(var/datum/view_record/stickyban/current_sticky as anything in stickies)
			sticky_ids += current_sticky.id

		if(length(sticky_ids))
			var/list/datum/view_record/stickyban_matched_ckey/whitelisted_records = DB_VIEW(/datum/view_record/stickyban_matched_ckey,
				DB_AND(
					DB_COMP("linked_stickyban", DB_IN, sticky_ids),
					DB_COMP("ckey", DB_EQUALS, ckey),
					DB_COMP("whitelisted", DB_EQUALS, TRUE)
				)
			)

			if(length(whitelisted_records))
				var/list/whitelisted_sticky_ids = list()
				for(var/datum/view_record/stickyban_matched_ckey/whitelisted_record as anything in whitelisted_records)
					whitelisted_sticky_ids["[whitelisted_record.linked_stickyban]"] = TRUE

				for(var/datum/view_record/stickyban/current_sticky as anything in stickies.Copy())
					if(whitelisted_sticky_ids["[current_sticky.id]"])
						stickies -= current_sticky

	if(!length(stickies))
		return FALSE

	return stickies

/datum/controller/subsystem/stickyban/proc/modular_match_sticky(existing_ban_id, ckey, address, computer_id)
	if(!existing_ban_id)
		return

	// Сохраняем политику против раздувания таблиц: не создаём авто-связь по CKEY при логине.
	if(address)
		add_matched_ip(existing_ban_id, address)

	if(computer_id)
		add_matched_cid(existing_ban_id, computer_id)

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
	// Избегаем двусмысленного порядка операций с оператором `in`.
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
