// ammo bullet
/datum/ammo/bullet/humvee_cannon
	name = "remote-cannon bullet"
	icon = 'icons/obj/items/weapons/projectiles.dmi'
	icon_state = "bullet_large"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_COVER
	accurate_range_min = 3

	accurate_range = 22
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_8
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_8
	scatter = 0
	max_range = 22
	effective_range_max = 12
	damage = 50
	penetration = ARMOR_PENETRATION_TIER_6
	damage_armor_punch = 0
	pen_armor_punch = 0
	shell_speed = AMMO_SPEED_TIER_6
	accuracy = HIT_ACCURACY_TIER_5
	damage_enviro = TRUE

/datum/ammo/bullet/humvee_cannon/on_hit_mob(mob/M,obj/projectile/P)
	burst(get_turf(M),P,damage_type, 1 , 2)

/datum/ammo/bullet/humvee_cannon/on_near_target(turf/T, obj/projectile/P)
	burst(get_turf(T),P,damage_type, 1 , 2)
	return 1

/datum/ammo/bullet/humvee_cannon/on_hit_obj(obj/O,obj/projectile/P)
	burst(get_turf(P),P,damage_type, 1 , 2)

/datum/ammo/bullet/humvee_cannon/on_hit_turf(turf/T,obj/projectile/P)
	burst(get_turf(T),P,damage_type, 1 , 2)

/datum/ammo/bullet/humvee_machinegun
	name = "remote-machinegun bullet"
	icon = 'icons/obj/items/weapons/projectiles.dmi'
	icon_state = "redbullet"
	flags_ammo_behavior = AMMO_BALLISTIC|AMMO_IGNORE_COVER

	accurate_range = 12
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_8
	accuracy_var_high = PROJECTILE_VARIANCE_TIER_8
	max_range = 15
	effective_range_max = 9
	damage = 35
	penetration = ARMOR_PENETRATION_TIER_4
	damage_armor_punch = 0
	pen_armor_punch = 0
	shell_speed = AMMO_SPEED_TIER_3
	accuracy = -HIT_ACCURACY_TIER_2
	damage_enviro = TRUE

// ammo rocket
/datum/ammo/rocket/humvee_launcher
	name = "white phosphorous rocket"
	flags_ammo_behavior = AMMO_ROCKET|AMMO_EXPLOSIVE|AMMO_STRIKES_SURFACE
	damage_type = BURN

	accuracy_var_low = PROJECTILE_VARIANCE_TIER_6
	accurate_range = 9
	damage = 90
	max_range = 9

/datum/ammo/rocket/humvee_launcher/set_bullet_traits()
	. = ..()
	LAZYADD(traits_to_give, list(
		BULLET_TRAIT_ENTRY(/datum/element/bullet_trait_incendiary)
	))

/datum/ammo/rocket/humvee_launcher/drop_flame(turf/turf, datum/cause_data/cause_data)
	playsound(turf, 'sound/weapons/gun_flamethrower3.ogg', 75, 1, 7)
	if(!istype(turf))
		return
	smoke.set_up(1, turf)
	smoke.start()
	var/datum/reagent/napalm/blue/reagent = new()
	new /obj/flamer_fire(turf, cause_data, reagent, 2)

	spawn(1)
		var/datum/effect_system/smoke_spread/phosphorus/landingSmoke = new /datum/effect_system/smoke_spread/phosphorus
		landingSmoke.set_up(2, 0, turf, null, 6, cause_data)
		landingSmoke.start()
		landingSmoke = null

/datum/ammo/rocket/humvee_launcher/on_hit_mob(mob/mob, obj/projectile/projectile)
	cell_explosion(get_turf(mob), 60, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	drop_flame(get_turf(mob), projectile.weapon_cause_data)

/datum/ammo/rocket/humvee_launcher/on_hit_obj(obj/object, obj/projectile/projectile)
	cell_explosion(get_turf(object), 60, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	drop_flame(get_turf(object), projectile.weapon_cause_data)

/datum/ammo/rocket/humvee_launcher/on_hit_turf(turf/turf, obj/projectile/projectile)
	cell_explosion(turf, 60, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	drop_flame(turf, projectile.weapon_cause_data)

/datum/ammo/rocket/humvee_launcher/do_at_max_range(obj/projectile/projectile)
	cell_explosion(get_turf(projectile), 60, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)
	drop_flame(get_turf(projectile), projectile.weapon_cause_data)

// ammo grenade
/datum/ammo/humvee_grenade_launcher
	name = "grenade shell"
	ping = null
	damage_type = BRUTE
	icon_state = "hornet_round"
	shrapnel_type = /datum/ammo/bullet/shrapnel/metal
	flags_ammo_behavior = AMMO_IGNORE_COVER

	damage = 60
	accuracy = HIT_ACCURACY_TIER_3
	max_range = 9

/datum/ammo/humvee_grenade_launcher/proc/apply_explosion_overlay(turf/T)
	var/obj/effect/overlay/O = new /obj/effect/overlay(T)
	O.name = "grenade"
	O.icon = 'icons/effects/explosion.dmi'
	flick("grenade", O)
	QDEL_IN(O, 7)

/datum/ammo/humvee_grenade_launcher/proc/detonate(turf/T, obj/projectile/projectile)
	set waitfor = 0
	apply_explosion_overlay(T)
	cell_explosion(T, 40, 20, EXPLOSION_FALLOFF_SHAPE_LINEAR, null, projectile.weapon_cause_data)

/datum/ammo/humvee_grenade_launcher/on_hit_mob(mob/mob, obj/projectile/projectile)
	mob.ex_act(50, projectile.dir, projectile.weapon_cause_data, 50)
	mob.apply_effect(3, SUPERSLOW)
	detonate(get_turf(mob), projectile)

/datum/ammo/humvee_grenade_launcher/on_hit_obj(obj/object, obj/projectile/projectile)
	detonate(get_turf(object), projectile)

/datum/ammo/humvee_grenade_launcher/on_hit_turf(turf/turf, obj/projectile/projectile)
	detonate(turf, projectile)

/datum/ammo/humvee_grenade_launcher/do_at_max_range(obj/projectile/projectile)
	detonate(get_turf(projectile), projectile)

// ammo magazine
/obj/item/ammo_magazine/hardpoint/humvee_cannon
	name = "Магазин для автопушки M24-RC1 (10x28мм)"
	desc = "Магазин для дистанционно управляемой автопушки M24-RC1, заполненный вольфрамовыми снарядами калибра 10x28mm мм."
	caliber = "10x28mm"
	icon_state = "ace_autocannon"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/humvee_cannon
	max_rounds = 150
	gun_type = /obj/item/hardpoint/primary/humvee_cannon

/obj/item/ammo_magazine/hardpoint/humvee_cannon/update_icon()
	if(current_rounds > 0)
		icon_state = "ace_autocannon"
	else
		icon_state = "ace_autocannon_empty"


/obj/item/ammo_magazine/hardpoint/humvee_machinegun
	name = "Коробы для Тяжелого пулемета M2-RC1 (10x28мм)"
	desc = "Коробы для спаренного M24-RC1, заполненный вольфрамовыми снарядами калибра 10x28mm мм."
	caliber = "10x28mm"
	icon_state = "m2c"
	item_state = "m2c"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/machineguns.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/bullet/humvee_machinegun
	max_rounds = 250
	gun_type = /obj/item/hardpoint/primary/humvee_machinegun

/obj/item/ammo_magazine/hardpoint/humvee_launcher
	name = "Магазин для реактивного огнемёта M24-JTMV"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/event.dmi'
	desc = "Магазин для вторичного вооружения M24-JTMV. Представляет собой пакет из четырех термобарических гранат, начинённых огнесмесью."
	caliber = "rocket" //correlates to any rocket mags
	icon_state = "quad_rocket"
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/rocket/humvee_launcher
	max_rounds = 4
	gun_type = /obj/item/hardpoint/secondary/humvee_launcher

/obj/item/ammo_magazine/hardpoint/humvee_grenade_launcher
	name = "Магазин для автомотического гранатомета M24-Mk48"
	desc = "Магазин, заряженный гранатами М40. Используется для перезарядки гранатомета М24-Мк47 с магазинным питанием."
	caliber = "grenade"
	icon_state = "glauncher_2"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/USCM/vehicles.dmi'
	w_class = SIZE_LARGE
	default_ammo = /datum/ammo/humvee_grenade_launcher
	max_rounds = 32
	gun_type = /obj/item/hardpoint/primary/humvee_grenade_launcher

/obj/item/ammo_magazine/hardpoint/tank_glauncher/update_icon()
	if(current_rounds >= max_rounds)
		icon_state = "glauncher_2"
	else if(current_rounds <= 0)
		icon_state = "glauncher_0"
	else
		icon_state = "glauncher_1"

// gear set
/obj/effect/essentials_set/humvee/autocannon
	desc = "Одноствольная дистанционно управляемая автопушка для бронеавтомобиля M2420 JTMV-HWC. Стреляет 10x28-мм вольфрамовыми снарядами. Эффективна против пехоты и легкобронированной техники."
	spawned_gear_list = list(
		/obj/item/hardpoint/primary/humvee_cannon,
		/obj/item/ammo_magazine/hardpoint/humvee_cannon,
		/obj/item/ammo_magazine/hardpoint/humvee_cannon,
	)

/obj/effect/essentials_set/humvee/humvee_flare_launcher
	desc = "Вспомогательный модуль для M24-JTMV, предназначенный для запуска осветительных огней."
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/humvee_flare_launcher,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
		/obj/item/ammo_magazine/hardpoint/flare_launcher,
	)

/obj/effect/essentials_set/humvee/humvee_launcher
	desc = "Вспомогательное оружие поддержки пехоты для M24-JTMV, стреляющее термобарическеми ракетами."
	spawned_gear_list = list(
		/obj/item/hardpoint/secondary/humvee_launcher,
		/obj/item/ammo_magazine/hardpoint/humvee_launcher,
	)
