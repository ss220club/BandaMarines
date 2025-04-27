/obj/item/ammo_magazine/rocket/he_c
	default_ammo = /datum/ammo/rocket/he_c

/datum/ammo/rocket/he_c
	damage_falloff = 0
	flags_ammo_behavior = AMMO_EXPLOSIVE|AMMO_ROCKET

	// Accuracy and range
	accuracy = HIT_ACCURACY_TIER_8
	accuracy_var_low = PROJECTILE_VARIANCE_TIER_9
	accurate_range = 6
	max_range = 9

	// Damage characteristics
	damage = 10
	penetration = ARMOR_PENETRATION_TIER_10

	shrapnel_chance = SHRAPNEL_CHANCE_TIER_4
	shrapnel_type = /obj/item/shard/shrapnel

	// Explosion parameters
	var/damage_ex = 75
	var/explosion_power = EXPLOSION_THRESHOLD_LOW
	var/explosion_falloff = 50
	var/explosion_falloff_shape = EXPLOSION_FALLOFF_SHAPE_LINEAR

	// Status effect parameters
	var/weaken_duration = 1
	var/paralyze_duration = 1

	// Target effect parameters
	var/mob_damage_modifier = 100
	var/turf_damage_modifier = 200

	var/smoke_radius = 3

/// Shared handler for all impact types
/datum/ammo/rocket/he_c/proc/handle_impact(atom/target, obj/projectile/projectile)
	var/turf/target_turf = get_turf(target)
	var/hit_something = FALSE

	if(ismob(target))
		var/mob/mob_target = target
		mob_target.ex_act(damage_ex, projectile.dir, projectile.weapon_cause_data, mob_damage_modifier)
		mob_target.apply_effect(weaken_duration, WEAKEN)
		mob_target.apply_effect(paralyze_duration, PARALYZE)
		hit_something = TRUE
	else if(isobj(target))
		var/obj/obj_target = target
		if(obj_target.density)
			obj_target.ex_act(damage_ex, projectile.dir, projectile.weapon_cause_data, mob_damage_modifier)
			hit_something = TRUE
	else if(isturf(target))
		for(var/mob/mob_in_turf in target_turf)
			mob_in_turf.ex_act(damage_ex, projectile.dir, projectile.weapon_cause_data, mob_damage_modifier)
			mob_in_turf.apply_effect(weaken_duration, WEAKEN)
			mob_in_turf.apply_effect(paralyze_duration, PARALYZE)
			hit_something = TRUE

		if(!hit_something)
			for(var/obj/obj_in_turf in target_turf)
				if(obj_in_turf.density)
					obj_in_turf.ex_act(damage_ex, projectile.dir, projectile.weapon_cause_data, mob_damage_modifier)
					hit_something = TRUE

		if(!hit_something)
			target_turf.ex_act(damage_ex, projectile.dir, projectile.weapon_cause_data, turf_damage_modifier)

	// Create explosion and smoke effects
	cell_explosion(
		target_turf,
		explosion_power,
		explosion_falloff,
		explosion_falloff_shape,
		null,
		projectile.weapon_cause_data
	)
	smoke.set_up(smoke_radius, target_turf)
	smoke.start()

/datum/ammo/rocket/he_c/on_hit_mob(mob/mob, obj/projectile/projectile)
	handle_impact(mob, projectile)

/datum/ammo/rocket/he_c/on_hit_obj(obj/object, obj/projectile/projectile)
	handle_impact(object, projectile)

/datum/ammo/rocket/he_c/on_hit_turf(turf/turf, obj/projectile/projectile)
	handle_impact(turf, projectile)

/datum/ammo/rocket/he_c/do_at_max_range(obj/projectile/projectile)
	handle_impact(get_turf(projectile), projectile)
