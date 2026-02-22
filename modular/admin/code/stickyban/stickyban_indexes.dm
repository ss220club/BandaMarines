/proc/modular_stickyban_build_index(name, list/fields, hints = 0)
	var/datum/db/index/index = new
	index.name = name
	index.fields = fields
	index.hints = hints
	return index

/proc/modular_stickyban_merge_indexes(datum/entity_meta/meta, list/new_indexes)
	if(!meta || !length(new_indexes))
		return

	if(!islist(meta.indexes))
		meta.indexes = list()

	var/list/existing_names = list()
	for(var/datum/db/index/existing_index as anything in meta.indexes)
		if(!existing_index || !existing_index.name)
			continue
		existing_names["[existing_index.name]"] = TRUE

	for(var/datum/db/index/new_index as anything in new_indexes)
		if(!new_index || !new_index.name)
			continue

		var/name_key = "[new_index.name]"
		if(existing_names[name_key])
			continue

		meta.indexes += new_index
		existing_names[name_key] = TRUE

/datum/entity_meta/stickyban/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_active_idx", list("active")),
		modular_stickyban_build_index("stickyban_identifier_date_idx", list("identifier", "date"))
	))

/datum/entity_meta/stickyban_matched_ckey/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_ckey_lookup_idx", list("ckey")),
		modular_stickyban_build_index("stickyban_ckey_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_ckey_pair_idx", list("linked_stickyban", "ckey")),
		modular_stickyban_build_index("stickyban_ckey_whitelist_idx", list("ckey", "whitelisted"))
	))

/datum/entity_meta/stickyban_matched_cid/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_cid_lookup_idx", list("cid")),
		modular_stickyban_build_index("stickyban_cid_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_cid_pair_idx", list("linked_stickyban", "cid"))
	))

/datum/entity_meta/stickyban_matched_ip/New()
	. = ..()
	modular_stickyban_merge_indexes(src, list(
		modular_stickyban_build_index("stickyban_ip_lookup_idx", list("ip")),
		modular_stickyban_build_index("stickyban_ip_by_sticky_idx", list("linked_stickyban")),
		modular_stickyban_build_index("stickyban_ip_pair_idx", list("linked_stickyban", "ip"))
	))
