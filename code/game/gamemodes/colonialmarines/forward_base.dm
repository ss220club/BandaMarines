#define FORWARD_BASE_FOG_DURATION (18 MINUTES) // From roundstart. 00:23 if the pre-game length wasnt changed
#define FORWARD_BASE_FOG_WARNING (1 MINUTES) // How many minutes before FORWARD_BASE_FOG_DURATION. 00:24 if the pre-game length wasnt changed
#define FORWARD_BASE_COMMS_FAILURE (2 MINUTES) // How many minutes after FORWARD_BASE_FOG_DURATION. 00:25 if the pre-game length wasnt changed
#define FORWARD_BASE_TURRET_BATTERY_DURATION (30 MINUTES) // From roundstart. 00:35 if the pre-game length wasnt changed
#define FORWARD_BASE_PYLON_INTERVAL (5 MINUTES) // Amount of time it takes for Hive Surge to unlock after holding two pylons
#define FORWARD_BASE_LARVA_INTERVAL (5 MINUTES) // How long it takes for xenos to start accumulating burrowed larva after holding both pylons
#define FORWARD_BASE_LARVA_AMOUNT 1 // Amount of larva gained per interval of the above

/datum/game_mode/colonialmarines/forward_base
	name = GAMEMODE_FORWARD_BASE
	config_tag = GAMEMODE_FORWARD_BASE
	votable = FALSE
	var/hive_pylon_timer
	var/hive_pylons_charged = FALSE

/datum/game_mode/colonialmarines/forward_base/proc/update_hive_surge(datum/hive_status/hive)
	if(hive.hivenumber != XENO_HIVE_NORMAL)
		return
	if(LAZYLEN(hive.active_endgame_pylons) < 2)
		deltimer(hive_pylon_timer)
		hive_pylon_timer = null
		hive_pylons_charged = FALSE
		return
	if(!hive_pylon_timer)
		hive_pylon_timer = addtimer(CALLBACK(src, PROC_REF(pylon_rewards), hive), FORWARD_BASE_PYLON_INTERVAL, TIMER_STOPPABLE)

/datum/game_mode/colonialmarines/forward_base/proc/pylon_rewards(datum/hive_status/hive)
	hive_pylon_timer = null
	if(LAZYLEN(hive.active_endgame_pylons) < 2)
		return
	if(!hive_pylons_charged)
		hive_pylons_charged = TRUE
		if(!(locate(/datum/hivebuff/hive_surge) in hive.used_hivebuffs))
			xeno_announcement(""Hive Surge теперь доступен как дар, который ваша Королева может приобрести бесплатно. Используйте его, чтобы сменить свою касту и уничтожить крепость носителей!", hive.hivenumber, QUEEN_MOTHER_ANNOUNCE)
	else
		hive.stored_larva += FORWARD_BASE_LARVA_AMOUNT
		hive.hive_ui.update_burrowed_larva()
	hive_pylon_timer = addtimer(CALLBACK(src, PROC_REF(pylon_rewards), hive), FORWARD_BASE_LARVA_INTERVAL, TIMER_STOPPABLE)

/datum/game_mode/colonialmarines/forward_base/get_roles_list()
	return ..() - list(JOB_DROPSHIP_PILOT, JOB_FIELD_DOCTOR)

/datum/game_mode/colonialmarines/forward_base/allow_early_drone_evolution()
	return ROUND_TIME < FORWARD_BASE_FOG_DURATION

/datum/game_mode/colonialmarines/forward_base/map_announcement()
	marine_announcement("Плохие новости, морпехи. КОФ поразил региональную сеть военной связи и уничтожил ближайшую дальневолновую ретрансляционную станцию. У нас есть только этот аварийный канал связи с вами - и всё. Я не могу направить в ваш район другое подразделение, а значит, не смогу обеспечить запрошенное вами подкрепление. У вас укреплённая позиция и достаточно боеприпасов, чтобы завершить задание. Вы сами по себе. Кэмерон, конец связи.", "BRIGADIER GENERAL CAMERON - CHINOOK 91 GSO STATION", 'sound/AI/commandreport.ogg')
	xeno_announcement("Рой враждебных носителей укрепился в гнезде на краю нашей территории. Густой туман скрывает их от вас, но он начинает рассеиваться. Проявите терпение. Скоро путь к ним будет открыт.", QUEEN_MOTHER_ANNOUNCE)

/datum/game_mode/colonialmarines/forward_base/ares_conclude()
	marine_announcement("Что ж, морпехи, региональный ретранслятор наконец-то снова в сети. Я как раз был на полпути к тому, чтобы отправить к вам подкрепление. Похоже, оно вам в итоге не понадобилось. Подсчитайте потери и пришлите мне отчёты о пострадавших. Кэмерон, конец связи.", "BRIGADIER GENERAL CAMERON - CHINOOK 91 GSO STATION", 'sound/AI/commandreport.ogg')

/datum/game_mode/colonialmarines/forward_base/pre_setup()
	. = ..()
	SSradio.ground_to_reserved = TRUE
	SSradio.update_cache()
	for(var/obj/structure/machinery/computer/shuttle/dropship/flight/console in GLOB.machines)
		if(console.linked_lz && istype(get_area(console), /area/forward_base))
			active_lz = console
			break
	for(var/area/forward_base/bunker_area in GLOB.all_areas)
		bunker_area.flags_area |= AREA_NOBURROW
	for(var/obj/effect/landmark/lv624/fog_blocker/fog in GLOB.landmarks_list)
		fog.time_to_dispel = FORWARD_BASE_FOG_DURATION

/datum/game_mode/colonialmarines/forward_base/post_setup()
	. = ..()
	if(GLOB.almayer_orbital_cannon)
		COOLDOWN_START(GLOB.almayer_orbital_cannon, ob_firing_cooldown, FORWARD_BASE_FOG_DURATION - ROUND_TIME)
	addtimer(CALLBACK(src, PROC_REF(allow_base_burrowing)), FORWARD_BASE_FOG_DURATION - ROUND_TIME)
	addtimer(CALLBACK(src, PROC_REF(disable_base_comms)), FORWARD_BASE_FOG_DURATION + FORWARD_BASE_COMMS_FAILURE - ROUND_TIME)
	addtimer(CALLBACK(src, PROC_REF(warn_resin_clear)), FORWARD_BASE_FOG_DURATION - ROUND_TIME)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(xeno_announcement), "Туман почти рассеялся. Через минуту носители будут на виду. Соберитесь и приготовьтесь разнести их гнездо.", QUEEN_MOTHER_ANNOUNCE), FORWARD_BASE_FOG_DURATION - FORWARD_BASE_FOG_WARNING - ROUND_TIME)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(marine_announcement), "ВНИМАНИЕ. НЕИЗБЕЖНЫЙ КОНТАКТ С ПРОТИВНИКОМ. Атмосферная маскировка стремительно рассеивается и исчезнет в течение шестидесяти секунд. ВСЕМ БОЕВЫМ ПОДРАЗДЕЛЕНИЯМ НЕМЕДЛЕННО ЗАНЯТЬ ОБОРОНИТЕЛЬНЫЕ ПОЗИЦИИ.", 'sound/effects/siren.ogg'), FORWARD_BASE_FOG_DURATION - FORWARD_BASE_FOG_WARNING - ROUND_TIME)
	var/obj/docking_port/stationary/marine_dropship/landing_zone = SSshuttle.getDock(active_lz.linked_lz)
	SSshuttle.action_load(SSmapping.all_shuttle_templates[/datum/map_template/shuttle/normandy], landing_zone)
	for(var/obj/structure/machinery/computer/shuttle/dropship/flight/console in GLOB.machines)
		console.time_lock = FORWARD_BASE_FOG_DURATION

/datum/game_mode/colonialmarines/forward_base/proc/allow_base_burrowing()
	for(var/area/forward_base/bunker_area in GLOB.all_areas)
		if(!(initial(bunker_area.flags_area) & AREA_NOBURROW))
			bunker_area.flags_area &= ~AREA_NOBURROW

/datum/game_mode/colonialmarines/forward_base/proc/disable_base_comms()
	marine_announcement("ВНИМАНИЕ. РЕЗЕРВНАЯ БАТАРЕЯ РЕТРАНСЛЯТОРА БАЗЫ РАЗРЯЖЕНА. Связь по военной радиосети недоступна. Рекомендуемое действие: захватить гражданскую вышку связи и восстановить контакт через сеть колонии.", "BASE COMMUNICATIONS ALERT", 'sound/AI/commandreport.ogg')
	for(var/obj/structure/machinery/telecomms/relay/preset/tower/all/relay in GLOB.telecomms_list)
		if(istype(get_area(relay), /area/forward_base))
			relay.toggled = FALSE
			relay.update_state()

/datum/game_mode/colonialmarines/forward_base/warn_resin_clear(obj/docking_port/mobile/marine_dropship)
	if(MODE_HAS_MODIFIER(/datum/gamemode_modifier/lz_weeding))
		return
	clear_proximity_resin()
	marine_announcement("ВНИМАНИЕ. АКТИВНА ДЕЗИНФЕКЦИЯ ПЕРИМЕТРА. C10-W Weedkiller распыляется вокруг базы.", "BASE PERIMETER ALERT", 'sound/effects/rocketpod_fire.ogg')

/datum/game_mode/colonialmarines/forward_base/spawn_lz_sentry(turf/target, list/structures_to_break)
	new /obj/structure/machinery/defenses/sentry/premade/deployable/colony/landing_zone/forward_base(target)

/datum/game_mode/colonialmarines/forward_base/check_win()
	if(SSticker.current_state != GAME_STATE_PLAYING || round_started > 0 || round_finished)
		return
	if(!count_marines(SSmapping.levels_by_trait(ZTRAIT_GROUND)))
		round_finished = MODE_INFESTATION_X_MAJOR
		return
	var/datum/hive_status/main_hive = GLOB.hive_datum[XENO_HIVE_NORMAL]
	if(!main_hive.see_humans_on_tacmap)
		var/groundside_humans = 0
		for(var/mob/living/carbon/human/human as anything in GLOB.alive_human_list)
			var/turf/human_turf = get_turf(human)
			if(is_ground_level(human_turf?.z))
				groundside_humans++
		if(groundside_humans < main_hive.get_real_total_xeno_count() * HIJACK_RATIO_FOR_TACMAP)
			main_hive.see_humans_on_tacmap = TRUE
			main_hive.tacmap_requires_queen_ovi = FALSE
			SEND_SIGNAL(main_hive, COMSIG_XENO_REVEAL_TACMAP)
			xeno_announcement("Осталась лишь небольшая горстка носителей, и теперь они видны на карте нашего улья.", XENO_HIVE_NORMAL, SPAN_ANNOUNCEMENT_HEADER_BLUE("[QUEEN_MOTHER_ANNOUNCE]"))
	return ..()

/obj/structure/machinery/defenses/sentry/premade/deployable/colony/landing_zone/forward_base
	battery_duration = FORWARD_BASE_TURRET_BATTERY_DURATION

#undef FORWARD_BASE_FOG_DURATION
#undef FORWARD_BASE_FOG_WARNING
#undef FORWARD_BASE_COMMS_FAILURE
#undef FORWARD_BASE_TURRET_BATTERY_DURATION
#undef FORWARD_BASE_PYLON_INTERVAL
#undef FORWARD_BASE_LARVA_INTERVAL
#undef FORWARD_BASE_LARVA_AMOUNT
