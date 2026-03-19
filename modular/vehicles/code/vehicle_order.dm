// Минимальное количество игроков для открытия категорий
#define MIN_PLAYERS_HEAVY_SUPPORT 65
#define MIN_PLAYERS_MEDIUM_SUPPORT 65
#define MIN_PLAYERS_LIGHT_SUPPORT 40
#define MIN_PLAYERS_LIGHT_RECON 1
#define MIN_PLAYERS_LIGHT_VEHICLE 40

// Лимиты на количество техники по категориям
#define LIMIT_HEAVY_SUPPORT_VEHICLES 1
#define LIMIT_MEDIUM_SUPPORT_VEHICLES 1
#define LIMIT_LIGHT_SUPPORT_VEHICLES 1
#define LIMIT_LIGHT_RECON_VEHICLES   1
#define LIMIT_LIGHT_CARRIERS         1

// Категоризация техники
/proc/get_vehicle_category(datum/vehicle_order/order)
    if(istype(order, /datum/vehicle_order/tank))
        return "Тяжелая бронетехника"
    if(istype(order, /datum/vehicle_order/apc) || istype(order, /datum/vehicle_order/apc/med) || istype(order, /datum/vehicle_order/apc/cmd))
        return "Бронетранспортеры"
    if(istype(order, /datum/vehicle_order/humvee/apc))
        return "Бронеавтомобили"
    if(istype(order, /datum/vehicle_order/arc))
        return "Специальная техника"
    if(istype(order, /datum/vehicle_order/van) || istype(order, /datum/vehicle_order/humvee/medical) || istype(order, /datum/vehicle_order/humvee/transport))
        return "Логистическая техника"
    return "другое"

// Проверка доступности категорий по игрокам
/proc/category_unlocked(category, obj/structure/machinery/computer/supply/asrs/vehicle/console)
    var/clients = length(GLOB.clients)

    var/player_count = FALSE
    switch(category)
        if("Тяжелая бронетехника")
            player_count = (clients >= MIN_PLAYERS_HEAVY_SUPPORT)
        if("Бронетранспортеры")
            player_count = (clients >= MIN_PLAYERS_HEAVY_SUPPORT)
        if("Бронеавтомобили")
            player_count = (clients >= MIN_PLAYERS_LIGHT_SUPPORT)
        if("Специальная техника")
            player_count = (clients >= MIN_PLAYERS_LIGHT_RECON)
        if("Логистическая техника")
            player_count = (clients >= MIN_PLAYERS_LIGHT_VEHICLE)
        else
            player_count = TRUE

    if(!player_count)
        return FALSE

    if(console)
        if(category == "Тяжелая бронетехника")
            if(console.category_given["Бронеавтомобили"] > 0 || console.category_given["Бронетранспортеры"] > 0)
                return FALSE

        if(category == "Бронетранспортеры")
            if(console.category_given["Бронеавтомобили"] > 0 || console.category_given["Тяжелая бронетехника"] > 0)
                return FALSE

        if(category == "Бронеавтомобили")
            if(console.category_given["Тяжелая бронетехника"] > 0 || console.category_given["Бронетранспортеры"] > 0)
                return FALSE

    return TRUE

// Консоль управления Vehicle ASRS
/obj/structure/machinery/computer/supply/asrs/vehicle
	var/list/category_limits   // постоянные лимиты
	var/list/category_given    // сколько уже выдали

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
    . = ..()

    category_limits = list(
        "Тяжелая бронетехника" = LIMIT_HEAVY_SUPPORT_VEHICLES,
        "Бронетранспортеры" = LIMIT_MEDIUM_SUPPORT_VEHICLES,
        "Бронеавтомобили" = LIMIT_LIGHT_SUPPORT_VEHICLES,
        "Специальная техника" = LIMIT_LIGHT_RECON_VEHICLES,
        "Логистическая техника" = LIMIT_LIGHT_CARRIERS
    )
    category_given = list(
        "Тяжелая бронетехника" = 0,
        "Бронетранспортеры" = 0,
        "Бронеавтомобили" = 0,
        "Специальная техника" = 0,
        "Логистическая техника" = 0
    )

    category_required_roles = list(
        "Тяжелая бронетехника" = list(JOB_TANK_CREW),
        "Бронетранспортеры" = list(JOB_TANK_CREW),
        "Бронеавтомобили" = list(JOB_TANK_CREW)
    )

    spent = FALSE
    tank_unlocked = TRUE
    circuit = null

    return INITIALIZE_HINT_NORMAL

// Прок проверки лифта
/proc/vehicle_elevator_safety_check(atom/A)
    if(isliving(A))
        return TRUE
    if(istype(A, /obj/vehicle))
        return TRUE
    for(var/atom/B in A.contents)
        if(vehicle_elevator_safety_check(B))
            return TRUE
    return FALSE

// Вторая проверка лифта после вызова
/obj/docking_port/mobile/vehicle_elevator/canMove()
    var/obj/docking_port/stationary/S = get_docked()
    // Проверяем только если лифт сейчас в ангаре
    if(istype(S, /obj/docking_port/stationary/vehicle_elevator/almayer))
        if(vehicle_elevator_safety_check(get_area(src)))
            set_mode(SHUTTLE_IDLE)
            stop_gears()
            open_railings()
            playsound(return_center_turf(), 'sound/machines/buzz-two.ogg', 50, 0)
            return FALSE

    return TRUE

// Прок проверки танкистов
/proc/category_has_access(mob/user, category, obj/structure/machinery/computer/supply/asrs/vehicle/console)
    if(!console)
        return TRUE

    var/list/req_roles = console.category_required_roles[category]

    if(req_roles)
        if(!(user.job in req_roles))
            return FALSE

    return TRUE
