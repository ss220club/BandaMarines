// ==========================================
// ================== Урон ==================
// После уничтожения - создается разрушенный каркас

// Главный чекер урона у vehicle
/obj/vehicle/motorbike/healthcheck()
	check_and_try_disasemble()
	. = ..()

/obj/vehicle/motorbike/proc/check_and_try_disasemble(damage = 0)
	if(health - damage <= 0)
		stroller.disconnect()
		//vehicle is dead, no more lights
		if(lighting_holder.light_range)
			lighting_holder.set_light_on(FALSE)
		QDEL_NULL(lighting_holder)
		new /obj/motorbike_destroyed(src.loc, icon_skin)


/obj/vehicle/motorbike/bullet_act(obj/projectile/P)
	if(stroller && prob(hit_chance_connected) && stroller.get_projectile_hit_boolean(P))
		return stroller.bullet_act(P)	// Приконекченная тележка задевается если задевать и мотоцикл
	if(buckled_mob && prob(hit_chance_buckled) && buckled_mob.get_projectile_hit_chance(P))
		return buckled_mob.bullet_act(P)	// Сидящие тоже могут получить пулю в задницу
	. = ..()
