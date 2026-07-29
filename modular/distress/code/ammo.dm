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
	damage = 150
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
	var/number_of_airburst = 12

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
	radius = 5
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
	max_range = 6
	damage = 55
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_8
	accuracy = HIT_ACCURACY_TIER_MAX

/datum/ammo/bullet/pkp
	name = "machinegun bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "redtrac"
	
	accuracy = HIT_ACCURACY_TIER_1
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_8
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 14
	damage = 45
	penetration = ARMOR_PENETRATION_TIER_4
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_9

/datum/ammo/bullet/sniper/upp
	name = "armor-piercing sniper bullet"
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "redtrac"
	damage = 80
	penetration = ARMOR_PENETRATION_TIER_6
	
/datum/ammo/bullet/rifle/type71
	name = "heavy rifle bullet"

	damage = 30
	penetration = ARMOR_PENETRATION_TIER_6

/datum/ammo/bullet/rifle/type71/ap
	name = "heavy armor-piercing rifle bullet"

	damage = 45
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/minigun
	name = "minigun bullet"
	headshot_state = HEADSHOT_OVERLAY_MEDIUM
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "redtrac"

	accuracy = HIT_ACCURACY_TIER_3
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 7
	damage = 30
	penetration = ARMOR_PENETRATION_TIER_3
	shrapnel_chance = SHRAPNEL_CHANCE_TIER_6

/datum/ammo/bullet/rifle/type71/ak
	name = "heavy rifle bullet"
	icon = 'modular/distress/icons/projectiles.dmi'
	icon_state = "redtrac"
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_2

/datum/ammo/bullet/rifle/type71/ak/ap
	name = "heavy armor-piercing rifle bullet"
	icon_state = "bullet_green"
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_10

/datum/ammo/bullet/rifle/type71/ak/heap
	name = "heavy high-explosive armor-piercing rifle bullet"
	headshot_state = HEADSHOT_OVERLAY_HEAVY
	icon_state = "bullet_green"
	damage = 60
	penetration = ARMOR_PENETRATION_TIER_10

/obj/item/ammo_magazine/rifle/ak4047
	name = "\improper AK-4047 magazine (7.62x39mm)"
	desc = "A rugged and reliable 40-round magazine designed for the AK-4047 series assault rifle. Built for durability, it can withstand harsh conditions and keep firing even in the worst environments."
	caliber = "7.62x39mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/UPP/assault_rifles.dmi'
	icon_state = "ak4047"
	item_state = "generic_mag"
	item_icons = list(
		WEAR_L_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_lefthand.dmi',
		WEAR_R_HAND = 'icons/mob/humans/onmob/inhands/weapons/ammo_righthand.dmi'
		)
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle/type71/ak
	max_rounds = 45
	gun_type = /obj/item/weapon/gun/rifle/ak4047
	ammo_band_icon = "+ak4047_band"
	ammo_band_icon_empty = "+ak4047_band_e"

/obj/item/ammo_magazine/rifle/ak4047/ap
	name = "\improper AK-4047 AP magazine (7.62x39mm)"
	desc = "A 7.62x39mm magazine containing armor piercing rounds for the AK-4047 rifle."
	default_ammo = /datum/ammo/bullet/rifle/type71/ak/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/ak4047/heap
	name = "\improper AK-4047 HEAP magazine (7.62x39mm)"
	desc = "A 7.62x39mm magazine containing the standard high explosive armor piercing rounds for the AK-4047 rifle."
	default_ammo = /datum/ammo/bullet/rifle/type71/ak/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/ak4047/incendiary
	name = "\improper AK-4047 incendiary magazine (7.62x39mm)"
	desc = "A 7.62x39mm assault rifle magazine containing the incendiary rounds for the AK-4047 rifle."
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/structure/machinery/defenses/sentry/launchable/upp
	name = "\improper UPP SDS-R8 Sentry post"
	desc = "A deployable, omni-directional automated turret with AI targeting capabilities. Armed with an M30 Autocannon and a 100-round drum magazine with 500 rounds stored internally. Due to the deployment method it is incapable of being moved."
	ammo = new /obj/item/ammo_magazine/sentry/dropped
	icon = 'icons/obj/structures/machinery/defenses/upp_defenses.dmi'
	faction_group = FACTION_UPP
	sentry_type = "upp_sentry"
	omni_directional = TRUE
	additional_rounds_stored = TRUE
	immobile = TRUE
	static = TRUE
	luminosity_strength = 9

/obj/structure/ship_ammo/sentry/upp
	name = "\improper UPP A/C-49-P Air Deployable Sentry"
	desc = "An omni-directional sentry, capable of defending an area from lightly armored hostile incursion. Can be loaded into the LAG-14 Internal Sentry Launcher."
	icon_state = "launchable_sentry"
	equipment_type = /obj/structure/dropship_equipment/weapon/launch_bay
	ammo_count = 1
	max_ammo_count = 1
	ammo_name = "area denial sentry"
	travelling_time = 0 // handled by droppod
	point_cost = 800 //handled by printer
	accuracy_range = 0 // pinpoint
	max_inaccuracy = 0

/obj/structure/ship_ammo/sentry/upp/detonate_on(turf/impact, obj/structure/dropship_equipment/weapon/fired_from)
	var/obj/structure/droppod/equipment/sentry/droppod = new(impact, /obj/structure/machinery/defenses/sentry/launchable/upp, source_mob)
	droppod.special_structures_to_damage = breakable_structures
	droppod.special_structure_damage = 500
	droppod.drop_time = 5 SECONDS
	droppod.launch(impact)
	qdel(src)

/obj/structure/machinery/defenses/sentry/premade/dropship/upp
	icon = 'icons/obj/structures/machinery/defenses/upp_defenses.dmi'
	sentry_type = "upp_sentry"
	faction_group = FACTION_LIST_UPP
	minimap_icon_state = "sentry_omni"

/obj/structure/machinery/defenses/sentry/premade/dropship/upp/update_health(damage, pass_forward = FALSE)
	. = ..()
	pass_forward = !pass_forward
	if(pass_forward)
		if(deployment_system)
			deployment_system.update_health(damage, pass_forward)

/obj/structure/machinery/defenses/sentry/premade/dropship/upp/Destroy()
	if(deployment_system)
		deployment_system.deployed_turret = null
		deployment_system = null
	QDEL_NULL(linked_cam)
	. = ..()

/obj/structure/dropship_equipment/sentry_holder/upp
    name = "\improper UPP SDS-R3 Sentry Defense System"
    desc = "A box that deploys a UPP SDS-R3 sentry turret. Fits on both the external weapon and crew compartment attach points of dropships. You need a powerloader to lift it."
    faction_exclusive = FACTION_UPP

/obj/structure/dropship_equipment/sentry_holder/upp/create_turret()
	if(!deployed_turret)
		deployed_turret = new /obj/structure/machinery/defenses/sentry/premade/dropship/upp(src)
		deployed_turret.deployment_system = src

	health = deployed_turret.health
