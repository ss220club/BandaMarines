// UPP Chief Engineer (CE) and Maintenance Technician (MT).

/obj/item/device/radio/headset/distress/UPP/command/ce
	minimap_path_blips_override = 'modular/distress/icons/minimap/upp_ce_blip.dmi'

/obj/item/device/radio/headset/distress/UPP/cct/mt
	minimap_path_blips_override = 'modular/distress/icons/minimap/upp_mt_blip.dmi'

/obj/item/clothing/accessory/storage/tool_webbing/equipped/upp
	name = "\improper инженерная разгрузка СПН"
	desc = "Тактическая разгрузка СПН для переноски инструментов, используемая инженерным составом Союза Прогрессивных Народов."
	icon = 'modular/distress/icons/vest/icons/upp_tool_vest.dmi'
	icon_state = "upp_tool_vest"
	inv_overlay_icon = 'modular/distress/icons/vest/inv/upp_tool_vest_inv.dmi'
	accessory_icons = list(
		WEAR_BODY = 'modular/distress/icons/vest/onmob/upp_tool_vest_onmob.dmi',
		WEAR_JACKET = 'modular/distress/icons/vest/onmob/upp_tool_vest_onmob.dmi',
	)

/obj/item/clothing/under/marine/veteran/UPP/officer/chief_engineer
	name = "\improper форма старшего инженера СПН"
	desc = "Комплект формы старшего инженера СПН, серийно производимой для вооружённых сил Союза Прогрессивных Народов. Редкость, особенно в зонах ICC."
	icon = 'modular/distress/icons/uniforms/icons/upp_ce_uniform.dmi'
	icon_state = "upp_uniform_ce"
	worn_state = "upp_uniform_ce"
	item_icons = list(
		WEAR_BODY = 'modular/distress/icons/uniforms/onmob/upp_ce_uniform_onmob.dmi',
	)

/obj/item/clothing/under/marine/veteran/UPP/maint_tech
	name = "\improper форма техника-механика СПН"
	desc = "Комплект формы техника-механика СПН, серийно производимой для вооружённых сил Союза Прогрессивных Народов."
	icon = 'modular/distress/icons/uniforms/icons/upp_mt_uniform.dmi'
	icon_state = "upp_uniform_mt"
	worn_state = "upp_uniform_mt"
	flags_jumpsuit = UNIFORM_SLEEVE_ROLLABLE
	item_icons = list(
		WEAR_BODY = 'modular/distress/icons/uniforms/onmob/upp_mt_uniform_onmob.dmi',
	)

/datum/job/antag/upp/chief_engineer
	title = JOB_UPP_CE
	selection_class = "job_ce"
	gear_preset = /datum/equipment_preset/upp/chief_engineer

/datum/job/antag/upp/maint_tech
	title = JOB_UPP_MT
	selection_class = "job_ot"
	total_positions = 3
	spawn_positions = 3
	gear_preset = /datum/equipment_preset/upp/maint_tech

//  Chief Engineer  //

/datum/equipment_preset/upp/chief_engineer
	name = "UPP Chief Engineer (Cryo)"
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/CE
	assignment = JOB_UPP_CE
	job_title = JOB_UPP_CE
	role_comm_title = "CE"
	minimap_icon = "upp_ce"
	minimap_background = "background_upp"
	paygrades = list(PAY_SHORT_UO2 = JOB_PLAYTIME_TIER_0) // no progression
	access = list(
		ACCESS_UPP_GENERAL,
		ACCESS_UPP_ENGINEERING,
		ACCESS_UPP_LEADERSHIP,
	)

/datum/equipment_preset/upp/chief_engineer/load_gear(mob/living/carbon/human/new_human)
	. = ..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP/command/ce, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/knife, WEAR_FEET)

/datum/equipment_preset/upp/chief_engineer/dressed
	name = "UPP Chief Engineer"

/datum/equipment_preset/upp/chief_engineer/dressed/load_gear(mob/living/carbon/human/new_human)
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP/command/ce, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/beret, WEAR_HEAD)
	var/obj/item/clothing/under/marine/veteran/UPP/officer/chief_engineer/UPP = new()
	var/obj/item/clothing/accessory/storage/tool_webbing/equipped/upp/W = new()
	UPP.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(UPP, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp/naval, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/marine/faction/UPP/officer, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/upp, WEAR_IN_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/upp, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector/upp, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full/upp, WEAR_WAIST)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction, WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

/datum/equipment_preset/upp/chief_engineer/get_antag_clothing_equipment()
	return list(
		list("СТАНДАРТНОЕ СНАРЯЖЕНИЕ (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Стандартная форма", 0, list(/obj/item/clothing/under/marine/veteran/UPP/officer/chief_engineer, /obj/item/clothing/shoes/marine/upp/knife, /obj/item/clothing/gloves/yellow, /obj/item/device/radio/headset/distress/UPP/command/ce), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),
		list("Индивидуальный рацион", 0, /obj/item/storage/box/mre/upp, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("ГОЛОВНОЙ УБОР (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Офицерская фуражка", 0, /obj/item/clothing/head/uppcap/peaked, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Берет", 0, /obj/item/clothing/head/uppcap/beret, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Бронированная кепка", 0, /obj/item/clothing/head/uppcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Шлем UM4", 0, /obj/item/clothing/head/helmet/marine/veteran/UPP, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("ВЕРХНЯЯ ОДЕЖДА (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Офицерская шинель", 0, /obj/item/clothing/suit/storage/marine/faction/UPP/officer, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Инженерная разгрузка", 0, /obj/item/clothing/accessory/storage/tool_webbing/equipped/upp, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Чёрная разгрузка", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("БРОНЯ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Бронежилет UM5", 0, /obj/item/clothing/suit/storage/marine/faction/UPP, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Бронежилет UL6", 0, /obj/item/clothing/suit/storage/marine/faction/UPP/support, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("ОЧКИ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Сварочные очки", 0, /obj/item/clothing/glasses/welding, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("ПОЯС (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Набор с инструментами (полный)", 0, /obj/item/storage/belt/utility/full/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Кобура с пистолетом NP92", 0, /obj/item/storage/belt/gun/type47/np92, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Кобура с пистолетом Type 47", 0, /obj/item/storage/belt/gun/type47, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБРАТЬ 2)", 0, null, null, null),
		list("Подсумок с электроникой (полный)", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Строительный подсумок", 0, /obj/item/storage/pouch/construction, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок первой помощи", 0, /obj/item/storage/pouch/firstaid/ert/upp, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	)

/datum/equipment_preset/upp/chief_engineer/get_antag_gear_equipment()
	return list(
		list("ИНЖЕНЕРНЫЕ ПРИНАДЛЕЖНОСТИ", 0, null, null, null),
		list("Бинокль", 0, /obj/item/device/binoculars/upp, null, VENDOR_ITEM_REGULAR),
		list("Датчик движения", 0, /obj/item/device/motiondetector/upp, null, VENDOR_ITEM_REGULAR),
	)

//  Maintenance Tech //

/datum/equipment_preset/upp/maint_tech
	name = "UPP Mechanical Technician (Cryo)"
	flags = EQUIPMENT_PRESET_EXTRA

	skills = /datum/skills/MT
	assignment = JOB_UPP_MT
	job_title = JOB_UPP_MT
	role_comm_title = "MT"
	minimap_icon = "upp_mt"
	minimap_background = "background_upp"
	paygrades = list(PAY_SHORT_UE3 = JOB_PLAYTIME_TIER_0, PAY_SHORT_UE4 = JOB_PLAYTIME_TIER_3)
	access = list(
		ACCESS_UPP_GENERAL,
		ACCESS_UPP_ENGINEERING,
	)

/datum/equipment_preset/upp/maint_tech/load_gear(mob/living/carbon/human/new_human)
	. = ..()
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP/cct/mt, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/knife, WEAR_FEET)

/datum/equipment_preset/upp/maint_tech/dressed
	name = "UPP Mechanical Technician"

/datum/equipment_preset/upp/maint_tech/dressed/load_gear(mob/living/carbon/human/new_human)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/UPP/cct/mt, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/welding, WEAR_EYES)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/uppcap/ushanka, WEAR_HEAD)
	//body
	var/obj/item/clothing/under/marine/veteran/UPP/maint_tech/UPP = new()
	var/obj/item/clothing/accessory/storage/tool_webbing/equipped/upp/W = new()
	UPP.attach_accessory(new_human, W)
	new_human.equip_to_slot_or_del(UPP, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/patch/upp, WEAR_ACCESSORY)
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/marine/engineerpack/upp, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/mre/upp, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/extinguisher/mini, WEAR_IN_BACK)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full/upp, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/upp/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/construction/full, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/electronics/full, WEAR_R_STORE)

	if(SSmapping.configs[GROUND_MAP].environment_traits[MAP_COLD])
		new_human.equip_to_slot_or_del(new /obj/item/clothing/mask/rebreather/scarf, WEAR_FACE)

/datum/equipment_preset/upp/maint_tech/get_antag_clothing_equipment()
	return list(
		list("СТАНДАРТНОЕ СНАРЯЖЕНИЕ (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Стандартная форма", 0, list(/obj/item/clothing/under/marine/veteran/UPP/maint_tech, /obj/item/clothing/shoes/marine/upp/knife, /obj/item/clothing/gloves/yellow, /obj/item/device/radio/headset/distress/UPP/cct/mt), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),
		list("Индивидуальный рацион", 0, /obj/item/storage/box/mre/upp, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("ГОЛОВНОЙ УБОР (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Бронированная кепка", 0, /obj/item/clothing/head/uppcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Ушанка", 0, /obj/item/clothing/head/uppcap/ushanka, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("ПОЯС (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Набор с инструментами (полный)", 0, /obj/item/storage/belt/utility/full/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Строительный набор", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("ПОДСУМКИ (ВЫБРАТЬ 2)", 0, null, null, null),
		list("Строительный подсумок (полный)", 0, /obj/item/storage/pouch/construction/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок с электроникой (полный)", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок первой помощи", 0, /obj/item/storage/pouch/firstaid/ert/upp, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	)

/datum/equipment_preset/upp/maint_tech/get_antag_gear_equipment()
	return list(
		list("ИНЖЕНЕРНЫЕ ПРИНАДЛЕЖНОСТИ", 0, null, null, null),
		list("Сварочные очки", 0, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("Датчик движения", 0, /obj/item/device/motiondetector/upp, null, VENDOR_ITEM_REGULAR),
		list("Огнетушитель (мини)", 0, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
	)


/obj/effect/essentials_set/upp_chief_engineer
	spawned_gear_list = list(
		/obj/item/device/binoculars/upp,
		/obj/item/map/current_map,
		/obj/item/device/motiondetector/upp,
		/obj/item/tool/extinguisher/mini,
	)

GLOBAL_LIST_INIT(cm_vending_clothing_upp_chief_engineer, list(
		list("СТАНДАРТНОЕ СНАРЯЖЕНИЕ (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Гарнитура", 0, /obj/item/device/radio/headset/distress/UPP/command/ce, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("Индивидуальный рацион", 0, /obj/item/storage/box/mre/upp, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("НАБОР СТАРШЕГО ИНЖЕНЕРА (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Набор старшего инженера", 0, /obj/effect/essentials_set/upp_chief_engineer, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("СУМКИ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Топливный инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp/distress, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Защищённая сумка", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Боевые перчатки", 0, /obj/item/clothing/gloves/marine/veteran/upp, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Боевые ботинки", 0, /obj/item/clothing/shoes/marine/upp/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("ГОЛОВНОЙ УБОР (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Офицерская фуражка", 0, /obj/item/clothing/head/uppcap/peaked, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_RECOMMENDED),
		list("Вязаная шапка", 0, /obj/item/clothing/head/cmcap/upp, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Берет", 0, /obj/item/clothing/head/uppcap/beret, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Бронированная кепка", 0, /obj/item/clothing/head/uppcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Шлем UM4", 0, /obj/item/clothing/head/helmet/marine/veteran/UPP, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("ВЕРХНЯЯ ОДЕЖДА (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Офицерская шинель", 0, /obj/item/clothing/suit/storage/marine/faction/UPP/officer, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_RECOMMENDED),
		list("Инженерная разгрузка", 0, /obj/item/clothing/accessory/storage/tool_webbing/equipped/upp, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Чёрная разгрузка", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Разгрузка", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("БРОНЯ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Бронежилет UM5", 0, /obj/item/clothing/suit/storage/marine/faction/UPP, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),
		list("Бронежилет UL6", 0, /obj/item/clothing/suit/storage/marine/faction/UPP/support, MARINE_CAN_BUY_ARMOR, VENDOR_ITEM_REGULAR),

		list("ОЧКИ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Сварочные очки", 0, /obj/item/clothing/glasses/welding, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),
		list("Медицинские очки-дисплей", 0, /obj/item/clothing/glasses/hud/health, MARINE_CAN_BUY_GLASSES, VENDOR_ITEM_REGULAR),

		list("ПОЯСА (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Набор с инструментами (полный)", 0, /obj/item/storage/belt/utility/full/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Строительный набор M277", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Кобура с пистолетом NP92", 0, /obj/item/storage/belt/gun/type47/np92, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Кобура с пистолетом Type 47", 0, /obj/item/storage/belt/gun/type47, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("КОСТЮМ РХБЗ (ДОПОЛНИТЕЛЬНО)", 0, null, null, null),
		list("Комплект РХБЗ", 0, /obj/item/clothing/under/marine/veteran/UPP/cbrn, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("Перчатки РХБЗ", 0, /obj/item/clothing/gloves/marine/veteran/upp/cbrn, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБРАТЬ 2)", 0, null, null, null),
		list("Подсумок с электроникой (полный)", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Строительный подсумок (полный)", 0, /obj/item/storage/pouch/construction/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок первой помощи", 0, /obj/item/storage/pouch/firstaid/ert/upp, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/upp_chief_engineer
	name = "\improper стойка снаряжения старшего инженера UnionAraratCorp"
	desc = "Автоматизированный вендор снаряжения для старшего инженера. Содержит набор инженерного снаряжения и инструментов."
	icon = 'modular/distress/icons/misc/upp_ce_vendor.dmi'
	icon_state = "upp_ce_vendor"
	req_access = list(ACCESS_UPP_ENGINEERING, ACCESS_UPP_LEADERSHIP)
	vendor_role = list(JOB_UPP_CE)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/clothing/upp_chief_engineer/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_upp_chief_engineer


/obj/effect/essentials_set/upp_maint_tech
	spawned_gear_list = list(
		/obj/item/clothing/glasses/welding,
		/obj/item/device/motiondetector/upp,
		/obj/item/tool/extinguisher/mini,
	)

GLOBAL_LIST_INIT(cm_vending_clothing_upp_maint_tech, list(
		list("СТАНДАРТНОЕ СНАРЯЖЕНИЕ (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Гарнитура", 0, /obj/item/device/radio/headset/distress/UPP/cct/mt, MARINE_CAN_BUY_EAR, VENDOR_ITEM_MANDATORY),
		list("Индивидуальный рацион", 0, /obj/item/storage/box/mre/upp, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),

		list("НАБОР ТЕХНИКА-МЕХАНИКА (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Набор техника-механика", 0, /obj/effect/essentials_set/upp_maint_tech, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

		list("СУМКИ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),
		list("Топливный инженерный рюкзак", 0, /obj/item/storage/backpack/marine/engineerpack/upp/distress, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Привязной сварочный ранец", 0, /obj/item/upp_weldpack, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),
		list("Защищённая сумка", 0, /obj/item/storage/backpack/satchel/lockable, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_MANDATORY),

		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ЗАБРАТЬ ВСЁ)", 0, null, null, null),
		list("Рабочие перчатки", 0, /obj/item/clothing/gloves/yellow, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_MANDATORY),
		list("Боевые ботинки", 0, /obj/item/clothing/shoes/marine/upp/knife, MARINE_CAN_BUY_SHOES, VENDOR_ITEM_MANDATORY),

		list("АКСЕССУАРЫ (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Инженерная разгрузка", 0, /obj/item/clothing/accessory/storage/tool_webbing/equipped/upp, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Чёрная разгрузка", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Разгрузка", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("ГОЛОВНОЙ УБОР (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Вязаная шапка", 0, /obj/item/clothing/head/cmcap/upp, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Бронированная кепка", 0, /obj/item/clothing/head/uppcap, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),
		list("Ушанка", 0, /obj/item/clothing/head/uppcap/ushanka, MARINE_CAN_BUY_HELMET, VENDOR_ITEM_REGULAR),

		list("ПОЯСА (ВЫБРАТЬ 1)", 0, null, null, null),
		list("Набор с инструментами (полный)", 0, /obj/item/storage/belt/utility/full/upp, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Строительный набор", 0, /obj/item/storage/belt/utility/construction, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),

		list("КОСТЮМ РХБЗ (ДОПОЛНИТЕЛЬНО)", 0, null, null, null),
		list("Комплект РХБЗ", 0, /obj/item/clothing/under/marine/veteran/UPP/cbrn, MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_REGULAR),
		list("Перчатки РХБЗ", 0, /obj/item/clothing/gloves/marine/veteran/upp/cbrn, MARINE_CAN_BUY_GLOVES, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБРАТЬ 2)", 0, null, null, null),
		list("Строительный подсумок (полный)", 0, /obj/item/storage/pouch/construction/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок с электроникой (полный)", 0, /obj/item/storage/pouch/electronics/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок первой помощи", 0, /obj/item/storage/pouch/firstaid/ert/upp, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
	))

/obj/structure/machinery/cm_vending/clothing/upp_maint_tech
	name = "\improper стойка снаряжения техника-механика UnionAraratCorp"
	desc = "Автоматизированный вендор снаряжения для техников-механиков. Содержит набор инженерного снаряжения и инструментов."
	icon = 'modular/distress/icons/misc/upp_mt_vendor.dmi'
	icon_state = "upp_mt_vendor"
	req_access = list(ACCESS_UPP_ENGINEERING)
	vendor_role = list(JOB_UPP_MT)
	vendor_theme = VENDOR_THEME_UPP

/obj/structure/machinery/cm_vending/clothing/upp_maint_tech/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_upp_maint_tech

/obj/effect/landmark/start/upp/chief_engineer
	name = "UPP Старший инженер"
	job = JOB_UPP_CE

/obj/effect/landmark/start/upp/maint_tech
	name = "UPP Техник-механик"
	job = JOB_UPP_MT

/obj/effect/landmark/late_join/upp/chief_engineer
	name = "UPP Старший инженер (позднее подключение)"
	job = JOB_UPP_CE

/obj/effect/landmark/late_join/upp/maint_tech
	name = "UPP Техник-механик (позднее подключение)"
	job = JOB_UPP_MT
