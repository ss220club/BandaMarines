// ==========================================
// ================== Урон ==================
// После уничтожения - создается разрушенный каркас

// Главный чекер урона у vehicle
/obj/vehicle/motorbike/healthcheck()
	if(is_destroying)
		return
	check_and_try_disasemble()
	. = ..()

/obj/vehicle/motorbike/proc/take_damage(damage)
	health -= damage
	healthcheck()

/obj/vehicle/motorbike/proc/check_and_try_disasemble(damage = 0)
	if(health - damage <= 0)
		is_destroying = TRUE
		disconnect()
		QDEL_NULL(lighting_holder)
		new /obj/motorbike_destroyed(src.loc, icon_skin)

/obj/vehicle/motorbike/proc/resolve_attack_target(sidecar_allowed = FALSE, driver_allowed = FALSE, sidecar_chance = 0, driver_chance = 0)
	var/obj/structure/bed/chair/sidecar/active_sidecar = get_valid_sidecar()
	if(sidecar_allowed && active_sidecar && prob(sidecar_chance))
		return active_sidecar
	if(driver_allowed && buckled_mob && !QDELETED(buckled_mob) && prob(driver_chance))
		return buckled_mob
	return src

/obj/vehicle/motorbike/proc/validate_xeno_attack(mob/living/carbon/xenomorph/M)
	if(M.a_intent == INTENT_HELP)
		return XENO_NO_DELAY_ACTION
	if(M.mob_size < MOB_SIZE_XENO)
		to_chat(M, SPAN_XENOWARNING("Вы слишком малы, чтобы нанести этому транспорту значительный урон!"))
		return XENO_NO_DELAY_ACTION
	return FALSE

/obj/vehicle/motorbike/corrosive_acid_act(damage = 0)
	if(damage <= 0)
		return
	take_damage(damage)

/obj/vehicle/motorbike/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	var/xeno_validation_result = validate_xeno_attack(xeno)
	if(xeno_validation_result)
		return TAILSTAB_COOLDOWN_NONE
	var/atom/target = resolve_attack_target(sidecar != null && !QDELETED(sidecar), buckled_mob != null && !QDELETED(buckled_mob), hit_chance_connected, hit_chance_buckled)
	if(target == sidecar)
		return target.handle_tail_stab(xeno, blunt_stab)
	if(target == buckled_mob)
		var/mob/affected_mob = buckled_mob
		if(prob(hit_chance_to_unbuckle))
			unbuckle()
			affected_mob.apply_effect(1, WEAKEN)
			affected_mob.throw_atom(src, 1, VEHICLE_SPEED_FASTER, xeno, TRUE)
			xeno.visible_message(SPAN_DANGER("[capitalize(xeno.declent_ru(NOMINATIVE))] сшибает [affected_mob.declent_ru(ACCUSATIVE)]!"), SPAN_DANGER("Мы сшибаем [affected_mob.declent_ru(ACCUSATIVE)]!"))
		var/result = affected_mob.attack_alien(xeno)
		if(result == XENO_ATTACK_ACTION)
			xeno.tail_stab_animation(affected_mob, blunt_stab)
		return result
	var/result = attack_alien(xeno, src)
	if(result != XENO_ATTACK_ACTION)
		return TAILSTAB_COOLDOWN_NONE
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/vehicle/motorbike/bullet_act(obj/projectile/P)
	var/sidecar_can_be_hit = get_valid_sidecar()
	var/driver_can_be_hit = buckled_mob && !QDELETED(buckled_mob) && buckled_mob.get_projectile_hit_chance(P)
	var/atom/target = resolve_attack_target(sidecar_can_be_hit, driver_can_be_hit, hit_chance_connected, hit_chance_buckled)
	if(target != src)
		return target.bullet_act(P)	// Приконекченная тележка и сидящие обрабатывают попадание самостоятельно.
	return ..()

/obj/vehicle/motorbike/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	var/atom/target = resolve_attack_target(get_valid_sidecar(), buckled_mob != null && !QDELETED(buckled_mob), hit_chance_connected, hit_chance_buckled)
	if(target != src)
		return target.attack_animal(M)	// Коляска и сидящие обрабатывают попадание самостоятельно.
	return ..()

/obj/vehicle/motorbike/attack_alien(mob/living/carbon/xenomorph/M, atom/forced_target)
	var/xeno_validation_result = validate_xeno_attack(M)
	if(xeno_validation_result)
		return xeno_validation_result
	var/atom/target = forced_target || resolve_attack_target(get_valid_sidecar(), buckled_mob != null && !QDELETED(buckled_mob), hit_chance_connected, hit_chance_buckled)
	if(target != src)
		if(target == buckled_mob)
			var/mob/affected_mob = buckled_mob
			if(prob(hit_chance_to_unbuckle))
				unbuckle()
				affected_mob.apply_effect(1, WEAKEN)
				affected_mob.throw_atom(src, 1, VEHICLE_SPEED_FASTER, M, TRUE)
				M.visible_message(SPAN_DANGER("[capitalize(M.declent_ru(NOMINATIVE))] сшибает [affected_mob.declent_ru(ACCUSATIVE)]!"), SPAN_DANGER("Мы сшибаем [affected_mob.declent_ru(ACCUSATIVE)]!"))
			return affected_mob.attack_alien(M)	// Атака водителя не проваливается в обработку байка.
		return target.attack_alien(M)	// Коляска самостоятельно обрабатывает пассажира и собственный урон.
	return ..(M)
