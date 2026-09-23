//Zenith Sanctum

/obj/structure/flora/grass/tallgrass/jungle_alt_2
	color = "#9ac68c"
	icon_state = "tallgrass"
	desc = "A clump of vibrant jungle grasses"
	fire_flag = FLORA_BURN_SPREAD_ONCE

/obj/structure/flora/grass/tallgrass/jungle_alt_2/corner
	icon_state = "tallgrass_corner"
	overlay_type = "tallgrass_overlay_corner"
	center = FALSE

/obj/structure/flora/jungle/vines/blue
	name = "vines"
	desc = "A mass of twisted vines."
	icon = 'modular/zenith_sanctum/icons/effects/vines/blue_vines.dmi'

/obj/structure/flora/jungle/vines/blue/light_1
	icon_state = "light_1"
	icon_tag = "light"

/obj/structure/flora/jungle/vines/blue/light_2
	icon_state = "light_2"
	icon_tag = "light"

/obj/structure/flora/jungle/vines/blue/light_3
	icon_state = "light_3"
	icon_tag = "light"

/obj/structure/flora/jungle/vines/dead
	name = "dead vines"
	desc = "A mass of twisted dead vines."
	icon = 'modular/zenith_sanctum/icons/effects/vines/dead_vines.dmi'

/obj/structure/flora/jungle/vines/dead/light_1
	icon_state = "light_1"
	icon_tag = "light"

/obj/structure/flora/jungle/vines/dead/light_2
	icon_state = "light_2"
	icon_tag = "light"

/obj/structure/flora/jungle/vines/dead/light_3
	icon_state = "light_3"
	icon_tag = "light"

// Heavy Vines - no visibility

/obj/structure/flora/jungle/vines/blue/heavy
	desc = "A thick, coiled mass of twisted vines."
	opacity = TRUE
	icon_state = "heavy_6"
	icon_tag = "heavy"
	variations = 6

/obj/structure/flora/jungle/vines/blue/heavy/New()
	..()
	icon_state = pick("heavy_1","heavy_2","heavy_3","heavy_4","heavy_5","heavy_6")

/obj/structure/flora/jungle/vines/dead/heavy
	desc = "A thick, coiled mass of twisted dead vines."
	opacity = TRUE
	icon_state = "heavy_6"
	icon_tag = "heavy"
	variations = 6

/obj/structure/flora/jungle/vines/dead/heavy/New()
	..()
	icon_state = pick("heavy_1","heavy_2","heavy_3","heavy_4","heavy_5","heavy_6")
