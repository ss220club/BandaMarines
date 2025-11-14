// стул на колесиках, по другому "сайдкар"
/obj/structure/bed/chair/sidecar
	name = "Мотоциклетная коляска - Родительская"
	desc = "Эта коляска не должна существовать в этой реальности"

	//======= Для отображения в игре ==============
	icon = 'modular/vehicles/icons/moto48x48.dmi'
	icon_state = "moto_ural_sidecar_classic"	// Для отображения на картах. //сюда бы смешную заглушку, чтобы понимать, что создал не то.
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
	var/obj/connected // Приконекченный байк
	var/welder_time = 1 SECONDS	// Время требуемое для сварки
	var/is_welded = FALSE	// Сейчас происходит процесс варки?
	//=============================================

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
