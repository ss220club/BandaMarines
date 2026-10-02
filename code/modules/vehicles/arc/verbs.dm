/obj/vehicle/multitile/arc/proc/toggle_antenna(mob/toggler)
	set name = "Переключить сенсорную антенну"	//SS220 EDIT
	set desc = "Выдвигает или убирает сенсорную антенну ARC. Если выдвинута, то ARC не может передвигаться."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = toggler || usr
	if(!user || !istype(user))
		return

	var/obj/vehicle/multitile/arc/vehicle = user.interactee
	if(!istype(vehicle))
		return

	var/seat
	for(var/vehicle_seat in vehicle.seats)
		if(vehicle.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break

	if(!seat)
		return

	if(vehicle.health < initial(vehicle.health) * 0.5)
		to_chat(user, SPAN_WARNING("[vehicle]'s hull is too damaged to operate!"))
		return

	var/obj/item/hardpoint/support/arc_antenna/antenna = locate() in vehicle.hardpoints
	if(!antenna)
		to_chat(user, SPAN_WARNING("[vehicle] has no antenna mounted!"))
		return

	if(antenna.deploying)
		return

	if(antenna.health <= 0)
		to_chat(user, SPAN_WARNING("[antenna] is broken!"))
		return

	if(vehicle.antenna_deployed)
		to_chat(user, SPAN_NOTICE("You begin to retract [antenna]..."))
		antenna.deploying = TRUE
		if(!do_after(user, max(vehicle.antenna_toggle_time - antenna.deploy_animation_time, 1 SECONDS), target = vehicle))
			to_chat(user, SPAN_NOTICE("You stop retracting [antenna]."))
			antenna.deploying = FALSE
			return

		antenna.retract_antenna()
		addtimer(CALLBACK(vehicle, PROC_REF(finish_antenna_retract), user), antenna.deploy_animation_time)

	else
		to_chat(user, SPAN_NOTICE("You begin to extend [antenna]..."))
		antenna.deploying = TRUE
		if(!do_after(user, max(vehicle.antenna_toggle_time - antenna.deploy_animation_time, 1 SECONDS), target = vehicle))
			to_chat(user, SPAN_NOTICE("You stop extending [antenna]."))
			antenna.deploying = FALSE
			return

		antenna.deploy_antenna()
		addtimer(CALLBACK(vehicle, PROC_REF(finish_antenna_deploy), user), antenna.deploy_animation_time)

/obj/vehicle/multitile/arc/proc/finish_antenna_retract(mob/user)
	var/obj/item/hardpoint/support/arc_antenna/antenna = locate() in hardpoints
	if(!antenna)
		antenna.deploying = FALSE
		return

	if(user)
		to_chat(user, SPAN_NOTICE("You retract [antenna], enabling the ARC to move again."))
		playsound(user, 'sound/machines/hydraulics_2.ogg', 80, TRUE)
	antenna_deployed = !antenna_deployed
	antenna.deploying = FALSE
	update_icon()
	SEND_SIGNAL(src, COMSIG_ARC_ANTENNA_TOGGLED)

/obj/vehicle/multitile/arc/proc/finish_antenna_deploy(mob/user)
	var/obj/item/hardpoint/support/arc_antenna/antenna = locate() in hardpoints
	if(!antenna)
		antenna.deploying = FALSE
		return

	if(user)
		to_chat(user, SPAN_NOTICE("You extend [antenna], locking the ARC in place."))
		playsound(user, 'sound/machines/hydraulics_2.ogg', 80, TRUE)
	antenna_deployed = !antenna_deployed
	antenna.deploying = FALSE
	update_icon()
	SEND_SIGNAL(src, COMSIG_ARC_ANTENNA_TOGGLED)

/obj/vehicle/multitile/arc/proc/open_arc_controls_guide()
	set name = "Справочник по управлению техникой"	//SS220 EDIT
	set desc = "Обязателен к просмотру для новых игроков на роли экипажа бронетехники или после обновлений."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!istype(user))
		return

	var/obj/vehicle/multitile/arc/vehicle = user.interactee
	if(!istype(vehicle))
		return

	var/seat
	for(var/vehicle_seat in vehicle.seats)
		if(vehicle.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break

	if(!seat)
		return
	//SS220 EDIT START
	var/dat = "<b><i>Обычные действия:</i></b><br>\
	1. <b>\"Дать имя технике\"</b> - позволяет дать произвольное имя технике. Единоразовое использование. Максимум 28 символов.<br> \
	2. <b>\"Получить информацию о статусе\"</b> - появляется окно \"Информация о статусе техники\" со всей доступной информацией о Вашей технике.<br> \
	3. <b>\"Переключить сенсорную антенну\"</b> - выдвигает или убирает сенсорную антенну ARC. Если выдвинута, то все неизвестные формы жизни в большом радиусе (45) будут видны на тактической карте, однако ARC не сможет передвигаться. Дополнительно активируется автоматическая пушка RE700.<br> \
	<font color='#cd6500'><b><i>Действия водителя:</i></b></font><br> 1. <b>\"Активация гудка\"</b> - задействует звуковой сигнал техники. Учтите, что гудок техники очень громкий, его могут услышать издалека как союзники, так и противники.<br> \
	2. <b>\"Переключить дверные замки\"</b> - переключает ограничения доступа к технике. Доступы командных ролей, брига и самого экипажа обходят эти ограничения.<br> \
	<font color='#cd6500'><b><i>Горячие клавиши водителя:</i></b></font><br> 1. <b>\"CTRL + Click\"</b> - активирует гудок техники.<br>"

	show_browser(user, dat, "Справочник по управлению техникой", "vehicle_help", width = 900, height = 500)	//SS220 EDIT FINISH
	onclose(user, "vehicle_help")
	return
