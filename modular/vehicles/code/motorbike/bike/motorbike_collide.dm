/obj/vehicle/motorbike
	var/crash_damage_multiplier = 1.0 // Множитель урона при столкновении
	var/last_crash_time = 0 // Время последнего столкновения
	var/crash_cooldown = 2 SECONDS // Задержка между столкновениями

/obj/vehicle/motorbike/Bump(atom/A)
	if(world.time < last_crash_time + crash_cooldown)
		return

	// Если нет водителя или скорость минимальная - стандартная обработка
	if(!buckled_mob || current_speed_level <= 1)
		return ..()

	// Обработка столкновений с разными типами объектов
	if(isturf(A))
		handle_wall_collision(A)
	else if(ismob(A))
		Collide(A)
	else if(isobj(A))
		handle_object_collision(A)
	else
		return ..()

	last_crash_time = world.time

/obj/vehicle/motorbike/Collide(atom/A)
	if(!seats[VEHICLE_DRIVER])
		return FALSE

	if(!ismob(A))
		return ..()

	// Если скорость низкая, то нам не нужно сталкиваться
	if(current_speed_level <= 1)
		message_admins("Столкновение скорость не та")
		return ..()

	var/mob/M = A

	var/mod = 0
	var/bike_collide = TRUE
	switch(M.mob_size)
		if(MOB_SIZE_SMALL)
			bike_collide = FALSE
			mod = 2
		if(MOB_SIZE_HUMAN)
			mod = 1
		if(MOB_SIZE_XENO_VERY_SMALL)
			bike_collide = FALSE
			mod = 1.2
		if(MOB_SIZE_XENO_SMALL)
			mod = 0.9
		if(MOB_SIZE_XENO)
			mod = 0.7
		if(MOB_SIZE_BIG)
			mod = 0.3
		if(MOB_SIZE_IMMOBILE)
			mod = 0

	// Учитываем скорость при столкновении
	mod *= current_speed_level * 0.5

	if(iscarbon(M))
		var/mob/living/carbon/C = M
		if(isyautja(C))
			mod *= 0.5
		if(mod)
			collide_mob(A, C, 1, 17 * mod, 2 * mod, 10 * mod, try_broke_bones = TRUE)
			message_admins("Столкновение 1 [A] с [C]")
		if(isxeno(M))
			attack_alien(M)
	else if(isliving(M) && !iscarbon(M))
		var/mob/living/L = M
		L.adjustBruteLoss(20 * current_speed_level)

	if(!bike_collide)
		playsound(src.loc, 'sound/effects/bone_break7.ogg', 25, 1)
		buckled_mob.visible_message(SPAN_DANGER("[buckled_mob] на [name] переехал [A]!"))
		message_admins("Столкновение return")
		return ..()

	playsound(src.loc, 'sound/effects/bang.ogg', 50, 1)

	if(!blooded)
		blooded = TRUE
		update_overlay()

	var/mob/living/carbon/occupant = buckled_mob
	unbuckle()
	if(mod)
		collide_mob(A, occupant, min(3, current_speed_level), 17 / mod, 2 / mod, 12 / mod, TRUE)
		message_admins("Столкновение 2 [A] с [occupant]")

	if(stroller && stroller.buckled_mob)
		var/mob/living/carbon/second_occupant = stroller.buckled_mob
		if(mod)
			collide_mob(A, second_occupant, 0, 15 / mod, 3 / mod, 15 / mod)
			message_admins("Столкновение 3 [A] с [second_occupant]")

	occupant.visible_message(SPAN_DANGER("[occupant] на [name] врезался в [A]!"))

	// Сброс скорости после серьезного столкновения
	reset_speed()

	message_admins("Продолжаем")
	. = ..()

// ==========================================
// ================ Коллизии ================

/obj/vehicle/motorbike/proc/collide_mob(atom/A, mob/living/carbon/M,
			throw_range = 0, damage_value = 15,
			weaken_value = 2, stutter_value = 12,
			try_broke_bones = FALSE, chance_fracture = 15)
	// Учитываем текущую скорость в эффектах
	throw_range *= current_speed_level * 0.5
	damage_value *= current_speed_level * 0.7
	weaken_value *= current_speed_level * 0.5
	stutter_value *= current_speed_level * 0.7

	if(throw_range)
		M.throw_atom(A, throw_range, SPEED_FAST, src, TRUE)

	damage_value = round(damage_value)
	weaken_value = round(weaken_value)
	stutter_value = round(stutter_value)

	weaken_value = clamp(weaken_value, 1, 4)

	var/def_zone = rand_zone()
	M.apply_damage(damage_value, BRUTE, def_zone)
	M.apply_effect(weaken_value, STUN)
	M.apply_effect(weaken_value, WEAKEN)
	M.apply_effect(stutter_value, STUTTER)
	message_admins("В [A] врезался [name] со скоростью [current_speed_level]! [M] получил [damage_value] урона, [weaken_value] ослабления и [stutter_value] заикания.", M.x, M.y, M.z)
	if(!ishuman(M))
		return

	if(!try_broke_bones)
		return
	var/obj/limb/L = M.get_limb(def_zone)
	if(L && prob(chance_fracture * current_speed_level * 0.5))
		L.fracture(100)
		message_admins("Сломал кости [try_broke_bones ? "с шансом" : "без шанса"] [chance_fracture * current_speed_level * 0.5] перелома костей в [def_zone ? "[def_zone]" : "рандомной"] зоне.", M.x, M.y, M.z)


// ==========================================
// ========== Коллизии с объектами ==========

/obj/vehicle/motorbike/proc/handle_wall_collision(turf/wall)
	if(!istype(wall, /turf/closed/wall))
		return

	var/speed_mod = current_speed_level * 0.5
	var/damage = 10 * speed_mod * crash_damage_multiplier

	// Наносим урон мотоциклу
	health -= damage

	// Эффекты для водителя
	if(buckled_mob)
		var/mob/living/L = buckled_mob
		L.apply_damage(damage * 0.7, BRUTE)
		L.apply_effect(current_speed_level, WEAKEN)
		L.apply_effect(current_speed_level * 2, STUN)
		to_chat(L, SPAN_HIGHDANGER("Вы врезались в стену на полной скорости!"))
		unbuckle()

	// Эффекты для пассажира в коляске
	if(stroller && stroller.buckled_mob)
		var/mob/living/L = stroller.buckled_mob
		L.apply_damage(damage * 0.5, BRUTE)
		L.apply_effect(current_speed_level, STUN)

	playsound(src, 'sound/effects/metal_crash.ogg', 75, 1)
	visible_message(SPAN_DANGER("[src] врезается в [wall] на полной скорости!"))

	// Сброс скорости после столкновения
	reset_speed()

/obj/vehicle/motorbike/proc/handle_object_collision(obj/O)
	if(O.density)
		var/speed_mod = current_speed_level * 0.3
		var/damage = 5 * speed_mod * crash_damage_multiplier

		// Урон мотоциклу
		health -= damage

		// Урон объекту
		if(O.health)
			throwforce = damage	// для урона в hitby
			O.hitby(src)
			throwforce = initial(throwforce)

		// Эффекты для водителя
		if(buckled_mob)
			var/mob/living/L = buckled_mob
			L.apply_damage(damage * 0.5, BRUTE)
			L.apply_effect(current_speed_level * 0.5, STUN)
			to_chat(L, SPAN_WARNING("Вы врезались в [O]!"))

		playsound(src, 'sound/effects/grillehit.ogg', 50, 1)
		visible_message(SPAN_WARNING("[src] врезается в [O]!"))

		// Небольшой сброс скорости
		if(current_speed_level > 2)
			current_speed_level = 2
			update_speed()
