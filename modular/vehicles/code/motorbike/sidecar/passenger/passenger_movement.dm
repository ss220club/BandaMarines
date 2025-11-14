// ================ Movement ================
// ==========================================
// =============== Позиционка ===============

/obj/structure/bed/chair/sidecar/passenger/update_position(atom/target = null, force_update = FALSE)
	if(dir == target.dir && !force_update)
		return
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	layer = initial(layer) //отвечает за отображение по слоям
	if(target != src)
		update_connected(target)
	update_buckle_mob()
	centralize_to_turf()

/obj/structure/bed/chair/sidecar/passenger/centralize_to_turf()
	if(!pixel_x_sides)
		return
	if(!connected)	// централизация только при коннекте
		return
	reload_connected()
	switch(dir)	// движок не хочет константно их сохранять в словарь по DIR'ам
		if(NORTH, SOUTH)
			var/ndir = dir == NORTH ? -1 : 1	// На севере нам нужно проделать всё "в другую сторону"
			pixel_x += pixel_x_sides * ndir // Централизуем коляску
			if(buckled_mob)
				buckled_mob.pixel_x += pixel_x_sides * ndir	// Сидящего
			if(connected)
				connected.pixel_x += pixel_x_sides * ndir	// Приконекченное мото
				if(connected.buckled_mob)	// Приконекченного сидящего в мото
					connected.buckled_mob.pixel_x += pixel_x_sides * ndir
		if(EAST, WEST)
			if(buckled_mob)
				buckled_mob.pixel_x = get_buckled_mob_pixel_x()

/obj/structure/bed/chair/sidecar/passenger/proc/get_buckled_mob_pixel_x()
	return buckled_mob.pixel_x = pixel_x - initial(pixel_x) - 1

/obj/structure/bed/chair/sidecar/passenger/proc/get_buckled_mob_pixel_y()
	return pixel_y - initial(pixel_y) + buckling_y

// ==========================================
// ============== Нормализация ==============

/obj/structure/bed/chair/sidecar/passenger/proc/reload_buckle_mob()
	if(!buckled_mob)
		return
	buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
	buckled_mob.pixel_y = initial(buckled_mob.pixel_y)
	buckled_mob.density = initial(buckled_mob.density)
	buckled_mob.layer = initial(buckled_mob.layer)
	buckled_mob.update_layer()	// Обновляем, если с персонажем "что-то случилось"
	buckled_mob.set_glide_size(initial(buckled_mob.glide_size))

/obj/structure/bed/chair/sidecar/passenger/push_to_left_side(atom/A)
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
	if(buckled_mob)
		buckled_mob.setDir(old_dir)
