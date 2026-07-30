// tank_camouflage.dm

/obj/vehicle/multitile/tank
    var/icon_skin = "classic"
    var/need_camo = FALSE
    var/icon_base = "tank_base"

/obj/vehicle/multitile/tank/New(loc, skin)
    . = ..()
    icon = 'modular/vehicles/icons/tank_camouflage.dmi'
    icon_state = icon_base

    if(skin)
        icon_skin = skin
    else if(need_camo)
        select_gamemode_skin()

        update_icon()

// ==========================================
// ============== Camo skin ===============
// Камуфлирование под текущую карту

/obj/vehicle/multitile/tank/camo
    need_camo = TRUE

// Функции выбора скина
/obj/vehicle/multitile/tank/proc/select_gamemode_skin()
    if(flags_atom & NO_GAMEMODE_SKIN)
        return  // <-- Добавлен отступ (4 пробела или табуляция)
    var/skin = SSmapping.configs[GROUND_MAP].camouflage_type
    var/static/list/valid_skins = list("snow", "desert", "classic", "urban")
    if(skin in valid_skins)
        icon_skin = skin  // <-- Добавлен отступ
        update_icon()

// ==========================================
// ============== Desert skin ===============

/obj/vehicle/multitile/tank/desert
    icon_state = "tank_base_d"
    icon_skin = "desert"

// ==========================================
// =============== Snow skin ================

//obj/vehicle/multitile/tank/snow
 //   icon_state = "tank_base_snow"  // Убедитесь, что этот стейт существует
 //   icon_skin = "snow"

// ==========================================
// =============== Urban skin ===============

/obj/vehicle/multitile/tank/urban
    icon_state = "tank_base_n"
    icon_skin = "urban"


