/obj/structure/bed/chair/stroller
	drag_delay = 1 //pulling something on wheels is easy
	can_block_movement = FALSE
	can_rotate = FALSE

	pixel_x = -8	// Центрируем
	buckling_y = 8	// можно было б 4, но увы, оно слишком выпирает

	var/list/pixel_north = list(-14, -4)
	var/list/pixel_south = list(-14, -4)
	var/list/pixel_east = list(2, -9)
	var/list/pixel_west = list(-2, 0)
	layer = LYING_LIVING_MOB_LAYER
	var/layer_west = LYING_BETWEEN_MOB_LAYER
	var/layer_above = ABOVE_MOB_LAYER

// ==========================================
// ================ Движение  ===============

/obj/structure/bed/chair/stroller/proc/update_position(atom/target = null, force_update = FALSE)
	forceMove(get_turf(target))	// Тащим привязанного моба с нами
	if(dir == target.dir && !force_update)
		return
	setDir(target.dir)
	layer = initial(layer)
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
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
			layer = layer_west - 0.01
	update_buckle_mob()

/obj/structure/bed/chair/stroller/proc/update_buckle_mob()
	if(!buckled_mob)
		return
	buckled_mob.pixel_x = pixel_x - initial(pixel_x)
	buckled_mob.pixel_y = pixel_y - initial(pixel_y) + buckling_y
	buckled_mob.setDir(dir)
	buckled_mob.density = FALSE
	if(dir == WEST)
		buckled_mob.layer = layer_west
	else
		buckled_mob.layer = initial(buckled_mob.layer)

// ==========================================
// =============== Усаживание ===============

/obj/structure/bed/chair/stroller/buckle_mob(mob/living/carbon/human/mob, mob/user)
	if (mob.mob_size == MOB_SIZE_XENO && (mob.a_intent == INTENT_GRAB || mob.stat == DEAD))	// Мы можем посадить небольшого ксеноса, если он будет помогать лапками в граб интенте. Как на кровати.
	else if (mob.mob_size == MOB_SIZE_XENO_SMALL &&  (mob.a_intent == INTENT_HELP || mob.a_intent == INTENT_GRAB || mob.stat == DEAD))	// мы сможем украсть руню или ящерку, если они не особо сопротивляться будут
	else if (mob.mob_size <= MOB_SIZE_XENO_VERY_SMALL)	// Lesser Drones, Люди
		do_buckle(mob, user)
		if(mob.loc == src.loc && buckling_sound && mob.buckled)
			playsound(src, buckling_sound, 20)
		return TRUE
	. = ..()

/obj/structure/bed/chair/stroller/do_buckle(mob/living/target, mob/user)
	if(..())
		update_buckle_mob()

/obj/structure/bed/chair/stroller/unbuckle()
	reload_buckle_mob()
	. = ..()

/obj/structure/bed/chair/stroller/proc/reload_buckle_mob()
	if(!buckled_mob)
		return
	buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
	buckled_mob.pixel_y = initial(buckled_mob.pixel_y)
	buckled_mob.density = initial(buckled_mob.density)
	buckled_mob.layer = initial(buckled_mob.layer)
	buckled_mob.update_layer()	// Обновляем, если с персонажем "что-то случилось"

// ==========================================
// ================ Коллизия ================

/obj/structure/bed/chair/stroller/BlockedPassDirs(atom/movable/mover, target_dir)
	if(connected)	// Не колизируем больше ни с чем, если приконектились
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/chair/stroller/Collide(atom/A)
	if(connected)
		return NO_BLOCKED_MOVEMENT
	return ..()

// ==========================================
