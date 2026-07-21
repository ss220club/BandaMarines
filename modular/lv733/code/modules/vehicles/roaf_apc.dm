// Планируется

/obj/vehicle/multitile/apc_roaf
	name = "\improper Type 16-7/E MCV"
	desc = "Тренировачный колесный десантный танк Type 16//D-2. Маневренная модификация с 105 мм пушкой и улучшнным двигателем."

	icon = 'modular/lv733/icons/roaf_apc/type16_hull.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 96
	bound_height = 96

	bound_x = -32
	bound_y = -32

	interior_map = /datum/map_template/interior/apc

	passengers_slots = 15
	xenos_slots = 8

	entrances = list(
		"left" = list(2, 0),
		"right" = list(-2, 0),
		"rear left" = list(1, 2),
		"rear center" = list(0, 2),
		"rear right" = list(-1, 2)
	)

	entrance_speed = 0.5 SECONDS
	required_skill = SKILL_VEHICLE_LARGE
	movement_sound = 'sound/vehicles/tank_driving.ogg'

	var/gunner_view_buff = 10

	hardpoints_allowed = list(
		/obj/item/hardpoint/holder/tank_turret/roaf,
		/obj/item/hardpoint/armor/ballistic/roaf,
		/obj/item/hardpoint/support/overdrive_enhancer/roaf,
		/obj/item/hardpoint/support/flare_launcher,
		/obj/item/hardpoint/locomotion/apc_wheels/roaf,
	)

	seats = list(VEHICLE_DRIVER = null, VEHICLE_GUNNER = null, VEHICLE_SUPPORT_GUNNER_ONE = null, VEHICLE_SUPPORT_GUNNER_TWO = null)
	active_hp = list(VEHICLE_DRIVER = null, VEHICLE_GUNNER = null, VEHICLE_SUPPORT_GUNNER_ONE = null, VEHICLE_SUPPORT_GUNNER_TWO = null)

	vehicle_flags = VEHICLE_CLASS_LIGHT
	mob_size_required_to_hit = MOB_SIZE_XENO

	// Чуть хуже, чем у обычного M577 (bullet 0.6/explosive 0.7/blunt 0.7/slash 0.8) - плата за башню.
	dmg_multipliers = list(
		"all" = 1, "acid" = 1.65, "slash" = 0.85, "bullet" = 0.65, "explosive" = 0.75, "blunt" = 0.75, "abstract" = 1
	)

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION
	minimap_icon_state = "apc"

/obj/vehicle/multitile/apc_roaf/initialize_cameras(change_tag = FALSE)
	if(!camera)
		camera = new /obj/structure/machinery/camera/vehicle(src)
	if(change_tag)
		camera.c_tag = "#[rand(1,100)] Type 16-7/E \"[nickname]\" MCV"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"
	else
		camera.c_tag = "#[rand(1,100)] Type 16-7/E MCV"
		if(camera_int)
			camera_int.c_tag = camera.c_tag + " interior"

/obj/vehicle/multitile/apc_roaf/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TWE_RAF_RIFLEMAN, JOB_TWE_RAF_SQUAD_LEADER, JOB_TWE_ROAF_ENGI, JOB_TWE_ROAF_PILOT)
	RRS.total = 2
	role_reserved_slots += RRS

	RRS = new
	RRS.category_name = "Synthetic Unit"
	RRS.roles = list(JOB_TWE_ROAF_SYNTH)
	RRS.total = 1
	role_reserved_slots += RRS

/obj/vehicle/multitile/apc_roaf/add_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	add_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide
	))
	if(seat == VEHICLE_DRIVER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/name_vehicle
		))
	else if(seat == VEHICLE_GUNNER)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
			/obj/vehicle/multitile/proc/name_vehicle
		))
	else if(seat == VEHICLE_SUPPORT_GUNNER_ONE || seat == VEHICLE_SUPPORT_GUNNER_TWO)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/reload_firing_port_weapon
		))

/obj/vehicle/multitile/apc_roaf/remove_seated_verbs(mob/living/M, seat)
	if(!M.client)
		return
	remove_verb(M.client, list(
		/obj/vehicle/multitile/proc/get_status_info,
		/obj/vehicle/multitile/proc/open_controls_guide,
	))
	SStgui.close_user_uis(M, src)
	if(seat == VEHICLE_DRIVER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/toggle_door_lock,
			/obj/vehicle/multitile/proc/activate_horn,
			/obj/vehicle/multitile/proc/name_vehicle,
		))
	else if(seat == VEHICLE_GUNNER)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/switch_hardpoint,
			/obj/vehicle/multitile/proc/cycle_hardpoint,
			/obj/vehicle/multitile/proc/toggle_gyrostabilizer,
			/obj/vehicle/multitile/proc/name_vehicle,
		))
	else if(seat == VEHICLE_SUPPORT_GUNNER_ONE || seat == VEHICLE_SUPPORT_GUNNER_TWO)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/reload_firing_port_weapon
		))

// У БТР нет своего relaymove() - копия версии с танка (tank.dm), только колёса вместо гусениц,
// иначе наводчик не сможет поворачивать башню, а водитель не проедет без колёс.
/obj/vehicle/multitile/apc_roaf/relaymove(mob/user, direction)
	if(user == seats[VEHICLE_DRIVER])
		if(!(locate(/obj/item/hardpoint/locomotion/apc_wheels) in hardpoints))
			return FALSE
		return ..()

	if(user != seats[VEHICLE_GUNNER])
		return FALSE

	var/obj/item/hardpoint/holder/tank_turret/T = null
	for(var/obj/item/hardpoint/holder/tank_turret/TT in hardpoints)
		T = TT
		break
	if(!T)
		return FALSE

	if(direction == GLOB.reverse_dir[T.dir] || direction == T.dir)
		return FALSE

	T.user_rotation(user, turning_angle(T.dir, direction))
	update_icon()

	return TRUE

// Бронеплита - чуть хуже штатной танковой (0.67/0.67/0.9), но всё так же снимается ломом.
// Своей иконки у неё нет (не входит в список видимых узлов) - использует штатную танковую.
/obj/item/hardpoint/armor/ballistic/roaf
	name = "\improper Облегчённая бронеплита Type 16-7/E"
	desc = "Упрощённая версия танковой брони, облегчённая под шасси БТР. Хуже держит удар, чем полноценная танковая пластина."
	type_multipliers = list("bullet" = 0.78, "slash" = 0.78, "all" = 0.95)

// Своя турель - у штатной tank_turret accepted_hardpoints - это ОБЩИЙ на все танки список, куда наш
// cannon/roaf не входит (сравнение по точному типу, а не istype) - без этого подтипа откреплённую
// пушку было бы невозможно поставить обратно. Своя иконка - см. комментарий в начале файла.
/obj/item/hardpoint/holder/tank_turret/roaf
	name = "\improper Турель Type 16-7/E"
	icon = 'modular/lv733/icons/roaf_apc/type16_turret.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_turret.dmi'
	accepted_hardpoints = list(
		/obj/item/hardpoint/primary/flamer,
		/obj/item/hardpoint/primary/cannon,
		/obj/item/hardpoint/primary/cannon/roaf,
		/obj/item/hardpoint/primary/minigun,
		/obj/item/hardpoint/primary/autocannon,
		/obj/item/hardpoint/secondary/small_flamer,
		/obj/item/hardpoint/secondary/towlauncher,
		/obj/item/hardpoint/secondary/m56cupola,
		/obj/item/hardpoint/secondary/grenade_launcher,
	)

// Пушка - чуть сильнее танковой LTB (урон 25 -> 30, перезарядка 20с -> 17с). Снимается ломом как обычная
// деталь (SIZE_LARGE) - лома не хватает только на саму башню (SIZE_MASSIVE, нужна клешня погрузчика).
// Своя иконка - см. комментарий в начале файла.
/obj/item/hardpoint/primary/cannon/roaf
	name = "\improper 120-мм пушка Type 16-7/E"
	desc = "Модификация танковой LTB-пушки с усиленным зарядом и облегчённым затвором для более частой стрельбы."
	icon = 'modular/lv733/icons/roaf_apc/type16_cannon_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_cannon_mounted.dmi'
	ammo = new /obj/item/ammo_magazine/hardpoint/ltb_cannon/roaf
	fire_delay = 17 SECONDS

/obj/item/ammo_magazine/hardpoint/ltb_cannon/roaf
	default_ammo = /datum/ammo/rocket/ltb/roaf
	gun_type = /obj/item/hardpoint/primary/cannon/roaf
	icon = 'modular/lv733/icons/roaf_apc/type16_shell.dmi'

/datum/ammo/rocket/ltb/roaf
	name = "Type 16-7/E cannon round"
	damage = 30

// Свои колёса - чисто под свою иконку (см. комментарий в начале файла), характеристики те же, что у apc_wheels.
/obj/item/hardpoint/locomotion/apc_wheels/roaf
	name = "\improper Колёса Type 16-7/E"
	icon = 'modular/lv733/icons/roaf_apc/type16_wheels_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_wheels_mounted.dmi'

// Двигатель - штатный "ускоритель" с танка (даёт +20% скорости, см. apply_buff/remove_buff в
// code/modules/vehicles/hardpoints/support/overdrive.dm), просто переименован и со своей иконкой.
// Ставится сразу при спавне (см. load_hardpoints ниже), как и остальные видимые узлы - можно снять ломом.
/obj/item/hardpoint/support/overdrive_enhancer/roaf
	name = "\improper Двигатель Type 16-7/E"
	icon = 'modular/lv733/icons/roaf_apc/type16_engine_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_engine_mounted.dmi'

/*
** ПРЕСЕТ СПАВНА
*/
/obj/effect/vehicle_spawner/apc_roaf
	name = "Type 16-7/E MCV Spawner"
	icon = 'modular/lv733/icons/roaf_apc/type16_hull.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/apc_roaf/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/apc_roaf/spawn_vehicle()
	var/obj/vehicle/multitile/apc_roaf/APC = new(loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

	return APC

/obj/effect/vehicle_spawner/apc_roaf/load_hardpoints(obj/vehicle/multitile/apc_roaf/V)
	V.add_hardpoint(new /obj/item/hardpoint/armor/ballistic/roaf)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/roaf)
	V.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer/roaf)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/roaf)
	// install() требует живого игрока и do_after() - для спавна используем add_hardpoint() холдера напрямую,
	// как это делают штатные танковые пресеты (см. /obj/effect/vehicle_spawner/tank/fixed в tank.dm).
	for(var/obj/item/hardpoint/holder/tank_turret/TT in V.hardpoints)
		TT.add_hardpoint(new /obj/item/hardpoint/primary/cannon/roaf)
		break
