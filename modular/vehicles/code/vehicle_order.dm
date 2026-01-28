// Минимальное количество игроков для открытия категорий
#define MIN_PLAYERS_HEAVY_SUPPORT 140
#define MIN_PLAYERS_LIGHT_RECON 1
#define MIN_PLAYERS_LIGHT_VEHICLE 40

// Лимиты на количество техники по категориям
#define LIMIT_HEAVY_SUPPORT_VEHICLES 1
#define LIMIT_LIGHT_RECON_VEHICLES   1
#define LIMIT_LIGHT_CARRIERS         1

// Категоризация техники
/proc/get_vehicle_category(datum/vehicle_order/order)
	if(istype(order, /datum/vehicle_order/apc) || istype(order, /datum/vehicle_order/apc/med) || istype(order, /datum/vehicle_order/apc/cmd) || istype(order, /datum/vehicle_order/tank))
		return "heavy support vehicles"
	if(istype(order, /datum/vehicle_order/arc))
		return "light recon vehicle"
	if(istype(order, /datum/vehicle_order/van))
		return "light carrier"
	return "other"

// Проверка доступности категорий по игрокам
/proc/category_unlocked(category)
	var/clients = length(GLOB.clients)
	switch(category)
		if("heavy support vehicles")
			return clients >= MIN_PLAYERS_HEAVY_SUPPORT
		if("light recon vehicle")
			return clients >= MIN_PLAYERS_LIGHT_RECON
		if("light carrier")
			return clients >= MIN_PLAYERS_LIGHT_VEHICLE
		else
			return TRUE

// Консоль управления Vehicle ASRS
/obj/structure/machinery/computer/supply/asrs/vehicle
	var/list/category_limits   // постоянные лимиты
	var/list/category_given    // сколько уже выдали

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	category_limits = list(
		"heavy support vehicles" = LIMIT_HEAVY_SUPPORT_VEHICLES,
		"light recon vehicle" = LIMIT_LIGHT_RECON_VEHICLES,
		"light carrier" = LIMIT_LIGHT_CARRIERS
	)
	category_given = list(
		"heavy support vehicles" = 0,
		"light recon vehicle" = 0,
		"light carrier" = 0
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
