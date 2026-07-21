/obj/structure/machinery/computer/dropship_weapons/dropship4
	name = "\improper 'Devana' weapons controls"
	req_one_access = list(ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT, ACCESS_WY_FLIGHT)
	firemission_envelope = new /datum/cas_fire_envelope/uscm_dropship()
	shuttle_tag = DROPSHIP_DEVANA

/obj/structure/machinery/computer/dropship_weapons/dropship5
	name = "\improper 'Morana' weapons controls"
	req_one_access = list(ACCESS_UPP_LEADERSHIP, ACCESS_UPP_FLIGHT, ACCESS_WY_FLIGHT)
	firemission_envelope = new /datum/cas_fire_envelope/uscm_dropship()
	shuttle_tag = DROPSHIP_MORANA

/obj/structure/machinery/computer/cameras/dropship/four
	name = "\improper 'Devana' camera controls"
	network = list(CAMERA_NET_RESEARCH, CAMERA_NET_LASER_TARGETS)

/obj/structure/machinery/computer/cameras/dropship/five
	name = "\improper 'Morana' camera controls"
	network = list(CAMERA_NET_RESEARCH, CAMERA_NET_LASER_TARGETS)
