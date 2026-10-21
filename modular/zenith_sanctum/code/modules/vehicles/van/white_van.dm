//Trucks
//Read the documentation in multitile.dm before trying to decipher this stuff

/obj/vehicle/multitile/van/white
	name = "Weyland-Yutani Van"
	desc = "Довольно старая груда металла на четырёх колёсах c затершейся эмблемой Вэйланд-Ютани — вы знаете, что делать. Вход — сзади и по бокам."

	icon = 'modular/zenith_sanctum/icons/obj/vehicles/white_van.dmi'
	icon_state = "van_base"
	interior_map = /datum/map_template/interior/white_van

	req_one_access = list(200)

/*
** PRESETS SPAWNERS
*/

/obj/effect/vehicle_spawner/van/white
	icon = 'modular/zenith_sanctum/icons/obj/vehicles/white_van.dmi'
