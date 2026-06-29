// Переменнные для интерфейса
/obj/structure/machinery/computer/supply/asrs/vehicle
	var/list/category_limits   // постоянные лимиты
	var/list/category_given    // сколько уже выдали
	var/list/category_required_roles // блокировка техники по роли

	// Новые списки для группировки
	var/list/group_limits
	var/list/group_given
	var/list/category_to_group 

// Блок старого интерфейса
/obj/structure/machinery/computer/supply/asrs/vehicle/attack_hand(mob/user)
	if(inoperable())
		return
	tgui_interact(user)

/obj/structure/machinery/computer/supply/asrs/vehicle/attack_remote(mob/user)
	attack_hand(user)

/obj/structure/machinery/computer/supply/asrs/vehicle/Topic(href, href_list)
	return

// Логика нового интерфейса
/obj/structure/machinery/computer/supply/asrs/vehicle/tgui_interact(mob/user, datum/tgui/ui)
	if(inoperable())
		return

	user.set_interaction(src)

	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "VehicleASRS", name)
		ui.set_autoupdate(FALSE)
		ui.open()

/obj/structure/machinery/computer/supply/asrs/vehicle/allowed(mob/user)
	return TRUE

/obj/structure/machinery/computer/supply/asrs/vehicle/ui_status(mob/user)
	. = ..()
	if(inoperable(MAINT))
		return UI_CLOSE

	if(!user.Adjacent(src))
		return UI_CLOSE

/obj/structure/machinery/computer/supply/asrs/vehicle/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/computer/supply/asrs/vehicle/ui_data(mob/user)
	. = ..()
	var/list/data = list()
	var/turf/upper_turf = get_turf(SSshuttle.getDock("almayer vehicle"))

	data["elevator_moving"] = SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE
	data["elevator_raised"] = SSshuttle.vehicle_elevator.z == upper_turf.z

	// Состав групп
	var/list/combat_cats = list("Тяжелая бронетехника", "Бронетранспортеры", "Бронеавтомобили")
	var/list/logistics_cats = list("Логистическая техника", "Санитаркая техника")
	var/list/special_cats = list("Разведка")

	// Общий расход групп
	var/list/group_totals = list("Огневая поддержка" = 0, "Логистика" = 0, "Специальная техника" = 0)

	for(var/cat in combat_cats)
		group_totals["Огневая поддержка"] += category_given[cat]
	for(var/cat in logistics_cats)
		group_totals["Логистика"] += category_given[cat]
	for(var/cat in special_cats)
		group_totals["Специальная техника"] += category_given[cat]

	// Подготовка категорий
	var/list/categories = list()
	for(var/category in category_limits)
		var/main_cat_name
		var/used_value

		if(category in combat_cats)
			main_cat_name = "Боевая поддержка"
			used_value = group_totals["Огневая поддержка"]
		else if(category in logistics_cats)
			main_cat_name = "Логистика"
			used_value = group_totals["Логистика"]
		else if(category in special_cats)
			main_cat_name = "Спецтехника"
			used_value = group_totals["Специальная техника"]
		else
			main_cat_name = "Другое"
			used_value = category_given[category]

		categories += list(list(
			"name" = capitalize(category),
			"used" = used_value,
			"limit" = category_limits[category],
			"main_category" = main_cat_name
		))
	data["categories"] = categories

	// Подготовка списка техники
	var/list/vehicle_list = list()
	for(var/d in vehicles)
		var/datum/vehicle_order/order = d
		var/category = get_vehicle_category(order)
		
		var/main_cat_name
		var/used_value

		if(category in combat_cats)
			main_cat_name = "Боевая поддержка"
			used_value = group_totals["Огневая поддержка"]
		else if(category in logistics_cats)
			main_cat_name = "Логистика"
			used_value = group_totals["Логистика"]
		else if(category in special_cats)
			main_cat_name = "Спецтехника"
			used_value = group_totals["Специальная техника"]
		else
			main_cat_name = "Другое"
			used_value = category_given[category]

		var/limit = category_limits[category]

		var/entry = list(
			"id" = "\ref[order]",
			"name" = order.name,
			"category" = capitalize(category),
			"main_category" = main_cat_name
		)

		if(order.has_vehicle_lock())
			entry["locked"] = TRUE
			entry["failure_message"] = order.failure_message
		else if(used_value >= limit)
			entry["limit_reached"] = TRUE
		else if(!category_unlocked(category, src))
			entry["category_locked"] = TRUE

		vehicle_list += list(entry)

	data["vehicles"] = vehicle_list
	return data

/obj/structure/machinery/computer/supply/asrs/vehicle/ui_act(action, params)
	. = ..()
	if(.) return

	var/turf/upper_turf = get_turf(SSshuttle.getDock("almayer vehicle"))
	var/turf/lower_turf = get_turf(SSshuttle.getDock("adminlevel vehicle"))

	switch(action)
		if("get_vehicle")
			var/id = params["id"]
			var/datum/vehicle_order/order = locate(id)
			if(!(order in vehicles))
				return

			var/category = get_vehicle_category(order)

			var/list/combat_cats = list("Тяжелая бронетехника", "Бронетранспортеры", "Бронеавтомобили")
			var/list/logistics_cats = list("Логистическая техника")
			var/list/special_cats = list("Разведка")

			var/list/current_group_list
			if(category in combat_cats)
				current_group_list = combat_cats
			else if(category in logistics_cats)
				current_group_list = logistics_cats
			else if(category in special_cats)
				current_group_list = special_cats

			var/total_group_used = 0
			if(current_group_list)
				for(var/cat in current_group_list)
					total_group_used += category_given[cat]
			else
				total_group_used = category_given[category]

			if(total_group_used >= category_limits[category])
				to_chat(usr, SPAN_WARNING("Лимит для данной группы техники ([category]) исчерпан!"))
				return

			if(!category_unlocked(category, src))
				to_chat(usr, SPAN_WARNING("Эта категория еще заблокирована!"))
				return

			if(!category_has_access(usr, category, src))
				to_chat(usr, SPAN_WARNING("У вас нет прав для управления этой техникой!"))
				return

			if(SSshuttle.vehicle_elevator.z != lower_turf.z || SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE)
				to_chat(usr, SPAN_WARNING("Лифт должен находиться внизу в режиме ожидания!"))
				return

			category_given[category]++ 
			var/obj/vehicle/multitile/ordered_vehicle = new order.ordered_vehicle(lower_turf)
			to_chat(usr, SPAN_NOTICE("Запрос на [order.name] принят. Техника загружается на платформу."))

			SSshuttle.vehicle_elevator.request(SSshuttle.getDock("almayer vehicle"))

			order.on_created(ordered_vehicle)
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_VEHICLE_ORDERED, ordered_vehicle)

			SStgui.update_uis(src)
			spawn(102)
				SStgui.update_uis(src)
			return TRUE

		if("raise_elevator")
			if(SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE)
				return
			if(SSshuttle.vehicle_elevator.z == upper_turf.z)
				to_chat(usr, SPAN_WARNING("Лифт уже поднят!"))
				return

			SSshuttle.vehicle_elevator.request(SSshuttle.getDock("almayer vehicle"))
			to_chat(usr, SPAN_NOTICE("Лифт поднимается..."))

			SStgui.update_uis(src)
			spawn(102)
				SStgui.update_uis(src)
			return TRUE

		if("lower_elevator")
			if(SSshuttle.vehicle_elevator.mode != SHUTTLE_IDLE)
				return

			if(!is_mainship_level(SSshuttle.vehicle_elevator.z))
				return

			if(vehicle_elevator_safety_check(get_area(SSshuttle.vehicle_elevator)))
				to_chat(usr, SPAN_WARNING("Система безопасности: очистите платформу от живых организмов и транспорта перед спуском!"))
				return

			if(SSshuttle.vehicle_elevator.z == lower_turf.z)
				to_chat(usr, SPAN_WARNING("Лифт уже опущен!"))
				return

			SSshuttle.vehicle_elevator.request(SSshuttle.getDock("adminlevel vehicle"))
			to_chat(usr, SPAN_NOTICE("Лифт опускается..."))

			SStgui.update_uis(src)
			spawn(102)
				SStgui.update_uis(src)
			return TRUE
