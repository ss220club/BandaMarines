/datum/species/monkey/necoarc
	name = "Necoarc"
	name_plural = "Necoarc"

	icobase = 'modular/necoarc/icon/r_NecoArc.dmi'
	deform = 'modular/necoarc/icon/r_NecoArc.dmi'

	flesh_color = "#afa59e"
	base_color = "#333333"

	cold_level_1 = -1
	cold_level_2 = -1
	cold_level_3 = -1

	tail = null
	eyes = "blank_s"

/datum/species/monkey/necoarc/New()
	..()
	equip_adjust = list(
		WEAR_R_HAND = list("[NORTH]" = list("x" = 1, "y" = 3), "[EAST]" = list("x" = -3, "y" = 2), "[SOUTH]" = list("x" = -1, "y" = 3), "[WEST]" = list("x" = 3, "y" = 2)),
		WEAR_L_HAND = list("[NORTH]" = list("x" = -1, "y" = 3), "[EAST]" = list("x" = 3, "y" = 2), "[SOUTH]" = list("x" = 1, "y" = 3), "[WEST]" = list("x" = -3, "y" = 2)),
		WEAR_WAIST = list("[NORTH]" = list("x" = 0, "y" = 3), "[EAST]" = list("x" = 0, "y" = 3), "[SOUTH]" = list("x" = 0, "y" = 3), "[WEST]" = list("x" = 0, "y" = 3)),
		WEAR_EYES = list("[NORTH]" = list("x" = 0, "y" = -3), "[EAST]" = list("x" = -3, "y" = -3), "[SOUTH]" = list("x" = 0, "y" = -3), "[WEST]" = list("x" = 3, "y" = -3)),
		WEAR_FEET = list("[NORTH]" = list("x" = 0, "y" = 7), "[EAST]" = list("x" = -1, "y" = 7), "[SOUTH]" = list("x" = 0, "y" = 7), "[WEST]" = list("x" = 1, "y" = 7)),
		WEAR_HEAD = list("[NORTH]" = list("x" = 0, "y" = -3), "[EAST]" = list("x" = -2, "y" = -3), "[SOUTH]" = list("x" = 0, "y" = -3), "[WEST]" = list("x" = 2, "y" = -3)),
		WEAR_BACK = list("[NORTH]" = list("x" = 0, "y" = 0), "[EAST]" = list("x" = -5, "y" = 0), "[SOUTH]" = list("x" = 0, "y" = 0), "[WEST]" = list("x" = 5, "y" = 0)),
		WEAR_FACE = list("[NORTH]" = list("x" = 0, "y" = -3), "[EAST]" = list("x" = -1, "y" = -3), "[SOUTH]" = list("x" = 0, "y" = -3), "[WEST]" = list("x" = 1, "y" = -3))
	)
