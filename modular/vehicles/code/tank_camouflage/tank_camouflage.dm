// tank_camouflage.dm

/obj/vehicle/multitile/tank
	name = "M34A2 Longstreet Light Tank"
	desc = "A giant piece of armor with a big gun, you know what to do. Entrance in the back."
	icon = 'modular/vehicles/icons/tank_camouflage.dmi'
	icon_state = "tank_base"

/obj/vehicle/multitile/tank/Initialize()
	. = ..()
	select_gamemode_skin()

/obj/vehicle/multitile/tank/proc/select_gamemode_skin()
	if(flags_atom & NO_GAMEMODE_SKIN)
		icon = 'modular/vehicles/icons/tank_camouflage.dmi'
		icon_state = "tank_base"
		update_icon()
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
		if("urban")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base_n"
		if("snow")
//			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
//			icon_state = "tank_base_s"
//		else
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_base"

	update_icon()


// ===== Башня =====
/obj/item/hardpoint/holder/tank_turret/select_gamemode_skin(expected_type, list/override_icon_state, list/override_protection)
	if(flags_atom & NO_GAMEMODE_SKIN)
		icon = 'modular/vehicles/icons/tank_camouflage.dmi'
		icon_state = "tank_turret_0"
		update_icon()
		return

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_turret_j_0"
		if("classic")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_turret_0"
		if("desert")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_turret_d_0"
		if("urban")
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_turret_n_0"
//		if("snow")
//			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
//			icon_state = "tank_turret_s_0"
		else
			icon = 'modular/vehicles/icons/tank_camouflage.dmi'
			icon_state = "tank_turret_0"

	update_icon()
