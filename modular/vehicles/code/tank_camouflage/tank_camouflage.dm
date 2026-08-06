// tank_camouflage.dm

/obj/vehicle/multitile/tank
	name = "M34A2 Longstreet Light Tank"
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back."
	icon = 'modular/vehicles/icons/tank_camouflage.dmi'
	icon_state = "tank_base"
/obj/vehicle/multitile/proc/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	if(flags_atom & NO_GAMEMODE_SKIN)
		return

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base_j"
		if("classic")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base"
		if("desert")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base_d"
//		if("snow")
//			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
//			icon_state = "tank_base_s"  // или другой корректный state
		if("urban")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base_n"
	update_icon()
