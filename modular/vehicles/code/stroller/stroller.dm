// стул на колесиках
/obj/structure/bed/chair/stroller
	name = "wheelchair"
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural_stroller"
	var/icon_skin = "classic"
	desc = "You sit in this. Either by will or force."
	drag_delay = 1 //pulling something on wheels is easy
	density = FALSE	// При коннекте - У нас уже есть колизия с мотоциклом
	anchored = TRUE	// При коннекте - Нехай трогать и перемещать
	health = 600
	can_buckle = TRUE
	can_block_movement = FALSE
	can_rotate = FALSE

	var/obj/connected = FALSE
	pixel_x = -8	// Центрируем
	buckling_y = 8	// можно было б 4, но увы, оно слишком выпирает

	var/list/pixel_north = list(-14, -4)
	var/list/pixel_south = list(-14, -4)
	var/list/pixel_east = list(2, -9)
	var/list/pixel_west = list(-2, 0)
	layer = LYING_LIVING_MOB_LAYER

/obj/structure/bed/chair/stroller/Initialize()
	overlays.Cut()
	icon_state = initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I
	if(buckled_mob)
		buckled_mob.setDir(dir)

/obj/structure/bed/chair/stroller/New(loc)
	. = ..()
	if(isobj(loc))
		connected = loc
	if(connected)
		connect()
	else
		disconnect()

/obj/structure/bed/chair/stroller/proc/connect()
	density = initial(density)
	anchored = initial(anchored)
	drag_delay = FALSE
	// unacidable = TRUE	// Нам не нужно чтобы её ломали
	// explo_proof = TRUE

/obj/structure/bed/chair/stroller/proc/disconnect()
	density = !density
	anchored = !anchored
	drag_delay = initial(drag_delay)

// /obj/structure/bed/chair/stroller/buckle_mob(mob/living/carbon/human/mob, mob/user)
// 	. = ..()
// 	mob.setDir(dir)

/obj/structure/bed/chair/stroller/unbuckle()
	if(buckled_mob)
		buckled_mob.pixel_x = initial(buckled_mob.pixel_x)
		buckled_mob.pixel_y = initial(buckled_mob.pixel_y)
		buckled_mob.update_layer()
	. = ..()

/obj/structure/bed/chair/stroller/proc/update_position(atom/target = null)
	loc = get_turf(target)
	//forceMove(get_turf(target)) //	рывками двигает
	setDir(target.dir)
	//layer = initial(layer)
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
	//layer = initial(layer) - (dir == EAST ? 0.1 : 0)
	update_buckle_mob()

/obj/structure/bed/chair/stroller/proc/update_buckle_mob()
	if(!buckled_mob)
		return
	buckled_mob.loc = loc
	//buckled_mob.forceMove(loc)
	buckled_mob.pixel_x = pixel_x - initial(pixel_x)
	buckled_mob.pixel_y = pixel_y - initial(pixel_y)
	buckled_mob.setDir(dir)
	//buckled_mob.layer = layer
	buckled_mob.density = FALSE
	if(dir == WEST)
		layer = LYING_BETWEEN_MOB_LAYER
	else
		buckled_mob.update_layer()

/obj/structure/bed/chair/stroller/unbuckle()
	reload_buckle_mob()
	. = ..()

/obj/structure/bed/chair/stroller/proc/reload_buckle_mob()
	buckled_mob.update_layer()
	buckled_mob.density = initial(buckled_mob.density)

/obj/structure/bed/chair/stroller/BlockedPassDirs(atom/movable/mover, target_dir)
	if(connected)	// Не колизируем больше ни с чем, если приконектились
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/chair/stroller/Collide(atom/A)
	if(connected)
		return NO_BLOCKED_MOVEMENT
	return ..()

/obj/structure/bed/chair/stroller/buckle_mob(mob/living/carbon/human/mob, mob/user)
	if (mob.mob_size = MOB_SIZE_XENO && (mob.a_intent = INTENT_GRAB || mob.stat == DEAD))	// Мы можем посадить небольшого ксеноса, если он будет помогать лапками в граб интенте. Как на кровати.
	else if (mob.mob_size = MOB_SIZE_XENO_SMALL &&  (mob.a_intent = INTENT_HELP || mob.a_intent = INTENT_GRAB || mob.stat == DEAD))	// мы сможем украсть руню или ящерку, если они не особо сопротивляться будут
	else if (mob.mob_size <= MOB_SIZE_XENO_VERY_SMALL)	// Lesser Drones, Люди
		do_buckle(M, user)
		if(mob.loc == src.loc && buckling_sound && mob.buckled)
			playsound(src, buckling_sound, 20)
	//if(ishuman(mob))
	else ..()
	// !!!!! Фиксануть шо оно не закрпляет моба ни так, ни эдак
