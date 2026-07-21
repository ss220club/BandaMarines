// Слоп ивент падения кораблы на 50й минуте, чтобы не было скучно

#define SHIP_CRASH_WARN_DELAY   (2 MINUTES)  // буффер
#define SHIP_CRASH_ZONE_WIDTH   24
#define SHIP_CRASH_ZONE_HEIGHT  30
#define SHIP_CRASH_ERT_MAX      5
#define SHIP_CRASH_ERT_SYNTHS   1
#define SHIP_CRASH_LARVA_PER_N  8            // НАДО ТЕСТИТЬ
#define SHIP_CRASH_SAFE_RADIUS  20           // минимальная дистанция до хайва и домашней ЛЗ

/obj/effect/lv733/crash_warning_overlay
	name = "зона падения"
	icon = 'icons/turf/overlays.dmi'
	icon_state = "greenOverlay"
	color = "#FF4400"
	alpha = 120
	layer = ABOVE_TURF_LAYER
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

// ERT

/datum/emergency_call/lv733_crash_response
	name = "LV-733: Спасательная группа ROAF"
	mob_max = SHIP_CRASH_ERT_MAX
	mob_min = 1
	probability = 0
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_medics = 1
	max_engineers = 1
	var/max_synths = 0
	var/synths = 0

/datum/emergency_call/lv733_crash_response/New()
	..()
	max_synths = SHIP_CRASH_ERT_SYNTHS
	arrival_message = "38-я КВАОГ, аварийная группа. Фиксируем крушение судна на LV-733. Держитесь!."
	objectives = "Провести оценку угрозы. Обеспечить безопасность периметра. Соединиться с выжившими и другими."

/datum/emergency_call/lv733_crash_response/proc/equip_crash_response_member(mob/living/carbon/human/new_human, eyes_type, right_pouch_type)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/veteran/royal_marine/lv733/roaf_uniform(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/royal_marine/knife/lv733/shoes_roaf(new_human), WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/veteran/royal_marine/lv733/hands_roaf(new_human), WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/lv733/roaf_beret(new_human), WEAR_HEAD)
	if(eyes_type)
		new_human.equip_to_slot_or_del(new eyes_type(new_human), WEAR_EYES)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/roaf(new_human), WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/veteran/royal_marine/light/iasf(new_human), WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/webbing/iasf(new_human), WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/lightpack/five_slot(new_human), WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/general_belt(new_human), WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/survival/full(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new right_pouch_type(new_human), WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/rmc_f90(new_human), WEAR_J_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human), WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/rmc_f90(new_human.back), WEAR_IN_BACK)

/datum/emergency_call/lv733_crash_response/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()
	if(!istype(spawn_loc))
		return

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы командир группы реагирования ROAF!"))
		equip_crash_response_member(mob, /obj/item/clothing/glasses/sunglasses/aviator/silver, /obj/item/storage/pouch/firstaid/full/alternate)
	else if(synths < max_synths && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("Вы синтетик группы реагирования ROAF!"))
		arm_equipment(mob, /datum/equipment_preset/synth/survivor/roaf_synth, TRUE, TRUE)
	else if(engineers < max_engineers && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_ENGINEER) && check_timelock(mob.client, JOB_SQUAD_ENGI, time_required_for_job))
		engineers++
		to_chat(mob, SPAN_ROLE_HEADER("Вы инженер группы реагирования ROAF!"))
		equip_crash_response_member(mob, /obj/item/clothing/glasses/welding, /obj/item/storage/pouch/firstaid/full/alternate)
		mob.equip_to_slot_or_del(new /obj/item/stack/sheet/metal/med_small_stack(mob.back), WEAR_IN_BACK)
	else if(medics < max_medics && HAS_FLAG(mob.client.prefs.toggles_ert, PLAY_MEDIC) && check_timelock(mob.client, JOB_SQUAD_MEDIC, time_required_for_job))
		medics++
		to_chat(mob, SPAN_ROLE_HEADER("Вы медик группы реагирования ROAF!"))
		equip_crash_response_member(mob, /obj/item/clothing/glasses/hud/health, /obj/item/storage/pouch/medkit/full_rmc)
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы боец группы реагирования ROAF!"))
		equip_crash_response_member(mob, null, /obj/item/storage/pouch/firstaid/full/alternate)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Задача: [objectives]")), 1 SECONDS)

/datum/round_event_control/lv733_ship_crash
	name = "LV-733: Падение корабля"
	typepath = /datum/round_event/lv733_ship_crash
	weight = 0
	earliest_start = 3 MINUTES
	max_occurrences = 1
	alert_observers = TRUE

/datum/round_event_control/lv733_ship_crash/can_spawn_event(players_amt, gamemode)
	if(SSmapping.configs[GROUND_MAP].map_name != MAP_LV733_WHITCHLER_POINT)
		return FALSE
	return ..()

/proc/trigger_lv733_ship_crash()
	var/datum/round_event_control/E = locate(/datum/round_event_control/lv733_ship_crash) in SSevents.control
	if(!E)
		return
	E.run_event()


/datum/round_event/lv733_ship_crash
	var/turf/crash_turf = null
	var/list/warning_overlays = list()

/datum/round_event/lv733_ship_crash/setup()
	startWhen = SHIP_CRASH_WARN_DELAY / SSevents.wait
	endWhen = startWhen + 1

/datum/round_event/lv733_ship_crash/announce()
	var/list/candidate_turfs = list()
	for(var/area/lv733/outdoors/colony_streets/street_area in GLOB.all_areas)
		for(var/turf/open/T in street_area)
			if(is_ground_level(T.z))
				candidate_turfs += T

	if(!length(candidate_turfs))
		return

	// Точки, от которых корабль обязан упасть не ближе SHIP_CRASH_SAFE_RADIUS: хайв ксеноморфов и домашняя ЛЗ ROAF.
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
			if(get_dist(candidate, excluded) < SHIP_CRASH_SAFE_RADIUS)
				too_close = TRUE
				break
		if(!too_close)
			safe_turfs += candidate

	// Если внезапно вся карта оказалась в зоне отчуждения - не блокируем ивент, падаем куда есть.
	crash_turf = pick(length(safe_turfs) ? safe_turfs : candidate_turfs)

	var/turf/corner = locate(crash_turf.x - floor(SHIP_CRASH_ZONE_WIDTH/2), crash_turf.y - floor(SHIP_CRASH_ZONE_HEIGHT/2), crash_turf.z)
	for(var/tx = corner.x to corner.x + SHIP_CRASH_ZONE_WIDTH - 1)
		for(var/ty = corner.y to corner.y + SHIP_CRASH_ZONE_HEIGHT - 1)
			var/turf/T = locate(tx, ty, crash_turf.z)
			if(T && is_ground_level(T.z))
				var/obj/effect/lv733/crash_warning_overlay/O = new(T)
				warning_overlays += O

	marine_announcement(
		"Внимание! Зафиксировано падение корабля в атмосфере LV-733. Неконтролируемое падение. Зона поражения обозначена. Немедленно покиньте отмеченный район!",
		"ПРЕДУПРЕЖДЕНИЕ О ПАДЕНИИ ОБЪЕКТА",
		sound('sound/misc/notice2.ogg')
	)

	// ТЕСТ (Ожидается, что ерт будет вызвано в 51:45 и заспавнено где-то в 52:15 (Падение шипа в 52:00))
	addtimer(CALLBACK(SSticker.mode, TYPE_PROC_REF(/datum/game_mode, get_specific_call), /datum/emergency_call/lv733_crash_response, FALSE, TRUE), SHIP_CRASH_WARN_DELAY - 15 SECONDS)

/datum/round_event/lv733_ship_crash/start()
	for(var/obj/effect/lv733/crash_warning_overlay/O in warning_overlays)
		qdel(O)
	warning_overlays.Cut()

	if(!crash_turf)
		message_admins("[SPAN_DANGER("LV733 ship_crash: start() aborted — crash_turf is null.")]")
		return

	var/ship_path = "maps/map_files/LV733_Whitchler_Point/standalone/ship_crash.dmm"
	if(!fexists(ship_path))
		message_admins("[SPAN_DANGER("LV733 ship_crash: fexists() says '[ship_path]' does NOT exist relative to the server's working directory. This is a path/CWD problem, not a parsing problem.")]")
		return
	var/datum/map_template/template = new(ship_path)
	if(!template.width || !template.height)
		message_admins("[SPAN_DANGER("LV733 ship_crash: file exists but failed to parse '[ship_path]' (width=[template.width], height=[template.height]). Likely a DMM format/regex issue in the file content.")]")
		return

	// Раздавить всё живое в зоне посадки корабля ДО загрузки шаблона - иначе тела молча
	// удалятся вместе с остальным мусором ниже (delete = TRUE), без сообщения о смерти.
	var/turf/footprint_corner = locate(crash_turf.x - floor(template.width/2), crash_turf.y - floor(template.height/2), crash_turf.z)
	if(footprint_corner)
		for(var/tx = footprint_corner.x to footprint_corner.x + template.width - 1)
			for(var/ty = footprint_corner.y to footprint_corner.y + template.height - 1)
				var/turf/T = locate(tx, ty, crash_turf.z)
				if(!T)
					continue
				for(var/mob/living/L in T)
					L.gib(create_cause_data("падение корабля"))

	// delete = TRUE вычищает всё, что осталось на тайлах посадки (предметы, мусор, трупы),
	// чтобы после загрузки шаблона под кораблём ничего не "просвечивало".
	if(!template.load(crash_turf, centered = TRUE, allow_cropping = TRUE, delete = TRUE))
		message_admins("[SPAN_DANGER("LV733 ship_crash: template.load() failed at [ADMIN_VERBOSEJMP(crash_turf)] (template [template.width]x[template.height]). Likely too close to the map edge or a cordon issue.")]")
		return

	// Бум
	var/list/explosion_turfs = list()
	for(var/turf/ET in range(6, crash_turf))
		if(is_ground_level(ET.z))
			explosion_turfs += ET

	for(var/i = 1 to min(8, length(explosion_turfs)))
		var/turf/exp_turf = pick_n_take(explosion_turfs)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(explosion), exp_turf, 1, 2, 3, 4), rand(0, 30))

	marine_announcement(
		"Судно упало на LV-733. Зафиксированы взрывы. Всем подразделениям — повышенная готовность.",
		"КРУШЕНИЕ ЗАФИКСИРОВАНО",
		sound('sound/misc/notice2.ogg')
	)

	_give_xeno_larva()

/datum/round_event/lv733_ship_crash/proc/_give_xeno_larva()
	var/datum/hive_status/hive = GLOB.hive_datum[XENO_HIVE_NORMAL]
	if(!hive)
		return

	var/human_count = length(GLOB.alive_human_list)
	var/larva_to_add = max(1, round(human_count / SHIP_CRASH_LARVA_PER_N))

	hive.stored_larva += larva_to_add
	hive.hive_ui.update_burrowed_larva()

	for(var/mob/living/carbon/xenomorph/X in GLOB.living_xeno_list)
		if(X.hivenumber == XENO_HIVE_NORMAL)
			to_chat(X, SPAN_XENONOTICE("Улей ощущает новых носителей. [larva_to_add] грудолом[larva_to_add == 1 ? "" : "а"] добавлено в пул."))

#undef SHIP_CRASH_WARN_DELAY
#undef SHIP_CRASH_ZONE_WIDTH
#undef SHIP_CRASH_ZONE_HEIGHT
#undef SHIP_CRASH_ERT_MAX
#undef SHIP_CRASH_ERT_SYNTHS
#undef SHIP_CRASH_LARVA_PER_N
#undef SHIP_CRASH_SAFE_RADIUS
