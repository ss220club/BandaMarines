/obj/vehicle/motorbike
	var/can_drive_when_hands_full = FALSE // Не надо водить когда хотя бы одна рука не свободна, лучше 2
	 // На будущее потеря контроля когда не можешь водить
	var/chance_lost_drive_control_when_one_hand = 5 // Ездишь с одной рукой - имеешь шанс нахуй потерять драйв контрол
	var/lost_drive_control_dir					 // Направление по которому начинает ездить машина потерявшее управление
	var/lost_drive_control_time_min = 2 SECONDS	 // Нижняя граница времени движения при потере контроля
	var/lost_drive_control_time_max	= 6 SECONDS // Верхняя граница времени движения при потере контроля
	var/lost_drive_control_time_temp = 0		 // "Когда" потеря контроля закончится по глобал тайму
	var/forward_dir = SOUTH // направление движения вперед при поворотах
	var/forward_dir_saved = SOUTH // Запоминаем куда мы ДВИГАЛИСЬ вперед


	// Система ускорения
	var/current_speed_level = 1 // 1 - начальная, 2 - промежуточная, 3 - максимальная
	var/straight_move_timer = 0
	var/last_move_time = 0
	var/move_delay_initial = 3
	var/move_delay_intermediate = 2
	var/move_delay_maximum = 1
	var/lightweight_speed_mod = 0.7 // Модификатор скорости если не прицеплена коляска

	// Скорость
	var/reset_time = 0.5 SECONDS // Через сколько секунд простоя сбрасываем скорость
	var/change_speed_time = 1.5 SECONDS // Через сколько времени меняем скорость (увеличиваем)

// ==========================================
// ========== Параметры движения ============

/obj/vehicle/motorbike/proc/update_drive_skill_parameters()
	if(!buckled_mob)
		chance_lost_drive_control_when_one_hand = initial(chance_lost_drive_control_when_one_hand)
		return
	var/mult = buckled_mob.get_skill_duration_multiplier(SKILL_VEHICLE)
	chance_lost_drive_control_when_one_hand = round(chance_lost_drive_control_when_one_hand * mult)

// ==========================================
// =============== Движение =================

/obj/vehicle/motorbike/proc/on_move()
	SIGNAL_HANDLER
	handle_acceleration()
	play_move_sound()
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay)) // плавность

/obj/vehicle/motorbike/relaymove(mob/user, direction)
	if(user.is_mob_incapacitated())
		return

	if(!direction) // Остановка
		if(current_speed_level != 1)
			reset_speed()
		return ..()

	if(!can_drive_when_hands_full && chance_lost_drive_control_when_one_hand >= 0)
		// Проверка движения назад
		var/back_dir = turn(dir, 180)
		if(direction == back_dir)
			reset_speed()

		// Проверка рук
		if(user.l_hand && user.r_hand)
			return ..(user, forward_dir_saved)

		// С одной рукой - имеешь шанс поменять направление во время дороги
		if(user.l_hand || user.r_hand)
			if(!lost_drive_control_time_temp && prob(chance_lost_drive_control_when_one_hand))
				lost_drive_control_dir = turn(forward_dir_saved, (prob(50) ? 90 : -90))
				var/lost_control_time = rand(lost_drive_control_time_min, lost_drive_control_time_max) * user.get_skill_duration_multiplier(SKILL_VEHICLE)
				lost_drive_control_time_temp = world.time + lost_control_time
				to_chat(user, SPAN_WARNING("Вы потеряли управление!"))
			if(world.time < lost_drive_control_time_temp)
				return ..(user, lost_drive_control_dir)
			else if(lost_drive_control_time_temp)
				lost_drive_control_time_temp = 0
				to_chat(user, SPAN_NOTICE("Вы восстановили управление!"))

		forward_dir_saved = direction

	// Движение вперед
	set_glide_size(DELAY_TO_GLIDE_SIZE(move_delay + 1))
	. = ..()

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
	if(!stroller)
		move_delay *= lightweight_speed_mod

/obj/vehicle/motorbike/proc/reset_speed()
	straight_move_timer = 0
	current_speed_level = 1
	update_speed()

/obj/vehicle/motorbike/proc/handle_acceleration()
	var/current_time = world.time

	// Сброс скорости при простое более 1 секунды
	if(current_time - last_move_time > 1 SECONDS && current_speed_level != 1)
		reset_speed()
		return

	// Движение по прямой
	if(forward_dir == dir)
		if(current_time - last_move_time > reset_time)
			straight_move_timer = 0 // Сброс таймера при долгой паузе
		else
			straight_move_timer += current_time - last_move_time

		// Повышение скорости каждые 3 секунды
		if(straight_move_timer >= change_speed_time && current_speed_level < 3)
			current_speed_level++
			straight_move_timer = 0
			update_speed()
	else // Поворот
		if(current_speed_level > 2)
			current_speed_level = 2
			update_speed()
		straight_move_timer = 0

	last_move_time = current_time

// ==========================================
// ========== Движение с коляской ===========

/obj/vehicle/motorbike/proc/update_stroller(force_update = FALSE)
	if(stroller)
		stroller.update_position(src, force_update)

/obj/vehicle/motorbike/handle_rotation()
	if(buckled_mob)
		buckled_mob.setDir(dir)
	play_rotate_sound()
	update_stroller()
	forward_dir = dir
