/obj/structure/bed/chair/sidecar
	//=============== Перемещение =================
	drag_delay = 3 //На колесах хоть и удобно таскать, но эта байдура тяжеленькая.
	var/drag_delay_heavy = 3 // Менять если хотите замедлить при каком то условии.
	can_block_movement = FALSE
	can_rotate = FALSE
	//=============================================

	//======== Позиционирование коляски ===========
	pixel_x = -8	// Центрируем
	var/pixel_x_sides = 10 // Смещение для выравнивания на тайле, когда приконекчен
	// Смещение при коннекте
	var/list/pixel_north = list(14, -4)
	var/list/pixel_south = list(-14, -4)
	var/list/pixel_east = list(2, -9)
	var/list/pixel_west = list(-2, 0)
	//=============================================

	//=================слои отрисовки==============
	layer = LYING_LIVING_MOB_LAYER
	var/layer_west = LYING_BETWEEN_MOB_LAYER
	var/layer_above = ABOVE_MOB_LAYER
	//=============================================

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

/obj/structure/bed/chair/sidecar/proc/update_drag_delay() //переопределить дочернем классе
	return
	//drag_delay = (условие замедления) ? drag_delay_heavy : initial(drag_delay) - пример
