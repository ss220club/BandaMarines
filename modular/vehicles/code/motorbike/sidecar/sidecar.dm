// стул на колесиках, по другому "сайдкар"
/obj/structure/bed/chair/sidecar
	name = "Мотоциклетная коляска - Родительская"
	desc = "Эта коляскя не должна существовать в этой реальности"

	//======= Для отображения в игре ==============
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = ""	// Для отображения на картах. //сюда бы смешную заглушку, чтобы понимать, что создал не то.
	var/icon_base = "moto_ural_sidecar"
	var/icon_skin = "classic"
	var/icon_destroyed = "destroyed"
	var/need_camo = FALSE // Камуфлируем под текущую карту?
	//=============================================

	//========= Какие то параметры XDD ============
	density = FALSE	// При коннекте - У нас уже есть колизия с мотоциклом
	anchored = TRUE	// При коннекте - Нехай трогать и перемещать
	stacked_size = FALSE // Иначе он будет его в нулину ломать
	picked_up_item = null // Нам не нужно превращение в стул...
	pixel_x = -8	// Центрируем
	var/pixel_x_sides = 10 // Смещение для выравнивания на тайле, когда приконекчен
	//=============================================

	//======== Защита, здоровье и ремонт ==========
	projectile_coverage = PROJECTILE_COVERAGE_MEDIUM
	health = 600 // Тележка прочнее мотоцикла. Увы, но это просто кусок металла.
	var/maxhealth = 600
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки
	var/is_welded = FALSE	// Сейчас происходит процесс варки?
	//=============================================

	//=============== Перемещение =================
	drag_delay = 3 //На колесах хоть и удобно таскать, но эта байдура тяжеленькая.
	var/drag_delay_heavy = 3 // Менять если хотите замедлить при каком то условии.
	can_block_movement = FALSE
	can_rotate = FALSE
	//=============================================

	//=========== Смещение при коннекте ===========
	var/list/pixel_north = list(14, -4)
	var/list/pixel_south = list(-14, -4)
	var/list/pixel_east = list(2, -9)
	var/list/pixel_west = list(-2, 0)
	//=============================================

	//отвечает за отображение по слоям
	//=================слои отрисовки==============
	layer = LYING_LIVING_MOB_LAYER
	var/layer_west = LYING_BETWEEN_MOB_LAYER
	var/layer_above = ABOVE_MOB_LAYER
	//=============================================

	var/obj/connected // Приконекченный байк

/obj/structure/bed/chair/sidecar/Initialize()
	. = ..()
	update_overlay()

/obj/structure/bed/chair/sidecar/New(loc, skin)
	if(skin)
		icon_skin = skin
	else if(need_camo)
		select_gamemode_skin()
	. = ..(loc, icon_skin)
	if(istype(loc, /obj/vehicle))
		connected = loc
	if(connected)
		connect(connected)
	else
		disconnect()

/obj/structure/bed/chair/sidecar/proc/update_overlay()
	overlays.Cut() //Очистка от слоев оверлея.
	icon_state = "[icon_base]_[icon_skin]"

/obj/structure/bed/chair/sidecar/get_examine_text(mob/user)
	. = ..()
	if(!isxeno(user))
		. += SPAN_NOTICE("Прочность: [health/maxhealth*100]%")

// ==========================================
// ============ Коннект с байком ============

/obj/structure/bed/chair/sidecar/proc/connect(atom/connection)
	connected = connection
	forceMove(connected.loc)
	// Обновляем местоположение, мы ж не хотим видеть коляску в чмстилище
	RegisterSignal(connected, COMSIG_MOVABLE_MOVED, PROC_REF(handle_parent_move))
	// Доп параметры для корректной обработки состояния "ОНО КАК ОБЪЕКТ НО СУКА НЕ ОБЪЕКТ"
	density = initial(density)
	anchored = initial(anchored)
	update_position(connected, TRUE)
	drag_delay = FALSE


/obj/structure/bed/chair/sidecar/proc/disconnect()
	if(connected)
		UnregisterSignal(connected, COMSIG_MOVABLE_MOVED)
	reload_connected()
	connected = null
	density = !density
	anchored = !anchored
	update_drag_delay()
	update_position(src, TRUE)
	push_to_left_side(src)

/obj/structure/bed/chair/sidecar/proc/handle_parent_move(atom/movable/mover, atom/oldloc, direction) //нужен для всех колясок
	SIGNAL_HANDLER
	forceMove(get_turf(mover))

// ==========================================


// ================ Movement ================
// ==========================================
// =============== Позиционка ===============

/obj/structure/bed/chair/sidecar/proc/update_position(atom/target = null, force_update = FALSE)
	if(dir == target.dir && !force_update)
		return
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	layer = initial(layer) //отвечает за отображение по слоям
	if(target != src)
		update_connected(target)
	centralize_to_turf()

/obj/structure/bed/chair/sidecar/proc/update_connected(atom/target)
	setDir(target.dir)

	switch(dir)	// движок не хочет константно их сохранять в словарь по DIR'ам
		if(NORTH)
			pixel_x += pixel_north[1]
			pixel_y += pixel_north[2]
		if(SOUTH)
			pixel_x += pixel_south[1]
			pixel_y += pixel_south[2]
		if(EAST)
			pixel_x += pixel_east[1]
			pixel_y += pixel_east[2]
		if(WEST)
			pixel_x += pixel_west[1]
			pixel_y += pixel_west[2]
			layer = layer_west - 0.01 //отвечает за отображение по слоям

/obj/structure/bed/chair/sidecar/proc/centralize_to_turf()
	if(!pixel_x_sides)
		return
	if(!connected)	// централизация только при коннекте
		return
	reload_connected()
	switch(dir)	// движок не хочет константно их сохранять в словарь по DIR'ам
		if(NORTH, SOUTH)
			var/ndir = dir == NORTH ? -1 : 1	// На севере нам нужно проделать всё "в другую сторону"
			pixel_x += pixel_x_sides * ndir // Централизуем коляску
			if(connected)
				connected.pixel_x += pixel_x_sides * ndir	// Приконекченное мото
				if(connected.buckled_mob)	// Приконекченного сидящего в мото
					connected.buckled_mob.pixel_x += pixel_x_sides * ndir
		//if(EAST, WEST)
			//тут пусто *звуки ветра*

// ==========================================
// ============== Нормализация ==============

/obj/structure/bed/chair/sidecar/proc/reload_connected()
	if(!connected)
		return
	if(connected.buckled_mob)
		connected.buckled_mob.pixel_x = initial(connected.buckled_mob.pixel_x)
	connected.pixel_x = initial(connected.pixel_x)


// ==========================================
// ================ Коллизия ================

/obj/structure/bed/chair/sidecar/BlockedPassDirs(atom/movable/mover, target_dir)
	if(connected)	// Не колизируем больше ни с чем, если приконектились
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/chair/sidecar/Collide(atom/A)
	if(connected)
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/chair/sidecar/proc/push_to_left_side(atom/A)
	var/old_dir = dir
	var/temp_dir = dir	// Выбираем сторону коннекта нашей тележки
	if(temp_dir == NORTH)
		temp_dir = EAST
	else if(temp_dir == EAST)
		temp_dir = SOUTH
	else if(temp_dir == SOUTH)
		temp_dir = WEST
	else if(temp_dir == WEST)
		temp_dir = NORTH
	setDir(temp_dir)
	step(A, temp_dir)	// Толкаем в сторону, если на пути стена, то "шаг" не совершится
	setDir(old_dir)

/obj/structure/bed/chair/sidecar/proc/update_drag_delay(condition) // Переписать под любую пару Condition - NewValue . was buckled_mob
	drag_delay = condition ? drag_delay_heavy : initial(drag_delay)

// ==========================================
// =============Health и урон ===============

// Главный чекер урона у vehicle, повторяем здесь же
/obj/structure/bed/chair/sidecar/proc/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/sidecar(src.loc, icon_skin) //заменить в дочке на нужный путь создания объекта
		deconstruct(FALSE)
		QDEL_NULL(src)

/obj/structure/bed/chair/sidecar/update_health(damage = 0)
	healthcheck(damage)
	. = ..()

/obj/structure/bed/chair/sidecar/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	health -= M.melee_damage_upper
	src.visible_message(SPAN_DANGER("<B>[M] [M.attacktext] [src]!</B>"))
	M.attack_log += text("\[[time_stamp()]\] <font color='red'>рвет [src.name]</font>")
	if(prob(10))
		new /obj/effect/decal/cleanable/blood/oil(src.loc)
	healthcheck()

/obj/structure/bed/chair/sidecar/attack_alien(mob/living/carbon/xenomorph/M)
	if(unslashable)
		return
	if(M.melee_damage_upper == 0)
		return
	M.animation_attack_on(src)
	playsound(src, hit_bed_sound, 25, 1)
	M.visible_message(SPAN_DANGER("[M] кромсает [src]!"),
	SPAN_DANGER("Мы кромсаем [src]."))
	health -= M.melee_damage_upper
	healthcheck()
	return XENO_ATTACK_ACTION

/obj/structure/bed/chair/sidecar/bullet_act(obj/projectile/P)
	var/damage = P.damage
	health -= damage
	..()
	healthcheck()
	return TRUE

/obj/structure/bed/chair/sidecar/ex_act(severity)
	health -= severity*0.05
	health -= severity*0.1
	healthcheck()
	return

// ==========================================
// ================= Guns ===================

//тут пусто :(

// ==========================================
// ================ Пулеметы ================

//тут пусто :(

// ==========================================
// ============== Безопасность ==============

//тут пусто :(

// ==========================================
// ============== Взаимодействие =============

//тут пусто :(

// ==========================================
// ================ Сигналы =================

//тут пусто :(

// ==========================================
// ================ Actions =================

//тут пусто :(

// ==========================================
// ================Buckling==================

// =============== Усаживание ===============

//тут пусто :(

// ==========================================
// =============== Обновление ===============

//тут пусто :(

// ==========================================
// ==========================================
// ======== Действия с инструментами ========

/obj/structure/bed/chair/sidecar/attackby(obj/item/O as obj, mob/user as mob)
	if(user.action_busy)
		to_chat(user, SPAN_WARNING("Вы уже чем-то заняты!"))
		return

	// Присоединение
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		to_chat(user, SPAN_WARNING("Коляску можно [connected ? "от" : "при"]соединить только через мотоцикл."))
		return FALSE

	// Ремонт корпуса
	if (iswelder(O))
		return handle_welder(O, user)

	// Ремонт шин
	//if (iswire())
	. = ..()

/obj/structure/bed/chair/sidecar/proc/handle_welder(obj/item/O, mob/user)
	if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
		to_chat(user, SPAN_WARNING("[O] недостаточен для ремонта корпуса!"))
		return FALSE
	if(health >= maxhealth)
		to_chat(user, SPAN_NOTICE("Корпус [src.name] в починке не нуждается!"))
		return TRUE
	var/obj/item/tool/weldingtool/WT = O
	if(WT.remove_fuel(1, user))
		if(!do_after(user, welder_time * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL, BUSY_ICON_BUILD))
			to_chat(user, SPAN_NOTICE("Вы прервали сварку корпуса [src.name] с помощью [O]."))
			return FALSE
		if(!src || !WT.isOn())
			to_chat(user, SPAN_NOTICE("Сварка корпуса [src.name] прервана из-за непригодных обстоятельств."))
			return FALSE
		var/procent = round((health / maxhealth) * 100)
		to_chat(user, SPAN_NOTICE("Вы сварили корпус [src.name] с помощью [O]. Сварено на [procent]%"))
		health = min(health + welder_health, maxhealth)
		playsound(src.loc, 'sound/items/Welder.ogg', 25, 1)
	else
		to_chat(user, SPAN_WARNING("В [O] не хватает топлива!"))
		return FALSE
	return TRUE

// ==========================================

/obj/structure/bed/chair/sidecar/proc/update_bike_permutated() //определяется в passenger
	return

/obj/structure/bed/chair/sidecar/proc/reset_bike_permutated() //определяется в passenger
	return
