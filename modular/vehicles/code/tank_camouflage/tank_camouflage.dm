
/obj/vehicle/multitile/tank
	if(skin)
		icon_skin = skin
	else if(need_camo)
		select_gamemode_skin()
	. = ..(loc, icon_skin)

// ==========================================
// ============== Camo skin ===============

// Камуфлирование под текущую карту

/obj/vehicle/multitile/tank/camo
	need_camo = TRUE

// Функции выбора скина
/obj/vehicle/multitile/tank/proc/select_gamemode_skin()
	if(flags_atom & NO_GAMEMODE_SKIN)
		return
	var/skin = SSmapping.configs[GROUND_MAP].camouflage_type
	switch(skin)
		if("snow")
			icon_skin = skin
		if("desert")
			icon_skin = skin
		if("classic")
			icon_skin = skin
		if("urban")
			icon_skin = skin

// ==========================================
// ============== Desert skin ===============

/obj/vehicle/multitile/tank/desert
	icon_state = "tank_base_d"
	icon_skin = "desert"

// ==========================================
// =============== Snow skin ================

/obj/vehicle/multitile/tank/snow
	icon_state = "moto_ural_snow"
	icon_skin = "snow"

// ==========================================
// =============== Urban skin ===============

/obj/vehicle/multitile/tank/urban
	icon_state = "tank_base_n"
	icon_skin = "urban"


