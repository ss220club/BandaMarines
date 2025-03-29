/obj/vehicle/motorbike
	//anchored = FALSE // Мы можем передвинуть байк, если он нам мешает.
	//drag_delay = 3 // Но медленно
	var/can_drive_when_hands_full = FALSE // Не надо водить когда хотя бы одна рука не свободна, лучше 2
	 // На будущее потеря контроля когда не можешь водить
	var/chance_lost_drive_control_when_one_hand = 2 // Ездишь с одной рукой - имеешь шанс нахуй потерять драйв контрол
	var/lost_drive_control_dir					 // Направление по которому начинает ездить машина потерявшее управление
	var/lost_drive_control_time_min = 2 SECONDS	 // Нижняя граница времени движения при потере контроля
	var/lost_drive_control_time_max	= 6 SECONDS // Верхняя граница времени движения при потере контроля
	var/lost_drive_control_time_temp = 0		 // "Когда" потеря контроля закончится по глобал тайму
	var/old_dir_saved = SOUTH
	var/old_dir = SOUTH

/obj/vehicle/motorbike/proc/on_move()
	SIGNAL_HANDLER
	update_stroller()
	if(old_dir == dir)
		play_move_sound()
	else
		play_rotate_sound()
		old_dir = dir

/obj/vehicle/motorbike/relaymove(mob/user, direction)
	if(!can_drive_when_hands_full)
		// Катаешься без рук - не можешь менять направление
		if(user.l_hand && user.r_hand)
			return ..(user, old_dir_saved)

		// С одной рукой - имеешь шанс поменять направление во время дороги
		if(user.l_hand || user.r_hand)
			if(!lost_drive_control_time_temp && prob(chance_lost_drive_control_when_one_hand))
				lost_drive_control_dir = turn(old_dir_saved, (prob(50) ? 90 : -90))
				var/lost_control_time = rand(lost_drive_control_time_min, lost_drive_control_time_max) * user.get_skill_duration_multiplier(SKILL_VEHICLE)
				lost_drive_control_time_temp = world.time + lost_control_time
				to_chat(user, SPAN_WARNING("Вы потеряли управление!"))
			if(world.time < lost_drive_control_time_temp)
				//. = step(src, lost_drive_control_dir)
				return ..(user, lost_drive_control_dir)
			else if(lost_drive_control_time_temp)
				lost_drive_control_time_temp = 0
				to_chat(user, SPAN_NOTICE("Вы восстановили управление!"))

		old_dir_saved = direction
	. = ..()

// ==========================================
// ========== Движение с коляской ===========

/obj/vehicle/motorbike/proc/update_stroller(force_update = FALSE)
	if(stroller)
		stroller.update_position(src, force_update)
