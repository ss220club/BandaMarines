/datum/job/command/tank_crew/set_spawn_positions(count)
	if (length(GLOB.clients) >= 40)
		spawn_positions = 2
	else
		spawn_positions = 0

/datum/job/command/tank_crew/get_total_positions(latejoin = TRUE)
	if(length(GLOB.clients) >= 40 || total_positions_so_far > 0)
		return 2

	return 0

GLOBAL_LIST_INIT(cm_vending_vehicle_crew_tank_spare, list(
	list("STARTING KIT SELECTION:", 0, null, null, null),

	list("INTEGRAL PARTS", 0, null, null, null),
	list("M34A2-A Multipurpose Turret", 200, /obj/effect/essentials_set/tank/turret, null, VENDOR_ITEM_REGULAR),

	list("PRIMARY WEAPON", 0, null, null, null),
	list("AC3-E Autocannon", 200, /obj/effect/essentials_set/tank/autocannon, null, VENDOR_ITEM_REGULAR),
	list("DRG-N Offensive Flamer Unit", 300, /obj/effect/essentials_set/tank/dragonflamer, null, VENDOR_ITEM_REGULAR),
	list("LTAA-AP Minigun", 300, /obj/effect/essentials_set/tank/gatling, null, VENDOR_ITEM_REGULAR),
	list("LTB Cannon", 500, /obj/effect/essentials_set/tank/ltb, null, VENDOR_ITEM_RECOMMENDED),

	list("SECONDARY WEAPON", 0, null, null, null),
	list("M92T Grenade Launcher", 300, /obj/effect/essentials_set/tank/tankgl, null, VENDOR_ITEM_REGULAR),
	list("M56 Cupola", 200, /obj/effect/essentials_set/tank/m56cupola, null, VENDOR_ITEM_REGULAR),
	list("LZR-N Flamer Unit", 200, /obj/effect/essentials_set/tank/tankflamer, null, VENDOR_ITEM_REGULAR),
	list("TOW Launcher", 400, /obj/effect/essentials_set/tank/tow, null, VENDOR_ITEM_RECOMMENDED),

	list("SUPPORT MODULE", 0, null, null, null),
	list("Artillery Module", 300, /obj/item/hardpoint/support/artillery_module, null, VENDOR_ITEM_REGULAR),
	list("Integrated Weapons Sensor Array", 300, /obj/item/hardpoint/support/weapons_sensor, null, VENDOR_ITEM_REGULAR),
	list("Overdrive Enhancer", 300, /obj/item/hardpoint/support/overdrive_enhancer, null, VENDOR_ITEM_RECOMMENDED),

	list("ARMOR", 0, null, null, null),
	list("External snowplow", 200, /obj/item/hardpoint/armor/snowplow, null, VENDOR_ITEM_REGULAR),
	list("Ballistic external armor", 200, /obj/item/hardpoint/armor/ballistic, null, VENDOR_ITEM_REGULAR),
	list("Caustic external armor", 200, /obj/item/hardpoint/armor/caustic, null, VENDOR_ITEM_REGULAR),
	list("Concussive external armor", 200, /obj/item/hardpoint/armor/concussive, null, VENDOR_ITEM_REGULAR),
	list("Paladin external armor", 200, /obj/item/hardpoint/armor/paladin, null, VENDOR_ITEM_REGULAR),

	list("TREADS", 0, null, null, null),
	list("Reinforced Treads", 200, /obj/item/hardpoint/locomotion/treads/robust, null, VENDOR_ITEM_REGULAR),
	list("Treads", 200, /obj/item/hardpoint/locomotion/treads, null, VENDOR_ITEM_REGULAR)))
