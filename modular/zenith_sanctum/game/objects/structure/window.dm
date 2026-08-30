/obj/structure/window/colorable
	icon_state = "colorable_window"
	basestate = "colorable_window"

/obj/structure/window/reinforced/colorable
	icon_state = "colorable_rwindow"
	basestate = "colorable_rwindow"

/obj/structure/window/reinforced/toughened/colorable
	icon_state = "colorable_rwindow"
	basestate = "colorable_rwindow"

/obj/structure/window/reinforced/tinted/colorable
	icon_state = "colorable_twindow"
	basestate = "colorable_twindow"

/obj/structure/window/reinforced/tinted/frosted/colorable
	icon_state = "colorable_fwindow"
	basestate = "colorable_fwindow"

/obj/structure/window/reinforced/ultra/colorable
	icon_state = "colorable_fwindow"
	basestate = "colorable_fwindow"

/obj/structure/window/framed/wood/plain
	icon_state = "wood_plain_window0"
	basestate = "wood_plain_window"
	window_frame = /obj/structure/window_frame/wood/plain

/obj/structure/window/framed/wood/reinforced/plain
	icon_state = "wood_plain_rwindow0"
	basestate = "wood_plain_rwindow"
	window_frame = /obj/structure/window_frame/wood/plain

/obj/structure/window/framed/wood/blue
	icon_state = "wood_blue_window0"
	basestate = "wood_blue_window"
	window_frame = /obj/structure/window_frame/wood/blue

/obj/structure/window/framed/wood/reinforced/blue
	icon_state = "wood_blue_rwindow0"
	basestate = "wood_blue_rwindow"
	window_frame = /obj/structure/window_frame/wood/blue

/obj/structure/window/framed/wood/green
	icon_state = "wood_green_window0"
	basestate = "wood_green_window"
	window_frame = /obj/structure/window_frame/wood/green

/obj/structure/window/framed/wood/reinforced/green
	icon_state = "wood_green_rwindow0"
	basestate = "wood_green_rwindow"
	window_frame = /obj/structure/window_frame/wood/green

/obj/structure/window/framed/wood/purple
	icon_state = "wood_purple_window0"
	basestate = "wood_purple_window"
	window_frame = /obj/structure/window_frame/wood/purple

/obj/structure/window/framed/wood/reinforced/purple
	icon_state = "wood_purple_rwindow0"
	basestate = "wood_purple_rwindow"
	window_frame = /obj/structure/window_frame/wood/purple

/obj/structure/window/framed/wood/teal
	icon_state = "wood_teal_window0"
	basestate = "wood_teal_window"
	window_frame = /obj/structure/window_frame/wood/teal

/obj/structure/window/framed/wood/reinforced/teal
	icon_state = "wood_teal_rwindow0"
	basestate = "wood_teal_rwindow"
	window_frame = /obj/structure/window_frame/wood/teal

//LV windows

/obj/structure/window/framed/lv_colony
	name = "window"
	icon = 'modular/zenith_sanctum/icons/turf/walls/lv_colony_windows.dmi'
	icon_state = "uppwall_window0"
	basestate = "uppwall_window"
	desc = "A glass window inside a wall frame."
	health = 40
	window_frame = /obj/structure/window_frame/lv_colony

/obj/structure/window/framed/lv_colony/reinforced
	name = "reinforced window"
	desc = "A glass window. Light refracts incorrectly when looking through. It looks rather strong. Might take a few good hits to shatter it."
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/lv_colony/reinforced

/obj/structure/window/framed/lv_colony/hull
	name = "hull window"
	desc = "A glass window with a special rod matrix inside a wall frame. This one was made out of exotic materials to prevent hull breaches. No way to get through here."
	//	icon_state = "upp_rwindow0"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/lv_colony/hull

/obj/structure/window/framed/lv_colony/white
	name = "window"
	icon = 'modular/zenith_sanctum/icons/turf/walls/white_lv_colony_windows.dmi'
	icon_state = "uppwall_window0"
	basestate = "uppwall_window"
	desc = "A glass window inside a wall frame."
	health = 40
	window_frame = /obj/structure/window_frame/lv_colony

/obj/structure/window/framed/lv_colony/white/reinforced
	name = "reinforced window"
	desc = "A glass window. Light refracts incorrectly when looking through. It looks rather strong. Might take a few good hits to shatter it."
	health = 100
	reinf = 1
	window_frame = /obj/structure/window_frame/lv_colony/white/reinforced

/obj/structure/window/framed/lv_colony/white/hull
	name = "hull window"
	desc = "A glass window with a special rod matrix inside a wall frame. This one was made out of exotic materials to prevent hull breaches. No way to get through here."
	//	icon_state = "upp_rwindow0"
	not_damageable = TRUE
	not_deconstructable = TRUE
	unslashable = TRUE
	unacidable = TRUE
	health = 1000000
	window_frame = /obj/structure/window_frame/lv_colony/white/hull
