//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_engi, list(
		list("ENGINEER SET (MANDATORY)", 0, null, null, null),
		list("Essential Engineer Set", 0, /obj/effect/essentials_set/engi, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("HANDHELD DEFENSE (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("21S Tesla Coil", 0, /obj/item/defenses/handheld/tesla_coil, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("JIMA Planted Flag", 0, /obj/item/defenses/handheld/planted_flag, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("UA 42-F Sentry Flamer", 0, /obj/item/defenses/handheld/sentry/flamer, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("UA 571-C Sentry Gun", 0, /obj/item/defenses/handheld/sentry, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
		list("Sentry Upgrade kit", 15, /obj/item/engi_upgrade_kit, null, VENDOR_ITEM_REGULAR),

		list("ИНЖЕНЕРНОЕ ОБОРУДОВАНИЕ", 0, null, null, null),
		list("Airlock Circuit Board", 2, /obj/item/circuitboard/airlock, null, VENDOR_ITEM_REGULAR),
		list("APC Circuit Board", 2, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("Entrenching Tool (ET)", 2, /obj/item/tool/shovel/etool, null, VENDOR_ITEM_REGULAR),
		list("High-Capacity Power Cell", 3, /obj/item/cell/high, null, VENDOR_ITEM_REGULAR),
		list("Metal x10", 5, /obj/item/stack/sheet/metal/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("Plasteel x10", 7, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("Пластичная взрывчатка С-4", 3, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("Пробивной заряд", 5, /obj/item/explosive/plastic/breaching_charge, null, VENDOR_ITEM_RECOMMENDED),
		list("Мешки с песком", 10, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_RECOMMENDED),
		list("Super-Capacity Power Cell", 10, /obj/item/cell/super, null, VENDOR_ITEM_REGULAR),
		list("ES-11 Mobile Fuel Canister", 4, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),

		list("ВЗРЫВЧАТЫЕ ВЕЩЕСТВА", 0, null, null, null),
		list("Упаковка гранат M40 HEDP (Осколочная) x 3", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HIDP (Зажигательная) x 3", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 WPDP (Химическая смесь) x 3", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HIDP (Дымовая) x 3", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Осколочная) x 3", 18, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Зажигательная) x 3", 18, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Дымовая) x 3", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM «Шершень» x 3", 20, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("Ящик мин M20 x 5", 18, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("Граната M40 MFHS (Пена)", 5, /obj/item/explosive/grenade/metal_foam, null, VENDOR_ITEM_REGULAR),
		list("Упаковка электрошоковых гранат G2 x 3",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ОСНОВНОГО ОРУЖИЯ", 0, null, null, null),
		list("Магазин для M4RA (10x24мм AP)", 6, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M4RA (10x24мм)", 6, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("Магазин для M39 (10x20мм AP)", 6, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M39 (10x20мм)", 6, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("Магазин для M41A (10x24мм AP)", 6, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M41A (10x24мм)", 6, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ДОПОЛНИТЕЛЬНОГО ОРУЖИЯ", 0, null, null, null),
		list("Расширенный магазин для M10 HV (10x20мм)", 10, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("Барабанный магазин для M10 HV (10x20мм)", 15, /obj/item/ammo_magazine/pistol/m10/drum , null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 FMJ)", 6, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 SSA)", 6, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine", 3, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine", 3, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("Магазин для VP78 (9мм)", 3, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("Магазин для SU-6 (.45)", 6, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("БРОНЯ", 0, null, null, null),
		list("Броня пехотинца M3 B12", 24, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("Броня пехотинца M4", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("ВООРУЖЕНИЕ С ОГРАНИЧЕННЫМ ДОСТУПОМ", 0, null, null, null),
		list("Пистолет VP78", 8, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", 12, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("Огнемёт M240", 12, /obj/item/storage/box/guncase/flamer, null, VENDOR_ITEM_REGULAR),
		list("Гранатомёт M79", 24, /obj/item/storage/box/guncase/m79, null, VENDOR_ITEM_REGULAR),
		list("Тяжёлый пулемёт M56D", 24, /obj/item/storage/box/guncase/m56d, null, VENDOR_ITEM_REGULAR),

		list("ЭЛЕМЕНТЫ ОДЕЖДЫ", 0, null, null, null),
		list("Чехол для мачете", 6, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Ножны для мачете", 8, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Рюкзак связиста ККМП", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для резервуаров к огнемёту", 4, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("Ременная сумка", 6, /obj/item/storage/pouch/sling, null, VENDOR_ITEM_REGULAR),
		list("Большой подсумок общего назначения", 6, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("M276 Pattern Combat Toolbelt Rig", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", 0, null, null, null),
		list("Роликовые носилки", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("Система воздушной эвакуации Фултон", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("Переносной огнетушитель", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Детектор движения", 8, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("Свисток", 3, /obj/item/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("Synthetic Reset Key", 10, /obj/item/device/defibrillator/synthetic, null, VENDOR_ITEM_REGULAR),

		list("БИНОКУЛЯРЫ", 0, null, null, null),
		list("Бинокль", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("Дальномер", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("Лазерный целеуказатель", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("ГОЛОВНЫЕ ЭКРАНЫ", 0, null, null, null),
		list("Medical Helmet Optic", 12, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("Welding Visor", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("ИНСТРУКЦИИ", 0, null, null, null),
		list("Инструкция для JTAC", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),

		list("КЛЮЧИ ШИФРОВАНИЯ", 0, null, null, null),
		list("Ключ шифрования для гарнитуры — разведка", 3, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — JTAC", 3, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — обеспечение", 3, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/engi
	name = "\improper ColMarTech Squad ComTech Gear Rack"
	desc = "An automated gear rack for combat technicians."
	icon_state = "eng_gear"
	vendor_role = list(JOB_SQUAD_ENGI)
	req_access = list(ACCESS_MARINE_ENGPREP)

/obj/structure/machinery/cm_vending/gear/engi/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_engi

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_engi, list(
		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ВОЗЬМИТЕ ВСЁ)", 0, null, null, null),
		list("Стандартная экипировка пехотинца", 0, list(/obj/item/clothing/under/marine/engineer, /obj/item/clothing/shoes/marine/knife, /obj/item/device/radio/headset/almayer/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Чёрные резиновые перчатки", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Жёлтые резиновые перчатки", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Сухой паек MRE", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Набор для ремонта оружия", 0, /obj/item/stack/repairable/gunkit, MARINE_CAN_BUY_REPAIRABLE, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("ШЛЕМЫ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Шлем техника ККМП", 0, /obj/item/clothing/head/helmet/marine/tech, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Сварочный шлем техника ККМП", 0, /obj/item/clothing/head/helmet/marine/welding, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("БРОНЯ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Лёгкая броня", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Средняя броня", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Тяжёлая броня", 0, /obj/item/clothing/suit/storage/marine/heavy, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("РЮКЗАКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Чехол для мачете", 0, /obj/item/storage/large_holster/machete/full, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Рюкзак техника ККМП", 0, /obj/item/storage/backpack/marine/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Ранец техника ККМП", 0, /obj/item/storage/backpack/marine/satchel/tech, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Разгрузочная система техника ККМП", 0, /obj/item/storage/backpack/marine/engineerpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Сварочный ранец техника", 0, /obj/item/storage/backpack/marine/engineerpack/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Разгрузочная система сварщика", 0, /obj/item/storage/backpack/marine/engineerpack/welder_chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Сумка для гранат", 0, /obj/item/storage/backpack/marine/grenadepack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("ПОЯС (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Поясная разгрузка G8-A", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для боеприпасов", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для пистолета", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с креплением для ПП M39", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для револьвера", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для ракетницы M82F", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Патронташ на пояс для дробовика", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для инструментов", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_MANDATORY),
		list("Пояс для гранат M40", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс строителя", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("ПОДСУМКИ (ВЫБЕРИТЕ 2)", 0, null, null, null),
		list("Подсумок строителя", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Инжекторы)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Шины, бинты, мазь)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Таблетки)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок электрика", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для гранат", 0, /obj/item/storage/pouch/explosive, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для осветительных огней", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для пистолетных магазинов", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для магазинов", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для дробовика", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок общего назначения", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Кобура для пистолета", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для инструментов", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок с инженерным набором", 0, /obj/item/storage/pouch/engikit, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),


		list("РАЗГРУЗКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Чёрный разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Коричневый разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Наплечная кобура", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Жилет для инструментов", 0, /obj/item/clothing/accessory/storage/tool_webbing/small/equipped, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("МАСКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Противогаз", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Инфракрасная балаклава", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/engi
	name = "\improper Раздатчик экипировки техника «КолМорТех»"
	desc = "An automated rack hooked up to a colossal storage of combat technician standard-issue equipment."
	req_access = list(ACCESS_MARINE_ENGPREP)
	vendor_role = list(JOB_SQUAD_ENGI)

/obj/structure/machinery/cm_vending/clothing/engi/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_engi

/obj/structure/machinery/cm_vending/clothing/engi/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/engi

/obj/structure/machinery/cm_vending/clothing/engi/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/engi

/obj/structure/machinery/cm_vending/clothing/engi/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/engi

/obj/structure/machinery/cm_vending/clothing/engi/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_ENGPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/engi

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/engi
	spawned_gear_list = list(
		/obj/item/explosive/plastic,
		/obj/item/stack/sandbags_empty = 25,
		/obj/item/stack/sheet/metal/large_stack,
		/obj/item/stack/sheet/plasteel/med_large_stack,
		/obj/item/circuitboard/apc,
		/obj/item/cell/high,
		/obj/item/tool/shovel/etool/folded,
		/obj/item/device/lightreplacer,
		/obj/item/weapon/gun/smg/nailgun/compact/tactical,
		/obj/item/stack/repairable/gunkit = 10,
	)
