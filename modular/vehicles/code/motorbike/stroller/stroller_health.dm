// Главный чекер урона у vehicle, повторяем здесь же
/obj/structure/bed/chair/stroller/proc/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		update_mob_gun_signal(TRUE)
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/stroller(src.loc, icon_skin)
		if(mounted)
			mounted.forceMove(src.loc)
			mounted.update_health(mounted.health) // Разрушенный каркас, патроны и тому подобное
		QDEL_NULL(src)

/obj/structure/bed/chair/stroller/update_health(damage = 0)
	healthcheck(damage)
	. = ..()

/obj/structure/bed/chair/stroller/deconstruct(disassembled)
	healthcheck()
	. = ..()

/obj/structure/bed/chair/stroller/attack_animal(mob/living/simple_animal/M as mob)
	if(M.melee_damage_upper == 0)
		return
	health -= M.melee_damage_upper
	src.visible_message(SPAN_DANGER("<B>[M] [M.attacktext] [src]!</B>"))
	M.attack_log += text("\[[time_stamp()]\] <font color='red'>рвет [src.name]</font>")
	if(prob(10))
		new /obj/effect/decal/cleanable/blood/oil(src.loc)
	healthcheck()

/obj/structure/bed/chair/stroller/bullet_act(obj/projectile/P)
	if(buckled_mob && prob(hit_chance_buckled) && buckled_mob.get_projectile_hit_chance(P))
		return buckled_mob.bullet_act(P)	// Сидящие тоже могут получить пулю в задницу
	var/damage = P.damage
	health -= damage
	..()
	healthcheck()
	return TRUE

/obj/structure/bed/chair/stroller/ex_act(severity)
	health -= severity*0.05
	health -= severity*0.1
	healthcheck()
	return


