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
	health = 800 // Тележка прочнее мотоцикла. Увы, но это просто кусок металла.
	var/maxhealth = 800
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/welder_time = 1 SECONDS	// Время требуемое для сварки

	can_buckle = TRUE
	var/obj/connected

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
		connect()
	else
		disconnect()

/obj/structure/bed/chair/stroller/proc/update_overlay()
	overlays.Cut()
	icon_state = initial(icon_state)
	icon_state = "[icon_state]_[icon_skin]"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = layer_above) //over mobs
	overlays += I

// ==========================================
// ======== Действия с инструментами ========

/obj/structure/bed/chair/stroller/attackby(obj/item/O as obj, mob/user as mob)

	// Присоединение
	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
		to_chat(user, SPAN_WARNING("Коляску можно [connected ? "от" : "при"]соединить только через мотоцикл."))
		return FALSE

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
// ============ Коннект с байком ============

/obj/structure/bed/chair/stroller/proc/connect()
	density = initial(density)
	anchored = initial(anchored)
	drag_delay = FALSE
	//connected - выставляется через привязь в motorbike

/obj/structure/bed/chair/stroller/proc/disconnect()
	density = !density
	anchored = !anchored
	drag_delay = initial(drag_delay)
	connected = null

// ==========================================
