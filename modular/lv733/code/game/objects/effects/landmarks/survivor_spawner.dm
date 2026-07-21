#define ROAF_SURVIVOR_INTRO list("<h2 style='color:#2F3E66; font-size:125%;'>Вы — оставшаяся часть 38-ой Королевской Авиа-Орбитальной группы, заблокированные на LV-733 Whitchler Point. Колония мертва или умирает, связь с внешним командованием превратилась в рваные обрывки сигналов. Припасы сокращаются, вы на грани срыва и понимаете: твари будут пытаться схватить вас и нужно что-делать, пока не стало совсем поздно ...</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>Вы осведомлены о ксеноморфной угрозе.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Ваша основная задача — выжить.</span>")

#define ROAF_SURVIVOR_STORY "<p style='font-size:95%; color:#A6A6A6;'>Аванпост «Уитшлер» — тренировочный полигон ROAF, принадлежащий TWE, на LV-733 «Уитшлер-Пойнт». Ваш отряд заблокирован в городской зоне. Припасы заканчиваются. Эвакуация затруднительна. Сигнал бедствия отправлен. Удерживайте позицию.</p>"

/// ROAF ///

/obj/effect/landmark/survivor_spawner/twe/roaf
	icon_state = "surv_twe"
	equipment = /datum/equipment_preset/survivor/roaf
	synth_equipment = /datum/equipment_preset/synth/survivor/roaf_synth
	CO_equipment = /datum/equipment_preset/survivor/whitchler/roaf_commander
	intro_text = ROAF_SURVIVOR_INTRO
	story_text = ROAF_SURVIVOR_STORY
	spawn_priority = SPAWN_PRIORITY_LOW

/obj/effect/landmark/survivor_spawner/twe/roaf/signaller
	equipment = /datum/equipment_preset/survivor/roaf/signaller
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/roaf/engi
	equipment = /datum/equipment_preset/survivor/roaf/engi
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/roaf/medic
	equipment = /datum/equipment_preset/survivor/roaf/medic
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/roaf/pilot
	equipment = /datum/equipment_preset/survivor/roaf/pilot
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/roaf/squad_leader
	equipment = /datum/equipment_preset/survivor/roaf/squad_leader
	spawn_priority = SPAWN_PRIORITY_HIGH

#undef ROAF_SURVIVOR_INTRO
#undef ROAF_SURVIVOR_STORY

#define RAC_SURVIVOR_INTRO list("<h2 style='color:#4A4A3D; font-size:125%;'>Вы — часть Royal Armored Cavalry, проходящие обучение на LV-733 Уитшлер-Пойнт. Танковое звено застряло в городском секторе, топливо и снаряды на исходе, а связь с командованием обрывочна ...</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>Вы осведомлены о ксеноморфной угрозе.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Ваша основная задача — выжить и сохранить бронетехнику боеспособной.</span>")

#define RAC_SURVIVOR_STORY "<p style='font-size:95%; color:#A6A6A6;'>Танковое звено Royal Armored Cavalry было переброшено на LV-733 для прохождения тренировачных сценариев. Средства эвакуации бронетехники нет. Приказ — удерживать звено на ходу и прикрывать отход остальных подразделений TWE.</p>"

/// RAC ///

/obj/effect/landmark/survivor_spawner/twe/rac
	icon_state = "surv_twe"
	equipment = /datum/equipment_preset/survivor/rac
	synth_equipment = /datum/equipment_preset/synth/survivor/rac_synth
	CO_equipment = /datum/equipment_preset/survivor/whitchler/rac_commander
	intro_text = RAC_SURVIVOR_INTRO
	story_text = RAC_SURVIVOR_STORY
	spawn_priority = SPAWN_PRIORITY_LOW

/obj/effect/landmark/survivor_spawner/twe/rac/driver
	equipment = /datum/equipment_preset/survivor/rac/driver
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/rac/engi
	equipment = /datum/equipment_preset/survivor/rac/engi
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/rac/medic
	equipment = /datum/equipment_preset/survivor/rac/medic
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/rac/squad_leader
	equipment = /datum/equipment_preset/survivor/rac/squad_leader
	spawn_priority = SPAWN_PRIORITY_HIGH

#undef RAC_SURVIVOR_INTRO
#undef RAC_SURVIVOR_STORY

#define CLF_WP_SURVIVOR_INTRO list("<h2 style='color:#7F2F2B; font-size:125%;'>Вы — боец Ячейки CLF-WP, скрывающейся на LV-733 Уитшлер-Пойнт. Ваша группа пряталась среди развалин, избегая как ксеноморфов, так и патрулей TWE. Связи с остальными Ячейками нет уже несколько дней ...</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>Вы осведомлены о ксеноморфной угрозе.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Ваша основная задача — выжить и найти выход с колинии.</span>")

#define CLF_WP_SURVIVOR_STORY "<p style='font-size:95%; color:#A6A6A6;'>Ваша Ячейка действовала на LV-733 задолго до вспышки, готовя саботаж местной инфраструктуры TWE. Когда начался хаос, вы укрылись в заброшенном секторе аванпоста «Уитшлер», рассчитывая переждать. Припасы на исходе, а по округе бродит то, что гораздо хуже патрулей.</p>"

/// CLF-WP ///

/obj/effect/landmark/survivor_spawner/clf_wy
	icon_state = "surv"
	hostile = TRUE
	equipment = /datum/equipment_preset/survivor/clf_wy
	synth_equipment = /datum/equipment_preset/synth/survivor/clf_wy_synth
	CO_equipment = /datum/equipment_preset/survivor/whitchler/clf_wy_curator
	intro_text = CLF_WP_SURVIVOR_INTRO
	story_text = CLF_WP_SURVIVOR_STORY
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2
	spawn_priority = SPAWN_PRIORITY_LOW

/obj/effect/landmark/survivor_spawner/clf_wy/engi
	equipment = /datum/equipment_preset/survivor/clf_wy/engi
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/clf_wy/medic
	equipment = /datum/equipment_preset/survivor/clf_wy/medic
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/clf_wy/leader
	equipment = /datum/equipment_preset/survivor/clf_wy/leader
	spawn_priority = SPAWN_PRIORITY_HIGH

#undef CLF_WP_SURVIVOR_INTRO
#undef CLF_WP_SURVIVOR_STORY

#define ISRG_SURVIVOR_INTRO list("<h2 style='color:#2F3E66; font-size:125%;'>Вы — сотрудник поисковой группы ISRG, направленной на LV-733 для розыска высокопоставленных персон колонии. Уитшлер-Пойнт оказался куда опаснее, чем предполагали данные разведки ...</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>Вы НЕ осведомлены о ксеноморфной угрозе.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Ваша основная задача — найти высокопоставленых чиновников и директоров.</span>")

#define ISRG_SURVIVOR_STORY "<p style='font-size:95%; color:#b86969;'>Ваша поисковая группа ISRG высадилась на LV-733, чтобы найти высокопоставленых чиновников и директоров. Перед посадкой вы видели хаос на колонии и у корабля случилась техническая поломка. Вы решаете дейстовать дальше по плану.</p>"

#define ISRG_K9_SYNTH_NOTICE "<span class='notice'>Вы — усовершенствованный служебный синтетик линейки K9, приданный поисковой группе ISRG. Вы НЕ можете пользоваться оружием и сложным снаряжением, и ОБЯЗАНЫ следовать командам своего кинолога-напарника. Вы МОЖЕТЕ отвечать голосом тольки кинологу (остальным через эвоции) .</span>"

/// ISRG ///

/obj/effect/landmark/survivor_spawner/isrg
	icon_state = "surv"
	equipment = /datum/equipment_preset/survivor/isrg
	synth_equipment = /datum/equipment_preset/synth_k9/isrg
	CO_equipment = /datum/equipment_preset/survivor/whitchler/isrg_commander
	intro_text = ISRG_SURVIVOR_INTRO
	story_text = ISRG_SURVIVOR_STORY
	spawn_priority = SPAWN_PRIORITY_LOW

/obj/effect/landmark/survivor_spawner/isrg/k9
	equipment = /datum/equipment_preset/survivor/isrg
	spawn_priority = SPAWN_PRIORITY_HIGH

/obj/effect/landmark/survivor_spawner/isrg/rescuer
	equipment = /datum/equipment_preset/survivor/isrg/rescuer
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/isrg/leader
	equipment = /datum/equipment_preset/survivor/isrg/leader
	spawn_priority = SPAWN_PRIORITY_HIGH

#undef ISRG_SURVIVOR_INTRO
#undef ISRG_SURVIVOR_STORY
