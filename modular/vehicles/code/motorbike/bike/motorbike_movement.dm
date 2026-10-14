/obj/vehicle/motorbike

	// Неуправляемая езда
	/// Уровень езды после которого можешь водить с одной рукой, иначе только 2 или потеряешь управление
	var/skill_vehicle_required_onehand = SKILL_VEHICLE_SMALL
	/// Проверка на прохождение значения скила skill_vehicle_required_onehand
	var/can_drive_one_hand = FALSE
	// TODO: Потеря контроля когда не можешь водить
	/// Ездишь с одной рукой - имеешь шанс нахуй потерять драйв контрол
	var/chance_lost_drive_control_when_one_hand = 5
	/// Направление по которому начинает ездить машина потерявшее управление
	var/lost_drive_control_dir
	/// Нижняя граница времени движения при потере контроля
	var/lost_drive_control_time_min = 2 SECONDS
	/// Верхняя граница времени движения при потере контроля
	var/lost_drive_control_time_max	= 6 SECONDS
	/// "Когда" потеря контроля закончится по глобал тайму
	var/lost_drive_control_time_temp = 0
	/// направление движения вперед при поворотах
	var/forward_dir = SOUTH
	/// Запоминаем куда мы ДВИГАЛИСЬ вперед
	var/forward_dir_saved = SOUTH

	// Система ускорения
	var/current_speed_level = BIKE_SPEED_MIN
	var/straight_move_timer = 0
	var/last_move_time = 0
	var/move_delay_initial = 3
	var/move_delay_intermediate = 2
	var/move_delay_maximum = 1
	var/lightweight_speed_mod = 0.7 // Модификатор скорости если не прицеплена коляска
	var/momentum_loss_on_weeds_factor = 0.2

	// Скорость
	/// Через сколько секунд простоя сбрасываем скорость
	var/reset_time = 0.5 SECONDS
	/// Через сколько времени меняем скорость (увеличиваем)
	var/change_speed_time = 1.5 SECONDS

// ==========================================
// ========== Параметры движения ============

/obj/vehicle/motorbike/proc/update_drive_skill_parameters()
	can_drive_one_hand = FALSE
	chance_lost_drive_control_when_one_hand = initial(chance_lost_drive_control_when_one_hand)
	if(!buckled_mob)
		return

	// Проверяем что можем гонять с одной рукой
	if(skillcheck(buckled_mob, SKILL_VEHICLE, skill_vehicle_required_onehand))
		can_drive_one_hand = TRUE
	else
		// Если не можем, то у нас дебафф модификаторы к гонке одной рукой
		var/mult = buckled_mob.get_skill_duration_multiplier(SKILL_VEHICLE)
		chance_lost_drive_control_when_one_hand = round(chance_lost_drive_control_when_one_hand * mult)

// ==========================================
// =============== Движение =================

/obj/vehicle/motorbike/proc/on_move()
	SIGNAL_HANDLER
	play_move_sound()
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay)) // плавность

/obj/vehicle/motorbike/proc/can_process_move_input(mob/user)
	if(!user || user.is_mob_incapacitated())
		return FALSE

	if(seats[VEHICLE_DRIVER] != user)
		return FALSE

	return TRUE

/obj/vehicle/motorbike/proc/handle_stop_input()
	if(current_speed_level != BIKE_SPEED_MIN)
		reset_speed()

/obj/vehicle/motorbike/proc/handle_reverse_braking(direction)
	var/back_dir = turn(dir, 180)
	if(direction == back_dir)
		reset_speed()

/obj/vehicle/motorbike/proc/update_drive_control_loss(mob/user)
	var/had_control_loss_timer = lost_drive_control_time_temp

	if(!lost_drive_control_time_temp && prob(chance_lost_drive_control_when_one_hand))
		lost_drive_control_dir = turn(forward_dir_saved, (prob(50) ? 90 : -90))
		var/lost_control_time = rand(lost_drive_control_time_min, lost_drive_control_time_max) * user.get_skill_duration_multiplier(SKILL_VEHICLE)
		lost_drive_control_time_temp = world.time + lost_control_time
		to_chat(user, SPAN_WARNING("Вы потеряли управление!"))

	if(world.time < lost_drive_control_time_temp)
		return TRUE

	if(had_control_loss_timer)
		lost_drive_control_time_temp = 0
		to_chat(user, SPAN_NOTICE("Вы восстановили управление!"))

	return FALSE

/obj/vehicle/motorbike/proc/resolve_hand_control(mob/user, direction)
	var/list/move_context = list(
		"direction" = direction,
		"should_accelerate" = TRUE
	)

	if(user.l_hand && user.r_hand)
		move_context["direction"] = forward_dir_saved
		return move_context

	if(user.l_hand || user.r_hand)
		if(update_drive_control_loss(user))
			move_context["direction"] = lost_drive_control_dir
			move_context["should_accelerate"] = FALSE

	return move_context

/obj/vehicle/motorbike/proc/resolve_move_direction(mob/user, direction)
	if(!can_drive_one_hand && chance_lost_drive_control_when_one_hand >= 0)
		handle_reverse_braking(direction)
		return resolve_hand_control(user, direction)

	return list(
		"direction" = direction,
		"should_accelerate" = TRUE
	)

/obj/vehicle/motorbike/proc/prepare_move_glide()
	update_speed()
	var/old_glide_size = glide_size
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay + 1))
	return old_glide_size

/obj/vehicle/motorbike/proc/finalize_move(should_accelerate)
	forward_dir = dir

	if(should_accelerate)
		handle_acceleration()

/obj/vehicle/motorbike/proc/sync_sidecar_after_move()
	var/obj/structure/bed/chair/sidecar/active_sidecar = get_valid_sidecar()
	if(!active_sidecar)
		return

	var/turf/current_turf = get_turf(src)
	if(!current_turf)
		return

	if(active_sidecar.loc != current_turf)
		active_sidecar.forceMove(current_turf)
	active_sidecar.update_position(src, TRUE)

/obj/vehicle/motorbike/relaymove(mob/user, direction)
	if(!can_process_move_input(user))
		return

	if(!direction)
		handle_stop_input()
		return ..(user, direction)

	var/list/move_context = resolve_move_direction(user, direction)
	var/move_direction = move_context["direction"]
	var/should_accelerate = move_context["should_accelerate"]
	var/old_glide_size = prepare_move_glide()
	var/old_dir = dir
	. = ..(user, move_direction)
	if(dir != old_dir)
		handle_rotation()
	if(!.)
		set_glide_size(old_glide_size)
		return

	finalize_move(should_accelerate)
	return .

// ==========================================
// ================ Скорость ================

/obj/vehicle/motorbike/proc/update_speed()
	switch(current_speed_level)
		if(1)
			move_delay = move_delay_initial
		if(2)
			move_delay = move_delay_intermediate
		if(3)
			move_delay = move_delay_maximum
	if(!get_valid_sidecar())
		move_delay *= lightweight_speed_mod
	if(locate(/obj/effect/alien/weeds) in loc)
		move_delay /= momentum_loss_on_weeds_factor

/obj/vehicle/motorbike/proc/reset_speed()
	straight_move_timer = 0
	current_speed_level = BIKE_SPEED_MIN
	update_speed()

/obj/vehicle/motorbike/proc/handle_acceleration()
	var/current_time = world.time

	// Сброс скорости при отпускании педали газа
	if(current_speed_level != BIKE_SPEED_MIN && current_time - last_move_time > (move_delay + 1))
		reset_speed()
		return

	// Движение по прямой
	if(forward_dir_saved == forward_dir)
		if(current_time - last_move_time > reset_time)
			straight_move_timer = 0 // Сброс таймера при долгой паузе
		else
			straight_move_timer += current_time - last_move_time

		if(current_speed_level < BIKE_SPEED_MAX && straight_move_timer >= change_speed_time)
			current_speed_level++
			straight_move_timer = 0
			update_speed()
	else // Поворот
		if(current_speed_level > BIKE_SPEED_MEDIUM)
			current_speed_level = BIKE_SPEED_MEDIUM
			update_speed()
		straight_move_timer = 0

	last_move_time = current_time

	forward_dir_saved = forward_dir

// ==========================================
// ========== Движение с коляской ===========

/obj/vehicle/motorbike/proc/update_sidecar(force_update = FALSE)
	var/obj/structure/bed/chair/sidecar/active_sidecar = get_valid_sidecar()
	if(active_sidecar)
		active_sidecar.update_position(src, force_update)

/obj/vehicle/motorbike/handle_rotation()
	if(buckled_mob)
		buckled_mob.setDir(dir)
	play_rotate_sound()
	update_sidecar()
	forward_dir = dir
