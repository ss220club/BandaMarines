//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_leader, list(
		list("SQUAD LEADER KIT (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Essential SL Kit", 0, /obj/effect/essentials_set/leader, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("SQUAD KIT (CHOOSE 1, for yourself or your squad)", 0, null, null, null),
		list("M4RA Sniper Kit", 0, /obj/item/storage/box/kit/mini_sniper, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M41A Standard Kit", 0, /obj/item/storage/box/kit/m41a_kit	, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("M240 Pyrotechnician Support Kit", 0, /obj/item/storage/box/kit/mini_pyro, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Тяжёлый пулемёт M2C", 0, /obj/item/storage/box/guncase/m2c, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Тяжёлый пулемёт M56D", 0, /obj/item/storage/box/guncase/m56d, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Гранатомёт M79", 0, /obj/item/storage/box/guncase/m79, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Дробовик MOU-53", 0, /obj/item/storage/box/guncase/mou53, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Тяжёлая винтовка XM88", 0, /obj/item/storage/box/guncase/xm88, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),
		list("Basic Engineering Supplies", 0, /obj/item/storage/box/kit/engineering_supply_kit, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR),

		list("БРОНЯ", 0, null, null, null),
		list("Броня пехотинца M4", 16, /obj/item/clothing/suit/storage/marine/medium/rto, null, VENDOR_ITEM_REGULAR),

		list("ЭЛЕМЕНТЫ ОДЕЖДЫ", 0, null, null, null),
		list("Чехол для мачете", 4, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Ножны для мачете", 4, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Рюкзак связиста ККМП", 5, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("M276 Pattern Combat Toolbelt Rig", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", 0, null, null, null),
		list("Свисток", 3, /obj/item/device/whistle, null, VENDOR_ITEM_REGULAR),
		list("Переносной огнетушитель", 3, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Детектор движения", 5, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("Система воздушной эвакуации Фултон", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),

		list("БИНОКУЛЯРЫ", 0, null, null, null),
		list("Дальномер", 3, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("Лазерный целеуказатель", 5, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("ГОЛОВНЫЕ ЭКРАНЫ", 0, null, null, null),
		list("Welding Visor", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("Medical Helmet Optic", 4, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_RECOMMENDED),
		list("Night Vision Optic", 25, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),

		list("ИНЖЕНЕРНОЕ ОБОРУДОВАНИЕ", 0, null, null, null),
		list("Жёлтые резиновые перчатки", 3, /obj/item/clothing/gloves/yellow, null, VENDOR_ITEM_REGULAR),
		list("Чёрные резиновые перчатки", 3, /obj/item/clothing/gloves/marine/insulated/black, null, VENDOR_ITEM_REGULAR),
		list("Металл x 10", 5, /obj/item/stack/sheet/metal/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("Plasteel x10", 7, /obj/item/stack/sheet/plasteel/small_stack, null, VENDOR_ITEM_RECOMMENDED),
		list("Пластичная взрывчатка С-4", 5, /obj/item/explosive/plastic, null, VENDOR_ITEM_RECOMMENDED),
		list("Пробивной заряд", 7, /obj/item/explosive/plastic/breaching_charge, null, VENDOR_ITEM_RECOMMENDED),
		list("Мешки с песком", 10, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_RECOMMENDED),
		list("Signal Flare Pack", 7, /obj/item/storage/box/m94/signal, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для инструментов", 5, /obj/item/storage/pouch/tools/full, null, VENDOR_ITEM_REGULAR),
		list("Очки сварщика", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

		list("ВЗРЫВЧАТЫЕ ВЕЩЕСТВА", 0, null, null, null),
		list("Упаковка гранат M40 HEDP (Осколочная) x 3", 18, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HIDP (Зажигательная) x 3", 18, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 WPDP (Химическая смесь) x 3", 18, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("Упаковка гранат M40 HSDP (Дымовая) x 3", 9, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Осколочная) x 3", 20, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Зажигательная) x 3", 20, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM (Дымовая) x 3", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("Упаковка прыгающих гранат M74 AGM «Шершень» x 3", 20, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("Ящик мин M20 x 5", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),
		list("Граната M40 MFHS (Пена)", 5, /obj/item/explosive/grenade/metal_foam, null, VENDOR_ITEM_REGULAR),
		list("Упаковка электрошоковых гранат G2 x 3",  16, /obj/item/storage/box/packet/sebb, null, VENDOR_ITEM_REGULAR),

		list("MEDICAL SUPPLIES", 0, null, null, null),
		list("Burn Kit", 2, /obj/item/stack/medical/advanced/ointment, null, VENDOR_ITEM_REGULAR),
		list("Trauma Kit", 2, /obj/item/stack/medical/advanced/bruise_pack, null, VENDOR_ITEM_REGULAR),
		list("Advanced Firstaid Kit", 12, /obj/item/storage/firstaid/adv, null, VENDOR_ITEM_REGULAR),
		list("Medical Splints", 1, /obj/item/stack/medical/splint, null, VENDOR_ITEM_REGULAR),

		list("Injector (Bicaridine)", 1, /obj/item/reagent_container/hypospray/autoinjector/bicaridine, null, VENDOR_ITEM_REGULAR),
		list("Injector (Dexalin+)", 1, /obj/item/reagent_container/hypospray/autoinjector/dexalinp, null, VENDOR_ITEM_REGULAR),
		list("Injector (Inaprovaline)", 1, /obj/item/reagent_container/hypospray/autoinjector/inaprovaline, null, VENDOR_ITEM_REGULAR),
		list("Injector (Kelotane)", 1, /obj/item/reagent_container/hypospray/autoinjector/kelotane, null, VENDOR_ITEM_REGULAR),
		list("Injector (Oxycodone)", 2, /obj/item/reagent_container/hypospray/autoinjector/oxycodone, null, VENDOR_ITEM_REGULAR),
		list("Injector (Tramadol)", 1, /obj/item/reagent_container/hypospray/autoinjector/tramadol, null, VENDOR_ITEM_REGULAR),
		list("Injector (Tricord)", 1, /obj/item/reagent_container/hypospray/autoinjector/tricord, null, VENDOR_ITEM_REGULAR),

		list("Health Analyzer", 4, /obj/item/device/healthanalyzer, null, VENDOR_ITEM_REGULAR),
		list("Роликовые носилки", 2, /obj/item/roller, null, VENDOR_ITEM_REGULAR),

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

		list("SPECIAL AMMUNITION", 0, null, null, null),
		list("Резервуар топливной смеси для M240 (Лигроин)", 3, /obj/item/ammo_magazine/flamer_tank, null, VENDOR_ITEM_REGULAR),
		list("Резервуар топливной смеси для M240 (B-Gel)", 3, /obj/item/ammo_magazine/flamer_tank/gellied, null, VENDOR_ITEM_REGULAR),

		list("ВООРУЖЕНИЕ С ОГРАНИЧЕННЫМ ДОСТУПОМ", 0, null, null, null),
		list("Огнемёт M240", 18, /obj/item/storage/box/guncase/flamer, null, VENDOR_ITEM_REGULAR),
		list("Пистолет VP78", 8, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", 12, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("Гранатомёт M79", 18, /obj/item/storage/box/guncase/m79, null, VENDOR_ITEM_REGULAR),

		list("КЛЮЧИ ШИФРОВАНИЯ", 0, null, null, null),
		list("Ключ шифрования для гарнитуры — инженерный", 3, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — разведка", 3, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — JTAC", 3, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("Ключ шифрования для гарнитуры — обеспечение", 3, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/leader
	name = "\improper ColMarTech Squad Leader Gear Rack"
	desc = "An automated gear rack for Squad Leaders."
	icon_state = "sl_gear"
	show_points = TRUE
	vendor_role = list(JOB_SQUAD_LEADER)
	req_access = list(ACCESS_MARINE_LEADER)

/obj/structure/machinery/cm_vending/gear/leader/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_leader

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_leader, list(
		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ВОЗЬМИТЕ ВСЁ)", 0, null, null, null),
		list("Стандартная экипировка пехотинца", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine/leader), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Броня пехотинца B12", 0, /obj/item/clothing/suit/storage/marine/medium/leader, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("Сухой паек MRE", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Оружейная смазка", 0, /obj/item/stack/repairable/gunlube, MARINE_CAN_BUY_REPAIRABLE, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("РЮКЗАКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Рюкзак ККМП", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Чехол для мачете", 0, /obj/item/storage/large_holster/machete/full, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Ранец ККМП", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("ПОЯС (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Поясная разгрузка G8-A", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс для боеприпасов", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс с кобурой для пистолета", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Спасательная сумка санитара", 0, /obj/item/storage/belt/medical/lifesaver, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Поясная разгрузка санитара", 0, /obj/item/storage/belt/medical, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с креплением для ПП M39", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для пистолета M10", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для револьвера", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для ракетницы M82F", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Патронташ на пояс для дробовика", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для инструментов", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для гранат M40", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБЕРИТЕ 2)", 0, null, null, null),
		list("Подсумок для инжекторов", 0, /obj/item/storage/pouch/autoinjector/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Инжекторы)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Медицинский подсумок (Шины, бинты, мазь)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Медицинский подсумок (Таблетки)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок для осветительных огней", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для резервуаров к огнемёту", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок общего назначения", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Ременная сумка", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для магазинов", 0, /obj/item/storage/pouch/magazine/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для дробовика", 0, /obj/item/storage/pouch/shotgun/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для пистолетных магазинов", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Кобура для пистолета", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("РАЗГРУЗКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Чёрный разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Коричневый разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Наплечная кобура", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("МАСКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Противогаз", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Инфракрасная балаклава", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/leader
	name = "\improper Раздатчик экипировки командира отряда «КолМорТех»"
	desc = "An automated rack hooked up to a colossal storage of Squad Leader standard-issue equipment."
	req_access = list(ACCESS_MARINE_LEADER)
	vendor_role = list(JOB_SQUAD_LEADER)

/obj/structure/machinery/cm_vending/clothing/leader/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_leader

/obj/structure/machinery/cm_vending/clothing/leader/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha/lead

/obj/structure/machinery/cm_vending/clothing/leader/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo/lead

/obj/structure/machinery/cm_vending/clothing/leader/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie/lead

/obj/structure/machinery/cm_vending/clothing/leader/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_LEADER, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta/lead

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/leader
	spawned_gear_list = list(
		/obj/item/explosive/plastic,
		/obj/item/device/binoculars/range/designator,
		/obj/item/storage/box/m94/signal,
		/obj/item/tool/extinguisher/mini,
		/obj/item/storage/box/zipcuffs,
	)
