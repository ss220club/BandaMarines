/datum/modpack/lv733/proc/fixup_missing_synth_landmarks()
	place_synth_landmark_near(/obj/effect/landmark/survivor_spawner/twe/roaf, /obj/effect/landmark/survivor_spawner/twe/roaf/synth)
	place_synth_landmark_near(/obj/effect/landmark/survivor_spawner/clf_wy, /obj/effect/landmark/survivor_spawner/clf_wy/synth)

/datum/modpack/lv733/proc/place_synth_landmark_near(camp_landmark_type, synth_landmark_type)
	if(locate(synth_landmark_type) in GLOB.landmarks_list)
		return

	var/obj/effect/landmark/survivor_spawner/anchor
	for(var/priority in GLOB.survivor_spawns_by_priority)
		for(var/obj/effect/landmark/survivor_spawner/spawner as anything in GLOB.survivor_spawns_by_priority[priority])
			if(istype(spawner, camp_landmark_type))
				anchor = spawner
				break
		if(anchor)
			break

	if(!anchor)
		return

	new synth_landmark_type(get_turf(anchor))
