#define SQUAD_ISRG "ISRG"
#define ISRG_SQUAD_FREQ 1504
#define ACCESS_MARINE_ISRG 1201
#define MINIMAP_SQUAD_ISRG "#85493d"

/datum/squad/marine/isrg
	name = SQUAD_ISRG
	equivalent_name = SQUAD_ISRG

	chat_color = "#85493d"

	access = list(ACCESS_MARINE_ISRG)

	radio_freq = ISRG_SQUAD_FREQ

	minimap_color = MINIMAP_SQUAD_ISRG
	background_icon = "background_isrg"

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
