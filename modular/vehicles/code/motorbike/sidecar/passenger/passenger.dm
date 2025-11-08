/obj/structure/bed/chair/sidecar/passenger
	name = "Мотоциклетная пассажирская коляска"
	desc = "Хоть по внешнему виду это пожоже на коляску, которая может перевозит одного человека. но на самом деле это просто стул обшитый металлом."

	//======= Для отображения в игре ==============
	icon_state = "moto_ural_sidecar_passenger_classic"
	icon_base = "moto_ural_sidecar_passenger"
	//=============================================

	//========= Какие то параметры XDD ============
	buckling_y = 8	// можно было б 4, но увы, оно слишком выпирает
	//=============================================

	//======== Защита, здоровье и ремонт ==========
	// пока ничего менять не надо. :)
	//=============================================

	//=============== Перемещение =================
	drag_delay_heavy = 4 // Тяжеленько. Хотите пулеметную точку? Хотите и таскать медленно.
	//=============================================

	//=========== Смещение при коннекте ===========
	// пока ничего менять не надо. :)
	//=============================================

	//========== Buckling. В passenger ===========
	can_buckle = TRUE
	var/buckle_time = 3 SECONDS	// Не сразу можно сесть.
	var/hit_chance_buckled = PROJECTILE_COVERAGE_LOW // Шанс попасть по сидящему
	var/hit_chance_to_unbuckle = 10 // Каждый удар имеет шанс отсоединить куклу при попадании по ней
	//===========================================

/obj/structure/bed/chair/sidecar/passenger/Initialize()
	. = ..()
	if(buckled_mob)
		buckled_mob.setDir(dir)

/obj/structure/bed/chair/sidecar/passenger/update_overlay()
	.=..()
	//==== оверлей коляски поверх моба =======
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = layer_above) //over mobs
	overlays += I
	//========================================
	//=== оверлей пулемета поверх коляски ====
	if(mounted)
		var/gun_overlay = "m56d"
		if(istype(mounted, /obj/item/device/m2c_gun))
			gun_overlay = "m2c"
		if(mounted.rounds <= 0)
			gun_overlay += "_e"
		var/image/I_gun = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "moto_ural_[gun_overlay]", layer = layer_above) //over mobs
		overlays += I_gun
	//========================================

// ==========================================
// ============ Коннект с байком ============

/obj/structure/bed/chair/sidecar/passenger/connect(atom/connection)
	.=..(connection)
	update_bike_permutated() // В passenger

/obj/structure/bed/chair/sidecar/passenger/disconnect()
	if(connected)
		UnregisterSignal(connected, COMSIG_MOVABLE_MOVED)
	update_bike_permutated() // В passenger
	reload_connected()
	connected = null
	density = !density
	anchored = !anchored
	update_drag_delay(buckled_mob)
	update_position(src, TRUE)
	push_to_left_side(src)

// ==========================================

// ================ Movement ================
// ==========================================
// =============== Позиционка ===============

/obj/structure/bed/chair/sidecar/passenger/update_position(atom/target = null, force_update = FALSE)
	if(dir == target.dir && !force_update)
		return
	pixel_x = initial(pixel_x)
	pixel_y = initial(pixel_y)
	layer = initial(layer)
	if(target != src)
		update_connected(target)
	update_buckle_mob() // В passenger
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
			// В passenger
			if(buckled_mob)
				buckled_mob.pixel_x += pixel_x_sides * ndir	// Сидящего
			//============
			if(connected)
				connected.pixel_x += pixel_x_sides * ndir	// Приконекченное мото
				if(connected.buckled_mob)	// Приконекченного сидящего в мото
					connected.buckled_mob.pixel_x += pixel_x_sides * ndir
		if(EAST, WEST)
			// В passenger
			if(buckled_mob)
				buckled_mob.pixel_x = get_buckled_mob_pixel_x()
			//============

/obj/structure/bed/chair/sidecar/passenger/proc/get_buckled_mob_pixel_x() // В passenger
	return buckled_mob.pixel_x = pixel_x - initial(pixel_x) - 1

/obj/structure/bed/chair/sidecar/passenger/proc/get_buckled_mob_pixel_y() // В passenger
	return pixel_y - initial(pixel_y) + buckling_y

// ==========================================
// ============== Нормализация ==============

/obj/structure/bed/chair/sidecar/passenger/proc/reload_buckle_mob() // В passenger
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
	// В passenger
	if(buckled_mob)
		buckled_mob.setDir(old_dir)
	// ===========

// ==========================================
// =============Health и урон ===============

/obj/structure/bed/chair/sidecar/passenger/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		update_mob_gun_signal(TRUE) // В passenger
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/sidecar/passenger(src.loc, icon_skin) //поменять путь в motorbike_destroyed для sidecar
		// В passenger
		if(mounted)
			mounted.forceMove(src.loc)
			mounted.update_health(mounted.health) // Разрушенный каркас, патроны и тому подобное
		unbuckle()
		//============
		deconstruct(FALSE)
		QDEL_NULL(src)

/obj/structure/bed/chair/sidecar/passenger/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	// В passenger
	if(buckled_mob && prob(hit_chance_buckled))	// Шанс попасть по сидящему
		return buckled_mob.attack_animal(M)
	//============
	health -= M.melee_damage_upper
	src.visible_message(SPAN_DANGER("<B>[M] [M.attacktext] [src]!</B>"))
	M.attack_log += text("\[[time_stamp()]\] <font color='red'>рвет [src.name]</font>")
	if(prob(10))
		new /obj/effect/decal/cleanable/blood/oil(src.loc)
	healthcheck()

/obj/structure/bed/chair/sidecar/passenger/attack_alien(mob/living/carbon/xenomorph/M)
	if(unslashable)
		return
	if(M.melee_damage_upper == 0)
		return
	// В passenger
	if(buckled_mob && prob(hit_chance_buckled))
		var/mob/affected_mob = buckled_mob
		if(prob(hit_chance_to_unbuckle))
			unbuckle()
			affected_mob.apply_effect(1, WEAKEN)
			affected_mob.throw_atom(src, 1, VEHICLE_SPEED_FASTER, M, TRUE)
			M.visible_message(SPAN_DANGER("[M] сшибает [src]!"), SPAN_DANGER("Мы сшибаем [src]!"))
		affected_mob.attack_alien(M)	// Шанс попасть по сидящему
	//============
	M.animation_attack_on(src)
	playsound(src, hit_bed_sound, 25, 1)
	M.visible_message(SPAN_DANGER("[M] кромсает [src]!"),
	SPAN_DANGER("Мы кромсаем [src]."))
	health -= M.melee_damage_upper
	healthcheck()
	return XENO_ATTACK_ACTION

/obj/structure/bed/chair/sidecar/passenger/bullet_act(obj/projectile/P)
	// В passenger
	if(buckled_mob && prob(hit_chance_buckled) && buckled_mob.get_projectile_hit_chance(P))
		return buckled_mob.bullet_act(P)	// Сидящие тоже могут получить пулю в задницу
	//============
	.=..()

// ==========================================
// ================= Guns ===================

/obj/structure/bed/chair/sidecar/passenger // В passenger
	var/obj/structure/machinery/m56d_hmg/mounted
	var/allowed_types_to_mount = list(
		/obj/item/device/m56d_gun,
		/obj/item/device/m2c_gun)
	var/allowed_types_to_reload = list(
		/obj/item/ammo_magazine/m56d,
		/obj/item/ammo_magazine/m2c)
	var/mounted_type
	var/mounted_time_to_assembly = 20 SECONDS	// Присоединение
	var/mounted_time_to_disassembly = 7 SECONDS	// Отсоединение

	var/mounted_div_shoot_degree = 1.5 // Уменьшаем градус стрельбы

// ==========================================
// ================ Пулеметы ================

/obj/structure/machinery/m56d_hmg/low // В passenger
	// Стрельба
	shoot_degree = 65
	fire_delay = 0.4 SECONDS
	burst_fire_delay = 0.3 SECONDS
	autofire_slow_mult = 1.2

/obj/structure/machinery/m56d_hmg/auto/low // В passenger
	// Стрельба
	shoot_degree = 45
	fire_delay = 0.2 SECONDS
	burst_fire_delay = 0.25 SECONDS
	cadeblockers_range = 0
	autofire_slow_mult = 1.2

// ==========================================
// ============== Безопасность ==============
// Убираем возможность убить байкера.

/obj/structure/machinery/m56d_hmg // В passenger
	var/list/objects_for_permutated = list()	// Кого не стоит дополнительно задевать, кроме стрелка.

// Даем пуле понимание кого "не трогать"
/obj/structure/machinery/m56d_hmg/load_into_chamber() // В passenger
	. = ..()
	if(!in_chamber)
		return .
	if(!length(objects_for_permutated))
		return .
	for(var/i in objects_for_permutated)
		in_chamber.permutated |= i

/obj/structure/bed/chair/sidecar/passenger/update_bike_permutated(only_mob = FALSE) // В passenger
	if(!mounted)
		return
	if(!connected)
		return
	if(!only_mob)
		mounted.objects_for_permutated.Add(connected)
	if(!connected.buckled_mob)
		return
	mounted.objects_for_permutated.Add(connected.buckled_mob)

/obj/structure/bed/chair/sidecar/passenger/reset_bike_permutated(only_mob = FALSE) // В passenger
	if(!mounted)
		return
	// Убираем возможность "задеть" байкера.
	if(!connected)
		mounted.objects_for_permutated = list()
		return
	if(!only_mob)
		mounted.objects_for_permutated.Remove(connected)
	if(!connected.buckled_mob)
		return
	mounted.objects_for_permutated.Remove(connected.buckled_mob)

// ==========================================
// ============== Взаимодействие =============

/obj/structure/bed/chair/sidecar/passenger/get_examine_text(mob/user) // В passenger
	. = ..()
	if(!mounted)
		return
	if(user != buckled_mob)
		. += SPAN_NOTICE("На [name] установлен [mounted.name].")
		return
	if(isxeno(user))
		. += SPAN_WARNING("Вы видите установленную огнепалку на этой железяке...")
		return
	. += SPAN_NOTICE("В [mounted.name] боекомплект [mounted.rounds]/[mounted.rounds_max]")

/obj/structure/bed/chair/sidecar/passenger/attackby(obj/item/O as obj, mob/user as mob) // В passenger
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return ..()

	// Установка пулеметов
	for(var/allowed_type in allowed_types_to_mount)
		if(istype(O, allowed_type))
			assembly(O, user)
			return TRUE

	if(!mounted)
		return ..()

	// Перезарядка
	for(var/allowed_type in allowed_types_to_reload)
		if(istype(O, allowed_type))
			reload(O, user)
			return TRUE

	// Разборка уже установленного объекта
	if(HAS_TRAIT(O, TRAIT_TOOL_SCREWDRIVER)) // Lets take it apart.
		return dissasemble(O, user)

	. = ..()

// Сборка
/obj/structure/bed/chair/sidecar/passenger/proc/assembly(obj/item/O, mob/user) // В passenger
	to_chat(user, "Вы устанавливаете [mounted] на коляску...")
	if(!do_after(user, mounted_time_to_assembly * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		return FALSE

	var/rounds_temp = 0

	if(istype(O, /obj/item/device/m56d_gun))
		//var/obj/structure/machinery/m56d_post/post = new(src)
		var/obj/item/device/m56d_gun/D = O
		if(D.has_mount)
			to_chat(user, SPAN_NOTICE("Вы отсоединили станок от [D.name]."))
			new /obj/item/device/m56d_post(user.loc)
		var/obj/structure/machinery/m56d_hmg/low/G = new(src)
		mounted = G
		mounted_type = D.type
		rounds_temp = D.rounds

	else if(istype(O, /obj/item/device/m2c_gun))
		var/obj/item/device/m2c_gun/D = O
		var/obj/structure/machinery/m56d_hmg/auto/low/G = new(src)	// Да, это тип M2C
		mounted = G
		mounted_type = D.type
		rounds_temp = D.rounds

	if(mounted)
		mounted.setDir(dir) // Make sure we face the right direction
		mounted.rounds = rounds_temp
		mounted.health = O.health // retain damage
		mounted.anchored = TRUE
		O.transfer_label_component(mounted)
		to_chat(user, SPAN_NOTICE("Вы установили [mounted.name] на коляску."))
		update_overlay()
		update_mob_gun_signal() // вдруг уже кто-то сидит
		update_bike_permutated() // Не хотим чтобы он застрелил того кто сидит
		QDEL_NULL(O)

// Разборка
/obj/structure/bed/chair/sidecar/passenger/proc/dissasemble(obj/item/O, mob/user) // В passenger
	if(!mounted)
		return FALSE
	if(mounted.locked)
		to_chat(user, "Установленное [mounted.name] невозможно отсоединить...")
		return FALSE
	to_chat(user, "Вы отсоединяете [mounted.name] на коляске...")
	if(!do_after(user, mounted_time_to_disassembly * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(user, SPAN_DANGER("Вы прекратили отсоединение [mounted.name] на коляске."))
		return FALSE
	user.visible_message(SPAN_NOTICE("[user] отсоединил [mounted.name] от [src.name]!"), SPAN_NOTICE("Вы отсоединили [mounted.name] от [src.name]!"))
	playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)

	var/obj/item/device/m56d_gun/HMG = new mounted_type(loc)
	mounted.transfer_label_component(HMG)
	HMG.rounds = mounted.rounds
	HMG.health = mounted.health
	HMG.update_icon()

	update_mob_gun_signal(TRUE) // вдруг уже кто-то сидит
	QDEL_NULL(mounted)
	update_overlay()
	update_buckle_mob()
	return TRUE

// Перезарядка
/obj/structure/bed/chair/sidecar/passenger/proc/reload(obj/item/O, mob/user) // В passenger
	if(!skillcheck(user, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("Вы недостаточно натренированы чтобы работать с этим калибром!"))
		return
	// Тыкаем магазином в них же и совершаем "перезарядку"
	// Он должен тыканьем заполненного магазина менять магазин внутри.
	mounted.attackby(O, user)
	update_overlay()

// ==========================================
// ================ Сигналы =================

#define COMSIG_MOB_MG_ENTER_VC "mob_vc_mg_enter"  // В passenger
#define COMSIG_MOB_MG_EXIT_VC "mob_vc_mg_exit"    // В passenger

// Стрельба
/obj/structure/bed/chair/sidecar/passenger/proc/update_mob_gun_signal(force_reset = FALSE) // В passenger
	if(!buckled_mob)
		return
	if(!ishuman_strict(buckled_mob))
		return	// Только люди могут стрелять
	// Перезапускаем сигналы и кнопки
	if(force_reset)
		remove_action(buckled_mob, /datum/action/human_action/mg_enter_vc)
		remove_action(buckled_mob, /datum/action/human_action/mg_exit_vc)
		UnregisterSignal(buckled_mob, COMSIG_MOB_MG_ENTER_VC)
		UnregisterSignal(buckled_mob, COMSIG_MOB_MG_EXIT_VC)
		if(mounted) mounted.on_unset_interaction(buckled_mob)

	// Даем сигналы мобу, если прикручен пулемет и моб сидит и не мертв
	else if(mounted && !buckled_mob.stat)
		RegisterSignal(buckled_mob, COMSIG_MOB_MG_ENTER_VC, PROC_REF(on_set_gun_interaction))	// Теперь мы можем перезайти за пулемет
		RegisterSignal(buckled_mob, COMSIG_MOB_MG_EXIT_VC, PROC_REF(on_unset_gun_interaction))
		give_action(buckled_mob, /datum/action/human_action/mg_enter_vc)

/obj/structure/bed/chair/sidecar/passenger/proc/on_set_gun_interaction() // В passenger
	SIGNAL_HANDLER
	mounted.on_set_interaction_vc(buckled_mob)

/obj/structure/bed/chair/sidecar/passenger/proc/on_unset_gun_interaction() // В passenger
	SIGNAL_HANDLER
	mounted.on_unset_interaction_vc(buckled_mob)

/obj/structure/bed/chair/sidecar/passenger/proc/update_gun_dir() // В passenger
	mounted.setDir(dir)

/obj/structure/machinery/m56d_hmg/proc/on_set_interaction_vc(mob/user) // В passenger
	//ADD_TRAIT(user, TRAIT_IMMOBILIZED, INTERACTION_TRAIT)
	give_action(user, /datum/action/human_action/mg_exit_vc)
	remove_action(user, /datum/action/human_action/mg_enter_vc)
	user.setDir(dir)
	user.reset_view(src)
	user.status_flags |= IMMOBILE_ACTION
	user.visible_message(SPAN_NOTICE("[user] mans [src]."), SPAN_NOTICE("You man [src], locked and loaded!"))

	RegisterSignal(user, list(COMSIG_MOB_RESISTED, COMSIG_MOB_DEATH, COMSIG_LIVING_SET_BODY_POSITION), PROC_REF(exit_interaction))
	RegisterSignal(user, COMSIG_MOB_MOUSEDOWN, PROC_REF(start_fire))
	RegisterSignal(user, COMSIG_MOB_MOUSEDRAG, PROC_REF(change_target))
	RegisterSignal(user, COMSIG_MOB_MOUSEUP, PROC_REF(stop_fire))

	operator = user
	update_mouse_pointer(operator, TRUE)
	flags_atom |= RELAY_CLICK

/obj/structure/machinery/m56d_hmg/proc/on_unset_interaction_vc(mob/user) // В passenger
	//REMOVE_TRAIT(user, TRAIT_IMMOBILIZED, INTERACTION_TRAIT)
	give_action(user, /datum/action/human_action/mg_enter_vc)
	remove_action(user, /datum/action/human_action/mg_exit_vc)
	user.setDir(dir) //set the direction of the player to the direction the gun is facing
	user.reset_view(null)
	user.status_flags &= ~IMMOBILE_ACTION
	user.visible_message(SPAN_NOTICE("[user] lets go of [src]."), SPAN_NOTICE("You let go of [src], letting the gun rest."))
	user.remove_temp_pass_flags(PASS_MOB_THRU) // this is necessary because being knocked over while using the gun makes you incorporeal

	SEND_SIGNAL(src, COMSIG_GUN_INTERRUPT_FIRE)
	UnregisterSignal(user, list(
		COMSIG_MOB_RESISTED,
		COMSIG_MOB_DEATH,
		COMSIG_LIVING_SET_BODY_POSITION,
		COMSIG_MOB_MOUSEUP,
		COMSIG_MOB_MOUSEDOWN,
		COMSIG_MOB_MOUSEDRAG,
	))

	if(operator == user) //We have no operator now
		operator = null
	flags_atom &= ~RELAY_CLICK

// ==========================================
// ================ Actions =================

/datum/action/human_action/mg_enter_vc // В passenger
	name = "Использовать орудие"
	action_icon_state = "frontline_toggle_on"

/datum/action/human_action/mg_enter_vc/action_activate() // В passenger
	. = ..()
	if(!can_use_action())
		return

	var/mob/living/carbon/human/human_user = owner
	SEND_SIGNAL(human_user, COMSIG_MOB_MG_ENTER_VC)


/datum/action/human_action/mg_exit_vc // В passenger
	name = "Отставить орудие"
	action_icon_state = "cancel_view"

/datum/action/human_action/mg_exit_vc/action_activate() // В passenger
	. = ..()
	if(!can_use_action())
		return

	var/mob/living/carbon/human/human_user = owner
	SEND_SIGNAL(human_user, COMSIG_MOB_MG_EXIT_VC)

#undef COMSIG_MOB_MG_EXIT

// ==========================================
// ================Buckling==================

// =============== Усаживание ===============

/obj/structure/bed/chair/sidecar/passenger/buckle_mob(mob/living/carbon/human/mob, mob/user) // В passenger
	if(!try_buckle_mob(mob, user))
		return TRUE
	. = ..()

/obj/structure/bed/chair/sidecar/passenger/proc/can_xeno_buckle(mob/M) // В passenger
	// Мы можем посадить небольшого ксеноса, если он будет помогать лапками в граб интенте. Как на кровати.
	// мы сможем украсть руню или ящерку, если они не особо сопротивляться будут
	// Мы можем посадить: Lesser Drones, Люди
	return (
		(M.mob_size == MOB_SIZE_XENO && \
			(M.a_intent == INTENT_GRAB || M.stat == DEAD)) \
		|| \
		(M.mob_size == MOB_SIZE_XENO_SMALL && \
			(M.a_intent == INTENT_HELP || M.a_intent == INTENT_GRAB || M.stat == DEAD)) \
		|| \
		(M.mob_size <= MOB_SIZE_XENO_VERY_SMALL)
		)

/obj/structure/bed/chair/sidecar/passenger/proc/try_buckle_mob(mob/M, mob/user) // В passenger
	if(!ismob(M) || (get_dist(src, user) > 1) || user.stat || buckled_mob || M.buckled)
		return FALSE
	if(!ishumansynth_strict(user))
		return FALSE	// Садить могут только хуманы и синты
	if(!can_xeno_buckle(M))
		return FALSE
	if(!do_after(user, buckle_time * user.get_skill_duration_multiplier(SKILL_VEHICLE), INTERRUPT_ALL, BUSY_ICON_FRIENDLY))
		return FALSE
	if(!ismob(M) || (get_dist(src, user) > 1) || user.stat || buckled_mob || M.buckled)
		to_chat(user, SPAN_WARNING("Кто-то был быстрее!"))
		return FALSE
	do_buckle(M, user)
	if(buckling_sound)
		playsound(src, buckling_sound, 20)
	return TRUE

/obj/structure/bed/chair/sidecar/passenger/afterbuckle(mob/M) // В passenger
	. = ..()
	if(buckled_mob)
		update_buckle_mob()
		update_drag_delay(buckled_mob)
		update_mob_gun_signal()
		update_bike_permutated(TRUE)
		RegisterSignal(buckled_mob, list(COMSIG_MOB_RESISTED, COMSIG_MOB_DEATH, COMSIG_LIVING_SET_BODY_POSITION, COMSIG_MOB_TACKLED_DOWN), PROC_REF(unbuckle))
	else
		if(connected)
			push_to_left_side(buckled_mob)
		update_drag_delay(buckled_mob)
		reset_bike_permutated(TRUE)

/obj/structure/bed/chair/sidecar/passenger/unbuckle() // В passenger
	// Отдельно, иначе возникнет ситуация где сигнал не успевает убраться,
	// т.к. нам ВСЕГДА нужен моб чтобы убрать у него сигнал
	update_mob_gun_signal(TRUE)
	reload_buckle_mob()
	UnregisterSignal(buckled_mob, list(COMSIG_MOB_RESISTED, COMSIG_MOB_DEATH, COMSIG_LIVING_SET_BODY_POSITION, COMSIG_MOB_TACKLED_DOWN))
	. = ..()

// ==========================================
// =============== Обновление ===============

/obj/structure/bed/chair/sidecar/passenger/proc/update_buckle_mob() // В passenger
	if(!buckled_mob)
		return
	buckled_mob.pixel_x = get_buckled_mob_pixel_x()
	buckled_mob.pixel_y = get_buckled_mob_pixel_y()
	buckled_mob.setDir(dir)
	buckled_mob.density = FALSE
	if(dir == WEST)
		buckled_mob.layer = layer_west
	else
		buckled_mob.layer = initial(buckled_mob.layer)
	if(mounted)
		update_gun_dir()

// ==========================================
// ==========================================

