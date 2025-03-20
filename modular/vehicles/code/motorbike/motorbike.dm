/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural"
	var/icon_skin = "classic"

	health = 400
	maxhealth = 400
	var/required_skill = SKILL_VEHICLE_SMALL

	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.

	move_delay = VEHICLE_SPEED_SUPERFAST	// Скорость
	projectile_coverage = PROJECTILE_COVERAGE_LOW // Шанс попадания проджектайлов

	// Система света
	light_system = MOVABLE_LIGHT
	light_range = 5
	var/atom/movable/vehicle_light_holder/lighting_holder
	var/vehicle_light_range = 5
	var/vehicle_light_power = 2

	// Ремонт, коннекты, действия
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки
	var/is_welded = FALSE	// Сейчас происходит процесс варки?
	var/wrench_time = 10 SECONDS // Время коннекта при закручивании

	var/obj/structure/bed/chair/stroller/stroller = null // привязанная тележка
	var/hit_chance_connected = PROJECTILE_COVERAGE_MEDIUM // prob шанс задеть тележку или сидящего при попадании
	var/hit_chance_buckled = PROJECTILE_COVERAGE_MINIMAL // Шанс попасть по сидящему


/obj/vehicle/motorbike/New(loc, skin, create_stroller = TRUE)
	if(skin)
		icon_skin = skin
	. = ..()
	if(create_stroller)
		stroller = new(src, icon_skin)
		update_stroller(TRUE)
	update_overlay()

/obj/vehicle/motorbike/Initialize()
	. = ..()
	update_overlay()
	if(bound_width > world.icon_size || bound_height > world.icon_size)
		lighting_holder = new(src)
		lighting_holder.set_light_range(vehicle_light_range)
		lighting_holder.set_light_power(vehicle_light_power)
		lighting_holder.set_light_on(vehicle_light_range || vehicle_light_power)
	else if(light_range)
		set_light_on(TRUE)
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(on_move))

/obj/vehicle/motorbike/proc/update_overlay()
	overlays.Cut()
	icon_state= initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I

// ==========================================
// ========== Присоединяем коляску ==========

// Пытаемся приконектить объект
/obj/vehicle/motorbike/proc/try_connect()
	stroller = get_before_connect()
	if(!stroller)
		return FALSE
	connect()
	return TRUE

// Ищем и выдаем нужный объект для коннекта
/obj/vehicle/motorbike/proc/get_before_connect(mob/user)
	for(var/obj/structure/bed/chair/stroller/S in range(1, get_turf(user)))
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
	stroller.connect(src)

// ==========================================
