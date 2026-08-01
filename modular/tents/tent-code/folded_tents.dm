/obj/item/folded_tent/eng
	name = "folded USCM Engineer Tent"
	icon = 'modular/tents/tent-Icons/tent-OBJ/tents_folded.dmi'
	icon_state = "eng"
	w_class = SIZE_LARGE

	/// Required cleared area along X axis
	desc = "A standard USCM Tent. This one for engineers, for colony engineering version. Unfold in a suitable location for maximum FOB vibes. Combat Technician not included. ENTRANCE TO THE SOUTH."
	template_preset = "tent_eng"
/obj/structure/tent/Initialize(mapload, ...)
	. = ..()
	bound_width = x_dim * world.icon_size
	bound_height = y_dim * world.icon_size
	for(var/turf/turf in locs)
		RegisterSignal(turf, COMSIG_TURF_ENTERED, PROC_REF(movable_entering_tent), override = TRUE)


