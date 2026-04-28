#define STICKY_SIGNAL_CKEY 1
#define STICKY_SIGNAL_CID 2
#define STICKY_SIGNAL_IP 4

// 5 секунд (world.time в деци-секундах).
#define STICKY_GRAPH_CACHE_TTL_DS 50

/datum/controller/subsystem/stickyban/proc/modular_dedupe_ids(list/raw_ids)
	var/list/deduped_ids = list()
	var/list/seen_ids = list()

	for(var/id in raw_ids)
		if(isnull(id) || id == "")
			continue

		var/id_key = "[id]"
		if(seen_ids[id_key])
			continue

		seen_ids[id_key] = TRUE
		deduped_ids += id

	return deduped_ids
