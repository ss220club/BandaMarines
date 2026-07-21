//USCM Provost
/datum/emergency_call/inspection_provost
	name = "Inspection - USCM Provost - ML knowledge and MP playtime required."
	mob_max = 2
	mob_min = 1
	probability = 0
	ert_message = "Запрошен инспектор военной прокуратуры для расследования нарушений Военного Закона" //SS220 EDIT

/datum/emergency_call/inspection_provost/New()
	..()
	objectives = "Расследуйте любые проблемы с соблюдением Военного Закона на корабле [MAIN_SHIP_NAME]." //SS220 EDIT

/datum/emergency_call/inspection_provost/remove_nonqualifiers(list/datum/mind/candidates_list)
	var/list/datum/mind/candidates_clean = list()
	for(var/datum/mind/single_candidate in candidates_list)
		if(check_timelock(single_candidate.current?.client, JOB_POLICE, time_required_for_job))
			candidates_clean.Add(single_candidate)
			continue
		if(single_candidate.current)
			to_chat(single_candidate.current, SPAN_WARNING("Вы не соответствуете требованиям для участия в ERT, так как у вас недостаточно наигранного времени (5 часов) за военную полицию!")) //SS220 EDIT
	return candidates_clean

/datum/emergency_call/inspection_provost/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_WARDEN, JOB_CHIEF_POLICE), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/uscm_event/provost/inspector, TRUE, TRUE) 
		to_chat(H, SPAN_ROLE_HEADER("Вы - Инспектор военной прокуратуры ККМП!")) //SS220 START
		to_chat(H, SPAN_ROLE_BODY("Вы направляетесь на борт [MAIN_SHIP_NAME] для расследования нераскрытого инцидента, связанного с соблюдением военного закона. Военная прокуратура может предоставить дополнительные сведения, однако вам следует немедленно проследовать в бриг и оценить обстановку."))
		to_chat(H, SPAN_ROLE_BODY("Последнее слово по вопросам военного закона остаётся за вами, однако вы по-прежнему обязаны соблюдать его. Используйте свои полномочия, чтобы восстановить порядок и обеспечить справедливость!"))
		to_chat(H, SPAN_WARNING("Эта роль требует знания военного закона и стандартных операционных процеруд. Обратитевь в Adminhelp, если у вас возникли вопросы или вы хотите уступить эту роль другому игроку."))
	else
		arm_equipment(H, /datum/equipment_preset/uscm_event/provost/enforcer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Силовик военной прокуратуры ККМП!"))
		to_chat(H, SPAN_ROLE_BODY("Вы назначены сопровождающим, помощником и сотрудником правопорядка для Инспектора, направленного на [MAIN_SHIP_NAME]"))
		to_chat(H, SPAN_ROLE_BODY("От вас не требуется применять военный закон на корабле, однако Инспектор может привлечь вас к выполнению обязанностей военной полиции в ходе расследования. В этом случае вы обязаны выполнять свои обязанности так же, как и любой другой сотрудник военной полиции.")) //SS220 END
		to_chat(H, SPAN_WARNING("Эта роль требует знания военного закона и стандартных операционных процеруд. Обратитевь в Adminhelp, если у вас возникли вопросы или вы хотите уступить эту роль другому игроку."))
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives: [objectives]")), 1 SECONDS)


/datum/emergency_call/inspection_provost/spawn_items()
	var/turf/drop_spawn

	drop_spawn = get_spawn_point(TRUE)
	new /obj/item/storage/box/handcuffs(drop_spawn)
	new /obj/item/storage/box/handcuffs(drop_spawn)

//USCM High Command
/datum/emergency_call/inspection_hc
	name = "Inspection - USCM High Command"
	mob_max = 2
	mob_min = 1
	probability = 0
	ert_message = "Запрошен инспектор высшего командования ККМП для проверки действий личного состава" //SS220 EDIT

/datum/emergency_call/inspection_hc/New()
	..()
	objectives = "Осмотрите и проведите оценку [MAIN_SHIP_NAME] и его экипажа."

/datum/emergency_call/inspection_hc/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SO), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/uscm_ship/so, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Инспектор, направленный высшим командованием ККМП!")) //SS220 START
		to_chat(H, SPAN_ROLE_BODY("На время текущего задания для [MAIN_SHIP_NAME] запланирована инспекция. Высшее командование может направить вам дополнительные указания, которые будут переданы по радиосвязи."))
		to_chat(H, SPAN_ROLE_BODY("Осмотрите корабль, оцените организованность, эффективность и соблюдение СОП соответствующими отделами, опросите экипаж и выявите возможные проблемы. Передайте результаты своей инспекции как командиру корабля, так и Высшему командованию ККМП."))
		to_chat(H, SPAN_WARNING("Помните, ваша инспекция не должна нарушать штатную работу корабля, и у вас нет полномочий принимать решения, связанные с применением военного закона. Обратитесь в Adminhelp, если у вас есть вопросы или вы хотите передать эту роль другому игроку."))
	else
		arm_equipment(H, /datum/equipment_preset/uscm/engineer_equipped, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы являетесь членом инспекционной группы, направленной высшим командованием ККМП!"))
		to_chat(H, SPAN_ROLE_BODY("На время текущего задания для [MAIN_SHIP_NAME] запланирована инспекция. Вы выполняете роль сотрудника охраны для офицера, проводящего инспекцию, а также его ассистента в случае, если ему потребуется ваша экспертиза."))
		to_chat(H, SPAN_ROLE_BODY("Следуйте за инспектором во время выполнения им своих обязанностей на корабле. Не стесняйтесь высказывать своё мнение и делиться своими знаниями, если считаете это уместным, а также оказывайте помощь по его запросу. Помните: хотя вы не подчиняетесь напрямую офицерам корабля, вы всё же обязаны уважать их полномочия и положение."))
		to_chat(H, SPAN_WARNING("Помните, вы не должны вмешиваться в штатную работу корабля и обязаны всегда выполнять приказы инспектора. Обратитесь в Adminhelp, если у вас есть вопросы или вы хотите передать эту роль другому игроку.")) //SS220 END
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives: [objectives]")), 1 SECONDS)

//Weyland-Yutani
/datum/emergency_call/inspection_wy
	name = "Inspection - Corporate"
	mob_max = 2
	mob_min = 1
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2
	home_base = /datum/lazy_template/ert/weyland_station
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	max_heavies = 1
	probability = 0
	ert_message = "Запрошен следователь ЧВК Вейланд-Ютани для расследования действий связного" //SS220 EDIT

/datum/emergency_call/inspection_wy/New()
	..()
	objectives = "Убедитесь, что экипаж корабля [MAIN_SHIP_NAME] знает о вашем присутствии. Проведите расследование в отношении корпоративного связного и любого другого актива компании и убедитесь, что они остаются верными компании. Составьте подробный отчет диспетчеру."

/datum/emergency_call/inspection_wy/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SQUAD_LEADER), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_lead_investigator, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Ведущий следователь ЧВК Вейланд-Ютани!")) //SS220 EDIT START
		to_chat(H, SPAN_ROLE_BODY("Хотя официально ваше подразделение выполняет обычные задачи по обеспечению безопасности Вейланд-Ютани, на практике вы выступаете как официальными, так и неофициальными расследователями действий сотрудников Компании. Вы направляетесь на борт [MAIN_SHIP_NAME], чтобы убедиться, что местный связной не забыл о своих приоритетах и, что ещё хуже, не решил укусить руку, которая его кормит."))
		to_chat(H, SPAN_ROLE_BODY("Помните, сотрудники ККМП на борту могут быть недовольны вашим присутствием. Если связной окажется под арестом, вы не должны выступать в качестве его юридического представителя ни при каких обстоятельствах, если только не получите соответствующее распоряжение от диспетчерской службы. Ваша основная обязанность - составить подробный отчёт обо всём, что касается связного и любых других сотрудников Вейланд-Ютани на борту корабля."))
		to_chat(H, SPAN_WARNING("Если диспетчерская служба не отдаст иных распоряжений, избегайте открытых конфликтов с морпехами. Если они проявляют откровенную враждебность, отступите. Вашим приоритетом является безопасность вашей команды. Если на корабле возникнет опасность, вашим лучшим решением будет эвакуация. Обратитесь в Adminhelp, если у вас есть дополнительные вопросы или вы хотите освободить этого персонажа для других игроков."))
	else if(heavies < max_heavies && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_HEAVY) && check_timelock(H.client, JOB_SQUAD_SPECIALIST))
		heavies++
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_riot_control, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Специалист по сдерживанию толпы ЧВК Вейланд-Ютани!"))
		to_chat(H, SPAN_ROLE_BODY("Хотя официально ваше подразделение выполняет обычные задачи по обеспечению безопасности Вейланд-Ютани, на практике вы выступаете как официальными, так и неофициальными расследователями действий сотрудников Компании. Старший следователь является руководителем операции; ваша задача - оказывать поддержку, предоставлять консультации и любую другую помощь, необходимую для успешного выполнения задачи."))
		to_chat(H, SPAN_ROLE_BODY("Помните, сотрудники ККМП на борту могут быть недовольны вашим присутствием. Ваш главный приоритет - обеспечить выживание старшего следователя, чтобы он мог составить требуемый отчёт."))
		to_chat(H, SPAN_WARNING("Если диспетчерская служба не отдаст иных распоряжений, избегайте открытых конфликтов с морпехами. Если они проявляют откровенную враждебность, отступите. Вашим приоритетом является безопасность вашей команды. Если на корабле возникнет опасность, вашим лучшим решением будет эвакуация. Обратитесь в Adminhelp, если у вас есть дополнительные вопросы или вы хотите освободить этого персонажа для других игроков."))
	else
		arm_equipment(H, /datum/equipment_preset/pmc/pmc_security, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы входите в состав следственной группы ЧВК Вейланд-Ютани"))
		to_chat(H, SPAN_ROLE_BODY("Хотя официально ваше подразделение выполняет обычные задачи по обеспечению безопасности Вейланд-Ютани, на практике вы выступаете как официальными, так и неофициальными расследователями действий сотрудников Компании. Старший следователь является руководителем операции; ваша задача - оказывать поддержку, предоставлять консультации и любую другую помощь, необходимую для успешного выполнения задачи."))
		to_chat(H, SPAN_ROLE_BODY("Помните, сотрудники ККМП на борту могут быть недовольны вашим присутствием. Ваш главный приоритет - обеспечить выживание старшего следователя, чтобы он мог составить требуемый отчёт."))
		to_chat(H, SPAN_WARNING("Если диспетчерская служба не отдаст иных распоряжений, избегайте открытых конфликтов с морпехами. Если они проявляют откровенную враждебность, отступите. Вашим приоритетом является безопасность вашей команды. Если на корабле возникнет опасность, вашим лучшим решением будет эвакуация. Обратитесь в Adminhelp, если у вас есть дополнительные вопросы или вы хотите освободить этого персонажа для других игроков.")) //SS220 EDIT END
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives: [objectives]")), 1 SECONDS)

/datum/emergency_call/inspection_wy/spawn_items()
	var/turf/drop_spawn

	drop_spawn = get_spawn_point(TRUE)
	new /obj/item/storage/box/handcuffs(drop_spawn)
	new /obj/item/storage/box/handcuffs(drop_spawn)

/datum/emergency_call/inspection_wy/lawyer
	name = "Lawyers - Corporate"
	mob_max = 2
	mob_min = 1
	name_of_spawn = /obj/effect/landmark/ert_spawns/distress_pmc
	item_spawn = /obj/effect/landmark/ert_spawns/distress_pmc/item
	probability = 0
	ert_message = "Была запрошена команда правовых представителей Вейланд-Ютани." //SS220 EDIT
	time_required_for_job = 15 HOURS

/datum/emergency_call/inspection_wy/lawyer/New()
	..()
	objectives = "Убедитесь, что экипаж корабля [MAIN_SHIP_NAME] знает о вашем присутствии. Выясните, на кого корпоративный связной доложил о несоблюдении обязательств по контракту, а также проверьте другие активы компании и убедитесь, что они остаются верными компании. Составьте подробный отчет для корпорации."

/datum/emergency_call/inspection_wy/lawyer/remove_nonqualifiers(list/datum/mind/candidates_list)
	var/list/datum/mind/candidates_clean = list()
	for(var/datum/mind/single_candidate in candidates_list)
		if(check_timelock(single_candidate.current?.client, list(JOB_POLICE, JOB_CORPORATE_LIAISON), time_required_for_job))
			candidates_clean.Add(single_candidate)
			continue
		if(single_candidate.current)
			to_chat(single_candidate.current, SPAN_WARNING("Вы не соответствуете требованиям для участия в ERT, так как у вас недостаточно наигранного времени (15 часов) за военную полицию/связного корпорации!"))
	return candidates_clean

/datum/emergency_call/inspection_wy/lawyer/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/T = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(T))
		return FALSE

	var/mob/living/carbon/human/H = new(T)
	M.transfer_to(H, TRUE)

	if(!leader && HAS_FLAG(H.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(H.client, list(JOB_SQUAD_LEADER), time_required_for_job))
		leader = H
		arm_equipment(H, /datum/equipment_preset/wy/exec_supervisor/lawyer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Старший правовой представитель Корпорации Вейланд-Ютани")) //SS220 EDIT START
		to_chat(H, SPAN_ROLE_BODY("Хотя формально Отдел корпоративных дел занимается стандартной документацией Вейланд-Ютани, фактически вы выполняете функции официальных и неофициальных следователей, проверяющих действия сотрудников Компании и иных лиц. Вы направляетесь на [MAIN_SHIP_NAME], чтобы удостовериться, что ККМП выполняет условия подписанных контрактов, представленных местным связным, и помнит, кто на самом деле является кромящей рукой."))
		to_chat(H, SPAN_ROLE_BODY("Помните, персонал ККМП на борту может негативно воспринять ваше присутствие. В случае заключения связного под стражу вы обязаны действовать как его юридический представитель. Ваша главная задача - подготовить детальный отчёт обо всех обстоятельствах, связанных со связным, сотрудниками Вейланд-Ютани, а также о любых нарушениях условий контрактов на борту корабля."))
		to_chat(H, SPAN_WARNING("Избегайте открытого конфликта с морпехами. Если они проявляют явную враждебность, отступите и составьте отчёт. Обратитесь в Adminhelp, если у вас есть дополнительные вопросы или вы хотите освободить этого персонажа для других игроков."))
	else
		arm_equipment(H, /datum/equipment_preset/wy/exec_spec/lawyer, TRUE, TRUE)
		to_chat(H, SPAN_ROLE_HEADER("Вы - Правовой представитель Корпорации Вейланд-Ютани"))
		to_chat(H, SPAN_ROLE_BODY("Хотя формально Отдел корпоративных дел занимается стандартной документацией Вейланд-Ютани, фактически вы выполняете функции официальных и неофициальных следователей, проверяющих действия сотрудников Компании и иных лиц. Старший правовой представитель является руководителем, ваша задача - оказывать ему правовую поддержку, предоставлять консултацию и любую другую помощь для успешного выполнения задачи."))
		to_chat(H, SPAN_ROLE_BODY("Помните, персонал ККМП на борту может негативно воспринять ваше присутствие. Вы и старший правовойй представитель обязаны избегать открытого противостояния с морской пехотой. Ваша главная задача — обеспечить ваше выживание и подготовку отчёта, который требуется Компании."))
		to_chat(H, SPAN_WARNING("Избегайте открытого конфликта с морпехами. Если они проявляют явную враждебность, отступите и составьте отчёт. Обратитесь в Adminhelp, если у вас есть дополнительные вопросы или вы хотите освободить этого персонажа для других игроков.")) //SS220 EDIT END
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), H, SPAN_BOLD("Objectives: [objectives]")), 1 SECONDS)


// Colonial Marshals - UA Law Enforcement / Investigative Federal Agents which usually watch over Colonies. Also a good option for prisoner transfers, investigating corporate corruption, survivor rescues, or illicit trade practices(black market).
/datum/emergency_call/inspection_cmb
	name = "Inspection - Colonial Marshals Investigation Team"
	mob_max = 4
	mob_min = 1
	probability = 0
	home_base = /datum/lazy_template/ert/weyland_station
	ert_message = "Запрошено Колониальное бюро маршалов для расследования" //SS220 EDIT

	var/max_synths = 1
	var/synths = 0

	var/will_spawn_icc_liaison
	var/icc_liaison

	var/will_spawn_cmb_observer
	var/cmb_observer

/datum/emergency_call/inspection_cmb/New()
	..()
	arrival_message = "[MAIN_SHIP_NAME], это станция \"Анкорпойнт\". Колониальное бюро маршалов. Сообщаем, что транспортное судно КМБ готовится к высадке на ваш корабль, передаем федеральные разрешения на стыковку. Ожидайте."
	objectives = "Получите инструкции в офисе КМБ на станции Анкорпойнт и выполняйте приказы. Убедитесь, что колониальные активы находятся в безопасности и под вашей опекой. Не вводите и не отменяйте законы на корабле, если вас об этом не просят, поскольку это не входит в вашу юрисдикцию."

	will_spawn_icc_liaison = prob(90)
	will_spawn_cmb_observer = prob(10)

/datum/emergency_call/inspection_cmb/create_member(datum/mind/M, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	M.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы - Колониальный маршал!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/leader, TRUE, TRUE)
	else if(synths < max_synths && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_SYNTH) && mob.client.check_whitelist_status(WHITELIST_SYNTHETIC))
		synths++
		to_chat(mob, SPAN_ROLE_HEADER("Вы - Следственный синтетик КМБ!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/synth/cmb, TRUE, TRUE)
	else if(!icc_liaison && will_spawn_icc_liaison && check_timelock(mob.client, JOB_CORPORATE_LIAISON, time_required_for_job))
		icc_liaison = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы - представитель Комиссии по Межзвёздной Торговле, прикреплённый к отряду КМБ")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/liaison, TRUE, TRUE)
	else if(!cmb_observer && will_spawn_cmb_observer)
		cmb_observer = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы - Межзвёздный наблюдатель по правам человека!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/observer, TRUE, TRUE)
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы - Заместитель маршала КМБ!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)


/datum/emergency_call/inspection_cmb/print_backstory(mob/living/carbon/human/M)
	if(M == leader)
		to_chat(M, SPAN_BOLD("You are the Colonial Marshal, originally from [pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")].")) // С ЭТИМ КАКНИБУДЬ ПОТОМ...
		to_chat(M, SPAN_BOLD("You started in the Marshals through [pick(50; "pursuing a career during college", 40;"working for law enforcement", 10;"being recruited for your skills")]."))
		to_chat(M, SPAN_BOLD("Rising through positions across the galaxy, you have become renown for your steadfast commitment to justice, fighting against crime and corruption alike."))
		to_chat(M, SPAN_BOLD("You have interstellar jurisdiction as a CMB Official to enforce Colonial and Earth law, but you cannot and should not override Marine Law on a Marine Ship."))
		to_chat(M, SPAN_BOLD("The laws of Earth stretch beyond the Sol. Where others are tempted and fall to corruption, you stay steadfast in your morals."))
		to_chat(M, SPAN_BOLD("Corporate Officers chase after paychecks and promotions, but you are motivated to do your sworn duty and care for the population, no matter how far or isolated a colony may be."))
		to_chat(M, SPAN_BOLD("You've seen a lot during your time in the Neroid Sector, but you're here because you're the best, doing the right thing to make the frontier a better place."))
		to_chat(M, SPAN_BOLD("Despite being stretched thin, the stalwart oath of the Marshals has continued to keep communities safe, with the CMB well respected by many. You are the representation of that oath, serve with distinction."))
	else if(issynth(M))
		to_chat(M, SPAN_BOLD("Despite being an older model, you are well regarded among your peers for your keen senses and alertness."))
		to_chat(M, SPAN_BOLD("In addition to law enforcement procedures, you are programmed to be an absolute expert in locating evidence, analyzing chemicals and investigating crimes."))
		to_chat(M, SPAN_BOLD("You do not enforce or comply with Marine Law, however you have an understanding of it."))
		to_chat(M, SPAN_BOLD("After receiving a software and law update in Sol, you were stationed at Anchorpoint Station to assist with CMB units on the frontier."))
		to_chat(M, SPAN_BOLD("Although combat is not expected, you are carrying light munition and equipment reserves of the team in your backpack, should they be needed."))
		to_chat(M, SPAN_BOLD("Despite being stretched thin, the stalwart oath of the Marshals has continued to keep communities safe, with the CMB well respected by many. You are a representation of that oath, serve with distinction."))
	else if(M == icc_liaison)
		to_chat(M, SPAN_BOLD("You are an Interstellar Commerce Liaison, originally from [pick(70;"The United Americas", 25;"Sol", 5;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("You are [pick(30; "skeptical", 40;"amicable", 30;"supportive")] of Weyland-Yutani."))
		to_chat(M, SPAN_BOLD("Your headset is equipped with several frequencies, including a gifted key from The ICC's parent company, Weyland-Yutani, to try to incentivize your support. Use it for communication."))
		to_chat(M, SPAN_BOLD("As the ICC Agent attached to the CMB Office at Anchorpoint Station, your job is to observe and ensure fair trade practices. Inspect and document cargo shipments for suspected illicit activity as needed. You should coordinate with the Marshals, and command(preferably for a warrant) in order to make arrests if necessary."))
		to_chat(M, SPAN_BOLD("Serving alongside such reputable men has made you a more virtuous person, especially compared to the Corporate Liaisons of other heavy-weight organizations."))
		to_chat(M, SPAN_BOLD("Work with the Colonial Marshals in their investigations and report to command if you suspect smuggling or illicit trade is happening."))
	else if(M == cmb_observer)
		to_chat(M, SPAN_BOLD("You are an Interstellar Human Rights Observer, originally from [pick(50;"The United Americas", 10;"Europe", 10;"Luna", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("You are [pick(60; "skeptical", 40;"amicable", 10;"supportive")] of Weyland-Yutani and their practices."))
		to_chat(M, SPAN_BOLD("You are [pick(40; "skeptical", 30;"amicable", 30;"supportive")] with the USCM's actions on the frontier."))
		to_chat(M, SPAN_BOLD("Through a lot of hard work, your organization managed to convince the Colonial Marshals to take you to the frontier for an article about the quality of life there."))
		to_chat(M, SPAN_BOLD("Observe the Feds in their adventures and keep an eye out for any inhumane acts from others. The Neroid Sector is full of atrocities on every side."))
		to_chat(M, SPAN_BOLD("Do not instigate or start any confrontations. You are an observer, and you do not wage wars. Only intervene in medical emergencies."))
	else
		to_chat(M, SPAN_BOLD("You are a CMB Deputy, originally from [pick(70;"The United Americas", 20;"Sol", 10;"a colony on the frontier")]."))
		to_chat(M, SPAN_BOLD("You joined the Marshals through [pick(50; "pursuing a career during college", 40;"working for law enforcement", 10;"being recruited for your skills")]."))
		to_chat(M, SPAN_BOLD("Following the lead of your Marshal, you have become renown for your steadfast commitment to justice, fighting against crime and corruption alike."))
		to_chat(M, SPAN_BOLD("You have interstellar jurisdiction as a CMB Official to enforce Colonial and Earth law, but you cannot and should not override Marine Law on a Marine Ship."))
		to_chat(M, SPAN_BOLD("You have been stationed at Anchorpoint Station for [pick(80;"several months", 10;"only a week", 10;"years")] investigating henious crimes among the frontier."))
		to_chat(M, SPAN_BOLD("The Earth stretch beyond the Sol. Where others fall to corruption, you stay steadfast in your morals."))
		to_chat(M, SPAN_BOLD("Corporate Officers chase after paychecks and promotions, but you are motivated to do your sworn duty and care for the population, no matter how far or isolated a colony may be."))
		to_chat(M, SPAN_BOLD("Despite being stretched thin, the stalwart oath of the Marshals has continued to keep communities safe, with the CMB well respected by many. You are a representation of that oath, serve with distinction."))

/datum/emergency_call/inspection_cmb/black_market
	name = "Inspection - Colonial Marshals Ledger Investigation Team"
	mob_max = 3 //Marshal, Deputy, ICC CL
	mob_min = 2
	shuttle_id = MOBILE_SHUTTLE_ID_ERT2

	max_synths = 0
	will_spawn_icc_liaison = TRUE
	will_spawn_cmb_observer = FALSE
	ert_message = "Запрошен отряд КМБ для расследования деятельности чёрного рынка." //SS220 EDIT

/datum/emergency_call/inspection_cmb/black_market/New()
	..()
	dispatch_message = "Высшее командование Третьего флота, сообщаем [MAIN_SHIP_NAME], что мы получили противоречивые данные о снабжении и нарушениях в системе ASRS на борту вашего корабля и запросили следственную группу КМБ, для высадки на ваш борт, дабы исключить любые нарушения."
	arrival_message = "Входящая радиопередача: [MAIN_SHIP_NAME], это станция \"Анкорпойнт\". Колониальное бюро маршалов. Сообщаем, что по запросу ГСО-91 мы направляем к вам на борт группу маршалов. Передаем разрешение на стыковку, конец связи."
	objectives = "Расследуйте несоответствия в ASRS корабля [MAIN_SHIP_NAME]. В случае незаконной деятельности соберите доказательства и подайте рапорт командованию КМБ на станции Анкорпойнт. При необходимости Представитель Комиссии по Межзвездной Торговле  может исправить поломку ASRS с помощью Tradeband Compliance Device. Сотрудничайте с военной полицией [MAIN_SHIP_NAME]." //SS220 EDIT

/datum/emergency_call/inspection_cmb/black_market/create_member(datum/mind/current_mind, turf/override_spawn_loc)
	var/turf/spawn_loc = override_spawn_loc ? override_spawn_loc : get_spawn_point()

	if(!istype(spawn_loc))
		return //Didn't find a useable spawn point.

	var/mob/living/carbon/human/mob = new(spawn_loc)
	current_mind.transfer_to(mob, TRUE)

	if(!leader && HAS_FLAG(mob?.client.prefs.toggles_ert, PLAY_LEADER) && check_timelock(mob.client, JOB_SQUAD_LEADER, time_required_for_job))
		leader = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы - Колониальный маршал!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/leader, TRUE, TRUE)
	else if(!icc_liaison && will_spawn_icc_liaison && check_timelock(mob.client, JOB_CORPORATE_LIAISON, time_required_for_job))
		icc_liaison = mob
		to_chat(mob, SPAN_ROLE_HEADER("Вы - представитель Комиссии по Межзвёздной Торговле, прикреплённый к КМБ!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/liaison/black_market, TRUE, TRUE) //ICC CL gets a custom item
	else
		to_chat(mob, SPAN_ROLE_HEADER("Вы - заместитель маршала КМБ!")) //SS220 EDIT
		arm_equipment(mob, /datum/equipment_preset/cmb/standard, TRUE, TRUE)

	print_backstory(mob)

	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), mob, SPAN_BOLD("Objectives:</b> [objectives]")), 1 SECONDS)
