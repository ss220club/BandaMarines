/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."

	//======= Для отображения в игре ==============
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural_classic"	// Для отображения на картах
	var/icon_base = "moto_ural"
	var/icon_skin = "classic"
	var/need_camo = FALSE // Камуфлируем под текущую карту?
	var/blooded = FALSE	// Окровавлен при столкновении в motorbike_collide.dm
	var/blooded_skin = "moto_mudak-overlay"
	var/image/motorbike_body_overlay
	var/image/motorbike_blood_overlay

	//==== Защита, здоровье, ремонт и соединение ====
	health = 400
	maxhealth = 400
	projectile_coverage = PROJECTILE_COVERAGE_LOW // Шанс попадания проджектайлов
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки
	var/is_welded = FALSE	// Сейчас происходит процесс варки?
	var/wrench_time = 10 SECONDS // Время коннекта при закручивании

	//========= Прочие параметры ============
	density = FALSE // Байк не влияет на толщину, мобы внутри влияют
	anchored = FALSE // Мы можем передвинуть байк, если он нам мешает.
	var/required_skill = SKILL_VEHICLE_DEFAULT // скилл больше не требуется

	//=============== Перемещение =================
	move_delay = 1.5	// Скорость
	var/move_delay_connected = VEHICLE_SPEED_SUPERFAST // == 2 - Скорость когда приконекчена тележка
	drag_delay = 3 // Но медленно

	//================ Система света ====================
	light_system = MOVABLE_LIGHT
	light_range = 5
	var/atom/movable/vehicle_light_holder/lighting_holder
	var/vehicle_light_range = 5
	var/vehicle_light_power = 2

	//================ Buckling ===============
	var/buckle_time = 0.7 SECONDS

	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.

	var/create_sidecar = NO_SIDECAR //Проверка на коляску при создании. 0 - никакая, 1 - пассажирская, 2 - грузовая и т.д.
	var/obj/structure/bed/chair/sidecar/sidecar = null // привязанная тележка
	var/hit_chance_connected = PROJECTILE_COVERAGE_MEDIUM // prob шанс задеть тележку или сидящего при попадании
	var/hit_chance_buckled = 50 // Шанс попасть по сидящему
	var/hit_chance_to_unbuckle = 5 // Каждый удар имеет шанс отсоединить куклу при попадании по ней
	var/is_destroying = FALSE


/obj/vehicle/motorbike/proc/resolve_spawn_skin(skin)
	if(skin)
		icon_skin = skin
	else if(need_camo)
		select_gamemode_skin()

/obj/vehicle/motorbike/proc/create_spawn_sidecar()
	if(create_sidecar == PASSENGER_SIDECAR)
		return new /obj/structure/bed/chair/sidecar/passenger(src, icon_skin)
	if(create_sidecar == CARGO_SIDECAR)
		return new /obj/structure/bed/chair/sidecar/cargo(src, icon_skin)
	to_chat(world, SPAN_WARNING("Внимание: Попытка присоединения несуществующей коляски"))
	return null

/obj/vehicle/motorbike/proc/setup_spawn_sidecar()
	if(create_sidecar == NO_SIDECAR)
		return
	sidecar = create_spawn_sidecar()
	if(sidecar)
		update_connect_params()
		update_sidecar(TRUE)

/obj/vehicle/motorbike/New(loc, skin)
	resolve_spawn_skin(skin)
	. = ..(loc, icon_skin)
	setup_spawn_sidecar()

/obj/vehicle/motorbike/proc/setup_lighting()
	if(bound_width > world.icon_size || bound_height > world.icon_size)
		if(!lighting_holder)
			lighting_holder = new(src)
		if(lighting_holder)
			lighting_holder.set_light_range(vehicle_light_range)
			lighting_holder.set_light_power(vehicle_light_power)
			lighting_holder.set_light_on(vehicle_light_range || vehicle_light_power)
	else if(light_range)
		set_light_on(TRUE)

/obj/vehicle/motorbike/proc/register_special_vehicle()
	GLOB.all_spec_vehicles += src

/obj/vehicle/motorbike/proc/cleanup_sidecar()
	if(sidecar)
		if(!QDELETED(sidecar))
			var/obj/structure/bed/chair/sidecar/sidecar_to_delete = sidecar
			sidecar_to_delete.disconnect()
			QDEL_NULL(sidecar_to_delete)
		sidecar = null

/obj/vehicle/motorbike/proc/cleanup_driver()
	if(buckled_mob)
		unbuckle()

/obj/vehicle/motorbike/proc/cleanup_lighting()
	QDEL_NULL(lighting_holder)

/obj/vehicle/motorbike/proc/unregister_special_vehicle()
	GLOB.all_spec_vehicles -= src

/obj/vehicle/motorbike/Initialize()
	. = ..()
	update_overlay()
	setup_lighting()
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))
	register_special_vehicle()

/obj/vehicle/motorbike/Destroy(force)
	cleanup_sidecar()
	cleanup_driver()
	cleanup_lighting()
	unregister_special_vehicle()
	. = ..()

/obj/vehicle/motorbike/proc/update_overlay()
	if(motorbike_body_overlay)
		overlays -= motorbike_body_overlay
		motorbike_body_overlay = null
	if(motorbike_blood_overlay)
		overlays -= motorbike_blood_overlay
		motorbike_blood_overlay = null

	icon_state = "[icon_base]_[icon_skin]"
	motorbike_body_overlay = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += motorbike_body_overlay
	if(blooded)
		motorbike_blood_overlay = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[blooded_skin]", layer = ABOVE_MOB_LAYER) //over mobs
		overlays += motorbike_blood_overlay

/obj/vehicle/motorbike/get_examine_text(mob/user)
	. = ..()
	if(!isxeno(user))
		. += SPAN_NOTICE("Прочность: [health/maxhealth*100]%")

// ==========================================
// ========== Присоединяем коляску ==========

// Пытаемся приконектить объект

/obj/vehicle/motorbike/proc/try_connect(mob/user)
	if(sidecar && !QDELETED(sidecar))
		return FALSE
	if(QDELETED(sidecar))
		sidecar = null
	var/obj/structure/bed/chair/sidecar/candidate = get_before_connect(user)
	if(!candidate)
		return FALSE
	sidecar = candidate
	if(!connect())
		sidecar = null
		return FALSE
	return TRUE

// Ищем и выдаем нужный объект для коннекта
/obj/vehicle/motorbike/proc/get_before_connect(mob/user)
	if(!user || QDELETED(user))
		return FALSE
	for(var/obj/structure/bed/chair/sidecar/S in range(1, get_turf(user)))
		if(S.connected)
			to_chat(user, SPAN_DANGER("[S] уже закреплена."))
			continue
		if(S.health < S.maxhealth - 100)
			to_chat(user, SPAN_DANGER("[S] повреждена и требует ремонта."))
			continue
		return S
	to_chat(user, SPAN_DANGER("Вы прокрутили крепежи и осознали, что рядом с вами нет коляски..."))
	return FALSE

// Завершаем конект в коляске
/obj/vehicle/motorbike/proc/connect()
	if(!sidecar || QDELETED(sidecar))
		return FALSE
	if(sidecar.connected && sidecar.connected != src)
		return FALSE
	if(!sidecar.connect(src))
		return FALSE
	update_connect_params()
	return TRUE

/obj/vehicle/motorbike/proc/update_connect_params()
	move_delay = move_delay_connected

/obj/vehicle/motorbike/proc/disconnect()
	if(sidecar && !QDELETED(sidecar))
		sidecar.disconnect()
	sidecar = null
	move_delay = initial(move_delay)

/obj/vehicle/motorbike/proc/on_sidecar_disconnected(obj/structure/bed/chair/sidecar/disconnected_sidecar)
	if(sidecar != disconnected_sidecar)
		return FALSE
	sidecar = null
	move_delay = initial(move_delay)
	return TRUE

/obj/vehicle/motorbike/proc/get_valid_sidecar()
	if(!sidecar)
		return null
	if(QDELETED(sidecar) || sidecar.connected != src)
		sidecar = null
		move_delay = initial(move_delay)
		return null
	return sidecar

// Глайдинг для плавного перемещения
/obj/vehicle/motorbike/set_glide_size(target)
	. = ..()
	var/obj/structure/bed/chair/sidecar/active_sidecar = get_valid_sidecar()
	if(active_sidecar)
		active_sidecar.set_glide_size(target)

/datum/supply_packs/motorbike
	name = "Мотоцикл (x1)"
	contains = list(
		/obj/vehicle/motorbike/camo,
		/obj/item/pamphlet/skill/vc/low,
	)
	cost = 40
	containertype = /obj/structure/largecrate
	containername = "Упакованный мотоцикл"
	group = "Vehicle Equipment"

// ======== Коляски для мотоциклов ==========
/datum/supply_packs/motorbike_stroller
	name = "Мотоциклетная коляска (x1)"
	contains = list(
		/obj/structure/bed/chair/sidecar/passenger/camo,
	)
	cost = 20
	containertype = /obj/structure/largecrate
	containername = "Упакованная коляска для мотоцикла"
	group = "Vehicle Equipment"
