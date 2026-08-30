/obj/structure/machinery/door/poddoor/almayer/grey
	icon_state ="grey_pdoor1"
	base_icon_state = "grey_pdoor"

/obj/structure/machinery/door/poddoor/almayer/grey/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/machinery/door/poddoor/almayer/grey/LateInitialize()
	. = ..()
	relativewall_neighbours()

/obj/structure/machinery/door/poddoor/almayer/grey/open
	density = FALSE

/obj/structure/machinery/door/poddoor/almayer/grey/locked
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/machinery/door/poddoor/almayer/grey/locked/attackby(obj/item/C, mob/user)
	if(HAS_TRAIT(C, TRAIT_TOOL_CROWBAR))
		return
	. = ..()

/obj/structure/machinery/door/poddoor/almayer/grey/closed
	density = TRUE
	opacity = TRUE

/obj/structure/machinery/door/poddoor/almayer/white
	icon_state ="white_pdoor1"
	base_icon_state = "white_pdoor"

/obj/structure/machinery/door/poddoor/almayer/white/Initialize()
	. = ..()
	return INITIALIZE_HINT_LATELOAD

/obj/structure/machinery/door/poddoor/almayer/white/LateInitialize()
	. = ..()
	relativewall_neighbours()

/obj/structure/machinery/door/poddoor/almayer/white/open
	density = FALSE

/obj/structure/machinery/door/poddoor/almayer/white/locked
	unslashable = TRUE
	unacidable = TRUE

/obj/structure/machinery/door/poddoor/almayer/white/locked/attackby(obj/item/C as obj, mob/user as mob)
	if(HAS_TRAIT(C, TRAIT_TOOL_CROWBAR))
		return
	. = ..()

/obj/structure/machinery/door/poddoor/almayer/white/closed
	density = TRUE
	opacity = TRUE
