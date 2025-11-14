// Мотоцикл с пассажирской коляской
/obj/vehicle/motorbike/passenger/full
	create_sidecar = 1

// Мотоцикл с грузовой коляской
/obj/vehicle/motorbike/cargo/full
	create_sidecar = 2


// ==========================================
// ============== Camo skin ===============

// Камуфлирование под текущую карту

/obj/vehicle/motorbike/camo
	need_camo = TRUE

/obj/structure/bed/chair/sidecar/passenger/camo
	need_camo = TRUE

/obj/structure/bed/chair/sidecar/cargo/camo
	need_camo = TRUE

/obj/vehicle/motorbike/camo/passenger/full
	create_sidecar = 1

/obj/vehicle/motorbike/camo/cargo/full
	create_sidecar = 2

// Функции выбора скина
/obj/vehicle/motorbike/proc/select_gamemode_skin()
	if(flags_atom & NO_GAMEMODE_SKIN)
		return
	var/skin = SSmapping.configs[GROUND_MAP].camouflage_type
	switch(skin)
		if("snow")
			icon_skin = skin
		if("desert")
			icon_skin = skin
		if("classic")
			icon_skin = skin
		if("urban")
			icon_skin = skin

/obj/structure/bed/chair/sidecar/proc/select_gamemode_skin()
	if(flags_atom & NO_GAMEMODE_SKIN)
		return
	var/skin = SSmapping.configs[GROUND_MAP].camouflage_type
	switch(skin)
		if("snow")
			icon_skin = skin
		if("desert")
			icon_skin = skin
		if("classic")
			icon_skin = skin
		if("urban")
			icon_skin = skin

// ==========================================
// ============== Desert skin ===============

/obj/vehicle/motorbike/desert
	icon_state = "moto_ural_desert"
	icon_skin = "desert"

/obj/structure/bed/chair/sidecar/passenger/desert
	icon_state = "moto_ural_sidecar_passenger_desert"
	icon_skin = "desert"

/obj/structure/bed/chair/sidecar/cargo/desert
	icon_state = "moto_ural_sidecar_cargo_desert"
	icon_skin = "desert"

/obj/vehicle/motorbike/desert/passenger/full
	create_sidecar = 1

/obj/vehicle/motorbike/desert/cargo/full
	create_sidecar = 2

// ==========================================
// =============== Snow skin ================

/obj/vehicle/motorbike/snow
	icon_state = "moto_ural_snow"
	icon_skin = "snow"

/obj/structure/bed/chair/sidecar/passenger/snow
	icon_state = "moto_ural_sidecar_passenger_snow"
	icon_skin = "snow"

/obj/structure/bed/chair/sidecar/cargo/snow
	icon_state = "moto_ural_sidecar_cargo_snow"
	icon_skin = "snow"

/obj/vehicle/motorbike/snow/passenger/full
	create_sidecar = 1

/obj/vehicle/motorbike/snow/cargo/full
	create_sidecar = 2

// ==========================================
// =============== Urban skin ===============

/obj/vehicle/motorbike/urban
	icon_state = "moto_ural_urban"
	icon_skin = "urban"

/obj/structure/bed/chair/sidecar/passenger/urban
	icon_state = "moto_ural_sidecar_passenger_urban"
	icon_skin = "urban"

/obj/structure/bed/chair/sidecar/cargo/urban
	icon_state = "moto_ural_sidecar_cargo_urban"
	icon_skin = "urban"

/obj/vehicle/motorbike/urban/passenger/full
	create_sidecar = 1

/obj/vehicle/motorbike/urban/cargo/full
	create_sidecar = 2

// ==========================================
// ================== Debug =================
// Машинка для тестов
/obj/vehicle/motorbike/debug
	name = "Мотоцикл главного инженера"
	desc = "Это модифицированный и улучшенный мотоцикл главного инженера для проверки... ВСЕГО. И черт возьми, он не разрушаем."
	health = 1000000
	maxhealth = 1000000
	icon_state = "moto_ural_urban"
	icon_skin = "urban"
	required_skill = SKILL_VEHICLE_DEFAULT
	wrench_time = 5
	welder_health = 200

/obj/vehicle/motorbike/passenger/debug/full
	create_sidecar = 1


/obj/vehicle/motorbike/debug/New(loc, skin)
	create_sidecar = 0
	. = ..(loc, skin)
	create_sidecar = initial(create_sidecar)
	if(create_sidecar == 1)
		sidecar = new /obj/structure/bed/chair/sidecar/passenger/debug(src, icon_skin)
		update_sidecar(TRUE)
		update_connect_params()
	update_overlay()

/obj/structure/bed/chair/sidecar/passenger/debug
	name = "Коляска главного инженера"
	desc = "Эта коляска сделана из пластитаниума. Разве такой материал вообще существует?"
	health = 1000000
	maxhealth = 1000000
	icon_state = "moto_ural_sidecar_passenger_urban"
	icon_skin = "urban"
	buckle_time = 0.5 SECONDS
	mounted_time_to_disassembly = 0.5 SECONDS
	mounted_time_to_assembly = 0.5 SECONDS
	welder_health = 200
