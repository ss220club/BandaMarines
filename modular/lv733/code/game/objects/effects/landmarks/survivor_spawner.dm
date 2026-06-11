#define ROAF_SURVIVOR_INTRO list("<h2 style='color:#2F3E66; font-size:125%;'>You are a member of the ROAF and IASF Parachute Regiment!</h2>",\
	"<span class='notice' style='color:#A6A6A6;'>You ARE aware of the xenomorph threat.</span>",\
	"<span class='danger' style='color:#7F2F2B;'>Your primary objective is to survive.</span>")

#define ROAF_SURVIVOR_STORY "<p style='font-size:95%; color:#A6A6A6;'>Outpost Whitchler - ROAF training ground of TWE on LV-733 \"Whitchler Point\". Only your squad remains. Supplies are gone. Evac is impossible. This was not an accident. Weyland-Yutani is involved. Distress signal sent. Hold position.</p>"

/// ROAF ///

/obj/effect/landmark/survivor_spawner/twe/roaf
	icon_state = "surv_twe"
	equipment = /datum/equipment_preset/survivor/roaf/paratrooper
	synth_equipment = /datum/equipment_preset/synth/survivor/roaf_synth
	CO_equipment = /datum/equipment_preset/survivor/whitchler/roaf_commander
	intro_text = ROAF_SURVIVOR_INTRO
	story_text = ROAF_SURVIVOR_STORY
	spawn_priority = SPAWN_PRIORITY_LOW

/obj/effect/landmark/survivor_spawner/twe/roaf/signaller
	equipment = /datum/equipment_preset/survivor/roaf/signaller
	spawn_priority = SPAWN_PRIORITY_MEDIUM

/obj/effect/landmark/survivor_spawner/twe/roaf/paratrooper
	equipment = /datum/equipment_preset/survivor/roaf/paratrooper
	spawn_priority = SPAWN_PRIORITY_LOW

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
