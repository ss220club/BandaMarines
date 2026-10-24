/obj/structure/bed/chair/sidecar/cargo/healthcheck(damage = 0)
	if(is_destroying || QDELETED(src) || health - damage > 0)
		return
	is_destroying = TRUE
	disconnect()
	// После уничтожения - создается разрушенный каркас
	new /obj/motorbike_destroyed/sidecar/cargo(src.loc, icon_skin)
	deconstruct(FALSE)
	QDEL_NULL(src)
