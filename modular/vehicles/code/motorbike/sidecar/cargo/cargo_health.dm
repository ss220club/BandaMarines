/obj/structure/bed/chair/sidecar/cargo/healthcheck(damage = 0)
	if(health - damage <= 0)
		disconnect()
		// После уничтожения - создается разрушенный каркас
		new /obj/motorbike_destroyed/sidecar/cargo(src.loc, icon_skin)
		deconstruct(FALSE)
		QDEL_NULL(src)
