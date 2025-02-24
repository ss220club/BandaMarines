// Главный чекер урона у vehicle, повторяем здесь же
/obj/structure/bed/chair/stroller/proc/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/stroller(src.loc, icon_skin)
		qdel(src)

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


