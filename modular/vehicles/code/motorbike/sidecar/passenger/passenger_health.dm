// Главный чекер урона у vehicle, повторяем здесь же
/obj/structure/bed/chair/sidecar/passenger/healthcheck(damage = 0)
	if(is_destroying || QDELETED(src) || health - damage > 0)
		return
	is_destroying = TRUE
	disconnect()
	update_mob_gun_signal(TRUE)
	// После уничтожения - создается разрушенный каркас
	new /obj/motorbike_destroyed/sidecar/passenger(src.loc, icon_skin)
	if(mounted && !QDELETED(mounted))
		mounted.forceMove(src.loc)
		mounted.update_health(mounted.health) // Разрушенный каркас, патроны и тому подобное
	unbuckle()
	deconstruct(FALSE)
	QDEL_NULL(src)

/obj/structure/bed/chair/sidecar/passenger/proc/get_xeno_unbuckle_chance()
	if(maxhealth <= 0)
		return 0
	var/damage_ratio = clamp((maxhealth - health) / (maxhealth * 0.4), 0, 1)
	return hit_chance_to_unbuckle * damage_ratio

/obj/structure/bed/chair/sidecar/passenger/proc/get_passenger_hit_chance()
	var/base_chance = min(hit_chance_buckled, 50)
	if(maxhealth <= 0)
		return base_chance
	var/damage_ratio = clamp((maxhealth - health) / (maxhealth * 0.5), 0, 1)
	return base_chance + (50 - base_chance) * damage_ratio

/obj/structure/bed/chair/sidecar/passenger/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	if(buckled_mob && prob(get_passenger_hit_chance()))	// Шанс попасть по сидящему
		return buckled_mob.attack_animal(M)
	health -= M.melee_damage_upper
	src.visible_message(SPAN_DANGER("<B>[capitalize(M.declent_ru(NOMINATIVE))] [ru_attack_verb(M.attacktext)] [declent_ru(ACCUSATIVE)]!</B>"))
	M.attack_log += text("\[[time_stamp()]\] <font color='red'>рвет [src.name]</font>")
	if(prob(10))
		new /obj/effect/decal/cleanable/blood/oil(src.loc)
	healthcheck()

/obj/structure/bed/chair/sidecar/passenger/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	if(xeno.a_intent == INTENT_HELP || xeno.mob_size < MOB_SIZE_XENO || unslashable)
		return TAILSTAB_COOLDOWN_NONE
	var/atom/target = (buckled_mob && prob(get_passenger_hit_chance())) ? buckled_mob : src
	var/result = attack_alien(xeno, target)
	if(result != XENO_ATTACK_ACTION)
		return TAILSTAB_COOLDOWN_NONE
	xeno.tail_stab_animation(target, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/bed/chair/sidecar/passenger/attack_alien(mob/living/carbon/xenomorph/M, atom/forced_target)
	if(M.a_intent == INTENT_HELP)
		return XENO_NO_DELAY_ACTION
	if(M.mob_size < MOB_SIZE_XENO)
		to_chat(M, SPAN_XENOWARNING("Вы слишком малы, чтобы нанести этому транспорту значительный урон!"))
		return XENO_NO_DELAY_ACTION
	if(unslashable)
		return
	if(M.melee_damage_upper == 0)
		return
	var/atom/target = forced_target || ((buckled_mob && prob(get_passenger_hit_chance())) ? buckled_mob : src)
	if(target != src)
		var/mob/affected_mob = target
		if(prob(get_xeno_unbuckle_chance()))
			unbuckle()
			affected_mob.apply_effect(1, WEAKEN)
			affected_mob.throw_atom(src, 1, VEHICLE_SPEED_FASTER, M, TRUE)
			M.visible_message(SPAN_DANGER("[capitalize(M.declent_ru(NOMINATIVE))] сшибает [affected_mob.declent_ru(ACCUSATIVE)]!"), SPAN_DANGER("Мы сшибаем [affected_mob.declent_ru(ACCUSATIVE)]!"))
		return affected_mob.attack_alien(M)	// При попадании в пассажира коляска больше не получает эту же атаку.
	M.animation_attack_on(src)
	playsound(src, hit_bed_sound, 25, 1)
	M.visible_message(SPAN_DANGER("[capitalize(M.declent_ru(NOMINATIVE))] кромсает [declent_ru(ACCUSATIVE)]!"),
	SPAN_DANGER("Мы кромсаем [declent_ru(ACCUSATIVE)]."))
	health -= M.melee_vehicle_damage + rand(-5, 5)
	healthcheck()
	return XENO_ATTACK_ACTION

/obj/structure/bed/chair/sidecar/passenger/bullet_act(obj/projectile/P)
	if(buckled_mob && prob(get_passenger_hit_chance()) && buckled_mob.get_projectile_hit_chance(P))
		return buckled_mob.bullet_act(P)	// Сидящие тоже могут получить пулю в задницу
	.=..()
