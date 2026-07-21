/obj/vehicle/multitile/apc_rac
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
		/obj/item/hardpoint/holder/tank_turret/rac,
		/obj/item/hardpoint/support/overdrive_enhancer/rac,
		/obj/item/hardpoint/locomotion/apc_wheels/rac,
	)

	seats = list(VEHICLE_DRIVER = null, VEHICLE_GUNNER = null, VEHICLE_SUPPORT_GUNNER_ONE = null, VEHICLE_SUPPORT_GUNNER_TWO = null)
	active_hp = list(VEHICLE_DRIVER = null, VEHICLE_GUNNER = null, VEHICLE_SUPPORT_GUNNER_ONE = null, VEHICLE_SUPPORT_GUNNER_TWO = null)

	vehicle_flags = VEHICLE_CLASS_LIGHT
	mob_size_required_to_hit = MOB_SIZE_XENO

	dmg_multipliers = list(
		"all" = 1, "acid" = 1.65, "slash" = 0.85, "bullet" = 0.65, "explosive" = 0.75, "blunt" = 0.75, "abstract" = 1
	)

	move_max_momentum = 2
	move_momentum_build_factor = 1.5
	move_turn_momentum_loss_factor = 0.8

	vehicle_ram_multiplier = VEHICLE_TRAMPLE_DAMAGE_APC_REDUCTION
	minimap_icon_state = "apc"

/obj/vehicle/multitile/apc_rac/initialize_cameras(change_tag = FALSE)
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

/obj/vehicle/multitile/apc_rac/load_role_reserved_slots()
	var/datum/role_reserved_slots/RRS = new
	RRS.category_name = "Crewmen"
	RRS.roles = list(JOB_TWE_RAC_RIFLEMAN, JOB_TWE_RAC_SQUAD_LEADER, JOB_TWE_RAC_ENGI, JOB_TWE_RAC_DRIVER)
	RRS.total = 2
	role_reserved_slots += RRS

	RRS = new
	RRS.category_name = "Synthetic Unit"
	RRS.roles = list(JOB_TWE_RAC_SYNTH)
	RRS.total = 1
	role_reserved_slots += RRS

/obj/vehicle/multitile/apc_rac/add_seated_verbs(mob/living/M, seat)
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
			/obj/vehicle/multitile/proc/name_vehicle,
			/obj/vehicle/multitile/apc_rac/proc/toggle_cannon_lob_mode,
			/obj/vehicle/multitile/apc_rac/proc/toggle_gunner_optics,
		))
	else if(seat == VEHICLE_SUPPORT_GUNNER_ONE || seat == VEHICLE_SUPPORT_GUNNER_TWO)
		add_verb(M.client, list(
			/obj/vehicle/multitile/proc/reload_firing_port_weapon
		))

/obj/vehicle/multitile/apc_rac/remove_seated_verbs(mob/living/M, seat)
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
			/obj/vehicle/multitile/apc_rac/proc/toggle_cannon_lob_mode,
			/obj/vehicle/multitile/apc_rac/proc/toggle_gunner_optics,
		))
	else if(seat == VEHICLE_SUPPORT_GUNNER_ONE || seat == VEHICLE_SUPPORT_GUNNER_TWO)
		remove_verb(M.client, list(
			/obj/vehicle/multitile/proc/reload_firing_port_weapon
		))

/obj/vehicle/multitile/apc_rac/relaymove(mob/user, direction)
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

/obj/vehicle/multitile/apc_rac/proc/toggle_cannon_lob_mode()
	set name = "Toggle Cannon Fire Mode"
	set desc = "Переключает орудие между настильной стрельбой по прямой и навесной стрельбой поверх препятствий."
	set category = "Vehicle"

	var/mob/M = usr
	if(!M || !istype(M))
		return
	var/obj/vehicle/multitile/V = M.interactee
	if(!istype(V, /obj/vehicle/multitile/apc_rac))
		return

	var/obj/item/hardpoint/primary/cannon/rac/C = null
	for(var/obj/item/hardpoint/holder/tank_turret/rac/TT in V.hardpoints)
		for(var/obj/item/hardpoint/primary/cannon/rac/CC in TT.hardpoints)
			C = CC
			break
		break
	if(!C)
		return
	C.toggle_lob_mode(M)

/obj/vehicle/multitile/apc_rac/proc/toggle_gunner_optics()
	set name = "Toggle Gunner Optics"
	set desc = "Переключает оптику наводчика."
	set category = "Vehicle"

	var/mob/living/M = usr
	if(!M || !istype(M))
		return
	if(M != seats[VEHICLE_GUNNER])
		return

	var/obj/item/hardpoint/holder/tank_turret/rac/T = null
	for(var/obj/item/hardpoint/holder/tank_turret/rac/TT in hardpoints)
		T = TT
		break
	if(!T)
		return
	T.toggle_optics(M)

/obj/item/hardpoint/holder/tank_turret/rac
	name = "\improper Турель Type 16-7/E"
	icon = 'modular/lv733/icons/roaf_apc/type16_turret.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_turret.dmi'
	accepted_hardpoints = list(
		/obj/item/hardpoint/primary/cannon/rac,
		/obj/item/hardpoint/secondary/m56cupola/rac,
	)

/obj/item/hardpoint/holder/tank_turret/rac/proc/toggle_optics(mob/living/user)
	if(zoom)
		unzoom(user)
	else
		do_zoom(user, 11, 12)

// Пушка - чуть сильнее танковой LTB (перезарядка 20с -> 17с)
/obj/item/hardpoint/primary/cannon/rac
	name = "\improper 105-мм пушка Type 16-7/E"
	desc = "Старая версия пушки с усиленным зарядом и облегчённым затвором для более частой стрельбы. Может стрелять как по настильной, так и по навесной траектории."
	icon = 'modular/lv733/icons/roaf_apc/type16_cannon_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_cannon_mounted.dmi'
	ammo = new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/shrapnel
	fire_delay = 17 SECONDS
	max_clips = 1
	var/is_lobbing = FALSE

/obj/item/hardpoint/primary/cannon/rac/generate_bullet(mob/user, turf/origin_turf)
	. = ..()
	if(is_lobbing)
		var/obj/projectile/P = .
		P.projectile_override_flags |= AMMO_HITS_TARGET_TURF

/obj/item/hardpoint/primary/cannon/rac/proc/toggle_lob_mode(mob/user)
	is_lobbing = !is_lobbing
	to_chat(user, SPAN_NOTICE("Вы переключаете [name] на [is_lobbing ? "навесную стрельбу поверх препятствий" : "настильную стрельбу по прямой"]."))
	playsound(owner, 'sound/machines/click.ogg', 15, 1)

/obj/item/ammo_magazine/hardpoint/ltb_cannon/rac
	gun_type = /obj/item/hardpoint/primary/cannon/rac
	icon = 'modular/lv733/icons/roaf_apc/type16_shell.dmi'

/obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/shrapnel
	name = "\improper Type 16-7/E shrapnel round"
	desc = "Осколочный снаряд, разрывается облаком осколков в радиусе 5 метров. Эффективен против пехоты и лёгких целей."
	default_ammo = /datum/ammo/rocket/rac_shrapnel

/obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/ap
	name = "\improper Type 16-7/E armor-piercing round"
	desc = "Бронебойный снаряд, способен проламывать стены. Эффективен против бронированных целей."
	default_ammo = /datum/ammo/rocket/rac_ap

/obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/incendiary
	name = "\improper Type 16-7/E incendiary round"
	desc = "Зажигательный фосфорный снаряд. Оставляет очаг липкого огня и облако едкого фосфорного дыма. Низкий прямой урон."
	default_ammo = /datum/ammo/rocket/rac_incendiary

// Ящики на 5 снарядов - для переноски россыпью хватает и одиночных магазинов-снарядов выше
/obj/structure/closet/crate/ammo/rac_shrapnel
	name = "\improper ящик со шрапнельными снарядами Type 16-7/E"
	desc = "Ящик, в котором лежат 5 осколочных снарядов для пушки Type 16-7/E."

/obj/structure/closet/crate/ammo/rac_shrapnel/Initialize(mapload, ...)
	. = ..()
	for(var/i in 1 to 5)
		new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/shrapnel(src)

/obj/structure/closet/crate/ammo/rac_ap
	name = "\improper ящик с бронебойными снарядами Type 16-7/E"
	desc = "Ящик, в котором лежат 5 бронебойных снарядов для пушки Type 16-7/E."

/obj/structure/closet/crate/ammo/rac_ap/Initialize(mapload, ...)
	. = ..()
	for(var/i in 1 to 5)
		new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/ap(src)

/obj/structure/closet/crate/ammo/alt/flame/rac_incendiary
	name = "\improper ящик с зажигательными снарядами Type 16-7/E"
	desc = "Ящик, в котором лежат 5 зажигательных фосфорных снарядов для пушки Type 16-7/E."

/obj/structure/closet/crate/ammo/alt/flame/rac_incendiary/Initialize(mapload, ...)
	. = ..()
	for(var/i in 1 to 5)
		new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/incendiary(src)

// --- Осколочный снаряд ---
/datum/ammo/bullet/shrapnel/rac
	name = "Type 16-7/E shrapnel fragment"
	max_range = 3

/datum/ammo/rocket/rac_shrapnel
	name = "Type 16-7/E shrapnel round"
	icon_state = "ltb"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE
	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 32
	max_range = 32
	damage = 10 // прямое попадание слабое, основной урон - от осколков
	shell_speed = AMMO_SPEED_TIER_3

/datum/ammo/rocket/rac_shrapnel/on_hit_mob(mob/mob, obj/projectile/projectile)
	create_shrapnel(get_turf(mob), 40, shrapnel_spread = 360, shrapnel_type = /datum/ammo/bullet/shrapnel/rac, cause_data = projectile.weapon_cause_data)

/datum/ammo/rocket/rac_shrapnel/on_hit_obj(obj/object, obj/projectile/projectile)
	create_shrapnel(get_turf(object), 40, shrapnel_spread = 360, shrapnel_type = /datum/ammo/bullet/shrapnel/rac, cause_data = projectile.weapon_cause_data)

/datum/ammo/rocket/rac_shrapnel/on_hit_turf(turf/turf, obj/projectile/projectile)
	create_shrapnel(turf, 40, shrapnel_spread = 360, shrapnel_type = /datum/ammo/bullet/shrapnel/rac, cause_data = projectile.weapon_cause_data)

/datum/ammo/rocket/rac_shrapnel/do_at_max_range(obj/projectile/projectile)
	create_shrapnel(get_turf(projectile), 40, shrapnel_spread = 360, shrapnel_type = /datum/ammo/bullet/shrapnel/rac, cause_data = projectile.weapon_cause_data)

// --- Бронебойный снаряд ---
/datum/ammo/rocket/rac_ap
	name = "Type 16-7/E armor-piercing round"
	icon_state = "ltb"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE
	damage_falloff = 0
	accuracy = HIT_ACCURACY_TIER_8
	accurate_range = 32
	max_range = 32
	damage = 10
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/rocket/rac_ap/on_hit_mob(mob/mob, obj/projectile/projectile)
	mob.ex_act(150, projectile.dir, projectile.weapon_cause_data, 100)
	mob.apply_effect(3, WEAKEN)
	mob.apply_effect(3, PARALYZE)
	if(ishuman_strict(mob))
		mob.ex_act(300, null, projectile.weapon_cause_data, 100)
	cell_explosion(get_turf(mob), 100, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/rac_ap/on_hit_obj(obj/object, obj/projectile/projectile)
	object.ex_act(150, projectile.dir, projectile.weapon_cause_data, 100)
	cell_explosion(get_turf(object), 100, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/rac_ap/on_hit_turf(turf/turf, obj/projectile/projectile)
	turf.ex_act(150, projectile.dir, projectile.weapon_cause_data, 200)
	cell_explosion(turf, 100, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/rocket/rac_ap/do_at_max_range(obj/projectile/projectile)
	var/turf/turf = get_turf(projectile)
	turf.ex_act(150, projectile.dir, projectile.weapon_cause_data)
	cell_explosion(turf, 100, 50, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

// --- Зажигательный (фосфорный) снаряд ---
/datum/ammo/rocket/rac_incendiary
	name = "Type 16-7/E incendiary round"
	icon_state = "ltb"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE
	damage_type = BURN
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 32
	max_range = 32
	damage = 8 // низкий прямой урон - основной эффект от огня/фосфора

/datum/ammo/rocket/rac_incendiary/on_hit_mob(mob/mob, obj/projectile/projectile)
	spread_fire_and_smoke(get_turf(mob), projectile)

/datum/ammo/rocket/rac_incendiary/on_hit_obj(obj/object, obj/projectile/projectile)
	spread_fire_and_smoke(get_turf(object), projectile)

/datum/ammo/rocket/rac_incendiary/on_hit_turf(turf/turf, obj/projectile/projectile)
	spread_fire_and_smoke(turf, projectile)

/datum/ammo/rocket/rac_incendiary/do_at_max_range(obj/projectile/projectile)
	spread_fire_and_smoke(get_turf(projectile), projectile)

/datum/ammo/rocket/rac_incendiary/proc/spread_fire_and_smoke(turf/T, obj/projectile/projectile)
	flame_radius(projectile.weapon_cause_data, 3, T)
	var/datum/effect_system/smoke_spread/phosphorus/smoke = new
	smoke.set_up(6, 0, T, null, 10 SECONDS, projectile.weapon_cause_data)
	smoke.start()

// --- Спаренный пулемёт
/obj/item/hardpoint/secondary/m56cupola/rac
	name = "\improper Спаренный пулемёт Type 16-7/E"
	desc = "Спаренный пулемёт танка Type 16-7/E. Питается от отдельного, независимого от основного орудия боекомплекта."
	ammo = new /obj/item/ammo_magazine/hardpoint/rac_mg
	max_clips = 2

/obj/item/ammo_magazine/hardpoint/rac_mg
	name = "\improper магазин пулемёта Type 16-7/E"
	desc = "Уникальный боекомплект спаренного пулемёта Type 16-7/E."
	caliber = "10x28mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	icon_state = "cupola_1"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/machinegun/rac
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/m56cupola/rac

/obj/item/ammo_magazine/hardpoint/rac_mg/update_icon()
	icon_state = "cupola_[current_rounds <= 0 ? "0" : "1"]"

/datum/ammo/bullet/machinegun/rac
	name = "Type 16-7/E machinegun bullet"

/obj/item/hardpoint/locomotion/apc_wheels/rac
	name = "\improper Колёса Type 16-7/E"
	desc = "Комплект колёс Type 16-7/E. Обеспечивают высокую скорость хода, но плохо бронированы."
	icon = 'modular/lv733/icons/roaf_apc/type16_wheels_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_wheels_mounted.dmi'
	health = 150
	damage_multiplier = 2

/obj/item/hardpoint/support/overdrive_enhancer/rac
	name = "\improper Двигатель Type 16-7/E"
	desc = "Форсированный двигатель Type 16-7/E. Массивный и тяжело бронированный узел - снять его можно только клешнёй погрузчика. Выдерживает серьёзные повреждения прежде чем выйти из строя."
	icon = 'modular/lv733/icons/roaf_apc/type16_engine_held.dmi'
	disp_icon = 'modular/lv733/icons/roaf_apc/type16_engine_mounted.dmi'
	w_class = SIZE_MASSIVE
	health = 800
	damage_multiplier = 0.25

/obj/effect/vehicle_spawner/apc_rac
	name = "Type 16-7/E MCV Spawner"
	icon = 'modular/lv733/icons/roaf_apc/type16_hull.dmi'
	icon_state = "apc_base"
	pixel_x = -48
	pixel_y = -48

/obj/effect/vehicle_spawner/apc_rac/Initialize()
	. = ..()
	spawn_vehicle()
	qdel(src)

/obj/effect/vehicle_spawner/apc_rac/spawn_vehicle()
	var/obj/vehicle/multitile/apc_rac/APC = new(loc)

	load_misc(APC)
	load_hardpoints(APC)
	handle_direction(APC)
	APC.update_icon()

	return APC

/obj/effect/vehicle_spawner/apc_rac/load_hardpoints(obj/vehicle/multitile/apc_rac/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/apc_wheels/rac)
	V.add_hardpoint(new /obj/item/hardpoint/support/overdrive_enhancer/rac)
	V.add_hardpoint(new /obj/item/hardpoint/holder/tank_turret/rac)
	for(var/obj/item/hardpoint/holder/tank_turret/TT in V.hardpoints)
		var/obj/item/hardpoint/primary/cannon/rac/cannon = new
		TT.add_hardpoint(cannon)
		LAZYADD(cannon.backup_clips, new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/ap)
		LAZYADD(cannon.backup_clips, new /obj/item/ammo_magazine/hardpoint/ltb_cannon/rac/incendiary)

		var/obj/item/hardpoint/secondary/m56cupola/rac/coax_mg = new
		TT.add_hardpoint(coax_mg)
		LAZYADD(coax_mg.backup_clips, new /obj/item/ammo_magazine/hardpoint/rac_mg)
		break
