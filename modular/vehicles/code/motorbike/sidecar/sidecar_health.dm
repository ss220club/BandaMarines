/obj/structure/bed/chair/sidecar

	//======== Защита, здоровье и ремонт ==========
	projectile_coverage = PROJECTILE_COVERAGE_MEDIUM
	health = 600 // Тележка прочнее мотоцикла. Увы, но это просто кусок металла.
	var/maxhealth = 600
	var/welder_health = 35	// Восстановление прочности за 1 топливо из сварки
	var/is_destroying = FALSE

// Главный чекер урона у vehicle, повторяем здесь же
/obj/structure/bed/chair/sidecar/proc/healthcheck(damage = 0)
	if(is_destroying || QDELETED(src))
		return
	if(health - damage > 0)
		return
	is_destroying = TRUE
	disconnect()
	// После уничтожения - создается разрушенный каркас
	//new /obj/motorbike_destroyed/sidecar(src.loc, icon_skin) //заменить в дочке на нужный путь создания объекта
	deconstruct(FALSE)
	QDEL_NULL(src)

/obj/structure/bed/chair/sidecar/update_health(damage = 0)
	if(QDELETED(src) || is_destroying)
		return
	health -= damage
	healthcheck()

/obj/structure/bed/chair/sidecar/corrosive_acid_act(damage = 0)
	if(damage <= 0)
		return
	health -= damage
	healthcheck()

/obj/structure/bed/chair/sidecar/handle_tail_stab(mob/living/carbon/xenomorph/xeno, blunt_stab)
	var/result = attack_alien(xeno, src)
	if(result != XENO_ATTACK_ACTION)
		return TAILSTAB_COOLDOWN_NONE
	xeno.tail_stab_animation(src, blunt_stab)
	return TAILSTAB_COOLDOWN_NORMAL

/obj/structure/bed/chair/sidecar/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	health -= M.melee_damage_upper
	src.visible_message(SPAN_DANGER("<B>[capitalize(M.declent_ru(NOMINATIVE))] [ru_attack_verb(M.attacktext)] [declent_ru(ACCUSATIVE)]!</B>"))
	M.attack_log += text("\[[time_stamp()]\] <font color='red'>рвет [src.name]</font>")
	if(prob(10))
		new /obj/effect/decal/cleanable/blood/oil(src.loc)
	healthcheck()

/obj/structure/bed/chair/sidecar/attack_alien(mob/living/carbon/xenomorph/M, atom/forced_target)
	if(M.a_intent == INTENT_HELP)
		return XENO_NO_DELAY_ACTION
	if(M.mob_size < MOB_SIZE_XENO)
		to_chat(M, SPAN_XENOWARNING("Вы слишком малы, чтобы нанести этому транспорту значительный урон!"))
		return XENO_NO_DELAY_ACTION
	if(unslashable)
		return
	if(M.melee_damage_upper == 0)
		return
	M.animation_attack_on(src)
	playsound(src, hit_bed_sound, 25, 1)
	M.visible_message(SPAN_DANGER("[capitalize(M.declent_ru(NOMINATIVE))] кромсает [declent_ru(ACCUSATIVE)]!"),
	SPAN_DANGER("Мы кромсаем [declent_ru(ACCUSATIVE)]."))
	health -= M.melee_vehicle_damage + rand(-5, 5)
	healthcheck()
	return XENO_ATTACK_ACTION

/obj/structure/bed/chair/sidecar/bullet_act(obj/projectile/P)
	var/damage = P.damage
	health -= damage
	..()
	healthcheck()
	return TRUE

/obj/structure/bed/chair/sidecar/ex_act(severity)
	health -= severity*0.05
	health -= severity*0.1
	healthcheck()
	return
