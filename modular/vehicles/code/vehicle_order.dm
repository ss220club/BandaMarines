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
		if("heavy support vehicles") return clients >= 140
		if("light recon vehicle") return clients >= 1
		if("light carrier") return clients >= 1
		else return TRUE

// Консоль управления Vehicle ASRS
/obj/structure/machinery/computer/supply/asrs/vehicle
	var/list/category_limits   // постоянные лимиты
	var/list/category_given    // сколько уже выдали

/obj/structure/machinery/computer/supply/asrs/vehicle/Initialize()
	// не вызываем родительский Initialize() чтобы избежать двойной инициализации spent
	..()
	category_limits = list("heavy support vehicles" = 1, "light recon vehicle" = 1, "light carrier" = 1)
	category_given = list("heavy support vehicles" = 0, "light recon vehicle" = 0, "light carrier" = 0)
	spent = FALSE // отключаем механику разовой выдачи
	tank_unlocked = TRUE
	circuit = null  // Это убирает возможность разбора консоли, чтобы нельзя было обнулять лимиты пересбором
	// отключены проверки allowed_roles и доступа, var/list/allowed_roles = list(JOB_TANK_CREW)

// Интерфейс консоли
/obj/structure/machinery/computer/supply/asrs/vehicle/attack_hand(mob/living/carbon/human/H as mob)
	if(inoperable()) return

//  тут были проверки на доступ
//	if(LAZYLEN(allowed_roles) && !allowed_roles.Find(H.job)) //replaced Z-level restriction with role restriction.
//		to_chat(H, SPAN_WARNING("This console isn't for you."))
//		return

//	if(!allowed(H))
//		to_chat(H, SPAN_DANGER("Access Denied."))
//		return

	H.set_interaction(src)
	post_signal("supply_vehicle")

	var/dat = ""
	if(!SSshuttle.vehicle_elevator)
		to_chat(H, SPAN_WARNING("Elevator system not detected!"))
		return

	var/turf/upper_turf = get_turf(SSshuttle.getDock("almayer vehicle"))

	dat += "<h3>Vehicle Elevator Status</h3>"
	if(SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE)
		dat += "Platform: <b>Moving</b><br>"
	else if(SSshuttle.vehicle_elevator.z == upper_turf.z)
		dat += "Platform: <b>Raised</b><br>"
		dat += "<a href='byond://?src=\ref[src];lower_elevator=1'>Lower elevator</a><br>"
	else
		dat += "Platform: <b>Lowered</b><br>"
		dat += "<a href='byond://?src=\ref[src];raise_elevator=1'>Raise elevator</a><br>"

	dat += "<hr><h4>Vehicle Categories</h4>"
	for(var/category in category_limits)
		var/used = category_given[category]
		var/limit = category_limits[category]
		dat += "[capitalize(category)]: [used]/[limit] used ([limit - used] remaining)<br>"

	dat += "<hr><h4>Available Vehicles</h4>"
	for(var/d in vehicles)
		var/datum/vehicle_order/order = d
		var/category = get_vehicle_category(order)
		var/used = category_given[category]
		var/limit = category_limits[category]

		if(order.has_vehicle_lock())
			dat += order.failure_message
			continue
		if(used >= limit)
			dat += "<font color='gray'>[order.name] (limit reached)</font><br>"
			continue
		if(!category_unlocked(category))
			dat += "<font color='gray'>[order.name] (category locked)</font><br>"
			continue

		dat += "<a href='byond://?src=\ref[src];get_vehicle=\ref[order]'>[order.name]</a> ([category])<br>"

	show_browser(H, dat, asrs_name, "computer", width = 575, height = 450)


// Основная логика без вызова родителя
/obj/structure/machinery/computer/supply/asrs/vehicle/Topic(href, href_list)
	// НЕ вызываем ..(), чтобы исключить оригинальные проверки
	if(!SSshuttle.vehicle_elevator)
		return

	var/turf/upper_turf = get_turf(SSshuttle.getDock("almayer vehicle"))
	var/turf/lower_turf = get_turf(SSshuttle.getDock("adminlevel vehicle"))

	if(href_list["get_vehicle"])
		var/datum/vehicle_order/order = locate(href_list["get_vehicle"])
		if(!(order in vehicles))
			return

		var/category = get_vehicle_category(order)
		if(!category_unlocked(category))
			to_chat(usr, SPAN_WARNING("[category] category not available yet!"))
			return

		var/used = category_given[category]
		var/limit = category_limits[category]
		if(used >= limit)
			to_chat(usr, SPAN_WARNING("Vehicle limit reached for [category]!"))
			return

		if(SSshuttle.vehicle_elevator.z != lower_turf.z || SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE)
			to_chat(usr, SPAN_WARNING("The elevator must be lowered to retrieve a vehicle!"))
			return

		category_given[category] = used + 1

		var/turf/spawn_turf = lower_turf
		var/obj/vehicle/multitile/ordered_vehicle = new order.ordered_vehicle(spawn_turf)
		to_chat(usr, SPAN_NOTICE("[order.name] retrieved. [limit - category_given[category]] remaining in [category] category."))

		SSshuttle.vehicle_elevator.request(SSshuttle.getDock("almayer vehicle"))
		order.on_created(ordered_vehicle)
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_VEHICLE_ORDERED, ordered_vehicle)

	else if(href_list["lower_elevator"])
		if(SSshuttle.vehicle_elevator.z == lower_turf.z)
			to_chat(usr, SPAN_WARNING("The elevator is already lowered!"))
			return
		SSshuttle.vehicle_elevator.request(SSshuttle.getDock("adminlevel vehicle"))
		to_chat(usr, SPAN_NOTICE("Elevator lowering..."))

	else if(href_list["raise_elevator"])
		if(SSshuttle.vehicle_elevator.z == upper_turf.z)
			to_chat(usr, SPAN_WARNING("The elevator is already raised!"))
			return
		SSshuttle.vehicle_elevator.request(SSshuttle.getDock("almayer vehicle"))
		to_chat(usr, SPAN_NOTICE("Elevator raising..."))

	add_fingerprint(usr)
	updateUsrDialog()

// этот ужас показывает сразу все листы в консоли gear вместо одного при выборе
/obj/structure/machinery/cm_vending/gear/vehicle_crew/get_listed_products(mob/user)
	var/list/display_list = list()

	display_list += GLOB.cm_vending_vehicle_crew_tank
	display_list += GLOB.cm_vending_vehicle_crew_arc
	display_list += GLOB.cm_vending_vehicle_crew_apc


	return display_list


