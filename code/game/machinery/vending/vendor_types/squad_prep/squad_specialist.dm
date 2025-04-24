//------------GEAR VENDOR---------------

GLOBAL_LIST_EMPTY(primary_specialists_picked)

GLOBAL_LIST_INIT(cm_vending_gear_spec, list(
		list("WEAPONS SPECIALIST SETS (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Demolitionist Set", 0, /obj/item/storage/box/spec/demolitionist, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Heavy Grenadier Set", 0, /obj/item/storage/box/spec/heavy_grenadier, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Pyro Set", 0, /obj/item/storage/box/spec/pyro, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Scout Set", 0, /obj/item/storage/box/spec/scout, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_REGULAR),
		list("Sniper Set", 0, /obj/item/storage/box/spec/sniper, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),
		list("Anti-Materiel Sniper Set", 0, /obj/item/storage/box/spec/sniper/anti_materiel, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),

		list("EXTRA SCOUT AMMUNITION", 0, null, null, null),
		list("A19 High Velocity Impact Magazine (10x24mm)", 40, /obj/item/ammo_magazine/rifle/m4ra/custom/impact, null, VENDOR_ITEM_REGULAR),
		list("A19 High Velocity Incendiary Magazine (10x24mm)", 40, /obj/item/ammo_magazine/rifle/m4ra/custom/incendiary, null, VENDOR_ITEM_REGULAR),
		list("A19 High Velocity Magazine (10x24mm)", 40, /obj/item/ammo_magazine/rifle/m4ra/custom, null, VENDOR_ITEM_REGULAR),

		list("EXTRA SNIPER AMMUNITION", 0, null, null, null),
		list("M42A Flak Magazine (10x28mm)", 40, /obj/item/ammo_magazine/sniper/flak, null, VENDOR_ITEM_REGULAR),
		list("M42A Incendiary Magazine (10x28mm)", 40, /obj/item/ammo_magazine/sniper/incendiary, null, VENDOR_ITEM_REGULAR),
		list("M42A Marksman Magazine (10x28mm Caseless)", 40, /obj/item/ammo_magazine/sniper, null, VENDOR_ITEM_REGULAR),
		list("XM43E1 Marksman Magazine (10x99mm Caseless)", 40, /obj/item/ammo_magazine/sniper/anti_materiel, null, VENDOR_ITEM_REGULAR),

		list("EXTRA DEMOLITIONIST AMMUNITION", 0, null, null, null),
		list("84mm Anti-Armor Rocket", 40, /obj/item/ammo_magazine/rocket/ap, null, VENDOR_ITEM_REGULAR),
		list("84mm High-Explosive Rocket", 40, /obj/item/ammo_magazine/rocket, null, VENDOR_ITEM_REGULAR),
		list("84mm White-Phosphorus Rocket", 40, /obj/item/ammo_magazine/rocket/wp, null, VENDOR_ITEM_REGULAR),

		list("EXTRA GRENADES", 0, null, null, null),
		list("Ящик гранат M40 HEDP (Осколочная) x 6", 40, /obj/effect/essentials_set/hedp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик гранат M40 HIDP (Зажигательная) x 6", 40, /obj/effect/essentials_set/hidp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик гранат M40 CCDP (Химическая смесь) x 6", 40, /obj/effect/essentials_set/ccdp_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик прыгающих гранат M74 AGM (Осколочная) x 6", 40, /obj/effect/essentials_set/agmf_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик прыгающих гранат M74 AGM (Зажигательная) x 6", 40, /obj/effect/essentials_set/agmi_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик прыгающих гранат M74 AGM (Дымовая) x 6", 20, /obj/effect/essentials_set/agms_6_pack, null, VENDOR_ITEM_REGULAR),
		list("Ящик электрошоковых гранат G2 x 6", 40, /obj/effect/essentials_set/sebb_6_pack, null, VENDOR_ITEM_REGULAR),

		list("EXTRA FLAMETHROWER TANKS", 0, null, null, null),
		list("Large Incinerator Tank", 40, /obj/item/ammo_magazine/flamer_tank/large, null, VENDOR_ITEM_REGULAR),
		list("Large Incinerator Tank (B) (Green Flame)", 40, /obj/item/ammo_magazine/flamer_tank/large/B, null, VENDOR_ITEM_REGULAR),
		list("Large Incinerator Tank (X) (Blue Flame)", 40, /obj/item/ammo_magazine/flamer_tank/large/X, null, VENDOR_ITEM_REGULAR),

	))

GLOBAL_LIST_INIT(cm_vending_gear_spec_heavy, list(
	list("WEAPONS SPECIALIST SETS (ВЫБЕРИТЕ 1)", 0, null, null, null),
	list("Heavy Armor Set", 0, /obj/item/storage/box/spec/B18, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_RECOMMENDED),
))



/obj/structure/machinery/cm_vending/gear/spec
	name = "\improper Раздатчик экипировки оружейного специалиста «КолМорТех» ColMarTech"
	desc = "An automated gear rack for Squad Weapons Specialists."
	icon_state = "spec_gear"
	show_points = TRUE
	use_points = FALSE
	use_snowflake_points = TRUE
	vendor_role = list(JOB_SQUAD_SPECIALIST)
	req_access = list(ACCESS_MARINE_SPECPREP)

/obj/structure/machinery/cm_vending/gear/spec/get_listed_products(mob/user)
	if(SSticker.mode && MODE_HAS_MODIFIER(/datum/gamemode_modifier/heavy_specialists))
		return GLOB.cm_vending_gear_spec_heavy
	return GLOB.cm_vending_gear_spec

/obj/structure/machinery/cm_vending/gear/spec/vendor_successful_vend_one(prod_type, mob/living/carbon/human/user, turf/target_turf, insignas_override, stack_amount)
	. = ..()
	if(length(GLOB.primary_specialists_picked) >= /datum/job/marine/specialist::total_positions)
		return

	if(ispath(prod_type, /obj/item/storage/box/spec))
		var/obj/item/storage/box/spec/spec_kit = prod_type
		GLOB.primary_specialists_picked[spec_kit::kit_name] = TRUE

//------------CLOTHING VENDOR---------------

GLOBAL_LIST_INIT(cm_vending_clothing_specialist, list(
		list("СТАНДАРТНАЯ ЭКИПИРОВКА (ВОЗЬМИТЕ ВСЁ)", 0, null, null, null),
		list("Стандартная экипировка пехотинца", 0, list(/obj/item/clothing/under/marine, /obj/item/clothing/shoes/marine/knife, /obj/item/clothing/gloves/marine, /obj/item/device/radio/headset/almayer/marine), MARINE_CAN_BUY_UNIFORM, VENDOR_ITEM_MANDATORY),
		list("Сухой паек MRE", 0, /obj/item/storage/box/mre, MARINE_CAN_BUY_MRE, VENDOR_ITEM_MANDATORY),
		list("Оружейная смазка", 0, /obj/item/stack/repairable/gunlube, MARINE_CAN_BUY_REPAIRABLE, VENDOR_ITEM_MANDATORY),
		list("Карта", 0, /obj/item/map/current_map, MARINE_CAN_BUY_MAP, VENDOR_ITEM_MANDATORY),

		list("РЮКЗАКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Backpack", 0, /obj/item/storage/backpack/marine, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_REGULAR),
		list("Satchel", 0, /obj/item/storage/backpack/marine/satchel, MARINE_CAN_BUY_BACKPACK, VENDOR_ITEM_RECOMMENDED),

		list("ПОЯС (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Поясная разгрузка G8-A", 0, /obj/item/storage/backpack/general_belt, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс для боеприпасов", 0, /obj/item/storage/belt/marine, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для пистолета", 0, /obj/item/storage/belt/gun/m4a3, MARINE_CAN_BUY_BELT, VENDOR_ITEM_RECOMMENDED),
		list("Пояс с креплением для ПП M39", 0, /obj/item/storage/belt/gun/m39, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для пистолета M10", 0, /obj/item/storage/belt/gun/m10, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для револьвера", 0, /obj/item/storage/belt/gun/m44, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Пояс с кобурой для ракетницы M82F", 0, /obj/item/storage/belt/gun/flaregun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),
		list("Патронташ на пояс для дробовика", 0, /obj/item/storage/belt/shotgun, MARINE_CAN_BUY_BELT, VENDOR_ITEM_REGULAR),

		list("ПОДСУМКИ (ВЫБЕРИТЕ 2)", 0, null, null, null),
		list("Медицинский подсумок (Инжекторы)", 0, /obj/item/storage/pouch/firstaid/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Шины, бинты, мазь)", 0, /obj/item/storage/pouch/firstaid/full/alternate, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Медицинский подсумок (Таблетки)", 0, /obj/item/storage/pouch/firstaid/full/pills, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок для осветительных огней", 0, /obj/item/storage/pouch/flare/full, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок для магазинов", 0, /obj/item/storage/pouch/magazine, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Подсумок для дробовика", 0, /obj/item/storage/pouch/shotgun, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_RECOMMENDED),
		list("Большой подсумок для пистолетных магазинов", 0, /obj/item/storage/pouch/magazine/pistol/large, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Подсумок общего назначения", 0, /obj/item/storage/pouch/general/medium, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Кобура для пистолета", 0, /obj/item/storage/pouch/pistol, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),
		list("Ременная сумка", 0, /obj/item/storage/pouch/sling, MARINE_CAN_BUY_POUCH, VENDOR_ITEM_REGULAR),

		list("РАЗГРУЗКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Коричневый разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest/brown_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_RECOMMENDED),
		list("Чёрный разгрузочный жилет", 0, /obj/item/clothing/accessory/storage/black_vest, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Наплечная кобура", 0, /obj/item/clothing/accessory/storage/holster, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", 0, /obj/item/clothing/accessory/storage/webbing/black, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", 0, /obj/item/clothing/accessory/storage/droppouch, MARINE_CAN_BUY_ACCESSORY, VENDOR_ITEM_REGULAR),

		list("МАСКИ (ВЫБЕРИТЕ 1)", 0, null, null, null),
		list("Противогаз", 0, /obj/item/clothing/mask/gas, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),
		list("Инфракрасная балаклава", 0, /obj/item/clothing/mask/rebreather/scarf, MARINE_CAN_BUY_MASK, VENDOR_ITEM_REGULAR),

		list("ВООРУЖЕНИЕ С ОГРАНИЧЕННЫМ ДОСТУПОМ", 0, null, null, null),
		list("Пистолет VP78", 15, /obj/item/storage/box/guncase/vp78, null, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", 15, /obj/item/storage/box/guncase/smartpistol, null, VENDOR_ITEM_REGULAR),

		list("БОЕПРИПАСЫ ДЛЯ ДОПОЛНИТЕЛЬНОГО ОРУЖИЯ", 0, null, null, null),
		list("Расширенный магазин для M10 HV (10x20мм)", 10, /obj/item/ammo_magazine/pistol/m10/extended , null, VENDOR_ITEM_REGULAR),
		list("Барабанный магазин для M10 HV (10x20мм)", 15, /obj/item/ammo_magazine/pistol/m10/drum , null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 FMJ)", 10, /obj/item/ammo_magazine/revolver/heavy, null, VENDOR_ITEM_REGULAR),
		list("Клип-обойма для M44 (.44 SSA)", 10, /obj/item/ammo_magazine/revolver/marksman, null, VENDOR_ITEM_REGULAR),
		list("M4A3 HP Magazine", 5, /obj/item/ammo_magazine/pistol/hp, null, VENDOR_ITEM_REGULAR),
		list("M4A3 AP Magazine", 5, /obj/item/ammo_magazine/pistol/ap, null, VENDOR_ITEM_REGULAR),
		list("Магазин для VP78 (9мм)", 5, /obj/item/ammo_magazine/pistol/vp78, null, VENDOR_ITEM_REGULAR),
		list("Магазин для SU-6 (.45)", 10, /obj/item/ammo_magazine/pistol/smart, null, VENDOR_ITEM_REGULAR),

		list("ЭЛЕМЕНТЫ ОДЕЖДЫ", 0, null, null, null),
		list("Чехол для мачете", 6, /obj/item/storage/large_holster/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Ножны для мачете", 15, /obj/item/storage/pouch/machete/full, null, VENDOR_ITEM_REGULAR),
		list("Рюкзак связиста ККМП", 15, /obj/item/storage/backpack/marine/satchel/rto, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для резервуаров к огнемёту", 5, /obj/item/storage/pouch/flamertank, null, VENDOR_ITEM_REGULAR),
		list("Очки сварщика", 3, /obj/item/clothing/glasses/welding, null, VENDOR_ITEM_REGULAR),
		list("Большой подсумок общего назначения", 10, /obj/item/storage/pouch/general/large, null, VENDOR_ITEM_REGULAR),
		list("M276 Pattern Combat Toolbelt Rig", 15, /obj/item/storage/belt/gun/utility, null, VENDOR_ITEM_REGULAR),
		list("Подсумок для инжекторов", 15, /obj/item/storage/pouch/autoinjector/full, null, VENDOR_ITEM_REGULAR),

		list("ВСПОМОГАТЕЛЬНОЕ СНАРЯЖЕНИЕ", 0, null, null, null),
		list("Роликовые носилки", 5, /obj/item/roller, null, VENDOR_ITEM_REGULAR),
		list("Система воздушной эвакуации Фултон", 5, /obj/item/stack/fulton, null, VENDOR_ITEM_REGULAR),
		list("Переносной огнетушитель", 5, /obj/item/tool/extinguisher/mini, null, VENDOR_ITEM_REGULAR),
		list("Детектор движения", 10, /obj/item/device/motiondetector, null, VENDOR_ITEM_REGULAR),
		list("Сканер данных", 10, /obj/item/device/motiondetector/intel, null, VENDOR_ITEM_REGULAR),
		list("Свисток", 5, /obj/item/device/whistle, null, VENDOR_ITEM_REGULAR),

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

/obj/structure/machinery/cm_vending/clothing/specialist
	name = "\improper Раздатчик экипировки оружейного специалиста «КолМорТех»"
	desc = "An automated rack hooked up to a colossal storage of Squad Weapons Specialist standard-issue equipment."
	show_points = TRUE
	req_access = list(ACCESS_MARINE_SPECPREP)
	vendor_role = list(JOB_SQUAD_SPECIALIST)

/obj/structure/machinery/cm_vending/clothing/specialist/get_listed_products(mob/user)
	return GLOB.cm_vending_clothing_specialist

/obj/structure/machinery/cm_vending/clothing/specialist/alpha
	squad_tag = SQUAD_MARINE_1
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_ALPHA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/alpha

/obj/structure/machinery/cm_vending/clothing/specialist/bravo
	squad_tag = SQUAD_MARINE_2
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_BRAVO)
	headset_type = /obj/item/device/radio/headset/almayer/marine/bravo

/obj/structure/machinery/cm_vending/clothing/specialist/charlie
	squad_tag = SQUAD_MARINE_3
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_CHARLIE)
	headset_type = /obj/item/device/radio/headset/almayer/marine/charlie

/obj/structure/machinery/cm_vending/clothing/specialist/delta
	squad_tag = SQUAD_MARINE_4
	req_access = list(ACCESS_MARINE_SPECPREP, ACCESS_MARINE_DELTA)
	headset_type = /obj/item/device/radio/headset/almayer/marine/delta

//------------ESSENTIAL SETS---------------

/obj/effect/essentials_set/hedp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
		/obj/item/explosive/grenade/high_explosive,
	)

/obj/effect/essentials_set/hefa_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
		/obj/item/explosive/grenade/high_explosive/frag,
	)

/obj/effect/essentials_set/hidp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
		/obj/item/explosive/grenade/incendiary,
	)

/obj/effect/essentials_set/ccdp_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
		/obj/item/explosive/grenade/phosphorus,
	)

/obj/effect/essentials_set/agmf_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
		/obj/item/explosive/grenade/high_explosive/airburst,
	)

/obj/effect/essentials_set/agmi_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
		/obj/item/explosive/grenade/incendiary/airburst,
	)

/obj/effect/essentials_set/agms_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
		/obj/item/explosive/grenade/smokebomb/airburst,
	)

/obj/effect/essentials_set/sebb_6_pack
	spawned_gear_list = list(
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
		/obj/item/explosive/grenade/sebb,
	)
