/obj/structure/tent
	name = "tent"
	icon = 'icons/obj/structures/tents_deployed_classic.dmi'
	desc = "Can be torn down with an entrenching tool."
	opacity = FALSE // Seems only the initial turf blocks light, not all of the multitile. Therefore, useless.
	layer = INTERIOR_WALL_SOUTH_LAYER // This should be below FLY_LAYER but just thank chairs and other bs
	health = 200
	appearance_flags = TILE_BOUND


/obj/structure/tent/eng
	icon = 'modular/tents/tent-Icons/Tent-OBJ/tents_deployed_classic.dmi'
	icon_state = "eng_interior"
	roof_state = "eng_top"
	x_dim = 4
	y_dim = 4
	layer = INTERIOR_WALL_SOUTH_LAYER
    /// Required cleared area along X axis
/obj/structure/tent/Initialize(mapload, ...)
	. = ..()
	bound_width = x_dim * world.icon_size
	bound_height = y_dim * world.icon_size
	for(var/turf/turf in locs)
		RegisterSignal(turf, COMSIG_TURF_ENTERED, PROC_REF(movable_entering_tent), override = TRUE)

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'modular/tents/tent-Icons/Tent-OBJ/tents_deployed_jungle.dmi'
		if("desert")
			icon = 'modular/tents/tent-Icons/Tent-OBJ/tents_deployed_desert.dmi'
		if("snow")
			icon = 'modular/tents/tent-Icons/Tent-OBJ/tents_deployed_snow.dmi'
		if("urban")
			icon = 'modular/tents/tent-Icons/Tent-OBJ/tents_deployed_urban.dmi'
