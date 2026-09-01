/datum/map_template/interior/modul
	name = "Base Interior Template"
	prefix = "modular/vehicles/interior_map/"
	interior_id = "SHOULD NEVER EXIST"

/datum/map_template/interior/modul/New()
	if(interior_id == "SHOULD NEVER EXIST")
		stack_trace("invalid interior datum")
	mappath = "[prefix][interior_id].dmm"
	return ..()

//van
/datum/map_template/interior/modul/uscm_van
	name = "USCM Van"
	interior_id = "uscm_van"

/datum/map_template/interior/modul/uscm_van/med
	name = "USCM Van"
	interior_id = "uscm_van_med"

//humvee
/datum/map_template/interior/modul/humvee
	name = "JTMV-HWC"
	interior_id = "humvee"

/datum/map_template/interior/modul/humvee/medical
	name = "JTMV-Ambulance"
	interior_id = "humvee_medical"

/datum/map_template/interior/modul/humvee/transport
	name = "JTMV-Utility"
	interior_id = "humvee_transport"

/datum/map_template/interior/modul/humvee/apc
	name = "JTMV-HWC"
	interior_id = "humvee"
