//------------GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_gear_intelligence_officer, list(
		list("INTELLIGENCE SET (MANDATORY)", 0, null, null, null),
		list("Essential Intelligence Set", 0, /obj/effect/essentials_set/intelligence_officer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("ИНЖЕНЕРНОЕ ОБОРУДОВАНИЕ", 0, null, null, null),
		list("Power Control Module", 5, /obj/item/circuitboard/apc, null, VENDOR_ITEM_REGULAR),
		list("Пластичная взрывчатка С-4", 10, /obj/item/explosive/plastic, null, VENDOR_ITEM_REGULAR),
		list("Очки сварщика", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ОСНОВНОГО ОРУЖИЯ", 0, null, null, null),
		list("Магазин для M4RA (10x24мм AP)", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M4RA (10x24мм)", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("Магазин для M39 (10x20мм AP)", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M39 (10x20мм)", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("Магазин для M41A (10x24мм AP)", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("Расширенный магазин для M41A (10x24мм)", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ДОПОЛНИТЕЛЬНОГО ОРУЖИЯ", 0, null, null, null),
		list("Клип-обойма для M44 (.44 FMJ)", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 SSA)", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("Магазин для VP78 (9мм)", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("Магазин для SU-6 (.45)", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("ВООРУЖЕНИЕ С ОГРАНИЧЕННЫМ ДОСТУПОМ", 0, null, null, null),
		list("Пистолет VP78", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("RESTRICTED GEAR", 0, null, null, null),
		list("M276 Pattern Combat Toolbelt Rig", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_RECOMMENDED),

		list("POUCHES", 0, null, null, null),
		list("Большой подсумок для магазинов", 10, /obj/item/storage/pouch/magazine/large, null, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для дробовика", 10, /obj/item/storage/pouch/shotgun/large, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для инжекторов", 15, /obj/item/storage/pouch/autoinjector/full, null, VENDOR_ITEM_RECOMMENDED),
		list("Ножны для мачете", 10, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", 0, null, null, null),
		list("Переносной огнетушитель", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Система воздушной эвакуации Фултон", 10, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("Детектор движения", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_RECOMMENDED),
		list("Сканер данных", 5, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),

		list("БИНОКУЛЯРЫ", 0, null, null, null),
		list("Бинокль", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("Дальномер", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("Лазерный целеуказатель", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("ГОЛОВНЫЕ ЭКРАНЫ", 0, null, null, null),
		list("Medical Helmet Optic", 5, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("Welding Visor", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),
		list("Night Vision Optic", 25, /obj/item/device/helmet_visor/night_vision, null, VENDOR_ITEM_RECOMMENDED),

		list("КЛЮЧИ ШИФРОВАНИЯ", 0, null, null, null),
		list("Ключ шифрования для гарнитуры — разведка", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),

		list("SPARE INTEL KIT", 0, null, null, null),
		list("Field Intelligence Support Kit (For untrained personnel)", 20, /obj/item/storage/box/kit/mini_intel, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/gear/intelligence_officer
	name = "ColMarTech Intelligence Officer Gear Rack"
	desc = "An automated gear rack for IOs."
	icon_state = "intel_gear"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)

/obj/structure/machinery/cm_vending/gear/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_gear_intelligence_officer

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_intelligence_officer, list(
		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ВОЗЬМИТЕ ВСЁ)", 0, null, null, null),
		list("Жёлтые резиновые перчатки", 0, /obj/item/clothing/gloves/marine/insulated, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Чёрные резиновые перчатки", 0, /obj/item/clothing/gloves/marine/insulated/black, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Headset", 0, /obj/item/device/radio/headset/almayer/intel, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("Сухой паек MRE", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("БРОНЯ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("XM4 Pattern Intel Armor", 0, /obj/item/clothing/suit/storage/marine/medium/rto/intel, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("M3-L Pattern Light Armor", 0, /obj/item/clothing/suit/storage/marine/light, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),
		list("Service Jacket", 0, /obj/item/clothing/suit/storage/jacket/marine/service, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_MANDATORY),

		list("РЮКЗАКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Expedition Pack", 0, /obj/item/storage/backpack/marine/satchel/intel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Expedition Chestrig", 0, /obj/item/storage/backpack/marine/satchel/intel/chestrig, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Radio Telephone Pack", 0, /obj/item/storage/backpack/marine/satchel/rto/io, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("ШЛЕМЫ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("XM12 Officer Helmet", 0, /obj/item/clothing/head/helmet/marine/rto/intel, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Beret, Standard", 0, /obj/item/clothing/head/beret/cm, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Beret, Tan", 0, /obj/item/clothing/head/beret/cm/tan, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("USCM Officer Cap", 0, /obj/item/clothing/head/cmcap/bridge, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("ПОЯС (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Поясная разгрузка G8-A", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для боеприпасов", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс с кобурой для пистолета", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с креплением для ПП M39", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для револьвера", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Патронташ на пояс для дробовика", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс для инструментов", 0, /obj/item/storage/belt/utility/full, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("ПОДСУМКИ (ВЫБЕРИТЕ 2)", 0, null, null, null),
		list("Document Pouch", 0, /obj/item/storage/pouch/document, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Инжекторы)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Медицинский подсумок (Шины, бинты, мазь)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Медицинский подсумок (Таблетки)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для осветительных огней", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для резервуаров к огнемёту", 0, /obj/item/storage/pouch/flamertank, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок общего назначения", 0, /obj/item/storage/pouch/general/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Большой подсумок для пистолетных магазинов", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для магазинов", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для дробовика", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Sidearm Pouch", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для инструментов", 0, /obj/item/storage/pouch/tools/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Ременная сумка", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("РАЗГРУЗКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Чёрный разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Коричневый разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Наплечная кобура", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("МАСКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Противогаз", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Инфракрасная балаклава", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR)
	))

//MARINE_CAN_BUY_SHOES MARINE_CAN_BUY_UNIFORM currently not used
/obj/structure/machinery/cm_vending/clothing/intelligence_officer
	name = "ColMarTech Intelligence Officer Equipment Rack"
	desc = "An automated rack hooked up to a colossal storage of IO standard-issue equipment."
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)

/obj/structure/machinery/cm_vending/clothing/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_intelligence_officer

//------------GUNS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/intelligence_officer
	name = "\improper ColMarTech Intelligence Officer Weapons Rack"
	desc = "An automated weapon rack hooked up to a small storage of standard-issue weapons. Can be accessed only by the Intelligence Officers."
	icon_state = "guns"
	req_access = list(ACCESS_MARINE_COMMAND)
	vendor_role = list(JOB_INTEL)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND

/obj/structure/machinery/cm_vending/sorted/cargo_guns/intelligence_officer/get_listed_products(mob/user)
	return GLOB.cm_vending_guns_intelligence_officer

GLOBAL_LIST_INIT(cm_vending_guns_intelligence_officer, list(
		list("ОСНОВНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Штурмовой карабин M4RA", 4, /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("Пистолет-пулемёт M39", 4, /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("Помповый дробовик M37A2", 4, /obj/item/weapon/gun/shotgun/pump, VENDOR_ITEM_REGULAR),
		list("Импульсная винтовка M41A MK2", 4, /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ОСНОВНОГО ОРУЖИЯ", -1, null, null),
		list("Коробка для патронов (Картечь)", 12, /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR),
		list("Коробка для патронов (Флешетты)", 12, /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR),
		list("Коробка для патронов (Пуля)", 12, /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR),
		list("Магазин для M4RA (10x24мм)", 24, /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("Магазин для M39 HV (10x20мм)", 24, /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR),
		list("M41A Magazine (10x24mm)", 24, /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR),

		list("ДОПОЛНИТЕЛЬНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Боевой пистолет 88 Mod 4", 4, /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("Боевой револьвер M44", 4, /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("Служебный пистолет M4A3", 4, /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ДОПОЛНИТЕЛЬНОГО ОРУЖИЯ", -1, null, null),
		list("88M4 AP Magazine (9mm)", 20, /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для М44 (.44)", 20, /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR),
		list("Магазин для M4A3 (9мм)", 20, /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine (9mm)", 8, /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine (9mm)", 8, /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR),
		list("Магазин для VP78 (9мм)", 16, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", -1, null, null),
		list("Rail Flashlight", 8, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("Underbarrel Flashlight Grip", 4, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", -1, null, null),
		list("M11 Throwing Knife", 18, /obj/item/weapon/throwing_knife, VENDOR_ITEM_REGULAR),
		list("M5 Bayonet", 4, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", 2, /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare pack", 20, /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	))

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/intelligence_officer
	spawned_gear_list = list(
		/obj/item/tool/crowbar,
		/obj/item/stack/fulton,
		/obj/item/device/motiondetector/intel,
		/obj/item/device/binoculars,
	)
