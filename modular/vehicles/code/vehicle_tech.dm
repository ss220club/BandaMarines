/datum/tech/humvee
	name = "M24 Series JTMV Vehicle"
	desc = "Purchase an M24 Series JTMV, a M2420 JTMV-HWC Heavy Weapon Carrier, M2421 JTMV-Ambulance, or M2422 JTMV-Utility variant may be selected."
	icon = 'modular/vehicles/icons/vehicle_tech.dmi'
	icon_state = "humvee"

	required_points = 5

	tier = /datum/tier/one

	announce_name = "ПРИОБРЕТЕНИЕ M24 Series JTMV"
	announce_message = "Получена авторизация на \"Многоцелевой бронетранспортер M2422 JTMV\".Он будет доставлен в отсек транспортных средств."

	flags = TREE_FLAG_MARINE


/datum/tech/humvee/on_unlock()
	. = ..()

	var/obj/structure/machinery/computer/supply/asrs/vehicle/comp = GLOB.VehicleElevatorConsole
	var/obj/structure/machinery/cm_vending/gear/vehicle_crew/gearcomp = GLOB.VehicleGearConsole

	if(!comp || !gearcomp)
		return FALSE

	comp.spent = FALSE

	comp.vehicles += new /datum/vehicle_order/humvee/apc()

	return TRUE
