#define MAINSHIP_CRASHSITE_SAFE_RADIUS 20

/datum/modpack/lv733/proc/spawn_mainship_crashsite()
	if(locate(/obj/effect/landmark/mainship_crashsite) in GLOB.landmarks_list)
		message_admins("[SPAN_NOTICE("LV733 mainship_crashsite: landmark already present, skipping.")]")
		return

	var/list/candidate_turfs = list()
	for(var/area/lv733/outdoors/colony_streets/street_area in GLOB.all_areas)
		for(var/turf/open/T in street_area)
			if(is_ground_level(T.z))
				candidate_turfs += T

	if(!length(candidate_turfs))
		message_admins("[SPAN_DANGER("LV733 mainship_crashsite: no candidate_turfs found in colony_streets areas - landmark NOT placed, hijack ground-crash will fall back to its unreliable corner-scan.")]")
		return

	var/list/turf/exclusion_points = list()
	for(var/obj/effect/landmark/queen_spawn/Q in GLOB.queen_spawns)
		exclusion_points += get_turf(Q)
	if(!length(exclusion_points))
		for(var/obj/effect/landmark/xeno_spawn/X in GLOB.xeno_spawns)
			exclusion_points += get_turf(X)
	for(var/area/lv733/outdoors/landing_zone_1/LZ in GLOB.all_areas)
		for(var/turf/T in LZ)
			exclusion_points += T

	var/list/turf/safe_turfs = list()
	for(var/turf/candidate as anything in candidate_turfs)
		var/too_close = FALSE
		for(var/turf/excluded as anything in exclusion_points)
			if(get_dist(candidate, excluded) < MAINSHIP_CRASHSITE_SAFE_RADIUS)
				too_close = TRUE
				break
		if(!too_close)
			safe_turfs += candidate

	var/turf/chosen = pick(length(safe_turfs) ? safe_turfs : candidate_turfs)
	new /obj/effect/landmark/mainship_crashsite(chosen)
	message_admins("[SPAN_NOTICE("LV733 mainship_crashsite: landmark placed at [ADMIN_VERBOSEJMP(chosen)].")]")

#undef MAINSHIP_CRASHSITE_SAFE_RADIUS
