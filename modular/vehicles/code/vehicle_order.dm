// Минимальное количество игроков для открытия категорий
#define MIN_PLAYERS_HEAVY_SUPPORT 85
#define MIN_PLAYERS_LIGHT_SUPPORT 70
#define MIN_PLAYERS_LIGHT_RECON 1
#define MIN_PLAYERS_LIGHT_VEHICLE 40

// Лимиты на количество техники по категориям
#define LIMIT_HEAVY_SUPPORT_VEHICLES 1
#define LIMIT_LIGHT_SUPPORT_VEHICLES 1
#define LIMIT_LIGHT_RECON_VEHICLES   1
#define LIMIT_LIGHT_CARRIERS         1

// Категоризация техники
/proc/get_vehicle_category(datum/vehicle_order/order)
	if(istype(order, /datum/vehicle_order/tank))
		return "heavy support vehicles"
	if(istype(order, /datum/vehicle_order/apc) || istype(order, /datum/vehicle_order/apc/med) || istype(order, /datum/vehicle_order/apc/cmd))
		return "light support vehicles"
	if(istype(order, /datum/vehicle_order/arc))
		return "light recon vehicle"
	if(istype(order, /datum/vehicle_order/van))
		return "light carrier"
	return "other"

// Проверка доступности категорий по игрокам
/proc/category_unlocked(category, obj/structure/machinery/computer/supply/asrs/vehicle/console)
	var/clients = length(GLOB.clients)

	var/player_count = FALSE
	switch(category)
		if("heavy support vehicles")
			player_count = (clients >= MIN_PLAYERS_HEAVY_SUPPORT)
		if("light support vehicles")
			player_count = (clients >= MIN_PLAYERS_LIGHT_SUPPORT)
		if("light recon vehicle")
			player_count = (clients >= MIN_PLAYERS_LIGHT_RECON)
		if("light carrier")
			player_count = (clients >= MIN_PLAYERS_LIGHT_VEHICLE)
		else
			player_count = TRUE

	if(!player_count)
		return FALSE

	if(console)
		if(category == "heavy support vehicles")
			if(console.category_given["light support vehicles"] > 0)
				return FALSE

		if(category == "light support vehicles")
			if(console.category_given["heavy support vehicles"] > 0)
				return FALSE

	return TRUE

// Консоль управления Vehicle ASRS
/obj/structure/machinery/computer/supply/asrs/vehicle
	var/list/category_limits   // постоянные лимиты
	var/list/category_given    // сколько уже выдали

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	. = ..()

	category_limits = list(
		"heavy support vehicles" = LIMIT_HEAVY_SUPPORT_VEHICLES,
		"light support vehicles" = LIMIT_LIGHT_SUPPORT_VEHICLES,
		"light recon vehicle" = LIMIT_LIGHT_RECON_VEHICLES,
		"light carrier" = LIMIT_LIGHT_CARRIERS
	)
	category_given = list(
		"heavy support vehicles" = 0,
		"light support vehicles" = 0,
		"light recon vehicle" = 0,
		"light carrier" = 0
	)

	spent = FALSE
	tank_unlocked = TRUE
	circuit = null

	return INITIALIZE_HINT_NORMAL

// показываем сразу все листы в консоли gear вместо одного
/obj/structure/machinery/cm_vending/gear/vehicle_crew/get_listed_products(mob/user)
	var/list/display_list = list()

	display_list += GLOB.cm_vending_vehicle_crew_tank
	display_list += GLOB.cm_vending_vehicle_crew_arc
	display_list += GLOB.cm_vending_vehicle_crew_apc


	return display_list


