#define ROAF_SURVIVOR_INTRO list("<h2 style='color:#2F3E66; font-size:125%;'>Вы — оставшаяся часть 38-ой Королевской Авиа-Орбитальной группы, заблокированные на LV-733 Whitchler Point. Колония мертва или умирает, связь с внешним командованием превратилась в рваные обрывки сигналов. Припасы сокращаются, вы на грани срыва и понимаете: твари будут пытаться схватить вас и нужно что-делать, пока не стало совсем поздно ...</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>Вы осведомлены о ксеноморфной угрозе.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Ваша основная задача — выжить.</span>")

#define ROAF_SURVIVOR_STORY "<p style='font-size:95%; color:#A6A6A6;'>Аванпост «Уитшлер» — тренировочный полигон ROAF, принадлежащий TWE, на LV-733 «Уитшлер-Пойнт». Остался только ваш отряд. Припасы закончились. Эвакуация невозможна. Это не было случайностью. Weyland-Yutani замешана. Сигнал бедствия отправлен. Удерживайте позицию.</p>"

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
