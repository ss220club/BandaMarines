/obj/vehicle/multitile/cm_vehicle/tank
	var/base_icon_state // e.g. "tank" — the part before the camo suffix

/obj/vehicle/tank
	name = "main battle tank"
	desc = "A heavily armored vehicle."
	icon = 'icons/obj/vehicles/tank.dmi' // Основной .dmi файл со всеми состояниями
	icon_state = "tank_default" // Состояние по умолчанию
	var/current_camouflage = "tank_base"

	// Переопределение типа для корректной работы ..() при инициализации подтипов
	var/base_type_path = /obj/vehicle/tank


	/proc/select_gamemode_skin(expected_type, list/override_icon_state)
		// Вызываем родительский метод, если он есть (в данном случае безопасно)
		. = ..()

		// Защита от смены спрайта на карте, где используется цветовая индексация
		if(flags_atom & MAP_COLOR_INDEX)
			return



		// Если передан ручной оверрайд (например, админ-команда), используем его
		if(override_icon_state && length(override_icon_state))
			icon_state = override_icon_state["[expected_type]"]
			current_camouflage = "custom"
			return

		switch(mode)
			if("jungle")
				current_camouflage = "jungle"
				icon_state = "tank_base_j"
			if("classic", "standard") // Добавлен стандартный fallback
				current_camouflage = "classic"
				icon_state = "tank_classic"
			if("desert")
				current_camouflage = "desert"
				icon_state = "tank_base_d"
			if("urban")
				current_camouflage = "urban"
				icon_state = "tank_base_n"
			else
				// Режим по умолчанию, если ни один кейс не подошел
				current_camouflage = "default"
				icon_state = "tank_base"

	Initialize(mapload, ...)
		. = ..()
		select_gamemode_skin(type)

		/obj/vehicle/tank/jungle
	name = "Jungle MBT"
	icon_state = "tank_base_j // Начальное состояние до вызова Initialize
	base_type_path = /modular/vehicles/icons

/obj/vehicle/tank/desert
	name = "Desert MBT"
	icon_state = "tank_base_d"
	base_type_path = /modular/vehicles/icons

/obj/vehicle/tank/urban
	name = "Urban MBT"
	icon_state = "tank_base_n"
	base_type_path = /modular/vehicles/icons

/obj/vehicle/tank/classic
	name = "Classic MBT"
	icon_state = "tank_base"
	base_type_path = /modular/vehicles/icons
