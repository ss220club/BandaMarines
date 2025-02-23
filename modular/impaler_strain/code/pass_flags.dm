/obj/structure/machinery/door/airlock/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_BURROWED

/obj/structure/machinery/door/airlock/dropship_hatch/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/machinery/door/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_BURROWED

/obj/structure/machinery/door/airlock/multi_tile/almayer/dropshiprear/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/machinery/door/poddoor/shutters/almayer/locked/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/machinery/door/poddoor/shutters/almayer/pressure/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = NONE

/obj/structure/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_BURROWED

/obj/structure/barricade/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		pass_flags.flags_can_pass_all = PASS_BURROWED
