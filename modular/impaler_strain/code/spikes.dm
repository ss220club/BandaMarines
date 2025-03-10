/obj/effect/xenomorph/ground_spike
	desc = ""
	icon = 'modular/impaler_strain/icons/effects.dmi'
	icon_state = "ground_spike"
	mouse_opacity = FALSE
	var/mob/living/carbon/xenomorph/source_xeno = null

/obj/effect/xenomorph/ground_spike/New(loc, source_xeno = null, ttl = 10)
	if(isxeno(source_xeno))
		src.source_xeno = source_xeno
	..(loc)
	QDEL_IN(src, ttl)
