/obj/structure/bed/chair/sidecar/passenger
	name = "Мотоциклетная пассажирская коляска"
	desc = "Хоть по внешнему виду это похоже на коляску, которая может перевозит одного человека. но на самом деле это просто стул обшитый металлом."

	//======= Для отображения в игре ==============
	icon_state = "moto_ural_sidecar_passenger_classic"
	icon_base = "moto_ural_sidecar_passenger"

	//========= Какие то параметры XDD ============
	buckling_y = 8	// можно было б 4, но увы, оно слишком выпирает

	//======== Защита, здоровье и ремонт ==========
	// пока ничего менять не надо. :)

	//=============== Перемещение =================
	drag_delay_heavy = 4 // Тяжеленько. Хотите пулеметную точку? Хотите и таскать медленно.

	//=========== Смещение при коннекте ===========
	// пока ничего менять не надо. :)

	//========== Buckling. В passenger ===========
	can_buckle = TRUE
	var/buckle_time = 3 SECONDS	// Не сразу можно сесть.
	var/hit_chance_buckled = PROJECTILE_COVERAGE_LOW // Шанс попасть по сидящему
	var/hit_chance_to_unbuckle = 10 // Каждый удар имеет шанс отсоединить куклу при попадании по ней

/obj/structure/bed/chair/sidecar/passenger/Initialize()
	. = ..()
	if(buckled_mob)
		buckled_mob.setDir(dir)

/obj/structure/bed/chair/sidecar/passenger/update_overlay()
	.=..()
	//==== оверлей коляски поверх моба =======
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-overlay", layer = layer_above) //over mobs //отвечает за отображение по слоям
	overlays += I
	//========================================
	//=== оверлей пулемета поверх коляски ====
	if(mounted)
		var/gun_overlay = "m56d"
		if(istype(mounted, /obj/item/device/m2c_gun))
			gun_overlay = "m2c"
		if(mounted.rounds <= 0)
			gun_overlay += "_e"
		var/image/I_gun = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "moto_ural_[gun_overlay]", layer = layer_above) //over mobs //отвечает за отображение по слоям
		overlays += I_gun
	//========================================

// ==========================================
// ============ Коннект с байком ============

/obj/structure/bed/chair/sidecar/passenger/connect(atom/connection)
	.=..(connection)
	update_bike_permutated()

/obj/structure/bed/chair/sidecar/passenger/disconnect()
	if(connected)
		UnregisterSignal(connected, COMSIG_MOVABLE_MOVED)
	update_bike_permutated()
	reload_connected()
	connected = null
	density = !density
	anchored = !anchored
	update_drag_delay()
	update_position(src, TRUE)
	push_to_left_side(src)

