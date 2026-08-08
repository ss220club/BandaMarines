/datum/supply_packs/upp/himat
	name = "UPP M112 HIMAT missile launcher."
	cost = 45
	contains = list(
		/obj/item/mortar_kit/himat,
	)
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M112 HIMAT missile launcher crate"
	group = "UPP Mortar"

/datum/supply_packs/upp/ammo_mortar_he
	name = "UPP M112 HIMAT missiles (x5 HE)"
	cost = 25
	contains = list(
		/obj/item/mortar_shell/himat/explosive,
		/obj/item/mortar_shell/himat/explosive,
		/obj/item/mortar_shell/himat/explosive,
		/obj/item/mortar_shell/himat/explosive,
		/obj/item/mortar_shell/himat/explosive,
	)
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M112 HIMAT HE missiles crate"
	group = "UPP Mortar"

/datum/supply_packs/upp/ammo_mortar_ap
	name = "UPP M112 HIMAT missiles (x5 AP)"
	cost = 25
	contains = list(
		/obj/item/mortar_shell/himat/antipersonnel,
		/obj/item/mortar_shell/himat/antipersonnel,
		/obj/item/mortar_shell/himat/antipersonnel,
		/obj/item/mortar_shell/himat/antipersonnel,
		/obj/item/mortar_shell/himat/antipersonnel,
		
	)
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M112 HIMAT AP missiles crate"
	group = "UPP Mortar"

/datum/supply_packs/upp/ammo_mortar_incend
	name = "UPP M112 HIMAT missiles (x5 Incend)"
	cost = 35
	contains = list(
		/obj/item/mortar_shell/incendiary/himat,
		/obj/item/mortar_shell/incendiary/himat,
		/obj/item/mortar_shell/incendiary/himat,
		/obj/item/mortar_shell/incendiary/himat,
		/obj/item/mortar_shell/incendiary/himat,
	)
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M112 HIMAT incendiary missiles crate"
	group = "UPP Mortar"

/datum/supply_packs/upp/ammo_mortar_flare
	name = "UPP M112 HIMAT missiles (x5 Flare)"
	cost = 10
	contains = list(
		/obj/item/mortar_shell/himat/training,
		/obj/item/mortar_shell/himat/training,
		/obj/item/mortar_shell/himat/training,
		/obj/item/mortar_shell/himat/training,
		/obj/item/mortar_shell/himat/training,
	)
	containertype = /obj/structure/closet/crate/explosives
	containername = "\improper M112 HIMAT flare missiles crate"
	group = "UPP Mortar"
