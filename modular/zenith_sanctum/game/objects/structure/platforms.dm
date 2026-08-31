/obj/structure/platform/wood
	icon_state = "wood_platform"
	creaking_sound = 'modular/zenith_sanctum/sound/effects/wood_creaking.ogg'
	breaking_sound = 'sound/effects/woodhit.ogg'

/obj/structure/platform/metal/stair_cut/strata_left/alt
	icon_state = "alt_strata_metalplatform_stair"

/obj/structure/platform/metal/stair_cut/strata_right/alt
	icon_state = "alt_strata_metalplatform_stair_alt"

// Alt Strata Platform (Light-Grey)

/obj/structure/platform/metal/strata/alt
	icon_state = "alt_strata_metalplatform"

/obj/structure/platform/metal/strata/alt/north
	dir = NORTH
/obj/structure/platform/metal/strata/alt/east
	dir = EAST
/obj/structure/platform/metal/strata/alt/west
	dir = WEST

// Alt Strata Platform Deco (Light-Grey)

/obj/structure/platform_decoration/metal/strata/alt
	name = "raised metal corner"
	desc = "A raised level of metal, often used to elevate areas above others. This is the corner."
	icon_state = "alt_strata_metalplatform_deco"

/obj/structure/platform_decoration/metal/strata/alt/north
	dir = NORTH
/obj/structure/platform_decoration/metal/strata/alt/east
	dir = EAST
/obj/structure/platform_decoration/metal/strata/alt/west
	dir = WEST

//------------------------------//
//    Wooden Stairs Platforms    //
//------------------------------//

/obj/structure/platform/wood
	icon_state = "wood_platform"
	name = "wooden platform"
	desc = "A raised level of wood, often used to elevate areas above others. You could probably climb it."

/obj/structure/platform/wood/north
	dir = NORTH
/obj/structure/platform/wood/east
	dir = EAST
/obj/structure/platform/wood/west
	dir = WEST

/obj/structure/platform/wood/stair_cut
	icon_state = "wood_platform_stair"
	dir = NORTH

/obj/structure/platform/wood/stair_cut/platform_left
	icon_state = "wood_platform_stair"

/obj/structure/platform/wood/stair_cut/platform_right
	icon_state = "wood_platform_stair_alt"

//------------------------------------//
// Wood based Platforms "decoration" //
//------------------------------------//

/obj/structure/platform_decoration/wood
	icon_state = "wood_platform_deco"

/obj/structure/platform_decoration/wood/north
	icon_state = "wood_platform_deco"
	dir = NORTH

/obj/structure/platform_decoration/wood/east
	dir = EAST
/obj/structure/platform_decoration/wood/west
	dir = WEST
/obj/structure/platform_decoration/wood/northeast
	dir = NORTHEAST
/obj/structure/platform_decoration/wood/northwest
	dir = NORTHWEST
/obj/structure/platform_decoration/wood/southeast
	dir = SOUTHEAST
/obj/structure/platform_decoration/wood/southwest
	dir = SOUTHWEST

/obj/structure/platform/stone/ancient_temple/already_broken

/obj/structure/platform/stone/ancient_temple/already_broken/Initialize()
	. = ..()
	broken()

/obj/structure/platform/stone/ancient_temple/alt/already_broken

/obj/structure/platform/stone/ancient_temple/alt/already_broken/Initialize()
	. = ..()
	broken()
