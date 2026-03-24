/obj/vehicle/multitile/modul/humvee/apc
	name = "\improper Бронеавтомобиль M2420 JTMV-HWC"
	desc = "Многоцелевой бронеавтомобиль M2420 JTMV. Легкобронированная машина. Входы сзади и по бокам."

// Прочность и модификаторы урона
	health = 500

	dmg_multipliers = list(
		"all" = 1,
		"acid" = 1.8,
		"slash" = 1.1,
		"bullet" = 0.6,
		"explosive" = 0.8,
		"blunt" = 0.8,
		"abstract" = 1,
	)

	interior_map = /datum/map_template/interior/modul/humvee/apc
	minimap_icon_state = "humvee"

	passengers_slots =  2 // танкисты всегда имеют 2 слота и не занимают passengers_slots
	revivable_dead_slots = 3 // нужно на случай если танкисты умрут и нужно будет их достать
	xenos_slots = 3

	required_skill = SKILL_VEHICLE_LARGE

	has_overdrive = FALSE
	allow_squeeze_under = FALSE

	misc_multipliers = list(
		"move" = 0.8, 
		"accuracy" = 1,
		"cooldown" = 1
	)

	entrances = list(
		"right" = list(-2, -1),
		"left" = list(1, -1),
		"back left" = list(1, 0),
		"back right" = list(-2, 0),
	)

	hardpoints_allowed = list(
		/obj/item/hardpoint/locomotion/humvee_wheels,
		/obj/item/hardpoint/holder/humvee_turret,
		/obj/item/hardpoint/armor/humvee_snowplow,
		/obj/item/hardpoint/support/humvee_overhead_lights,
		/obj/item/hardpoint/primary/humvee_hatch,
	)

