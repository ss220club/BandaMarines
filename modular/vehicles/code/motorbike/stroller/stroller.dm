// стул на колесиках, по другому "сайдкар"
/obj/structure/bed/chair/stroller
	name = "Коляска"
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural_stroller"
	var/icon_skin = "classic"
	var/icon_destroyed = "destroyed"
	desc = "Для детишек."
	density = FALSE	// При коннекте - У нас уже есть колизия с мотоциклом
	anchored = TRUE	// При коннекте - Нехай трогать и перемещать
	projectile_coverage = PROJECTILE_COVERAGE_MEDIUM
	health = 800 // Тележка прочнее мотоцикла. Увы, но это просто кусок металла.
	var/maxhealth = 800
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки
	var/is_welded = FALSE	// Сейчас происходит процесс варки?

	can_buckle = TRUE
	var/buckle_time = 3 SECONDS	// Не сразу можно сесть.
	var/obj/connected
	var/hit_chance_buckled = PROJECTILE_COVERAGE_MINIMAL // Шанс попасть по сидящему

/obj/structure/bed/chair/stroller/Initialize()
	. = ..()
	update_overlay()
	if(buckled_mob)
		buckled_mob.setDir(dir)

/obj/structure/bed/chair/stroller/New(loc, skin)
	if(skin)
		icon_skin = skin
	. = ..()
	if(isobj(loc))
		connected = loc
	if(connected)
		connect(connected)
	else
		disconnect()

/obj/structure/bed/chair/stroller/proc/update_overlay()
	overlays.Cut()
	icon_state = initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = layer_above) //over mobs
	overlays += I
	if(mounted)
		var/gun_overlay = "m56d"
		if(istype(mounted, /obj/item/device/m2c_gun))
			gun_overlay = "m2c"
		if(mounted.rounds <= 0)
			gun_overlay += "_e"
		var/image/I_gun = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "moto_ural_[gun_overlay]", layer = layer_above) //over mobs
		overlays += I_gun


// ==========================================
// ============ Коннект с байком ============

/obj/structure/bed/chair/stroller/proc/connect(atom/connection)
	connected = connection
	forceMove(connected.loc) // Обновляем местоположение, мы ж не хотим видеть коляску в чмстилище
	RegisterSignal(connected, COMSIG_MOVABLE_MOVED, PROC_REF(handle_parent_move))
	// Доп параметры для корректной обработки состояния "ОНО КАК ОБЪЕКТ НО СУКА НЕ ОБЪЕКТ"
	density = initial(density)
	anchored = initial(anchored)
	update_position(connected, TRUE)
	drag_delay = FALSE

/obj/structure/bed/chair/stroller/proc/disconnect()
	if(connected)
		UnregisterSignal(connected, COMSIG_MOVABLE_MOVED)
	reload_connected()
	connected = null
	density = !density
	anchored = !anchored
	update_drag_delay()
	update_position(src, TRUE)
	push_to_left_side(src)

/obj/structure/bed/chair/stroller/proc/handle_parent_move(atom/movable/mover, atom/oldloc, direction)
	SIGNAL_HANDLER
	forceMove(get_turf(mover))

// ==========================================
