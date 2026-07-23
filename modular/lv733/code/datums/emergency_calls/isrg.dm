#define LV733_ISRG_ERT_CHANCE 70
#define LV733_RAC_ERT_CHANCE 50

/datum/emergency_call/lv733_isrg_response
	name = "Спасательной группа ISRG"
	mob_max = 5
	mob_min = 1
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_medics = 1
	max_smartgunners = 1

/datum/emergency_call/lv733_isrg_response/New()
	..()
	arrival_message = "Спасательная группа ISRG получила ваш сигнал. Выдвигаемся для оценки угрозы и проведении эвакуационного протокола."
	objectives = "Прибыть на место. Оценить угрозу. Обеспечить безопасность гражданских и сотрудников WY. Оказать поддержку и эвакуацию."

/datum/emergency_call/lv733_isrg_response/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()
	if(!istype(spawn_loc))
		return

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы командир спасательной группы ISRG!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/isrg/leader, TRUE, TRUE)
	else if(smartgunners < max_smartgunners && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SMARTGUNNER) && check_timelock(mob.client, JOB_SQUAD_SMARTGUN, time_required_for_job))
		smartgunners++
		to_chat(mob, SPAN_ROLE_HEADER("Вы смартганер спасательной группы ISRG!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/isrg/smartgunner, TRUE, TRUE)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("Вы кинолог-медик спасательной группы ISRG!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/isrg, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы боец спасательной группы ISRG!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/isrg/rescuer, TRUE, TRUE)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Задача: [objectives]")), 1 SECONDS)

/datum/game_mode/colonialmarines/activate_distress()
	if(SSmapping.configs[GROUND_MAP].map_name == MAP_LV733_WHITCHLER_POINT)
		if(prob(LV733_ISRG_ERT_CHANCE))
			ert_dispatched = TRUE
			get_specific_call(/datum/emergency_call/lv733_isrg_response)
			return
		if(prob(LV733_RAC_ERT_CHANCE))
			ert_dispatched = TRUE
			get_specific_call(/datum/emergency_call/lv733_rac_response)
			return
	return ..()
