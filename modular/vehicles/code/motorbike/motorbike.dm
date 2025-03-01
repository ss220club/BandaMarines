/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural"
	var/icon_skin = "classic"

	health = 700
	maxhealth = 700
	var/required_skill = SKILL_VEHICLE_SMALL

	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.

	move_delay = 1.5	// Скорость
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
	var/wrehcn_time = 10 SECONDS // Время коннекта при закручивании

	var/obj/structure/bed/chair/stroller/stroller = null // привязанная тележка
	var/hit_chance_connected = PROJECTILE_COVERAGE_MEDIUM // prob шанс задеть тележку или сидящего при попадании
	var/hit_chance_buckled = PROJECTILE_COVERAGE_MINIMAL // Шанс попасть по сидящему

	var/can_drive_when_hands_full = FALSE // Не надо водить когда хотя бы одна рука не свободна, лучше 2 // !!!!!!!!!!1 ДОДЕЛАТЬ
	/* // На будущее потеря контроля когда не можешь водить
	var/chance_lost_drive_control_when_one_hand = 10 // Ездишь с одной рукой - имеешь шанс нахуй потерять драйв контрол
	var/lost_drive_control_dir					 // Направление по которому начинает ездить машина потерявшее управление
	var/lost_drive_control_time_min = 2 SECONDS	 // Нижняя граница времени движения при потере контроля
	var/lost_drive_control_time_max	= 6 SECONDS // Верхняя граница времени движения при потере контроля
	var/lost_drive_control_time_temp = 0		 // "Когда" потеря контроля закончится по глобал тайму
	*/
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

/obj/vehicle/motorbike/proc/update_overlay()
	overlays.Cut()
	icon_state= initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = ABOVE_MOB_LAYER) //over mobs
	overlays += I

// ==========================================
// ================== Урон ==================
// После уничтожения - создается разрушенный каркас

// Главный чекер урона у vehicle
/obj/vehicle/motorbike/healthcheck()
	check_and_try_disasemble()
	. = ..()

/obj/vehicle/motorbike/proc/check_and_try_disasemble(damage = 0)
	if(health - damage <= 0)
		stroller.disconnect()
		//vehicle is dead, no more lights
		if(lighting_holder.light_range)
			lighting_holder.set_light_on(FALSE)
		QDEL_NULL(lighting_holder)
		new /obj/motorbike_destroyed(src.loc, icon_skin)


/obj/vehicle/motorbike/bullet_act(obj/projectile/P)
	if(stroller && prob(hit_chance_connected) && stroller.get_projectile_hit_boolean(P))
		return stroller.bullet_act(P)	// Приконекченная тележка задевается если задевать и мотоцикл
	if(buckled_mob && prob(hit_chance_buckled) && buckled_mob.get_projectile_hit_chance(P))
		return buckled_mob.bullet_act(P)	// Сидящие тоже могут получить пулю в задницу
	. = ..()


// ==========================================
// ========== Движение с коляской ==========

/obj/vehicle/motorbike/Moved(atom/oldloc, direction, Forced)
	. = ..()
	update_stroller()

/obj/vehicle/motorbike/proc/update_stroller(force_update = FALSE)
	if(stroller)
		stroller.update_position(src, force_update)


/obj/vehicle/motorbike/do_buckle(mob/living/target, mob/user)
	if(!skillcheck(target, SKILL_VEHICLE, required_skill))
		if(target == user)
			to_chat(user, SPAN_WARNING("Вы без понятия как им управлять!"))
		return FALSE
	if(..())
		update_stroller(src, TRUE)

// ==========================================
// ======== Действия с инструментами ========

/obj/vehicle/motorbike/attackby(obj/item/O as obj, mob/user as mob)

	// Присоединение
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))		// !!!!!!!!!!! НЕ РАБОТАЕТ
		var/mob/living/L = user
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		L.animation_attack_on(src)
		to_chat(user, SPAN_NOTICE("Вы начинаете крутить крепежи..."))
		if(!do_after(user, wrehcn_time, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
			to_chat(user, SPAN_WARNING("Крутка крипежей прервана."))
			return FALSE
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		L.animation_attack_on(src)
		if(stroller)
			stroller.disconnect()
			stroller = null
		else
			if(!try_connect(user))
				return ..()
		to_chat(user, SPAN_NOTICE("Вы [anchored ? "присоединили" : "отсоединили"] коляску."))
		return TRUE

	// Ремонт корпуса
	if (iswelder(O))
		if(is_welded)
			to_chat(user, SPAN_WARNING("Вы уже варите!"))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("[O] недостаточен для ремонта корпуса!"))
			return FALSE
		if(health >= maxhealth)
			to_chat(user, SPAN_NOTICE("Корпус [src.name] в починке не нуждается!"))
			return TRUE
		var/obj/item/tool/weldingtool/WT = O
		if(WT.remove_fuel(1, user))
			is_welded = TRUE
			if(!do_after(user, welder_time, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
				to_chat(user, SPAN_NOTICE("Вы прервали сварку корпуса [src.name] с помощью [O]."))
				is_welded = FALSE
				return FALSE
			if(!src || !WT.isOn())
				to_chat(user, SPAN_NOTICE("Сварка корпуса [src.name] прервана из-за непригодных обстоятельств."))
				is_welded = FALSE
				return FALSE
			is_welded = FALSE
			var/procent = round((health / maxhealth) * 100)
			if(!lighting_holder.light)
				lighting_holder.set_light_on(TRUE)
				lighting_holder.set_light_range(vehicle_light_range)
			to_chat(user, SPAN_NOTICE("Вы сварили корпус [src.name] с помощью [O]. Сварено на [procent]%"))
			health = min(health + welder_health, maxhealth)
			playsound(src.loc, 'sound/items/Welder.ogg', 25, 1)
		else
			to_chat(user, SPAN_WARNING("В [O] не хватает топлива!"))
		return TRUE

	// Ремонт шин
	//if (iswire())
	. = ..()

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
