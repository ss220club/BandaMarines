// =====================================================================
// 1. ДОБАВЛЕНИЕ НОВЫХ ПЕРЕМЕННЫХ К ОРИГИНАЛЬНОМУ КЛАССУ
// =====================================================================
/obj/structure/machinery/cm_vending/gear/vehicle_crew
	var/list/last_display_list

// =====================================================================
// 2. НОВАЯ ЛОГИКА
// =====================================================================
/obj/structure/machinery/cm_vending/gear/vehicle_crew/populate_products(datum/source, obj/effect/vehicle_spawner/spawner)
	
	selected_vehicle = spawner.category
	// Логика анонсов BandaMarines
	switch(selected_vehicle)
		if("APC")
			marine_announcement("В поддержку наземных сил операции вам будет предоставлен БТР.")
		if("ARC")
			marine_announcement("В поддержку наземных сил операции вам будет предоставлен БРМ.")
		if("VAN")
			marine_announcement("В поддержку наземных сил операции вам будет предоставлен Грузовик.")
		if("HWC")
			marine_announcement("В поддержку наземных сил операции вам будет предоставлен Бронеавтомобиль.")
		if("TANK")
			// Специфическая логика для танка из оригинального CM
			available_categories &= ~(VEHICLE_INTEGRAL_AVAILABLE)
			marine_announcement("В поддержку наземных сил операции вам будет предоставлен Танк.")
		
		else
			// Фолбэк, если категория не распознана
			if(!selected_vehicle)
				selected_vehicle = "TANK"
				available_categories &= ~(VEHICLE_INTEGRAL_AVAILABLE)
				marine_announcement("В поддержку наземных сил операции вам будет предоставлен танк.")

/obj/structure/machinery/cm_vending/gear/vehicle_crew/get_listed_products(mob/user)
	var/list/display_list = list()

	if(!user)
		display_list += GLOB.cm_vending_vehicle_crew_tank_modul
		display_list += GLOB.cm_vending_vehicle_crew_apc_modul
		display_list += GLOB.cm_vending_vehicle_crew_humvee_modul // Ваша добавка
		return display_list

	// 2. Логика выбора конкретного списка на основе выбранной техники
	switch(selected_vehicle)
		if("TANK")
			if(available_categories)
				last_display_list = GLOB.cm_vending_vehicle_crew_tank_modul
		if("APC")
			if(available_categories)
				last_display_list = GLOB.cm_vending_vehicle_crew_apc_modul
		if("HWC")
			if(available_categories)
				last_display_list = GLOB.cm_vending_vehicle_crew_humvee_modul

	if(last_display_list)
		return last_display_list

	return display_list

// =====================================================================
// 3. ЛСТЫ СНАРЯЖЕНИЯ 
// =====================================================================
var/list/cm_vending_vehicle_crew_humvee

// Танк
GLOBAL_LIST_INIT(cm_vending_vehicle_crew_tank_modul, list(
	list("ВЫБОР СТАРТОВОГО НАБОРА:", 0, null, null, null),

//	list("ОСНОВНЫЕ ЧАСТИ", 0, null, null, null),
//	list("Универсальная башня M34A2-A", 0, /obj/effect/essentials_set/tank/turret, VEHICLE_INTEGRAL_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("ОСНОВНОЕ ОРУДИЕ", 0, null, null, null),
	list("Пушка LTB 86мм", 0, /obj/effect/essentials_set/tank/ltb, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_RECOMMENDED), // TANK SUPREMACY
	list("Автопушка AC3-E", 0, /obj/effect/essentials_set/tank/autocannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Наступательный огнемет DRG-N", 0, /obj/effect/essentials_set/tank/dragonflamer, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Миниган LTAA-AP", 0, /obj/effect/essentials_set/tank/gatling, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_REGULAR),

	list("ВТОРИЧНОЕ ОРУДИЕ", 0, null, null, null),
	list("Гранатомет M92T", 0, /obj/effect/essentials_set/tank/tankgl, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Зенитная установка M56 Cupola", 0, /obj/effect/essentials_set/tank/m56cupola, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Огнемет LZR-N", 0, /obj/effect/essentials_set/tank/tankflamer, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_RECOMMENDED),

	list("МОДУЛЬ ПОДДЕРЖКИ", 0, null, null, null),
	list("Артиллерийский модуль", 0, /obj/item/hardpoint/support/artillery_module, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Интегрированный сенсорный массив оружия", 0, /obj/item/hardpoint/support/weapons_sensor, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Усилитель форсажа", 0, /obj/item/hardpoint/support/overdrive_enhancer, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_RECOMMENDED),

	list("БРОНЯ", 0, null, null, null),
	list("Инженерный отвал", 0, /obj/item/hardpoint/armor/snowplow, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Противозрывная защита", 0, /obj/item/hardpoint/armor/paladin, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR), // TANK SUPREMACY
	list("Химическая защита", 0, /obj/item/hardpoint/armor/caustic, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR), // TANK SUPREMACY
	list("Защита с амортизацией ударов", 0, /obj/item/hardpoint/armor/concussive, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR), // TANK SUPREMACY
	list("Баллистическая защита", 0, /obj/item/hardpoint/armor/ballistic, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_REGULAR), // TANK SUPREMACY

	list("ГУСЕНИЦЫ", 0, null, null, null),
	list("Усиленные гусеницы", 0, /obj/item/hardpoint/locomotion/treads/robust, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_REGULAR),
	list("Гусеницы", 0, /obj/item/hardpoint/locomotion/treads, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_REGULAR)))


// БТР
GLOBAL_LIST_INIT(cm_vending_vehicle_crew_apc_modul, list(
	list("ВЫБОР СТАРТОВОГО НАБОРА:", 0, null, null, null),

	list("ОСНОВНОЕ ОРУДИЕ", 0, null, null, null),
	list("Сдвоенная пушка PARS-159 Боярин", 0, /obj/effect/essentials_set/apc/dualcannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("ВТОРИЧНОЕ ОРУДИЕ", 0, null, null, null),
	list("Фронтальная пушка RE-RE700", 0, /obj/effect/essentials_set/apc/frontalcannon, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("МОДУЛЬ ПОДДЕРЖКИ", 0, null, null, null),
	list("Сигнальная ракетница M-97F", 0, /obj/effect/essentials_set/apc/flarelauncher, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("КОЛЕСА", 0, null, null, null),
	list("Колеса БТР", 0, /obj/item/hardpoint/locomotion/apc_wheels, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_MANDATORY)))


// Хамви с пушкой
GLOBAL_LIST_INIT(cm_vending_vehicle_crew_humvee_modul, list(
	list("ВЫБОР СТАРТОВОГО НАБОРА:", 0, null, null, null),

	list("ОСНОВНОЕ ОРУДИЕ", 0, null, null, null),
	list("Автопушка M24-RC1", 0, /obj/effect/essentials_set/humvee/autocannon, VEHICLE_PRIMARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("ВТОРИЧНОЕ ОРУДИЕ", 0, null, null, null),
	list("Сигнальная ракетница M-77F", 0, /obj/effect/essentials_set/humvee/humvee_flare_launcher, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),
//	list("M24-RC1 Thermobaric Launcher", 0, /obj/effect/essentials_set/humvee/humvee_launcher, VEHICLE_SECONDARY_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("МОДУЛЬ ПОДДЕРЖКИ", 0, null, null, null),
	list("Навесные прожекторы JTMV", 0, /obj/item/hardpoint/support/humvee_overhead_lights, VEHICLE_SUPPORT_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("БРОНЯ", 0, null, null, null),
	list("Инженерный отвал", 0, /obj/item/hardpoint/armor/humvee_snowplow, VEHICLE_ARMOR_AVAILABLE, VENDOR_ITEM_MANDATORY),

	list("КОЛЕСА", 0, null, null, null),
	list("Колеса M24-JTMV", 0, /obj/item/hardpoint/locomotion/humvee_wheels, VEHICLE_TREADS_AVAILABLE, VENDOR_ITEM_MANDATORY)))
