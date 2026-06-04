#define SQUAD_ROAF "ROAF"
#define ROAF_FREQ 1503
#define ACCESS_MARINE_ROAF 1200
#define MINIMAP_SQUAD_ROAF "#324e6b"

/datum/squad/marine/roaf
	name = SQUAD_ROAF
	equivalent_name = SQUAD_ROAF
	faction = FACTION_ROAF

	chat_color = "#324e6b"

	access = list(ACCESS_MARINE_ROAF)

	radio_freq = ROAF_FREQ

	minimap_color = MINIMAP_SQUAD_ROAF
	background_icon = "background_roaf"

	squad_type = "Team"
	lead_icon = "leader"

	roundstart = FALSE
	usable = TRUE
	active = TRUE
	locked = FALSE

	omni_squad_vendor = FALSE

	roles_cap = list(
		JOB_SQUAD_MARINE = null,
		JOB_SQUAD_ENGI = 1,
		JOB_SQUAD_MEDIC = 1,
		JOB_SQUAD_SMARTGUN = 1,
		JOB_SQUAD_SPECIALIST = 1,
		JOB_SQUAD_TEAM_LEADER = 1,
		JOB_SQUAD_LEADER = 1,
	)
