/turf/closed/wall/upp_ship/grey
	icon = 'modular/zenith_sanctum/icons/turf/walls/upp_walls_grey.dmi'

/turf/closed/wall/upp_ship/grey/reinforced
	name = "reinforced hull"
	damage_cap = HEALTH_WALL_REINFORCED
	icon_state = "reinforced"
	icon_state = "uppwall_reinforced"

/turf/closed/wall/upp_ship/grey/reinforced/outer
	name = "ultra reinforced hull"
	desc = "An extremely reinforced metal wall used to isolate potentially dangerous areas."
	turf_flags = TURF_HULL
	icon_state = "hull"
	icon_state = "uppwall_hull"

// LV colony walls

/turf/closed/wall/lv_outpost
	name = "bare outpost walls"
	icon = 'modular/zenith_sanctum/icons/turf/walls/lv_colony_walls.dmi'
	icon_state = "lvwall"
	desc = "A thick and chunky metal wall. The surface is barren and imposing."
	walltype = WALL_LV_BASE

/turf/closed/wall/lv_outpost/reinforced
	name = "ribbed outpost walls"
	icon_state = "lvwall_reinforced"
	desc = "A thick and chunky metal wall covered in jagged ribs."
	damage_cap = HEALTH_WALL_REINFORCED

/turf/closed/wall/lv_outpost/reinforced/hull
	desc = "A thick and chunky metal wall that is, just by virtue of its placement and imposing presence, entirely indestructible."
	icon_state = "lvwall_hull"
	turf_flags = TURF_HULL

/turf/closed/wall/lv_outpost/white
	name = "bare outpost walls"
	icon = 'modular/zenith_sanctum/icons/turf/walls/white_lv_colony_walls.dmi'
	icon_state = "lvwall"
	desc = "A thick and chunky metal wall. The surface is barren and imposing."

/turf/closed/wall/lv_outpost/white/reinforced
	name = "ribbed outpost walls"
	icon_state = "lvwall_reinforced"
	desc = "A thick and chunky metal wall covered in jagged ribs."
	damage_cap = HEALTH_WALL_REINFORCED

/turf/closed/wall/lv_outpost/white/reinforced/hull
	desc = "A thick and chunky metal wall that is, just by virtue of its placement and imposing presence, entirely indestructible."
	icon_state = "lvwall_hull"
	turf_flags = TURF_HULL

/turf/closed/wall/strata_outpost
	blend_objects = list(/obj/structure/machinery/door, /obj/structure/window_frame, /obj/structure/window/framed, /obj/structure/mineral_door)

/turf/closed/wall/wood/plain
	name = "plain wood wall"
	icon = 'modular/zenith_sanctum/icons/turf/walls/wood_plain.dmi'
	icon_state = "wood"
	walltype = WALL_WOOD
	baseturfs = /turf/open/floor/wood

/turf/closed/wall/wood/blue
	name = "blue wood wall"
	icon = 'modular/zenith_sanctum/icons/turf/walls/wood_blue.dmi'
	icon_state = "wood"
	walltype = WALL_WOOD
	baseturfs = /turf/open/floor/wood

/turf/closed/wall/wood/green
	name = "green wood wall"
	icon = 'modular/zenith_sanctum/icons/turf/walls/wood_green.dmi'
	icon_state = "wood"
	walltype = WALL_WOOD
	baseturfs = /turf/open/floor/wood

/turf/closed/wall/wood/purple
	name = "purple wood wall"
	icon = 'modular/zenith_sanctum/icons/turf/walls/wood_purple.dmi'
	icon_state = "wood"
	walltype = WALL_WOOD
	baseturfs = /turf/open/floor/wood

/turf/closed/wall/wood/teal
	name = "teal wood wall"
	icon = 'modular/zenith_sanctum/icons/turf/walls/wood_teal.dmi'
	icon_state = "wood"
	walltype = WALL_WOOD
	baseturfs = /turf/open/floor/wood

/turf/closed/wall/rock/brown/mud
	color = "#826161"
	baseturfs = /turf/open/auto_turf/lv_grass/layer0_mud_alt

/turf/closed/wall/rock/grey
	color = "#645e5f"
	baseturfs = /turf/open/gm/dirt
