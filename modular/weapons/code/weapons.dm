
// !!! Временно размещаем их тут, пока я не закину тот модуль с заказами карго
// Потом закинуть в modular/supply_packs/_supply_packs.dm когда вмержу байко


/datum/supply_packs/rockets_launchers_common
	name = "RPG M83A2-C Crate (x3)"
	contains = list(
		/obj/item/prop/folded_anti_tank_sadar/common,
		/obj/item/prop/folded_anti_tank_sadar/common,
		/obj/item/prop/folded_anti_tank_sadar/common,
	)
	cost = 40	// Цена как за 8 гранат HEDP (6 штук стоят 30$)
	containertype = /obj/structure/closet/crate/secure/explosives
	containername = "Ящик упакованных РПГ"
	group = "Explosives"
