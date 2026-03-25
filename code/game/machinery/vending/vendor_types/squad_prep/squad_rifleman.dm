//------------SQUAD RIFLEMAN UNIFORM AND GEAR VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_marine, list(
		list("СТАНДАРТНОЕ ДЕРЬМО, ВОЗЬМИ ВСЕ", 0, null, null, null),
		list("ОДЕЖДА ДЖОНА МАРИНА", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine, /obj/item/clothing/head/helmet/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("ОБЕД ДЖОНА МАРИНА", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("ХУЙНЯ", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("БРОНЯ ДЛЯ КРУТЫХ", 0, null, null, null),
		list("Руни", 0, list(/obj/item/clothing/suit/storage/marine/xenos/runner, /obj/item/clothing/head/helmet/marine/xenos/runner), MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Дрончик", 0, list(/obj/item/clothing/suit/storage/marine/xenos, /obj/item/clothing/head/helmet/marine/xenos), MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Дефундер", 0, list(/obj/item/clothing/suit/storage/marine/xenos/defender, /obj/item/clothing/head/helmet/marine/xenos/defender), MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("ХРАНИЛИЩЕ ВСЕЙ ХУЙНИ", 0, null, null, null),
		list("РЮКЗАК ШКОЛЬНИКА", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Бизнесменская сумка", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Псих с дробовиком", 0, /obj/item/storage/large_holster/m37, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),

		list("ОТЦОВСКИЙ РЕМЕНЬ", 0, null, null, null),
		list("стрелять люблю пиздец", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("пиздалет хочу пиздец", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("КРУТЫЕ НОЖИКИ", 0, /obj/item/storage/belt/knifepouch, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("м10 хочу пиздец", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("м39 геймер", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("револьвер оцелот", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("светить люблю пиздец", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("думгай", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Вассерман", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("гранаты люблю пиздец", 0, /obj/item/storage/belt/grenade, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("СУМОЧКА АБИБАС", 0, null, null, null),
		list("ножики люблю пиздец", 0, /obj/item/storage/pouch/bayonet, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("наркоман со шприцами", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("помазаца хочу", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("колесики попить хочу", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("светопалки", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("БУМАГА а4", 0, /obj/item/storage/pouch/document/small, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("магазины хочу больше", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("думгай но поменьше", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Вассерман младший", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("пистолет люблю, но не так сильно", 0, /obj/item/storage/pouch/magazine/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("пиздалет в кармане", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("МАСКА ДЛЯ ВОЕННЫХ ПРЕСТУПЛЕНИЙ", 0, null, null, null),
		list("газик, без мазика", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("балаклава срать на корабле неизвестность", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("для строителей и красовальшиков", 0, /obj/item/clothing/mask/rebreather, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("ИНЖЕНЕРОМ ХОЧУ БЫТЬ ПИЗДЕЦ", 0, null, null, null),
		list("Е-бать", 5, /obj/item/tool/shovel/etool/folded, null, VENDOR_ITEM_REGULAR),
		list("мешки с говном (пустые)", 20, /obj/item/stack/sandbags_empty/half, null, VENDOR_ITEM_REGULAR),
		list("фуелтанк в кармане", 5, /obj/item/tool/weldpack/minitank, null, VENDOR_ITEM_REGULAR),
		list("варка для самых маленьких", 5, /obj/item/tool/weldingtool/simple, null, VENDOR_ITEM_REGULAR),

		list("ДОРОГИЕ ПУШКИ", 0, null, null, null),
		list("пиздалет вп87", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("сучка 6 умный пиздалет", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),
		list("гранатомет для крутых (без летала)", 30, /obj/item/storage/box/guncase/m85a1, null, VENDOR_ITEM_REGULAR),

		list("БАБАХИ", 0, null, null, null),
		list("граната бабаха 3 штука", 20, /obj/item/storage/box/packet/high_explosive, null, VENDOR_ITEM_REGULAR),
		list("граната огонь 3 штука", 20, /obj/item/storage/box/packet/incendiary, null, VENDOR_ITEM_REGULAR),
		list("граната военных преступлений 3 штука", 20, /obj/item/storage/box/packet/phosphorus, null, VENDOR_ITEM_REGULAR),
		list("смок на мид 3 штука", 10, /obj/item/storage/box/packet/smoke, null, VENDOR_ITEM_REGULAR),
		list("граната воздух взрывать 3 штука", 15, /obj/item/storage/box/packet/airburst_he, null, VENDOR_ITEM_REGULAR),
		list("граната воздух взрывать огонь 3 штука", 15, /obj/item/storage/box/packet/airburst_incen, null, VENDOR_ITEM_REGULAR),
		list("граната дымок воздух 3 штука", 10, /obj/item/storage/box/packet/airburst_smoke, null, VENDOR_ITEM_REGULAR),
		list("ХОРНЕТЫ КОНЧАТСЯ, ЗАРЯЖУ ДРУГИЕ (3 щтука)", 15, /obj/item/storage/box/packet/hornet, null, VENDOR_ITEM_REGULAR),
		list("коробка веселья 5 штука внутри", 20, /obj/item/storage/box/explosive_mines, null, VENDOR_ITEM_REGULAR),

		list("ГЛАВНЫЙ КАЛИБР", 0, null, null, null),
		list("м4разь пиздабольные 10 умножить на 24 милиметра", 10, /obj/item/ammo_magazine/rifle/m4ra/ap, null, VENDOR_ITEM_REGULAR),
		list("м4разь увеличенная 10 умножить на 24 милиметра", 10, /obj/item/ammo_magazine/rifle/m4ra/extended, null, VENDOR_ITEM_REGULAR),
		list("м39 пиздабольные 10 умножить на 20 милиметра", 10, /obj/item/ammo_magazine/smg/m39/ap , null, VENDOR_ITEM_REGULAR),
		list("м39 увеличенная 10 умножить на 20 милиметра", 10, /obj/item/ammo_magazine/smg/m39/extended , null, VENDOR_ITEM_REGULAR),
		list("м41а пиздабольные 10 умножить на 24 милиметра", 10, /obj/item/ammo_magazine/rifle/ap , null, VENDOR_ITEM_REGULAR),
		list("м41а увеличенная 10 умножить на 24 милиметра", 10, /obj/item/ammo_magazine/rifle/extended , null, VENDOR_ITEM_REGULAR),

		list("ПОРОХ ДЛЯ ПИЗДАЛЕТОВ", 0, null, null, null),
		list("м10 увеличенные 10 на 20 милиметра БТР", 10, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("тяжелый спид точка 44", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("снайперский спид точка 44", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("м4а3 ебать всех", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("м4а3 пиздабольные", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("вп87", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("сучка 6 умная точка 45", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("КРУТЫЕ ШМОТКИ НА ПРЕСС", 0, null, null, null),
		list("Варриор-гандон", 30, list(/obj/item/clothing/suit/storage/marine/xenos/warrior, /obj/item/clothing/head/helmet/marine/xenos/warrior), null, VENDOR_ITEM_REGULAR),
		list("Люркер-гандон2", 20, list(/obj/item/clothing/suit/storage/marine/xenos/lurker, /obj/item/clothing/head/helmet/marine/xenos/lurker), null, VENDOR_ITEM_REGULAR),
		list("Бэ18 тяжелый хуй", 35, list(/obj/item/clothing/suit/storage/marine/specialist, /obj/item/clothing/head/helmet/marine/specialist), null, VENDOR_ITEM_REGULAR),

		list("НАДЕТЬ НА ОДЕЖДУ", 0, null, null, null),
		list("разгрузка", 10, /obj/item/clothing/accessory/storage/webbing, null, VENDOR_ITEM_REGULAR),
		list("черная разгрузка", 10, /obj/item/clothing/accessory/storage/webbing/black, null, VENDOR_ITEM_REGULAR),
		list("коричневая разгрузка", 15, /obj/item/clothing/accessory/storage/black_vest/brown_vest, null, VENDOR_ITEM_REGULAR),
		list("нога сумка", 15, /obj/item/clothing/accessory/storage/black_vest/leg_pouch, null, VENDOR_ITEM_REGULAR),
		list("нога сумка черный", 15, /obj/item/clothing/accessory/storage/black_vest/black_leg_pouch, null, VENDOR_ITEM_REGULAR),
		list("черная разгрузка", 15, /obj/item/clothing/accessory/storage/black_vest, null, VENDOR_ITEM_REGULAR),
		list("упасть сумка", 10, /obj/item/clothing/accessory/storage/droppouch, null, VENDOR_ITEM_REGULAR),
		list("черный упасть сумка", 10, /obj/item/clothing/accessory/storage/droppouch/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("плечи кобура", 15, /obj/item/clothing/accessory/storage/holster, null, VENDOR_ITEM_REGULAR),
		list("мачете в модной сумочке", 15, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("мачете сумка", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Детка, возьми телефон, я знаю ты хочешь позвонить...", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("топливо в жопе", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("очки-окуляры для крутых", 5, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("ремень сумка", 15, /obj/item/storage/pouch/sling, null, VENDOR_ITEM_REGULAR),
		list("большой сумка Вассермана", 15, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),

		list("УТИЛИТЫ DREAMSEEKER", 0, null, null, null),
		list("катать друзей", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("улетать друзей", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("тушить друзей", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("видеть недрузей", 15, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("детектор умных мыслей", 15, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("свистулька", 5, /obj/item/clothing/accessory/device/whistle, null, VENDOR_ITEM_REGULAR),

		list("ОКУЛЯРЫ", 0, null, null, null),
		list("окуляры для смотра вдаль", 5, /obj/item/device/binoculars, null, VENDOR_ITEM_REGULAR),
		list("ОБ НА КООРДИНАТЫ", 10, /obj/item/device/binoculars/range, null, VENDOR_ITEM_REGULAR),
		list("крутой бинокль с лазерным прицелом", 15, /obj/item/device/binoculars/range/designator, null, VENDOR_ITEM_REGULAR),

		list("НАГЛАЗНИКИ", 0, null, null, null),
		list("медик!!!", 15, /obj/item/device/helmet_visor/medical, null, VENDOR_ITEM_REGULAR),
		list("инженер", 5, /obj/item/device/helmet_visor/welding_visor, null, VENDOR_ITEM_REGULAR),

		list("ЧИТАТЬ ЛЮБЛЮ ПИЗДЕЦ", 0, null, null, null),
		list("джитак читать", 15, /obj/item/pamphlet/upgradeable/jtac, null, VENDOR_ITEM_REGULAR),
		list("инженер читать", 15, /obj/item/pamphlet/upgradeable/engineer, null, VENDOR_ITEM_REGULAR),

		list("РАДИОХЕД", 0, null, null, null),
		list("слушать инжей", 5, /obj/item/device/encryptionkey/engi, null, VENDOR_ITEM_REGULAR),
		list("слушать умных (дебилы)", 5, /obj/item/device/encryptionkey/intel, null, VENDOR_ITEM_REGULAR),
		list("слушать джитак", 5, /obj/item/device/encryptionkey/jtac, null, VENDOR_ITEM_REGULAR),
		list("слушать карго", 5, /obj/item/device/encryptionkey/req, null, VENDOR_ITEM_REGULAR),
		list("слушать мед", 5, /obj/item/device/encryptionkey/med, null, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/marine
	name = "\improper ColMarTech Automated Marine Equipment Rack"
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
