/obj/vehicle/multitile/humvee/transport
	name = "\improper Грузовой автомобиль M2422 JTMV"
	desc = "Вспомогательный автомобиль M2422 JTMV. Легкобронированная машина. Входы сзади и по бокам."

	icon = 'modular/vehicles/icons/humvee/humvee_transport.dmi'
	icon_state = "humvee_base"
	pixel_x = -48
	pixel_y = -48

	bound_width = 64
	bound_height = 64

	bound_x = -32
	bound_y = -32

// Прочность и модификаторы урона
	health = 600

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	interior_map = /datum/map_template/interior/modul/humvee/transport

	passengers_slots = 8
	xenos_slots = 4

	misc_multipliers = list(
		"move" = 0.7,
		"accuracy" = 1,
		"cooldown" = 1
	)

	entrances = list(
		"right" = list(-2, -1),
		"left" = list(1, -1),
		"back left" = list(0, 1),
		"back right" = list(-1, 1),
	)

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/humvee_wheels,
		/obj/item/hardpoint/armor/humvee_snowplow,
		/obj/item/hardpoint/support/humvee_overhead_lights,
	)
