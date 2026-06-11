/obj/structure/machinery/defenses/planted_flag/roaf
	name = "\improper ROAF planted flag"
	desc = "A planted flag bearing ROAF colors, providing a rallying point for nearby ROAF personnel."
	icon = 'modular/lv733/icons/planted_flag.dmi'
	handheld_type = /obj/item/defenses/handheld/planted_flag/roaf
	defense_type = "Normal"
	faction = FACTION_ROAF
	selected_categories = list(
		SENTRY_CATEGORY_IFF = FACTION_ROAF,
	)

/obj/item/defenses/handheld/planted_flag/roaf
	name = "handheld ROAF planted flag"
	desc = "A compact ROAF defensive rally flag, designed for deployment in the field."
	icon = 'modular/lv733/icons/planted_flag.dmi'
	icon_state = "Normal planted_flag_handheld"
	defense_type = /obj/structure/machinery/defenses/planted_flag/roaf
	deployment_time = 1 SECONDS
