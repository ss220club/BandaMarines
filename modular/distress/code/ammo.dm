/datum/ammo/grenade_container/smoke/upp
	name = "smoke grenade shell"
	nade_type = /obj/item/explosive/grenade/smokebomb
	icon_state = "smoke_shell"

// TANK CANNON
/datum/ammo/rocket/ltb/p17702
	name = "93mmm round"
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "p17702"
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET|AMMO_STRIKES_SURFACE

	accuracy = HIT_ACCURACY_TIER_3
	accurate_range = 32
	max_range = 32
	damage = 200
	shell_speed = AMMO_SPEED_TIER_3

/obj/item/ammo_magazine/hardpoint/p17702
	name = "P-177-02 93mm Cannon Magazine"
	desc = "A magazine of high-explosive, anti-tank cannon rounds."
	icon = 'modular/distress/icons/ammoupp.dmi'
	caliber = "93mm"
	icon_state = "p17702_8"
	w_class = SIZE_LARGE //Heavy
	default_ammo = /datum/ammo/rocket/ltb/p17702
	max_rounds = 8
	gun_type = /obj/item/hardpoint/primary/cannon/p17702

/obj/item/ammo_magazine/hardpoint/p17702/update_icon()
	icon_state = "p17702_[current_rounds]"

/obj/item/ammo_magazine/hardpoint/t60p3m
	name = "T6OP-3M Magazine (10x27mm)"
	desc = "A box of 500, 10x27mm caseless rounds for use in the T6OP-3M heavy machine gun system."
	caliber = "10x27mm"
	icon = 'modular/distress/icons/ammoupp.dmi'
	icon_state = "t60p3m"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/rifle/heavy/tracer
	max_rounds = 500
	gun_type = /obj/item/hardpoint/secondary/t60p3m

/datum/ammo/bullet/rifle/heavy/tracer
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "bullet_red"
	
/obj/item/mortar_shell/himat
	name = "\improper HIMAT missile"
	icon = 'modular/distress/icons/mortar.dmi'
	desc = "This is a small, two-stage missile used by HIMAT launcher. This one has a standard anti-tank package."
	icon_state = "missile"

/obj/item/mortar_shell/himat/detonate(turf/T)
	cell_explosion(T, 2400, 2400, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data)

/obj/item/mortar_shell/himat/explosive
	name = "\improper HIMAT HE missile"
	desc = "This is a small, two-stage missile used by HIMAT launcher. This one has a high-explosive package, primarily used for demolition."
	icon_state = "missile_he"

/obj/item/mortar_shell/himat/explosive/detonate(turf/T)
	explosion(T, 1, 4, 6, 8, explosion_cause_data = cause_data)

/obj/item/mortar_shell/himat/antipersonnel
	name = "\improper HIMAT AP missile"
	desc = "This is a small, two-stage missile used by HIMAT launcher. This one has an anti-personnel package, air-bursting for maximum soft-target damage."
	icon_state = "missile_ap"
	var/number_of_airburst = 10

/obj/item/mortar_shell/himat/antipersonnel/detonate(turf/T)
	var/list/turf_list = RANGE_TURFS(7, T)
	for(var/i = 1 to number_of_airburst)
		sleep(0.5 SECONDS)
		var/turf/impact_tile = pick(turf_list)
		create_shrapnel(impact_tile, 16, shrapnel_type = /datum/ammo/bullet/shrapnel/himat, cause_data = cause_data)
		cell_explosion(impact_tile, 20, 10, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, cause_data)

/obj/item/mortar_shell/incendiary/himat
	name = "\improper HIMAT IN missile"
	desc = "This is a small, two-stage missile used by HIMAT launcher. This one has an incendiary package, covering area of impact with burning flames."
	icon = 'modular/distress/icons/mortar.dmi'
	icon_state = "missile_inc"
	radius = 8
	flame_level = BURN_TIME_TIER_5 + 5
	burn_level = BURN_LEVEL_TIER_7
	flameshape = FLAMESHAPE_DEFAULT
	fire_type = FIRE_VARIANT_DEFAULT

/obj/item/mortar_shell/himat/training
	name = "\improper HIMAT flare missile"
	desc = "This is a small, two-stage missile used by HIMAT launcher. This one dispenses short-living burning ash and is used during training exercises."
	icon_state = "missile_training"

/obj/item/mortar_shell/himat/training/detonate(turf/T)
	create_shrapnel(T, 10, shrapnel_type = /datum/ammo/flare/starshell, cause_data = cause_data)

/datum/ammo/bullet/shrapnel/himat
	accurate_range = 8
	max_range = 8
	damage = 95
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_2
	accuracy = HIT_ACCURACY_TIER_MAX

