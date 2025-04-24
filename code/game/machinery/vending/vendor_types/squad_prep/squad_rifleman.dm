//------------SQUAD RIFLEMAN UNIFORM AND GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_marine, list(
		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ВОЗЬМИТЕ ВСЁ)", 0, null, null, null),
		list("Стандартная экипировка пехотинца", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Сухой паек MRE", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Оружейная смазка", 0, /obj/item/stack/repairable/gunlube, MARINE_CAN_BUY_REPAIRABLE, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("БРОНЯ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Лёгкая броня", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Средняя броня", 0, /obj/item/clothing/suit/storage/marine/medium, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Тяжёлая броня", 0, /obj/item/clothing/suit/storage/marine/heavy, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("РЮКЗАКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Рюкзак", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Ранец", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Чехол для дробовика", 0, /obj/item/storage/large_holster/m37, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("ПОЯС (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Пояс для боеприпасов", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс с кобурой для пистолета", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с ножнами", 0, /obj/item/storage/belt/knifepouch, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с креплением для ПП M39", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для револьвера", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для ракетницы M82F", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Патронташ на пояс для дробовика", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Поясная разгрузка G8-A", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для гранат M40", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБЕРИТЕ 2)", 0, null, null, null),
		list("Подсумок для ножей", 0, /obj/item/storage/pouch/bayonet, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Медицинский подсумок (Инжекторы)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Шины, бинты, мазь)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Таблетки)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок для осветительных огней", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок для документов", 0, /obj/item/storage/pouch/document/small, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для магазинов", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для дробовика", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок общего назначения", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для пистолетных магазинов", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Кобура для пистолета", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("МАСКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Противогаз", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Инфракрасная балаклава", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Респиратор", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("ИНЖЕНЕРНОЕ ОБОРУДОВАНИЕ", 0, null, null, null),
		list("Шанцевый инструмент", 5, /obj/item/tool/shovel/etool/folded, null, VENDOR_ITEM_REGULAR),
		list("Мешки с песком", 20, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_REGULAR),
		list("ES-11 Mobile Fuel Canister", 5, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),
		list("ME3 Hand Welder", 5, /obj/item/tool/weldingtool/simple, null, VENDOR_ITEM_REGULAR),

		list("ВООРУЖЕНИЕ С ОГРАНИЧЕННЫМ ДОСТУПОМ", 0, null, null, null),
		list("Пистолет VP78", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("Гранатомёт M79", 30, /obj/item/storage/box/guncase/m79, null, VENDOR_ITEM_REGULAR),

		list("ВЗРЫВЧАТЫЕ ВЕЩЕСТВА", 0, null, null, null),
		list("Упаковка гранат M40 HEDP (Осколочная) x 3", 20, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HIDP (Зажигательная) x 3", 20, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 WPDP (Химическая смесь) x 3", 20, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HSDP (Дымовая) x 3", 10, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Осколочная) x 3", 15, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Зажигательная) x 3", 15, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Дымовая) x 3", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM «Шершень» x 3", 15, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("Ящик мин M20 x 5", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ОСНОВНОГО ОРУЖИЯ", 0, null, null, null),
		list("Магазин для M4RA (10x24мм AP)", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M4RA (10x24мм)", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("Магазин для M39 (10x20мм AP)", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M39 (10x20мм)", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("Магазин для M41A (10x24мм AP)", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M41A (10x24мм)", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ДОПОЛНИТЕЛЬНОГО ОРУЖИЯ", 0, null, null, null),
		list("Расширенный магазин для M10 HV (10x20мм)", 10, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("Барабанный магазин для M10 HV (10x20мм)", 15, /obj/item/ammo_magazine/pistol/m10/drum , null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 FMJ)", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 SSA)", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("Магазин для VP78 (9мм)", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("Магазин для SU-6 (.45)", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("БРОНЯ", 0, null, null, null),
		list("Броня пехотинца M3 B12", 30, /obj/item/clothing/suit/storage/marine/medium/leader, null, VENDOR_ITEM_REGULAR),
		list("Броня пехотинца M4", 20, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("ЭЛЕМЕНТЫ ОДЕЖДЫ", 0, null, null, null),
		list("Нагрудный жилет", 10, /obj/item/clothing/accessory/storage/webbing, null, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", 10, /obj/item/clothing/accessory/storage/webbing/black, null, VENDOR_ITEM_REGULAR),
		list("Коричневый разгрузочный жилет", 15, /obj/item/clothing/accessory/storage/black_vest/brown_vest, null, VENDOR_ITEM_REGULAR),
		list("Чёрный разгрузочный жилет", 15, /obj/item/clothing/accessory/storage/black_vest, null, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", 10, /obj/item/clothing/accessory/storage/droppouch, null, VENDOR_ITEM_REGULAR),
		list("Наплечная кобура", 15, /obj/item/clothing/accessory/storage/holster, null, VENDOR_ITEM_REGULAR),
		list("Чехол для мачете", 15, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Ножны для мачете", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Рюкзак связиста ККМП", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для резервуаров к огнемёту", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("Очки сварщика", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("Ременная сумка", 15, /obj/item/storage/pouch/sling, null, VENDOR_ITEM_REGULAR),
		list("Большой подсумок общего назначения", 15, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", 0, null, null, null),
		list("Роликовые носилки", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("Система воздушной эвакуации Фултон", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("Переносной огнетушитель", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Детектор движения", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("Сканер данных", 15, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("Свисток", 5, /obj/item/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("Набор для ремонта оружия", 5, /obj/item/stack/repairable/gunkit, null, VENDOR_ITEM_REGULAR),

		list("БИНОКУЛЯРЫ", 0, null, null, null),
		list("Бинокль", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("Дальномер", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("Лазерный целеуказатель", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("ГОЛОВНЫЕ ЭКРАНЫ", 0, null, null, null),
		list("Medical Helmet Optic", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("Welding Visor", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("ИНСТРУКЦИИ", 0, null, null, null),
		list("Инструкция для JTAC", 15, /obj/item/pamphlet/skill/jtac, null, VENDOR_ITEM_REGULAR),
		list("Инструкция для инженера", 15, /obj/item/pamphlet/skill/engineer, null, VENDOR_ITEM_REGULAR),

		list("КЛЮЧИ ШИФРОВАНИЯ", 0, null, null, null),
		list("Ключ шифрования для гарнитуры — инженерный", 5, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — разведка", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — JTAC", 5, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — обеспечение", 5, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/marine
	name = "\improper Раздатчик экипировки «КолМорТех»"
	desc = "An automated rack hooked up to a colossal storage of Marine Rifleman standard-issue equipment."
	icon_state = "mar_rack"
	show_points = TRUE
	vendor_theme = VENDOR_THEME_USCM

	vendor_role = list(JOB_SQUAD_MARINE)

/obj/structure/machinery/cm_vending/clothing/marine/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_marine

/obj/structure/machinery/cm_vending/clothing/marine/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha

/obj/structure/machinery/cm_vending/clothing/marine/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo

/obj/structure/machinery/cm_vending/clothing/marine/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie

/obj/structure/machinery/cm_vending/clothing/marine/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta
