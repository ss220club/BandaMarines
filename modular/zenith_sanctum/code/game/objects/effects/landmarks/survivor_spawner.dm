/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/standard
	synth_equipment = /datum/equipment_preset/synth/survivor/pmc
	intro_text = list("<h2>Вы выжили при крушении корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача - выжить и встретиться с второй огневой группой. По последней информации они временно закрепились в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_LOW
	archetype = INSERT_STANDARD

/obj/effect/landmark/survivor_spawner/zenith_sanctum_pmc_medic
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/medic
	intro_text = list("<h2>Вы выжили при крушении корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача - выжить и встретиться с второй огневой группой. По последней информации они временно закрепились в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_HIGH
	archetype = INSERT_MEDIC

/obj/effect/landmark/survivor_spawner/zenith_sanctum_pmc_engineer
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/engineer
	intro_text = list("<h2>Вы выжили при крушении корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача - выжить и встретиться с второй огневой группой. По последней информации они временно закрепились в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_MEDIUM
	archetype = INSERT_ENGINEER

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_leader
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/pmc_leader
	intro_text = list("<h2>Вы выжили при крушении корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача - выжить и встретиться с второй огневой группой. По последней информации они временно закрепились в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_HIGH
	archetype = INSERT_LEADER

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_commander
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/pmc_commander
	intro_text = list("<h2>Вы выжили при крушении десантного корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача — выжить и встретиться с второй огневой группой, обеспечить выживание высокопоставленных лиц Корпорации. По последней информации они временно закрепились в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = "Вы командир взвода ЧВК Вэйланд-Ютани. Ваш корабль сопровождал супервайзера из отдела исследований инопланетных технологий на колонию LV-624. Вашим людям предстояло исследование дальних частей руин древней цивилизации. Однако вскоре после прибытия основная колония LV-624 пала в связи с появление улья XX-121. Требовалось эвакуировать высокопоставленные лица во вторую безопасную колонию на планете — Храм Зенита. Этим занялась вторая огневая группа — они ушли через джунгли неделей ранее, пока Вы с Первыми выигрывали для них, как можно больше времени. Когда сдерживать противника более не представлялось возможным, Вы отступили на десантном корабле, однако неудачно брошенная инженером граната отбросила труп ксеноморфа на десантный корабль, и кислотная кровь повредила один из двигателей. Ваши люди говорят, тот факт, что Вы выжили в этом крушение — настоящее чудо, однако чудо уже то, что корабль вообще до сюда дотянул."
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_VERY_HIGH
	archetype = INSERT_CO

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_synth
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/synth/survivor/pmc
	synth_equipment = /datum/equipment_preset/synth/survivor/pmc
	intro_text = list("<h2>Вы выжили при крушении корабля!</h2>",\
	"<span class='notice'>Вы знаете об угрозе ксеноморфов.</span>",\
	"<span class='danger'>Ваша первичная задача - обеспечить выживание высокопоставленных лиц Корпорации, включая командира взвода ЧВК; поддержка первой огневой группы. По последней информации вторая огневая группа временно закрепилась в западном крыле ботаники, там могут быть дополнительные припасы.</span>")
	story_text = "Вы синтетик поддержки ЧВК Вэйланд-Ютани. Вы личный помощник командира взвода. Вам назначили обеспечение непосредственной безопасности супервайзера. Однако вскоре после прибытия колония подверглась заражению биологической угрозой XX-121. Теперь требовалось спасти высокопоставленные лица во вторую безопасную колонию на планете — Храм Зенита. По Вашему совету командир решил разделить взвод на две огневые группы - первая, более опытная, останется отвлекать врага, насколько это возможно, пока вторая эвакуирует все активы Корпорации через джунгли. XX-121 не видели в Вашем присутствии непосредственной угрозы, что позволило заниматься разведкой и сбором припасов, помимо стандартных процедур по оказанию первой помощи - это выиграло приблизительно 37 часов, однако оборона не могла держаться вечно. При отступлении Вы приняли на себя роль пилота десантного корабля, похищенного особями XX-121 двумя днями ранее. Из-за критического повреждения левого двигателя Вам удалось хотя бы доставить шаттл на территорию Храма Зенита в 64.8% целостности."
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_VERY_HIGH
	archetype = INSERT_SYNTH
