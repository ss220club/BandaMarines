
// ==========================================
// ============== Desert skin ===============

/obj/vehicle/motorbike/desert
	icon_skin = "desert"

/obj/structure/bed/chair/stroller/desert
	icon_skin = "desert"

// ==========================================
// =============== Snow skin ================

/obj/vehicle/motorbike/snow
	icon_skin = "snow"

/obj/structure/bed/chair/stroller/snow
	icon_skin = "snow"

// ==========================================
// =============== Urban skin ===============

/obj/vehicle/motorbike/urban
	icon_skin = "urban"

/obj/structure/bed/chair/stroller/urban
	icon_skin = "urban"



// ==========================================
// ================== Debug =================
// Машинка для тестов
/obj/vehicle/motorbike/debug
	name = "Мотоцикл главного инженера"
	desc = "Это модифицированный и улучшенный мотоцикл главного инженера для проверки... ВСЕГО. И черт возьми, он не разрушаем."
	health = 1000000
	maxhealth = 1000000
	icon_skin = "urban"
	required_skill = SKILL_VEHICLE_DEFAULT
	wrench_time = 5
	welder_health = 200

/obj/structure/bed/chair/stroller/debug
	name = "Коляска главного инженера"
	desc = "Эта коляска сделана из пластитаниума. Разве такой материал вообще существует?"
	health = 1000000
	maxhealth = 1000000
	icon_skin = "urban"
	buckle_time = 1 SECONDS
	welder_health = 200
