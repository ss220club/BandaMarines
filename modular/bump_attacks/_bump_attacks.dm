/datum/modpack/bump_attacks
	name = "Bump Attacks"
	desc = "Adds bump attacks from TGMC"
	author = "TGMC, larentoun"

/datum/modpack/bump_attacks/post_initialize()
	. = ..()
	GLOB.admin_verbs_default += /datum/admins/proc/toggle_bump_attacks
