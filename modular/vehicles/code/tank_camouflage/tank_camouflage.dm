
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
    if(skin in list("desert", "classic", "urban"))
        icon_skin = skin

// ==========================================
// ============== Desert skin ===============

/obj/vehicle/multitile/tank/desert
	icon_state = "tank_base_d"
	icon_skin = "desert"

// ==========================================
// =============== Snow skin ================


// ==========================================
// =============== Urban skin ===============

/obj/vehicle/multitile/tank/urban
	icon_state = "tank_base_n"
	icon_skin = "urban"


