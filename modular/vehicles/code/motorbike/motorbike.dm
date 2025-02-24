/obj/vehicle/motorbike
	name = "Мотоцикл"
	desc = "Для крутышей."
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural"
	var/icon_skin = "classic"

	pixel_x = -8	// спрайт 48х48, центрируем.
	buckling_y = 7
	layer = ABOVE_LYING_MOB_LAYER //Allows it to drive over people, but is below the driver.
	var/pixel_x_sides = 10// !!!!!!!!!! pixel_x = 10 --- сделать смещение для выравнивания на тайле, когда приконекчен stroller

	move_delay = 1.5
	health = 600
	maxhealth = 600
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки

	var/obj/structure/bed/chair/stroller/stroller = null // привязанная тележка

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
		new /obj/motorbike_destroyed(src.loc, icon_skin)

// ==========================================
// ========== Движение с коляской ==========

/obj/vehicle/motorbike/Moved(atom/oldloc, direction, Forced)
	. = ..()
	update_stroller()

/obj/vehicle/motorbike/proc/update_stroller(force_update = FALSE)
	if(stroller)
		stroller.update_position(src, force_update)

// ==========================================
// ======== Действия с инструментами ========

/obj/vehicle/motorbike/attackby(obj/item/O as obj, mob/user as mob)

	// Присоединение
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
		if(stroller)
			stroller.disconnect()
			stroller = null
		else
			if(!try_connect(user))
				return ..()
		to_chat(user, SPAN_NOTICE("Вы [anchored ? "присоединили" : "отсоединили"] коляску."))
		if(isliving(user))
			var/mob/living/L = user
			L.animation_attack_on(src)
		return TRUE

	// Ремонт корпуса
	if (iswelder(O))
		if(!HAS_TRAIT(O, TRAIT_TOOL_BLOWTORCH))
			to_chat(user, SPAN_WARNING("[O] недостаточен для ремонта корпуса!"))
			return FALSE
		if(health >= maxhealth)
			to_chat(user, SPAN_NOTICE("Корпус [src.name] в починке не нуждается!"))
			return TRUE
		var/obj/item/tool/weldingtool/WT = O
		if(WT.remove_fuel(1, user))
			if(!do_after(user, welder_time, INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
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
	for(var/obj/structure/bed/chair/stroller/S in range(1))
		if(S.health <= S.maxhealth)
			to_chat(user, SPAN_DANGER("[S] повреждена и требует ремонта."))
			return FALSE
		return S

// Завершаем конект в коляске
/obj/vehicle/motorbike/proc/connect()
	stroller.connect()

// ==========================================
