/obj/structure/machinery/door/window/colorable
	icon_state = "colorable_left"
	base_state = "colorable_left"

/obj/structure/machinery/door/window/colorable/northleft
	dir = NORTH

/obj/structure/machinery/door/window/colorable/eastleft
	dir = EAST

/obj/structure/machinery/door/window/colorable/westleft
	dir = WEST

/obj/structure/machinery/door/window/colorable/southleft
	dir = SOUTH

/obj/structure/machinery/door/window/colorable/northright
	dir = NORTH
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/eastright
	dir = EAST
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/westright
	dir = WEST
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/southright
	dir = SOUTH
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/brigdoor/northleft
	dir = NORTH

/obj/structure/machinery/door/window/colorable/brigdoor/eastleft
	dir = EAST

/obj/structure/machinery/door/window/colorable/brigdoor/westleft
	dir = WEST

/obj/structure/machinery/door/window/colorable/brigdoor/southleft
	dir = SOUTH

/obj/structure/machinery/door/window/colorable/brigdoor/northright
	dir = NORTH
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/brigdoor/eastright
	dir = EAST
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/brigdoor/westright
	dir = WEST
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/brigdoor/southright
	dir = SOUTH
	icon_state = "colorable_right"
	base_state = "colorable_right"

/obj/structure/machinery/door/window/colorable/tinted
	opacity = TRUE

/obj/structure/machinery/door/window/colorable/brigdoor
	name = "Secure glass door"
	desc = "A thick chunk of tempered glass on metal track. Probably more robust than you."
	req_access = list(ACCESS_MARINE_BRIG)
	health = 300 //Stronger doors for prison (regular window door health is 150)
