/datum/emergency_call/lv733_rac_response
	name = "Группа реагирования RAC"
	mob_max = 5
	mob_min = 1
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT4
	home_base = /datum/lazy_template/ert/twe_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_medics = 1
	max_engineers = 1
	var/synths = 0
	var/max_synths = 1

/datum/emergency_call/lv733_rac_response/New()
	..()
	arrival_message = "Группа реагирования Royal Armored Cavalry получила ваш сигнал бедствия. Выдвигаемся для оценки обстановки и оказания поддержки."
	objectives = "Прибыть на место. Оценить угрозу. Оказать поддержку и обеспечить эвакуацию."

/datum/emergency_call/lv733_rac_response/proc/upgrade_armor(mob/living/carbon/human/mob, obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert/new_vest_type)
	var/obj/item/old_suit = mob.wear_suit
	if(old_suit)
		qdel(old_suit)
	mob.equip_to_slot_or_del(new new_vest_type(mob), WEAR_JACKET)

/datum/emergency_call/lv733_rac_response/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()
	if(!istype(spawn_loc))
		return

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_TWE_RAC_COMMANDER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы командир группы реагирования RAC!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/whitchler/rac_commander, TRUE, TRUE)
		upgrade_armor(mob, /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_TWE_RAC_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("Вы медик группы реагирования RAC!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/rac/medic, TRUE, TRUE)
		upgrade_armor(mob, /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert/medic)
	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_TWE_RAC_ENGI, time_required_for_job))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("Вы инженер группы реагирования RAC!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/rac/engi, TRUE, TRUE)
		upgrade_armor(mob, /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert)
	else if(synths < max_synths && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("Вы синтетик группы реагирования RAC!"))
		arm_equipment(mob, /datum/equipment_preset/synth/survivor/rac_synth, TRUE, TRUE)
		upgrade_armor(mob, /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert)
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы стрелок группы реагирования RAC!"))
		arm_equipment(mob, /datum/equipment_preset/survivor/rac, TRUE, TRUE)
		upgrade_armor(mob, /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/rac_vest_ert)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Задача: [objectives]")), 1 SECONDS)
