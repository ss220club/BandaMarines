/obj/vehicle/multitile/modul/humvee/apc
	name = "\improper Бронеавтомобиль M2420 JTMV-HWC"
	desc = "Многоцелевой бронеавтомобиль M2420 JTMV. Легкобронированная машина. Входы сзади и по бокам."

// Прочность и модификаторы урона
	health = 500

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	interior_map = /datum/map_template/interior/modul/humvee/apc
	minimap_icon_state = "humvee"

	passengers_slots =  2 // танкисты всегда имеют 2 слота и не занимают passengers_slots
	revivable_dead_slots = 2 // нужно на случай если танкисты умрут и нужно будет их достать
	xenos_slots = 3

	required_skill = SKILL_VEHICLE_LARGE

	has_overdrive = FALSE
	allow_squeeze_under = FALSE

	misc_multipliers = list(
		"move" = 0.8, 
		"accuracy" = 1,
		"cooldown" = 1
	)

	entrances = list(
		"right" = list(-2, -1),
		"left" = list(1, -1),
		"back left" = list(1, 0),
		"back right" = list(-2, 0),
	)

/obj/vehicle/multitile/modul/humvee/apc/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TANK_CREW, JOB_WO_CREWMAN, JOB_UPP_CREWMAN, JOB_PMC_CREWMAN)
	RRS.total = 2
	role_reserved_slots += RRS

/obj/vehicle/multitile/modul/humvee/apc/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] Бронеавтомобиль M2420 \"[nickname]\" JTMV-HWC" //this fluff allows it to be at the start of cams list
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " интерьер" //this fluff allows it to be at the start of cams list
	else
		camera.c_tag = "#[rand(1,100)] Бронеавтомобиль M2420 JTMV-HWC"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " интерьер" //this fluff allows it to be at the start of cams list

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/humvee_wheels,
		/obj/item/hardpoint/holder/humvee_turret,
		/obj/item/hardpoint/armor/humvee_snowplow,
		/obj/item/hardpoint/support/humvee_overhead_lights,
		/obj/item/hardpoint/primary/humvee_hatch,
	)

