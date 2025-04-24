//------------REQ VENDORS AND THEIR SQUAD VARIANTS---------------

//------------ARMAMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns
	name = "\improper Автоматизированный раздатчик вооружения «КолМорТех»"
	desc = "An automated supply rack hooked up to a big storage of various firearms, explosives, load carrying equipment and other miscellaneous items. Can be accessed by the Quartermaster and Cargo Technicians."
	icon_state = "req_guns"
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC

/obj/structure/machinery/cm_vending/sorted/cargo_guns/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/cargo_guns/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/cargo_guns/populate_product_list(scale)
	listed_products = list(
		list("ОСНОВНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Помповый дробовик M37A2", floor(scale * 30), /obj/item/weapon/gun/shotgun/pump, VENDOR_ITEM_REGULAR),
		list("Пистолет-пулемет M39", floor(scale * 60), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("Импульсная винтовка M41A MK2", floor(scale * 60), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_REGULAR),
		list("Штурмовой карабин M4RA", floor(scale * 20), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),

		list("ДОПОЛНИТЕЛЬНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Автоматический пистолет M10", floor(scale * 50), /obj/item/weapon/gun/pistol/m10, VENDOR_ITEM_REGULAR),
		list("Боевой пистолет 88 Mod 4", floor(scale * 50), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("Боевой револьвер M44", floor(scale * 50), /obj/item/weapon/gun/revolver/m44, VENDOR_ITEM_REGULAR),
		list("Служебный пистолет M4A3", floor(scale * 50), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),
		list("Сигнальная ракетница M82F", floor(scale * 20), /obj/item/weapon/gun/flare, VENDOR_ITEM_REGULAR),

		list("RESTRICTED FIREARMS", -1, null, null),
		list("Пистолет VP78", floor(scale * 4), /obj/item/storage/box/guncase/vp78, VENDOR_ITEM_REGULAR),
		list("Умный пистолет SU-6", floor(scale * 3), /obj/item/storage/box/guncase/smartpistol, VENDOR_ITEM_REGULAR),
		list("Дробовик MOU-53", floor(scale * 2), /obj/item/storage/box/guncase/mou53, VENDOR_ITEM_REGULAR),
		list("Тяжёлая винтовка XM88", floor(scale * 3), /obj/item/storage/box/guncase/xm88, VENDOR_ITEM_REGULAR),
		list("Тяжёлая импульсная винтовка M41AE2", 2.5, /obj/item/storage/box/guncase/lmg, VENDOR_ITEM_REGULAR),
		list("Импульсная винтовка M41A MK1", floor(scale * 3), /obj/item/storage/box/guncase/m41aMK1, VENDOR_ITEM_REGULAR),
		list("Тяжёлый пулемёт M56D", floor(scale * 2), /obj/item/storage/box/guncase/m56d, VENDOR_ITEM_REGULAR),
		list("Тяжёлый пулемёт M2C", floor(scale * 2), /obj/item/storage/box/guncase/m2c, VENDOR_ITEM_REGULAR),
		list("Огнемёт M240", floor(scale * 2), /obj/item/storage/box/guncase/flamer, VENDOR_ITEM_REGULAR),
		list("Гранатомет M79", floor(scale * 3), /obj/item/storage/box/guncase/m79, VENDOR_ITEM_REGULAR),
		list("Тяжёлый дробовик XM51", floor(scale * 3), /obj/item/storage/box/guncase/xm51, VENDOR_ITEM_REGULAR),

		list("ВЗРЫВЧАТЫЕ ВЕЩЕСТВА", -1, null, null),
		list("Осколочная граната M15", floor(scale * 2), /obj/item/explosive/grenade/high_explosive/m15, VENDOR_ITEM_REGULAR),
		list("Противопехотная мина M20 Клеймор", floor(scale * 4), /obj/item/explosive/mine, VENDOR_ITEM_REGULAR),
		list("Граната M40 HEDP (Осколочная)", floor(scale * 25), /obj/item/explosive/grenade/high_explosive, VENDOR_ITEM_REGULAR),
		list("Граната M40 HIDP (Зажигательная)", floor(scale * 4), /obj/item/explosive/grenade/incendiary, VENDOR_ITEM_REGULAR),
		list("Граната M40 CCDP (Химическая смесь)", floor(scale * 4), /obj/item/explosive/grenade/phosphorus, VENDOR_ITEM_REGULAR),
		list("Граната M40 HSDP (Дымовая)", floor(scale * 5), /obj/item/explosive/grenade/smokebomb, VENDOR_ITEM_REGULAR),
		list("Прыгающая граната M74 AGM (Осколочная)", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst, VENDOR_ITEM_REGULAR),
		list("Прыгающая граната M74 AGM (Зажигательная)", floor(scale * 4), /obj/item/explosive/grenade/incendiary/airburst, VENDOR_ITEM_REGULAR),
		list("Прыгающая граната M74 AGM (Дымовая)", floor(scale * 4), /obj/item/explosive/grenade/smokebomb/airburst, VENDOR_ITEM_REGULAR),
		list("Прыгающая граната M74 AGM «Звезда»", floor(scale * 2), /obj/item/explosive/grenade/high_explosive/airburst/starshell, VENDOR_ITEM_REGULAR),
		list("Прыгающая граната M74 AGM «Шершень»", floor(scale * 4), /obj/item/explosive/grenade/high_explosive/airburst/hornet_shell, VENDOR_ITEM_REGULAR),
		list("Электрошоковая граната G2", floor(scale * 5), /obj/item/explosive/grenade/sebb, VENDOR_ITEM_REGULAR),
		list("Граната M40 HIRR (Резиновая)", floor(scale * 8), /obj/item/explosive/grenade/slug/baton, VENDOR_ITEM_REGULAR),
		list("Граната M40 MFHS (Пена)", floor(scale * 6), /obj/item/explosive/grenade/metal_foam, VENDOR_ITEM_REGULAR),
		list("Пластичная взрывчатка С-4", floor(scale * 3), /obj/item/explosive/plastic, VENDOR_ITEM_REGULAR),
		list("Пробивной заряд", floor(scale * 2), /obj/item/explosive/plastic/breaching_charge, VENDOR_ITEM_REGULAR),

		list("WEBBINGS", -1, null, null),
		list("Чёрный разгрузочный жилет", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest, VENDOR_ITEM_REGULAR),
		list("Коричневый разгрузочный жилет", floor(scale * 2), /obj/item/clothing/accessory/storage/black_vest/brown_vest, VENDOR_ITEM_REGULAR),
		list("Наплечная кобура", floor(scale * 1.5), /obj/item/clothing/accessory/storage/holster, VENDOR_ITEM_REGULAR),
		list("Нагрудный жилет", floor(scale * 5), /obj/item/clothing/accessory/storage/webbing, VENDOR_ITEM_REGULAR),
		list("Чёрный нагрудный жилет", floor(scale * 5), /obj/item/clothing/accessory/storage/webbing/black, VENDOR_ITEM_REGULAR),
		list("Жилет с ножнами", floor(scale * 1), /obj/item/clothing/accessory/storage/knifeharness, VENDOR_ITEM_REGULAR),
		list("Наплечный подсумок", floor(scale * 2), /obj/item/clothing/accessory/storage/droppouch, VENDOR_ITEM_REGULAR),
		list("Навесная разгрузка", floor(scale * 5), /obj/item/clothing/suit/storage/webbing, VENDOR_ITEM_REGULAR),

		list("РЮКЗАКИ", -1, null, null),
		list("Военный лёгкий рюкзак", floor(scale * 15), /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR),
		list("Чехол для дробовика", floor(scale * 10), /obj/item/storage/large_holster/m37, VENDOR_ITEM_REGULAR),
		list("Топливный бак G4-1", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack/flamethrower/kit, VENDOR_ITEM_REGULAR),
		list("Разгрузочная система техника ККМП", floor(scale * 2), /obj/item/storage/backpack/marine/engineerpack, VENDOR_ITEM_REGULAR),
		list("Mortar Shell Backpack", floor(scale * 1), /obj/item/storage/backpack/marine/mortarpack, VENDOR_ITEM_REGULAR),
		list("Technician Welder-Satchel", floor(scale * 5), /obj/item/storage/backpack/marine/engineerpack/satchel, VENDOR_ITEM_REGULAR),
		list("IMP Ammo Rack", floor(scale * 2), /obj/item/storage/backpack/marine/ammo_rack, VENDOR_ITEM_REGULAR),
		list("Radio Telephone Pack", floor(scale * 2), /obj/item/storage/backpack/marine/satchel/rto, VENDOR_ITEM_REGULAR),
		list("Parachute", floor(scale * 20), /obj/item/parachute, VENDOR_ITEM_REGULAR),
		list("Grenade Satchel", floor(scale * 2), /obj/item/storage/backpack/marine/grenadepack, VENDOR_ITEM_REGULAR),

		list("BELTS", -1, null, null),
		list("G8-A General Utility Pouch", floor(scale * 2), /obj/item/storage/backpack/general_belt, VENDOR_ITEM_REGULAR),
		list("M276 Ammo Load Rig", floor(scale * 15), /obj/item/storage/belt/marine, VENDOR_ITEM_REGULAR),
		list("M276 General Pistol Holster Rig", floor(scale * 10), /obj/item/storage/belt/gun/m4a3, VENDOR_ITEM_REGULAR),
		list("M276 Knife Rig", floor(scale * 5), /obj/item/storage/belt/knifepouch, VENDOR_ITEM_REGULAR),
		list("M276 M39 Holster Rig", floor(scale * 5), /obj/item/storage/belt/gun/m39, VENDOR_ITEM_REGULAR),
		list("M276 M10 Holster Rig", floor(scale * 5), /obj/item/storage/belt/gun/m10, VENDOR_ITEM_REGULAR),
		list("M276 M40 Grenade Rig", floor(scale * 2), /obj/item/storage/belt/grenade, VENDOR_ITEM_REGULAR),
		list("M276 General Revolver Holster Rig", floor(scale * 5), /obj/item/storage/belt/gun/m44, VENDOR_ITEM_REGULAR),
		list("M276 M82F Holster Rig", floor(scale * 2), /obj/item/storage/belt/gun/flaregun, VENDOR_ITEM_REGULAR),
		list("M276 Shotgun Shell Loading Rig", floor(scale * 10), /obj/item/storage/belt/shotgun, VENDOR_ITEM_REGULAR),
		list("M276 Mortar Operator Belt", floor(scale * 2), /obj/item/storage/belt/gun/mortarbelt, VENDOR_ITEM_REGULAR),

		list("POUCHES", -1, null, null),
		list("Autoinjector Pouch", floor(scale * 1), /obj/item/storage/pouch/autoinjector, VENDOR_ITEM_REGULAR),
		list("Medical Kit Pouch", floor(scale * 2), /obj/item/storage/pouch/medkit, VENDOR_ITEM_REGULAR),
		list("First-Aid Pouch (Full)", floor(scale * 5), /obj/item/storage/pouch/firstaid/full, VENDOR_ITEM_REGULAR),
		list("First Responder Pouch", floor(scale * 2), /obj/item/storage/pouch/first_responder, VENDOR_ITEM_REGULAR),
		list("Syringe Pouch", floor(scale * 2), /obj/item/storage/pouch/syringe, VENDOR_ITEM_REGULAR),
		list("Tools Pouch (Full)", floor(scale * 2), /obj/item/storage/pouch/tools/full, VENDOR_ITEM_REGULAR),
		list("Construction Pouch", floor(scale * 2), /obj/item/storage/pouch/construction, VENDOR_ITEM_REGULAR),
		list("Electronics Pouch", floor(scale * 2), /obj/item/storage/pouch/electronics, VENDOR_ITEM_REGULAR),
		list("Explosive Pouch", floor(scale * 2), /obj/item/storage/pouch/explosive, VENDOR_ITEM_REGULAR),
		list("Flare Pouch (Full)", floor(scale * 5), /obj/item/storage/pouch/flare/full, VENDOR_ITEM_REGULAR),
		list("Document Pouch", floor(scale * 2), /obj/item/storage/pouch/document/small, VENDOR_ITEM_REGULAR),
		list("Sling Pouch", floor(scale * 2), /obj/item/storage/pouch/sling, VENDOR_ITEM_REGULAR),
		list("Machete Pouch (Full)", 1, /obj/item/storage/pouch/machete/full, VENDOR_ITEM_REGULAR),
		list("Bayonet Pouch", floor(scale * 2), /obj/item/storage/pouch/bayonet, VENDOR_ITEM_REGULAR),
		list("Medium General Pouch", floor(scale * 2), /obj/item/storage/pouch/general/medium, VENDOR_ITEM_REGULAR),
		list("Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine, VENDOR_ITEM_REGULAR),
		list("Shotgun Shell Pouch", floor(scale * 5), /obj/item/storage/pouch/shotgun, VENDOR_ITEM_REGULAR),
		list("Sidearm Pouch", floor(scale * 5), /obj/item/storage/pouch/pistol, VENDOR_ITEM_REGULAR),
		list("Large Pistol Magazine Pouch", floor(scale * 5), /obj/item/storage/pouch/magazine/pistol/large, VENDOR_ITEM_REGULAR),
		list("Fuel Tank Strap Pouch", floor(scale * 4), /obj/item/storage/pouch/flamertank, VENDOR_ITEM_REGULAR),
		list("Large General Pouch", floor(scale * 1), /obj/item/storage/pouch/general/large, VENDOR_ITEM_REGULAR),
		list("Large Magazine Pouch", floor(scale * 1), /obj/item/storage/pouch/magazine/large, VENDOR_ITEM_REGULAR),
		list("Large Shotgun Shell Pouch", floor(scale * 1), /obj/item/storage/pouch/shotgun/large, VENDOR_ITEM_REGULAR),

		list("REPAIR TOOLS", -1, null, null),
		list("Multi-Purpose Combat Lubricant", floor(scale * 5), /obj/item/stack/repairable/gunlube, VENDOR_ITEM_REGULAR),
		list("Firearms Repair Kit", floor(scale * 3), /obj/item/stack/repairable/gunkit, VENDOR_ITEM_REGULAR),

		list("FLARE AND LIGHT", -1, null, null),
		list("Combat Flashlight", floor(scale * 8), /obj/item/device/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("M89-S Signal Flare Pack", floor(scale * 2), /obj/item/storage/box/m94/signal, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_REGULAR),

		list("ESSENTIAL DEVICES", -1, null, null),
		list("Motion Detector", floor(scale * 4), /obj/item/device/motiondetector, VENDOR_ITEM_REGULAR),
		list("Data Detector", floor(scale * 4), /obj/item/device/motiondetector/intel, VENDOR_ITEM_REGULAR),
		list("Binoculars", floor(scale * 2), /obj/item/device/binoculars, VENDOR_ITEM_REGULAR),
		list("Rangefinder", floor(scale * 1), /obj/item/device/binoculars/range, VENDOR_ITEM_REGULAR),
		list("Laser Designator", floor(scale * 1), /obj/item/device/binoculars/range/designator, VENDOR_ITEM_REGULAR),
		list("Fulton Device Stack", floor(scale * 1), /obj/item/stack/fulton, VENDOR_ITEM_REGULAR),
		list("Sentry Gun Network Laptop", 4, /obj/item/device/sentry_computer, VENDOR_ITEM_REGULAR),
		list("Spare PDT/L Battle Buddy Kit", floor(scale * 4), /obj/item/storage/box/pdt_kit, VENDOR_ITEM_REGULAR),
		list("W-Y brand rechargeable mini-battery", floor(scale * 3), /obj/item/cell/crap, VENDOR_ITEM_REGULAR),
		list("High-Capacity Power Cell", floor(scale * 1), /obj/item/cell/high, VENDOR_ITEM_REGULAR),

		list("SKILL PAMPHLETS", -1, null, null),
		list("JTAC Pamphlet", floor(scale * 1), /obj/item/pamphlet/skill/jtac, VENDOR_ITEM_REGULAR),
		list("Engineering Pamphlet", floor(scale * 1), /obj/item/pamphlet/skill/engineer, VENDOR_ITEM_REGULAR),
		list("Powerloader Certification", 0.75, /obj/item/pamphlet/skill/powerloader, VENDOR_ITEM_REGULAR),

		list("MISCELLANEOUS", -1, null, null),
		list("Entrenching Tool", floor(scale * 4), /obj/item/tool/shovel/etool/folded, VENDOR_ITEM_REGULAR),
		list("Противогаз", floor(scale * 10), /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR),
		list("Machete Scabbard (Full)", floor(scale * 6), /obj/item/storage/large_holster/machete/full, VENDOR_ITEM_REGULAR),
		list("MB-6 Folding Barricades (x3)", floor(scale * 3), /obj/item/stack/folding_barricade/three, VENDOR_ITEM_REGULAR),
		list("Welding Goggles", floor(scale * 3), /obj/item/clothing/glasses/welding, VENDOR_ITEM_REGULAR),
		list("Fire Extinguisher (Portable)", floor(scale * 3), /obj/item/tool/extinguisher/mini, VENDOR_ITEM_REGULAR),
		list("Nailgun Magazine (7x45mm)", floor(scale * 4), /obj/item/ammo_magazine/smg/nailgun, VENDOR_ITEM_REGULAR),

		list("EXPLOSIVES BOXES", -1, null, null),
		list("M15 Fragmentation Grenade Packet", 0, /obj/item/storage/box/packet/m15, VENDOR_ITEM_REGULAR),
		list("M40 HEDP Grenade Packet", 0, /obj/item/storage/box/packet/high_explosive, VENDOR_ITEM_REGULAR),
		list("M40 HEDP Grenade Box", 0, /obj/item/storage/box/nade_box, VENDOR_ITEM_REGULAR),
		list("M40 HIDP Grenade Packet", 0, /obj/item/storage/box/packet/incendiary, VENDOR_ITEM_REGULAR),
		list("M40 HIDP Grenade Box", 0, /obj/item/storage/box/nade_box/incen, VENDOR_ITEM_REGULAR),
		list("M40 CCDP Grenade Packet", 0, /obj/item/storage/box/packet/phosphorus/strong, VENDOR_ITEM_REGULAR),
		list("M40 CCDP Grenade Box", 0, /obj/item/storage/box/nade_box/phophorus, VENDOR_ITEM_REGULAR),
		list("M40 HSDP Grenade Packet", 0, /obj/item/storage/box/packet/smoke, VENDOR_ITEM_REGULAR),
		list("M40 MFHS Grenade Packet", 0, /obj/item/storage/box/packet/foam, VENDOR_ITEM_REGULAR),
		list("M40 HIRR Baton Slug Packet", 0, /obj/item/storage/box/packet/baton_slug, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F Grenade Packet", 0, /obj/item/storage/box/packet/airburst_he, VENDOR_ITEM_REGULAR),
		list("M74 AGM-F Grenade box", 0, /obj/item/storage/box/nade_box/airburst, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I Grenade Packet", 0, /obj/item/storage/box/packet/airburst_incen, VENDOR_ITEM_REGULAR),
		list("M74 AGM-I Grenade Box", 0, /obj/item/storage/box/nade_box/airburstincen, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Smoke Grenade Packet", 0, /obj/item/storage/box/packet/airburst_smoke, VENDOR_ITEM_REGULAR),
		list("M74 AGM-S Star Shell Packet", 0, /obj/item/storage/box/packet/flare, VENDOR_ITEM_REGULAR),
		list("M74 AGM-H Hornet Shell Packet", 0, /obj/item/storage/box/packet/hornet, VENDOR_ITEM_REGULAR),
		list("G2 Electroshock grenade packet", 0, /obj/item/storage/box/packet/sebb, VENDOR_ITEM_REGULAR),
		list("M20 mine box", 0, /obj/item/storage/box/explosive_mines, VENDOR_ITEM_REGULAR),

		list("OTHER BOXES", -1, null, null),
		list("Box of Combat Flashlights", 0, /obj/item/ammo_box/magazine/misc/flashlight/combat, VENDOR_ITEM_REGULAR),
		list("Box of M94 Marking Flare Packs", 0, /obj/item/ammo_box/magazine/misc/flares, VENDOR_ITEM_REGULAR),
		list("Box of M89 Signal Flare Packs", 0, /obj/item/ammo_box/magazine/misc/flares/signal, VENDOR_ITEM_REGULAR),
		list("Box of High-Capacity Power Cells", 0, /obj/item/ammo_box/magazine/misc/power_cell, VENDOR_ITEM_REGULAR),
		list("Nailgun Magazine Box (7x45mm)", floor(scale * 2), /obj/item/ammo_box/magazine/nailgun, VENDOR_ITEM_REGULAR)
		)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/stock(obj/item/item_to_stock, mob/user)
	if(istype(item_to_stock, /obj/item/storage) && !istype(item_to_stock, /obj/item/storage/box/m94) && !istype(item_to_stock, /obj/item/storage/large_holster/machete))
		to_chat(user, SPAN_WARNING("Can't restock \the [item_to_stock]."))
		return

	//this below is in case we have subtype of an object, that SHOULD be treated as parent object (like /empty ammo box)
	var/corrected_path = return_corresponding_type(item_to_stock.type)

	var/list/R
	for(R in (listed_products))
		if(item_to_stock.type == R[3] || corrected_path && corrected_path == R[3])
			if(!check_if_item_is_good_to_restock(item_to_stock, user))
				return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user] stocks [src] with \a [R[1]]."),
			SPAN_NOTICE("You stock [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_guns/cargo
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions
	vend_dir = WEST
	vend_dir_whitelist = list(NORTH, SOUTH)

/obj/structure/machinery/cm_vending/sorted/cargo_guns/cargo/blend
	icon_state = "req_guns_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//------------AMMUNITION VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/cargo_ammo
	name = "\improper Автоматизированный раздатчик боеприпасов «КолМорТех»" // SS220 - EDIT
	desc = "An automated supply rack hooked up to a big storage of various ammunition types. Can be accessed by the Quartermaster and Cargo Technicians."
	icon_state = "req_ammo"
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_TO_HAND | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC
	vend_dir = WEST
	vend_dir_whitelist = list(SOUTHWEST, NORTHWEST)

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/populate_product_list(scale)
	listed_products = list(
		list("ШТАТНЫЕ БОЕПРИПАСЫ", -1, null, null), // SS220 - EDIT
		list("Коробка для патронов (Картечь)", floor(scale * 56), /obj/item/ammo_magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коробка для патронов (Флешетты)", floor(scale * 56), /obj/item/ammo_magazine/shotgun/flechette, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коробка для патронов (Пуля)", floor(scale * 56), /obj/item/ammo_magazine/shotgun/slugs, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коробка для патронов (Пуля 16г)", floor(scale * 4), /obj/item/ammo_magazine/shotgun/light/breaching, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M4RA (10x24мм)", floor(scale * 60), /obj/item/ammo_magazine/rifle/m4ra, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M41A MK2 (10x24мм)", floor(scale * 100), /obj/item/ammo_magazine/rifle, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M39 HV (10x20мм)", floor(scale * 100), /obj/item/ammo_magazine/smg/m39, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M10 HV (10x20мм)", floor(scale * 100), /obj/item/ammo_magazine/pistol/m10, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Клип-обойма для M44 (.44)", floor(scale * 80), /obj/item/ammo_magazine/revolver, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M4A3 (9мм)", floor(scale * 100), /obj/item/ammo_magazine/pistol, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("БРОНЕБОЙНЫЕ БОЕПРИПАСЫ", -1, null, null), // SS220 - EDIT
		list("Магазин для 88 Mod 4 (9мм AP)", floor(scale * 50), /obj/item/ammo_magazine/pistol/mod88, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M4RA (10x24мм AP)", floor(scale * 16), /obj/item/ammo_magazine/rifle/m4ra/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M39 (10x20мм AP)", floor(scale * 12), /obj/item/ammo_magazine/smg/m39/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M41A MK2 (10x24мм AP)", floor(scale * 10), /obj/item/ammo_magazine/rifle/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M4A3 (9мм AP)", floor(scale * 2), /obj/item/ammo_magazine/pistol/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("РАСШИРЕННЫЕ МАГАЗИНЫ", -1, null, null), // SS220 - EDIT
		list("Расширенный магазин для M10 HV (10x20мм)", floor(scale * 10), /obj/item/ammo_magazine/pistol/m10/extended , VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Барабанный магазин для M10 HV (10x20мм)", floor(scale * 8), /obj/item/ammo_magazine/pistol/m10/drum , VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Расширенный магазин для M39 (10x20мм)", floor(scale * 10), /obj/item/ammo_magazine/smg/m39/extended, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Расширенный магазин для M4RA (10x24мм)", floor(scale * 10), /obj/item/ammo_magazine/rifle/m4ra/extended, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Расширенный магазин для M41A MK2 (10x24мм)", floor(scale * 8), /obj/item/ammo_magazine/rifle/extended, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("ОСОБЫЕ БОЕПРИПАСЫ", -1, null, null), // SS220 - EDIT
		list("Батарея для M56 DV9", 4, /obj/item/smartgun_battery, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Барабанный магазин для M56 Smartgun", 4, /obj/item/ammo_magazine/smartgun, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Клип-обойма для M44 (.44 FMJ)", 10, /obj/item/ammo_magazine/revolver/heavy, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Клип-обойма для M44 (.44 SSA)", 6, /obj/item/ammo_magazine/revolver/marksman, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M4A3 (9мм HP)", floor(scale * 2), /obj/item/ammo_magazine/pistol/hp, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Патронный короб для M41AE2 (10x24мм Holo-Target)", floor(scale * 2), /obj/item/ammo_magazine/rifle/lmg/holo_target, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коробка для патронов (.458 SOCOM)", floor(scale * 4), /obj/item/ammo_magazine/lever_action/xm88, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("БОЕПРИПАСЫ С ОГРАНИЧЕННЫМ ДОСТУПОМ", -1, null, null), // SS220 - EDIT
		list("Магазин для VP78 (9мм)", 11, /obj/item/ammo_magazine/pistol/vp78, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для SU-6 (.45)", 13, /obj/item/ammo_magazine/pistol/smart, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Резервуар топливной смеси для M240", floor(scale * 3), /obj/item/ammo_magazine/flamer_tank, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Патронный короб для M41AE2 (10x24мм)", floor(scale * 3), /obj/item/ammo_magazine/rifle/lmg, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M41A MK1 (10x24мм)", 4.5, /obj/item/ammo_magazine/rifle/m41aMK1, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для M41A MK1 (10x24mm AP)", floor(scale * 2), /obj/item/ammo_magazine/rifle/m41aMK1/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Барабанный магазин для M56D", floor(scale * 2), /obj/item/ammo_magazine/m56d, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Патронный короб для M2C", floor(scale * 2), /obj/item/ammo_magazine/m2c, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Магазин для XM51 (16г)", floor(scale * 3), /obj/item/ammo_magazine/rifle/xm51, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("ЯЩИКИ ДЛЯ МАГАЗИНОВ", -1, null, null), // SS220 - EDIT
		list("Ящик с магазинами (M10 x 22)", 0, /obj/item/ammo_box/magazine/m10, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M10 Расширенный x 14)", 0, /obj/item/ammo_box/magazine/m10/extended, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M10 Барабан x 12)", 0, /obj/item/ammo_box/magazine/m10/drum, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M39 x 12)", 0, /obj/item/ammo_box/magazine/m39, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M39 AP x 12)", 0, /obj/item/ammo_box/magazine/m39/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M39 Расширенный x 10)", 0, /obj/item/ammo_box/magazine/m39/ext, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M41A x 10)", 0, /obj/item/ammo_box/magazine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M41A AP x 10)", 0, /obj/item/ammo_box/magazine/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M41A Расширенный x 8)", 0, /obj/item/ammo_box/magazine/ext, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4A3 x 16)", 0, /obj/item/ammo_box/magazine/m4a3, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4A3 AP x 16)", 0, /obj/item/ammo_box/magazine/m4a3/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4A3 HP x 16)", 0, /obj/item/ammo_box/magazine/m4a3/hp, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4RA x 16)", 0, /obj/item/ammo_box/magazine/m4ra, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4RA AP x 16)", 0, /obj/item/ammo_box/magazine/m4ra/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M4RA Расширенный x 16)", 0, /obj/item/ammo_box/magazine/m4ra/ext, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с коробами (M41AE2 x 8)", 0, /obj/item/ammo_box/magazine/m41ae2, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с коробами (M41AE2 Holo-Target x 8)", 0, /obj/item/ammo_box/magazine/m41ae2/holo, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M41A MK1 x 8)", 0, /obj/item/ammo_box/magazine/mk1, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (M41A MK1 AP x 8)", 0, /obj/item/ammo_box/magazine/mk1/ap, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с патронами (Картечь x 100)", 0, /obj/item/ammo_box/magazine/shotgun/buckshot, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с патронами (Флешетты x 100)", 0, /obj/item/ammo_box/magazine/shotgun/flechette, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с патронами (Пуля x 100)", 0, /obj/item/ammo_box/magazine/shotgun, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с патронами  (Пуля 16г x 120)", 0, /obj/item/ammo_box/magazine/shotgun/light/breaching, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (88 Mod 4 AP x 16)", 0, /obj/item/ammo_box/magazine/mod88, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (SU-6 x 16)", 0, /obj/item/ammo_box/magazine/su6, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (VP78 x 16)", 0, /obj/item/ammo_box/magazine/vp78, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с магазинами (XM51 x 8)", 0, /obj/item/ammo_box/magazine/xm51, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с патронами (.458 SOCOM x 300)", 0, /obj/item/ammo_box/magazine/lever_action/xm88, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с коробами (M2C x 8)", 0, /obj/item/ammo_box/magazine/m2c, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с барабанами (M56B x 8)", 0, /obj/item/ammo_box/magazine/m56b, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с барабанами (M56D x 8)", 0, /obj/item/ammo_box/magazine/m56d, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с клип-обоймами (M44 x 16)", 0, /obj/item/ammo_box/magazine/m44, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с клип-обоймами (SSA M44 x 16)", 0, /obj/item/ammo_box/magazine/m44/marksman, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с клип-обоймами (FMJ M44 x 16)", 0, /obj/item/ammo_box/magazine/m44/heavy, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ящик с топливной смесью (Лигроин x 8)", 0, /obj/item/ammo_box/magazine/flamer, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		)

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/stock(obj/item/item_to_stock, mob/user)
	//these are exempted because checks would be huge and not worth it
	if(istype(item_to_stock, /obj/item/storage))
		to_chat(user, SPAN_WARNING("Can't restock \the [item_to_stock]."))
		return
	var/list/R

	//this below is in case we have subtype of an object, that SHOULD be treated as parent object (like /empty ammo box)
	var/corrected_path = return_corresponding_type(item_to_stock.type)

	for(R in (listed_products))
		if(item_to_stock.type == R[3] || corrected_path && corrected_path == R[3])
			if(!check_if_item_is_good_to_restock(item_to_stock, user))
				return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user] stocks [src] with \a [R[1]]."),
			SPAN_NOTICE("You stock [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo/blend
	icon_state = "req_ammo_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//Special cargo-specific vendor with vending offsets
/obj/structure/machinery/cm_vending/sorted/cargo_ammo/cargo
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_LOAD_AMMO_BOXES | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions

//------------ATTACHMENTS VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/attachments
	name = "\improper Armat Systems Attachments Vendor"
	desc = "An automated supply rack hooked up to a big storage of weapons attachments. Can be accessed by the Quartermaster and Cargo Technicians."
	req_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM
	icon_state = "req_attach"
	vend_dir = WEST
	vend_dir_whitelist = list(SOUTHEAST, NORTHEAST)
	vend_flags = VEND_CLUTTER_PROTECTION | VEND_LIMITED_INVENTORY | VEND_STOCK_DYNAMIC //We want to vend to turf not hand, since we are in requisitions

/obj/structure/machinery/cm_vending/sorted/attachments/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/attachments/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/cm_vending/sorted/attachments/populate_product_list(scale)
	listed_products = list(
		list("BARREL", -1, null, null),
		list("Extended Barrel", 6.5, /obj/item/attachable/extended_barrel, VENDOR_ITEM_REGULAR),
		list("M5 Bayonet", 10.5, /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("Recoil Compensator", 6.5, /obj/item/attachable/compensator, VENDOR_ITEM_REGULAR),
		list("Suppressor", 6.5, /obj/item/attachable/suppressor, VENDOR_ITEM_REGULAR),
		list("Shotgun Choke", 4.5, /obj/item/attachable/shotgun_choke, VENDOR_ITEM_REGULAR),

		list("RAIL", -1, null, null),
		list("B8 Smart-Scope", 3.5, /obj/item/attachable/alt_iff_scope, VENDOR_ITEM_REGULAR),
		list("Magnetic Harness", 8.5, /obj/item/attachable/magnetic_harness, VENDOR_ITEM_REGULAR),
		list("Rail Flashlight", 10.5, /obj/item/attachable/flashlight, VENDOR_ITEM_REGULAR),
		list("S4 2x Telescopic Mini-Scope", 4.5, /obj/item/attachable/scope/mini, VENDOR_ITEM_REGULAR),
		list("S5 Red-Dot Sight", 9.5, /obj/item/attachable/reddot, VENDOR_ITEM_REGULAR),
		list("S6 Reflex Sight", 9.5, /obj/item/attachable/reflex, VENDOR_ITEM_REGULAR),
		list("S8 4x Telescopic Scope", 4.5, /obj/item/attachable/scope, VENDOR_ITEM_REGULAR),

		list("UNDERBARREL", -1, null, null),
		list("Angled Grip", 6.5, /obj/item/attachable/angledgrip, VENDOR_ITEM_REGULAR),
		list("Bipod", 6.5, /obj/item/attachable/bipod, VENDOR_ITEM_REGULAR),
		list("Burst Fire Assembly", 4.5, /obj/item/attachable/burstfire_assembly, VENDOR_ITEM_REGULAR),
		list("Gyroscopic Stabilizer", 4.5, /obj/item/attachable/gyro, VENDOR_ITEM_REGULAR),
		list("Laser Sight", 9.5, /obj/item/attachable/lasersight, VENDOR_ITEM_REGULAR),
		list("Mini Flamethrower", 4.5, /obj/item/attachable/attached_gun/flamer, VENDOR_ITEM_REGULAR),
		list("XM-VESG-1 Flamer Nozzle", 4.5, /obj/item/attachable/attached_gun/flamer_nozzle, VENDOR_ITEM_REGULAR),
		list("U7 Underbarrel Shotgun", 4.5, /obj/item/attachable/attached_gun/shotgun, VENDOR_ITEM_REGULAR),
		list("Underbarrel Extinguisher", 4.5, /obj/item/attachable/attached_gun/extinguisher, VENDOR_ITEM_REGULAR),
		list("Underbarrel Flashlight Grip", 9.5, /obj/item/attachable/flashlight/grip, VENDOR_ITEM_REGULAR),
		list("Underslung Grenade Launcher", 9.5, /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR),
		list("Vertical Grip", 9.5, /obj/item/attachable/verticalgrip, VENDOR_ITEM_REGULAR),

		list("STOCK", -1, null, null),
		list("M37 Wooden Stock", 4.5, /obj/item/attachable/stock/shotgun, VENDOR_ITEM_REGULAR),
		list("M39 Arm Brace", 4.5, /obj/item/attachable/stock/smg/collapsible/brace, VENDOR_ITEM_REGULAR),
		list("M39 Folding Stock", 4.5, /obj/item/attachable/stock/smg/collapsible, VENDOR_ITEM_REGULAR),
		list("M39 Stock", 4.5, /obj/item/attachable/stock/smg, VENDOR_ITEM_REGULAR),
		list("M41A Solid Stock", 4.5, /obj/item/attachable/stock/rifle, VENDOR_ITEM_REGULAR),
		list("M41A Folding Stock", 4.5, /obj/item/attachable/stock/rifle/collapsible, VENDOR_ITEM_REGULAR),
		list("M44 Magnum Sharpshooter Stock", 4.5, /obj/item/attachable/stock/revolver, VENDOR_ITEM_REGULAR)
		)

/obj/structure/machinery/cm_vending/sorted/attachments/blend
	icon_state = "req_attach_wall"
	vend_delay = 3
	vend_sound = 'sound/machines/vending_drop.ogg'
	tiles_with = list(
		/obj/structure/window/framed/almayer,
		/obj/structure/machinery/door/airlock,
		/turf/closed/wall/almayer,
	)

//------------UNIFORM VENDOR---------------

/obj/structure/machinery/cm_vending/sorted/uniform_supply
	name = "\improper Раздатчик униформы «КолМорТех»" // SS220 - EDIT
	desc = "An automated supply rack hooked up to a big storage of standard marine uniforms. Can be accessed by the Quartermaster and Cargo Technicians."
	icon_state = "clothing"
	req_access = list()
	req_one_access = list(ACCESS_MARINE_CARGO)
	vendor_theme = VENDOR_THEME_USCM

	listed_products = list(
		list("УНИФОРМА", -1, null, null), // SS220 - EDIT
		list("Униформа ККМП", 20, /obj/item/clothing/under/marine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Униформа техника ККМП", 5, /obj/item/clothing/under/marine/engineer, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Униформа санитара ККМП", 5, /obj/item/clothing/under/marine/medic, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("БОТИНКИ", -1, null, null), // SS220 - EDIT
		list("Ботинки пехотинца", 20, /obj/item/clothing/shoes/marine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коричневые ботинки пехотинца", 5, /obj/item/clothing/shoes/marine/brown, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Зелёные ботинки пехотинца", 5, /obj/item/clothing/shoes/marine/jungle, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Серые ботинки пехотинца", 5, /obj/item/clothing/shoes/marine/grey, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Урбанистские ботинки пехотинца", 5, /obj/item/clothing/shoes/marine/urban, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("РЮКЗАКИ", -1, null, null), // SS220 - EDIT
		list("Военный лёгкий рюкзак", 20, /obj/item/storage/backpack/marine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ранец ККМП", 20, /obj/item/storage/backpack/marine/satchel, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Разгрузочная система ККМП", 10, /obj/item/storage/backpack/marine/satchel/chestrig, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Рюкзак техника ККМП", 10, /obj/item/storage/backpack/marine/tech, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Разгрузочная система техника ККМП", 10, /obj/item/storage/backpack/marine/satchel/tech, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Рюкзак санитара ККМП", 10, /obj/item/storage/backpack/marine/medic, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ранец санитара ККМП", 10, /obj/item/storage/backpack/marine/satchel/medic, VENDOR_ITEM_REGULAR), // SS220 - EDIT


		list("БРОНЯ", -1, null, null), // SS220 - EDIT
		list("Шлем пехотинца М10", 20, /obj/item/clothing/head/helmet/marine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Шлем техника М10", 20, /obj/item/clothing/head/helmet/marine/tech, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Шлем санитара М10", 20, /obj/item/clothing/head/helmet/marine/medic, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца с лямками M3", 20, /obj/item/clothing/suit/storage/marine/medium/carrier, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца с подкладками M3", 20, /obj/item/clothing/suit/storage/marine/medium/padded, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца без подкладок M3", 20, /obj/item/clothing/suit/storage/marine/medium/padless, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца с гофрой M3", 20, /obj/item/clothing/suit/storage/marine/medium/padless_lines, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца с черепом M3", 20, /obj/item/clothing/suit/storage/marine/medium/skull, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца с подгонкой M3", 20, /obj/item/clothing/suit/storage/marine/medium/smooth, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца тяжёлая M3-EOD", 10, /obj/item/clothing/suit/storage/marine/heavy, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Броня пехотинца лёгкая M3-L", 10, /obj/item/clothing/suit/storage/marine/light, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("ПЕРЧАТКИ", -1, null, null), // SS220 - EDIT
		list("Перчатки пехотинца", 40, /obj/item/clothing/gloves/marine, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Чёрные перчатки пехотинца", 40, /obj/item/clothing/gloves/marine/black, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Коричневые перчатки пехотинца", 20, /obj/item/clothing/gloves/marine/brown, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Серые перчатки пехотинца", 20, /obj/item/clothing/gloves/marine/grey, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("СВЯЗЬ", -1, null, null), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — отряд «Альфа»", 5, /obj/item/device/encryptionkey/alpha, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — отряд «Браво»", 5, /obj/item/device/encryptionkey/bravo, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — отряд «Чарли»", 5, /obj/item/device/encryptionkey/charlie, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — отряд «Дельта»", 5, /obj/item/device/encryptionkey/delta, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — отряд «Эхо»", 5, /obj/item/device/encryptionkey/echo, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — инженерный", 5, /obj/item/device/encryptionkey/engi, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — разведка", 5, /obj/item/device/encryptionkey/intel, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — ОПАН", 5, /obj/item/device/encryptionkey/jtac, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — медицинский", 5, /obj/item/device/encryptionkey/med, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — охрана", 8, /obj/item/device/encryptionkey/sentry_laptop, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Гарнитура пехотинца", 5, /obj/item/device/radio/headset/almayer, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Ключ шифрования для гарнитуры — обеспечение", 5, /obj/item/device/encryptionkey/req, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("МАСКИ", -1, null, null, null), // SS220 - EDIT
		list("Противогаз", 20, /obj/item/clothing/mask/gas, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Инфракрасная балаклава", 10, /obj/item/clothing/mask/rebreather/scarf, VENDOR_ITEM_REGULAR), // SS220 - EDIT

		list("ДРУГОЕ", -1, null, null), // SS220 - EDIT
		list("Ballistic goggles", 10, /obj/item/clothing/glasses/mgoggles, VENDOR_ITEM_REGULAR),
		list("M1A1 Ballistic goggles", 10, /obj/item/clothing/glasses/mgoggles/v2, VENDOR_ITEM_REGULAR),
		list("Prescription ballistic goggles", 10, /obj/item/clothing/glasses/mgoggles/prescription, VENDOR_ITEM_REGULAR),
		list("Marine RPG glasses", 10, /obj/item/clothing/glasses/regular, VENDOR_ITEM_REGULAR),
		list("M5 Integrated Gas Mask", 10, /obj/item/prop/helmetgarb/helmet_gasmask, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Netting", 10, /obj/item/prop/helmetgarb/netting, VENDOR_ITEM_REGULAR),
		list("M10 Helmet Rain Cover", 10, /obj/item/prop/helmetgarb/raincover, VENDOR_ITEM_REGULAR),
		list("Attachable Dogtags", 15, /obj/item/clothing/accessory/dogtags, VENDOR_ITEM_REGULAR),
		list("USCM Flair", 15, /obj/item/prop/helmetgarb/flair_uscm, VENDOR_ITEM_REGULAR),
		list("Falling Falcons Shoulder Patch", 15, /obj/item/clothing/accessory/patch/falcon, VENDOR_ITEM_REGULAR),
		list("Falling Falcons UA Shoulder Patch", 15, /obj/item/clothing/accessory/patch/falconalt, VENDOR_ITEM_REGULAR),
		list("USCM Large Chest Patch", 15, /obj/item/clothing/accessory/patch/uscmlarge, VENDOR_ITEM_REGULAR),
		list("USCM Shoulder Patch", 15, /obj/item/clothing/accessory/patch, VENDOR_ITEM_REGULAR),
		list("United Americas Shoulder patch", 10, /obj/item/clothing/accessory/patch/ua, VENDOR_ITEM_REGULAR),
		list("United Americas Flag Shoulder patch", 10, /obj/item/clothing/accessory/patch/uasquare, VENDOR_ITEM_REGULAR),
		list("Спальник", 30, /obj/item/roller/bedroll, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		list("Камера с креплением на голову М5", 15, /obj/item/device/overwatch_camera, VENDOR_ITEM_REGULAR), // SS220 - EDIT
		)

/obj/structure/machinery/cm_vending/sorted/uniform_supply/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/structure/machinery/cm_vending/sorted/uniform_supply/populate_product_list(scale)
	return

/obj/structure/machinery/cm_vending/sorted/uniform_supply/vend_fail()
	return

/obj/structure/machinery/cm_vending/sorted/uniform_supply/stock(obj/item/item_to_stock, mob/user)
	var/list/R
	for(R in (listed_products))
		if(item_to_stock.type == R[3] && !istype(item_to_stock,/obj/item/storage))
			//Marine armor handling
			if(istype(item_to_stock, /obj/item/clothing/suit/storage/marine))
				var/obj/item/clothing/suit/storage/marine/AR = item_to_stock
				if(AR.pockets && length(AR.pockets.contents))
					to_chat(user, SPAN_WARNING("\The [AR] has something inside it. Empty it before restocking."))
					return
			//Marine helmet handling
			else if(istype(item_to_stock, /obj/item/clothing/head/helmet/marine))
				var/obj/item/clothing/head/helmet/marine/H = item_to_stock
				if(H.pockets && length(H.pockets.contents))
					to_chat(user, SPAN_WARNING("\The [H] has something inside it. Empty it before restocking."))
					return

			if(item_to_stock.loc == user) //Inside the mob's inventory
				if(item_to_stock.flags_item & WIELDED)
					item_to_stock.unwield(user)
				user.temp_drop_inv_item(item_to_stock)

			if(isstorage(item_to_stock.loc)) //inside a storage item
				var/obj/item/storage/S = item_to_stock.loc
				S.remove_from_storage(item_to_stock, user.loc)

			qdel(item_to_stock)
			user.visible_message(SPAN_NOTICE("[user] stocks \the [src] with \a [R[1]]."),
			SPAN_NOTICE("You stock \the [src] with \a [R[1]]."))
			R[2]++
			if(vend_flags & VEND_LOAD_AMMO_BOXES)
				update_derived_ammo_and_boxes_on_add(R)
			updateUsrDialog()
			return //We found our item, no reason to go on.

//------------TRAINING WEAPONS RACK---------------

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/training //Nonlethal stuff for events.
	name = "\improper ColMarTech Automated Training Weapons Rack"
	desc = "An automated weapon rack hooked up to a big storage of standard-issue weapons and non-lethal ammunition."

/obj/structure/machinery/cm_vending/sorted/cargo_guns/squad_prep/training/populate_product_list(scale)
	listed_products = list(
		list("ОСНОВНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Штурмовой карабин M4RA", floor(scale * 10), /obj/item/weapon/gun/rifle/m4ra, VENDOR_ITEM_REGULAR),
		list("Помповый дробовик M37A2", floor(scale * 15), /obj/item/weapon/gun/shotgun/pump, VENDOR_ITEM_REGULAR),
		list("Пистолет-пулемет M39", floor(scale * 30), /obj/item/weapon/gun/smg/m39, VENDOR_ITEM_REGULAR),
		list("Импульсная винтовка M41A MK2", floor(scale * 30), /obj/item/weapon/gun/rifle/m41a, VENDOR_ITEM_RECOMMENDED),

		list("ОСНОВНОЕ НЕЛЕТАЛЬНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Box of Beanbag Shells (12g)", floor(scale * 15), /obj/item/ammo_magazine/shotgun/beanbag, VENDOR_ITEM_REGULAR),
		list("M4RA Rubber Magazine (10x24mm)", floor(scale * 15), /obj/item/ammo_magazine/rifle/m4ra/rubber, VENDOR_ITEM_REGULAR),
		list("M39 Rubber Magazine (10x20mm)", floor(scale * 25), /obj/item/ammo_magazine/smg/m39/rubber, VENDOR_ITEM_REGULAR),
		list("M41A Rubber Magazine (10x24mm)", floor(scale * 25), /obj/item/ammo_magazine/rifle/rubber, VENDOR_ITEM_REGULAR),

		list("ДОПОЛНИТЕЛЬНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("Боевой пистолет 88 Mod 4", floor(scale * 25), /obj/item/weapon/gun/pistol/mod88, VENDOR_ITEM_REGULAR),
		list("Служебный пистолет M4A3", floor(scale * 25), /obj/item/weapon/gun/pistol/m4a3, VENDOR_ITEM_REGULAR),

		list("ДОПОЛНИТЕЛЬНОЕ НЕЛЕТАЛЬНОЕ ВООРУЖЕНИЕ", -1, null, null),
		list("88M4 Rubber Magazine (9mm)", floor(scale * 25), /obj/item/ammo_magazine/pistol/mod88/rubber, VENDOR_ITEM_REGULAR),
		list("M4A3 Rubber Magazine (9mm)", floor(scale * 25), /obj/item/ammo_magazine/pistol/rubber, VENDOR_ITEM_REGULAR),

		list("ATTACHMENTS", -1, null, null),
		list("Rail Flashlight", floor(scale * 25), /obj/item/attachable/flashlight, VENDOR_ITEM_RECOMMENDED),
		list("Underbarrel Flashlight Grip", floor(scale * 10), /obj/item/attachable/flashlight/grip, VENDOR_ITEM_RECOMMENDED),
		list("Underslung Grenade Launcher", floor(scale * 25), /obj/item/attachable/attached_gun/grenade, VENDOR_ITEM_REGULAR), //They already get these as on-spawns, might as well formalize some spares.

		list("UTILITIES", -1, null, null),
		list("M07 Training Grenade", floor(scale * 15), /obj/item/explosive/grenade/high_explosive/training, VENDOR_ITEM_REGULAR),
		list("M15 Rubber Pellet Grenade", floor(scale * 10), /obj/item/explosive/grenade/high_explosive/m15/rubber, VENDOR_ITEM_REGULAR),
		list("M5 Bayonet", floor(scale * 25), /obj/item/attachable/bayonet, VENDOR_ITEM_REGULAR),
		list("M94 Marking Flare Pack", floor(scale * 10), /obj/item/storage/box/m94, VENDOR_ITEM_RECOMMENDED)
	)
