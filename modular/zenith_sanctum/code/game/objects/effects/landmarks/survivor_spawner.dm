/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/standard
	synth_equipment = /datum/equipment_preset/synth/survivor/pmc
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"<span class='notice'>You are aware of the xenomorph threat.</span>",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_LOW
	archetype = INSERT_STANDARD

/obj/effect/landmark/survivor_spawner/zenith_sanctum_pmc_medic
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/medic
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"You are aware of the xenomorph threat.",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_HIGH
	archetype = INSERT_MEDIC

/obj/effect/landmark/survivor_spawner/zenith_sanctum_pmc_engineer
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/engineer
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"You are aware of the xenomorph threat.",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_MEDIUM
	archetype = INSERT_ENGINEER

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_leader
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/pmc_leader
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"You are aware of the xenomorph threat.",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_HIGH
	archetype = INSERT_LEADER

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_cl
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/corporate/manager
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"<span class='notice'>You are NOT aware of the xenomorph threat.</span>",\
	"<span class='danger'>Your primary objective is to survive. You believe a second dropship crashed somewhere to the north, which was carrying additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_HIGH
	archetype = INSERT_CORPORATE

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_commander
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/survivor/pmc/pmc_commander
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"You are aware of the xenomorph threat.",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_VERY_HIGH
	archetype = INSERT_CO

/obj/effect/landmark/survivor_spawner/zenith_sanctum_crashed_pmc_synth
	icon_state = "surv_wy"
	equipment = /datum/equipment_preset/synth/survivor/pmc
	synth_equipment = /datum/equipment_preset/synth/survivor/pmc
	intro_text = list("<h2>You are a survivor of a crash landing!</h2>",\
	"You are aware of the xenomorph threat.",\
	"<span class='danger'>Your primary objective is to survive. You believe the first firegroup established a temporary base in botanics, there might be additional supplies.</span>")
	story_text = ""
	roundstart_damage_min = 3
	roundstart_damage_max = 10
	roundstart_damage_times = 2

	spawn_priority = SPAWN_PRIORITY_VERY_HIGH
	archetype = INSERT_SYNTH
