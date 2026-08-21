// Nightmare-система на LV733 каждый раунд случайно выбирает ОДИН лагерь выживших (ROAF/RAC/CLF-WY/ISRG,
// см. modular/lv733/maps/Nightmare/LV733_Whitchler_Point/scenario.json). В самих .dmm лагерей ROAF и CLF-WY
// нет отдельного лендмарка под синта - без archetype = INSERT_SYNTH синт-выживший job-системой вообще
// не подбирается (RAC был точно такой же баг, его починили переносом одного из лендмарков на карте;
// для ROAF/CLF-WY свободного лендмарка на карте под перенос нет, поэтому лендмарк синта ставим кодом,
// на той же тайле, где уже стоит любой лендмарк этого лагеря - если лагерь в этом раунде не выбран,
// его лендмарков на карте не будет вообще, и proc ничего не делает).

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
