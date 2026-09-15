// ==========================================
// =============== Мотоциклы ================

/datum/supply_packs/motorbike
	name = "Vehicle - Motorbike (x1)"
	contains = list(
		/obj/vehicle/motorbike/camo,
		/obj/item/pamphlet/skill/vc/low,
	)
	cost = 40
	containertype = /obj/structure/largecrate
	containername = "Упакованный мотоцикл"
	group = "Vehicle Equipment"

// ======== Коляски для мотоциклов ==========
/datum/supply_packs/motorbike_stroller
	name = "Vehicle - Motorbike stroller (x1)"
	contains = list(
		/obj/structure/bed/chair/sidecar/passenger/camo,
	)
	cost = 20
	containertype = /obj/structure/largecrate
	containername = "Упакованная коляска для мотоцикла"
	group = "Vehicle Equipment"

// ==========================================
// ============ Хамер амуниция ==============

/datum/supply_packs/ammo_humvee_cannon
	name = "M24-RC1 Remote Cannon magazine (x3)"
	contains = list(
		/obj/item/ammo_magazine/hardpoint/humvee_cannon,
		/obj/item/ammo_magazine/hardpoint/humvee_cannon,
		/obj/item/ammo_magazine/hardpoint/humvee_cannon,
	)
	cost = 30
	containertype = /obj/structure/closet/crate/ammo
	containername = "Ящик с боеприпасами дистанционно управляемой автопушки M24-RC1 для бронеавтомобилей"
	group = "Vehicle Ammo"

/datum/supply_packs/ammo_humvee_launcher
	name = "M24-RC1 Thermobaric magazine (x1)"
	contains = list(
		/obj/item/ammo_magazine/hardpoint/humvee_launcher,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/ammo
	containername = "Ящик с гранатами реактивного огнемёта M24-RC1 для бронеавтомобилей"
	group = "Vehicle Ammo"

// ========= Хамер запасные части ===========
/datum/supply_packs/humvee_cannon_replacement
	name = "Replacement M24-RC1 Remote Cannon (x1)"
	contains = list(
		/obj/item/hardpoint/primary/humvee_cannon,
	)
	cost = 40
	containertype = /obj/structure/closet/crate/weapon
	containername = "Ящик с дистанционно управляемой автопушкой M24-RC1 для бронеавтомобилей"
	group = "Vehicle Equipment"

/datum/supply_packs/humvee_flare_replacement
	name = "Replacement M-77F Flare Launcher (x1)"
	contains = list(
		/obj/item/hardpoint/secondary/humvee_flare_launcher,
	)
	cost = 15
	containertype = /obj/structure/closet/crate/weapon
	containername = "Ящик с пусковой установкой осветительных ракет M-77F для бронеавтомобилей"
	group = "Vehicle Equipment"

/datum/supply_packs/humvee_wheels_replacement
	name = "Replacement M24 Series Wheels (x1)"
	contains = list(
		/obj/item/hardpoint/locomotion/humvee_wheels,
	)
	cost = 20
	containertype = /obj/structure/closet/crate/weapon
	containername = "Ящик с колёсами серии M24 для бронеавтомобилей"
	group = "Vehicle Equipment"

/datum/supply_packs/humvee_overhead_lights
	name = "M24 Series Overhead Lights (x1)"
	contains = list(
		/obj/item/hardpoint/support/humvee_overhead_lights,
	)
	cost = 15
	containertype = /obj/structure/closet/crate/weapon
	containername = "Ящик с навесными прожекторами серии M24 для бронеавтомобилей"
	group = "Vehicle Equipment"

// ==========================================
