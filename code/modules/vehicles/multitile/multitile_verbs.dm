//------------------------------------------------------
//------------------------VERBS-------------------------
//This file contains all basic verbs that vehicles contain


//Used to swap which module a position is using
//e.g. swapping primary gunner from the minigun to the smoke launcher
/obj/vehicle/multitile/proc/switch_hardpoint()
	set name = "Сменить активный модуль"	//SS220 EDIT
	set category = "Vehicle"

	var/mob/M = usr
	if(!M || !istype(M))
		return

	var/obj/vehicle/multitile/V = M.interactee
	if(!V || !istype(V))
		return

	var/seat = V.get_mob_seat(M)
	if(!seat)
		return

	var/list/usable_hps = V.get_activatable_hardpoints(seat)
	if(!LAZYLEN(usable_hps))
		to_chat(M, SPAN_WARNING("None of the hardpoints can be activated or they are all broken."))
		return

	var/obj/item/hardpoint/HP = tgui_input_list(usr, "Select a hardpoint.", "Switch Hardpoint", usable_hps)
	if(!HP)
		return

	var/obj/item/hardpoint/old_HP = V.active_hp[seat]
	if(old_HP)
		SEND_SIGNAL(old_HP, COMSIG_GUN_INTERRUPT_FIRE) //stop fire when switching away from HP

	V.active_hp[seat] = HP
	var/msg = "You select \the [HP]."
	if(HP.ammo)
		msg += " Ammo: <b>[SPAN_HELPFUL(HP.ammo.current_rounds)]/[SPAN_HELPFUL(HP.ammo.max_rounds)]</b> | Mags: <b>[SPAN_HELPFUL(LAZYLEN(HP.backup_clips))]/[SPAN_HELPFUL(HP.max_clips)]</b>"
	to_chat(M, SPAN_WARNING(msg))

//cycles through hardpoints in a activatable hardpoints list without asking anything
/obj/vehicle/multitile/proc/cycle_hardpoint()
	set name = "Выбрать следующий активный модуль"	//SS220 EDIT
	set category = "Vehicle"

	var/mob/M = usr
	if(!M || !istype(M))
		return

	var/obj/vehicle/multitile/V = M.interactee
	if(!istype(V))
		return

	var/seat = V.get_mob_seat(M)
	if(!seat)
		return

	var/list/usable_hps = V.get_activatable_hardpoints(seat)
	if(!LAZYLEN(usable_hps))
		to_chat(M, SPAN_WARNING("None of the hardpoints can be activated or they are all broken."))
		return
	var/new_hp = usable_hps.Find(V.active_hp[seat])
	if(!new_hp)
		new_hp = 0

	new_hp = (new_hp % length(usable_hps)) + 1
	var/obj/item/hardpoint/HP = usable_hps[new_hp]
	if(!HP)
		return

	var/obj/item/hardpoint/old_HP = V.active_hp[seat]
	if(old_HP)
		SEND_SIGNAL(old_HP, COMSIG_GUN_INTERRUPT_FIRE) //stop fire when switching away from HP

	V.active_hp[seat] = HP
	var/msg = "You select \the [HP]."
	if(HP.ammo)
		msg += " Ammo: <b>[SPAN_HELPFUL(HP.ammo.current_rounds)]/[SPAN_HELPFUL(HP.ammo.max_rounds)]</b> | Mags: <b>[SPAN_HELPFUL(LAZYLEN(HP.backup_clips))]/[SPAN_HELPFUL(HP.max_clips)]</b>"
	to_chat(M, SPAN_WARNING(msg))

// Used to lock/unlock the vehicle doors to anyone without proper access
/obj/vehicle/multitile/proc/toggle_door_lock()
	set name = "Переключить дверные замки"	//SS220 EDIT
	set category = "Vehicle"

	var/mob/M = usr
	if(!M || !istype(M))
		return

	var/obj/vehicle/multitile/V = M.interactee
	if(!istype(V))
		return

	var/seat = V.get_mob_seat(M)
	if(!seat)
		return
	if(seat != VEHICLE_DRIVER)
		return

	V.door_locked = !V.door_locked
	to_chat(M, SPAN_NOTICE("You [V.door_locked ? "lock" : "unlock"] the vehicle doors."))

//opens vehicle status window with HP and ammo of hardpoints
/obj/vehicle/multitile/proc/get_status_info()
	set name = "Получить информацию о статусе"	//SS220 EDIT
	set desc = "Отображает всю доступную информацию о Вашей технике в малом окне."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!istype(user))
		return

	var/obj/vehicle/multitile/V = user.interactee
	if(!istype(V))
		return

	var/seat
	for(var/vehicle_seat in V.seats)
		if(V.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break
	if(!seat)
		return

	V.tgui_interact(user)

// BEGIN TGUI \\

/obj/vehicle/multitile/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VehicleStatus", "[capitalize(name)]")
		ui.open()

/obj/vehicle/multitile/ui_data(mob/user)
	var/list/data = list()

	var/list/resist_name = list("Bio" = "acid", "Slash" = "slash", "Bullet" = "bullet", "Expl" = "explosive", "Blunt" = "blunt")
	var/list/resist_data_list = list()

	for(var/i in resist_name)
		var/resist = 1 - LAZYACCESS(dmg_multipliers, LAZYACCESS(resist_name, i))
		resist_data_list += list(list(
			"name" = i,
			"pct" = resist
		))

	data["resistance_data"] = resist_data_list
	data["integrity"] = floor(100 * health / initial(health))
	data["door_locked"] = door_locked
	data["total_passenger_slots"] = interior.passengers_slots
	data["total_taken_slots"] = interior.passengers_taken_slots

	var/list/passenger_category_data_list = list()

	for(var/datum/role_reserved_slots/RRS in interior.role_reserved_slots)
		passenger_category_data_list += list(list(
			"name" = RRS.category_name,
			"taken" = RRS.taken,
			"total" = RRS.total
		))

	data["passenger_categories_data"] = passenger_category_data_list

	var/list/hps = hardpoints.Copy()
	var/list/hardpoint_data_list = list()

	for(var/obj/item/hardpoint/holder/H in hps)
		hardpoint_data_list += H.get_tgui_info()
		LAZYREMOVE(hps, H)
	for(var/obj/item/hardpoint/H in hps)
		hardpoint_data_list += list(H.get_tgui_info())

	data["hardpoint_data"] = hardpoint_data_list

	return data

/obj/vehicle/multitile/ui_state(mob/user)
	return GLOB.not_incapacitated_state

// END TGUI \\

//opens vehicle controls guide, that contains description of all verbs and shortcuts in it
/obj/vehicle/multitile/proc/open_controls_guide()
	set name = "Справочник по управлению техникой"	//SS220 EDIT
	set desc = "Обязателен к просмотру для новых игроков на роли экипажа бронетехники или после обновлений"	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!istype(user))
		return

	var/obj/vehicle/multitile/V = user.interactee
	if(!istype(V))
		return

	var/seat
	for(var/vehicle_seat in V.seats)
		if(V.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break
	if(!seat)
		return
	//SS220 EDIT START
	var/dat = "<b><i>Обычные действия:</i></b><br>1. <b>\"Сменить активный модуль\"</b> - выводит список всех не уничтоженных и доступных вам активируемых модулей, в том числе оружия, позволяя переключить текущий активный модуль на другой из списка. Чтобы активировать выбранный модуль, кликните по нему. <font color='#cd6500'>УБЕДИТЕСЬ, ЧТО ВЫ НЕ ПОПАДЕТЕ ПО МОРПЕХАМ.</b></font><br>\
	2. <b>\"Дать имя технике\"</b> - позволяет дать произвольное имя технике. Единоразовое использование. Максимум 28 символов.<br> \
	3. <b>\"Получить информацию о статусе\"</b> - появляется окно \"Информация о статусе техники\" со всей доступной информацией о Вашей технике<br> \
	<font color='#cd6500'><b><i>Действия водителя:</i></b></font><br> 1. <b>\"Активация гудка\"</b> - задействует звуковой сигнал техники. Учтите, что гудок техники очень громкий, его могут услышать издалека как союзники, так и противники.<br> \
	2. <b>\"Переключить дверные замки\"</b> - переключает ограничения доступа к технике. Доступы командных ролей, брига и самого экипажа обходят эти ограничения.<br> \
	<font color=\"red\"><b><i>Действия стрелка:</i></b></font><br> 1. <b>\"Выбрать следующий активный модуль\"</b> - работает аналогично смене активного модуля, за исключением того, что эта функция автоматически переключается на следующий модуль в списке, позволяя делать это быстрее.<br> \
	2. <b>\"Переключить гиростабилизатор турели\"</b> - переключает гиростабилизатор турели, позволяя ей удерживать текущее направление и игнорировать поворот корпуса. <i>(Доступно только на технике с вращающейся турелью, например, на легком танке M34A2 «Лонгстрит».)</i><br> \
	<font color='#2cc42c'><b><i>Действия стрелка поддержки:</i></b></font><br> 1. <b>\"Перезарядка бортового оружия\"</b> - запускает автоматический процесс перезарядки для M56 FPW. Требуется подтверждение.<br> \
	<font color='#cd6500'><b><i>Горячие клавиши водителя:</i></b></font><br> 1. <b>\"CTRL + Click\"</b> - активирует гудок техники.<br> \
	<font color=\"red\"><b><i>Горячие клавиши стрелка:</i></b></font><br> 1. <b>\"ALT + Click\"</b> - Переключить гиростабилизатор турели. <i>(Доступно только на технике с вращающейся турелью, например, на легком танке M34A2 «Лонгстрит».)</i><br>"

	show_browser(user, dat, "Справочник по управлению техникой", "vehicle_help", width = 900, height = 500) //SS220 EDIT FINISH
	onclose(user, "vehicle_help")
	return

//toggles gyrostabilizer for vehicles that have turret, allowing it to keep direction regardless hull rotations
/obj/vehicle/multitile/proc/toggle_gyrostabilizer()
	set name = "Переключить гиростабилизатор турели"	//SS220 EDIT
	set desc = "Включает и выключает гиростабилизатор турели, позволяя ей двигаться независимо от направления движений корпуса."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/M = usr
	if(!M || !istype(M))
		return

	var/obj/vehicle/multitile/V = M.interactee
	if(!istype(V))
		return

	var/obj/item/hardpoint/holder/tank_turret/T = null
	for(var/obj/item/hardpoint/holder/tank_turret/TT in V.hardpoints)
		T = TT
		break
	if(!T)
		return
	T.toggle_gyro(usr)

//single use verb that allows VCs to add a nickname in "" at the end of their vehicle name
/obj/vehicle/multitile/proc/name_vehicle()
	set name = "Дать имя технике"	//SS220 EDIT
	set desc = "Позволяет дать произвольное имя технике. Единоразовое использование. Максимум 26 символов."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!istype(user))
		return

	var/obj/vehicle/multitile/V = user.interactee
	if(!istype(V))
		return

	var/seat
	for(var/vehicle_seat in V.seats)
		if(V.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break
	if(!seat)
		return

	if(V.nickname)
		to_chat(user, SPAN_WARNING("Vehicle already has a \"[V.nickname]\" nickname."))
		return

	var/new_nickname = stripped_input(user, "Enter a unique IC name or a callsign to add to your vehicle's name. [MAX_NAME_LEN] characters maximum. \n\nIMPORTANT! This is an IC nickname/callsign for your vehicle and you will be punished for putting in meme names.\nSINGLE USE ONLY.", "Name your vehicle", null, MAX_NAME_LEN)
	if(!new_nickname)
		return
	if(length(new_nickname) > MAX_NAME_LEN)
		alert(user, "Name [new_nickname] is over [MAX_NAME_LEN] characters limit. Try again.", "Naming vehicle failed", "Ok")
		return
	if(alert(user, "Vehicle's name will be [V.name + "\"[new_nickname]\""]. Confirm?", "Confirmation?", "Yes", "No") != "Yes")
		return

	//post-checks
	if(V.seats[seat] != user) //check that we are still in seat
		to_chat(user, SPAN_WARNING("You need to be buckled to vehicle seat to do this."))
		return

	if(V.nickname) //check again if second VC was faster.
		to_chat(user, SPAN_WARNING("The other crewman beat you to it!"))
		return

	V.nickname = new_nickname
	V.name = initial(V.name) + " \"[V.nickname]\""
	to_chat(user, SPAN_NOTICE("You've added \"[V.nickname]\" nickname to your vehicle."))

	message_admins(WRAP_STAFF_LOG(user, "added \"[V.nickname]\" nickname to their [initial(V.name)]. ([V.x],[V.y],[V.z])"), V.x, V.y, V.z)

	V.initialize_cameras(TRUE)

//Activates vehicle horn. Yes, it is annoying.
/obj/vehicle/multitile/proc/activate_horn()
	set name = "Активация гудка"	//SS220 EDIT
	set desc = "Задействует звуковой сигнал техники. Бип-бип."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!istype(user))
		return

	var/obj/vehicle/multitile/V = user.interactee
	if(!istype(V))
		return

	var/seat
	for(var/vehicle_seat in V.seats)
		if(V.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break
	if(!seat)
		return

	if(world.time < V.next_honk)
		to_chat(user, SPAN_WARNING("You need to wait [(V.next_honk - world.time) / 10] seconds."))
		return

	V.next_honk = world.time + 10 SECONDS
	to_chat(user, SPAN_NOTICE("You activate vehicle's horn."))
	V.perform_honk()

/obj/vehicle/multitile/proc/perform_honk()
	if(honk_sound)
		playsound(loc, honk_sound, 75, TRUE, 15) //heard within ~15 tiles

//Support gunner verbs

/obj/vehicle/multitile/proc/reload_firing_port_weapon()
	set name = "Перезарядка бортового оружия"	//SS220 EDIT
	set desc = "Запускает автоматический процесс перезарядки бортового оружия."	//SS220 EDIT
	set category = "Vehicle"

	var/mob/user = usr
	if(!user || !istype(user))
		return

	var/obj/vehicle/multitile/V = user.interactee
	if(!istype(V))
		return

	var/seat
	for(var/vehicle_seat in V.seats)
		if(V.seats[vehicle_seat] == user)
			seat = vehicle_seat
			break

	if(!seat)
		return

	if(V.health < initial(V.health) * 0.5)
		to_chat(user, SPAN_WARNING("\The [V]'s hull is too damaged to operate!"))

	for(var/obj/item/hardpoint/special/firing_port_weapon/FPW in V.hardpoints)
		if(FPW.allowed_seat == seat)
			if(alert(user, "Initiate M56 FPW reload process? It will take [FPW.reload_time / 10] seconds.", "Initiate reload", "Yes", "No") == "Yes")
				FPW.start_auto_reload(user)
			return

	to_chat(user, SPAN_WARNING("Warning. No FPW for [seat] found, tell a dev!"))
