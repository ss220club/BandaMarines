/datum/map_template/interior/modular
	name = "Base Interior Template"
	prefix = "modular/vehicles/interior_map/"
	interior_id = "SHOULD NEVER EXIST"

/datum/map_template/interior/modular/New()
	if(interior_id == "SHOULD NEVER EXIST")
		stack_trace("invalid interior datum")
	mappath = "[prefix][interior_id].dmm"
	return ..()

//van
/datum/map_template/interior/modular/uscm_van
	name = "USCM Van"
	interior_id = "uscm_van"

/datum/map_template/interior/modular/uscm_van/med
	name = "USCM Van"
	interior_id = "uscm_van_med"

//humvee
/datum/map_template/interior/modular/humvee
	name = "JTMV-HWC"
	interior_id = "humvee"

/datum/map_template/interior/modular/humvee/medical
	name = "JTMV-Ambulance"
	interior_id = "humvee_medical"

/datum/map_template/interior/modular/humvee/transport
	name = "JTMV-Utility"
	interior_id = "humvee_transport"

/datum/map_template/interior/modular/humvee/apc
	name = "JTMV-HWC"
	interior_id = "humvee"

//tank & AEV
/datum/map_template/interior/modular/aev
	name = "AEV"
	interior_id = "aev"

/datum/map_template/interior/modular/tank_command
	name = "Command Tank"
	interior_id = "tank_command"
