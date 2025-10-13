GLOBAL_DATUM(almayer_aa_cannon, /obj/structure/anti_air_cannon)

/obj/structure/anti_air_cannon
	name = "\improper IX-50 MGAD Пушка"
	desc = "IX-50 — это современная система микрогравитационной и воздушной обороны, способная независимо отслеживать и нейтрализовать угрозы ракетами, прикрепленными к ней."
	icon = 'icons/effects/128x128.dmi'
	icon_state = "anti_air_cannon"
	density = TRUE
	anchored = TRUE
	layer = LADDER_LAYER
	bound_width = 128
	bound_height = 64
	bound_y = 64
	unslashable = TRUE
	unacidable = TRUE

	// Which ship section is being protected by the AA gun
	var/protecting_section = ""
	var/is_disabled = FALSE

/obj/structure/anti_air_cannon/New()
	. = ..()
	if(!GLOB.almayer_aa_cannon)
		GLOB.almayer_aa_cannon = src

/obj/structure/anti_air_cannon/Destroy()
	. = ..()
	if(GLOB.almayer_aa_cannon == src)
		GLOB.almayer_aa_cannon = null
		message_admins("Reference to GLOB.almayer_aa_cannon is lost!")

/obj/structure/anti_air_cannon/ex_act()
	return

/obj/structure/anti_air_cannon/bullet_act()
	return

/obj/structure/machinery/computer/aa_console
	name = "\improper Консоль системы MGAD"
	desc = "Консоль, управляющая системами отслеживания противовоздушной обороны."
	icon_state = "ob_console"
	dir = WEST
	flags_atom = ON_BORDER|CONDUCT|FPRINT

	req_one_access = list(ACCESS_MARINE_ENGINEERING, ACCESS_MARINE_COMMAND)
	unacidable = TRUE
	unslashable = TRUE

/obj/structure/machinery/computer/aa_console/initialize_pass_flags(datum/pass_flags_container/PF)
	..()
	if (PF)
		PF.flags_can_pass_all = PASS_ALL

/obj/structure/machinery/computer/aa_console/ex_act()
	return

/obj/structure/machinery/computer/aa_console/bullet_act()
	return

/obj/structure/machinery/computer/aa_console/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AntiAirConsole", "[src.name]")
		ui.open()


/obj/structure/machinery/computer/aa_console/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_state

/obj/structure/machinery/computer/aa_console/ui_status(mob/user, datum/ui_state/state)
	. = ..()
	if(inoperable())
		return UI_CLOSE
	if(!allowed(user))
		return UI_CLOSE

/obj/structure/machinery/computer/aa_console/ui_static_data(mob/user)
	var/list/data = list()

	data["sections"] = list()

	for(var/section in GLOB.almayer_ship_sections)
		data["sections"] += list(list(
			"section_id" = section,
		))

	return data

/obj/structure/machinery/computer/aa_console/ui_data(mob/user)
	var/list/data = list()

	data["disabled"] = GLOB.almayer_aa_cannon.is_disabled
	data["protecting_section"] = GLOB.almayer_aa_cannon.protecting_section

	return data

/obj/structure/machinery/computer/aa_console/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!GLOB.almayer_aa_cannon)
		return

	switch(action)
		if("protect")
			GLOB.almayer_aa_cannon.protecting_section = params["section_id"]
			if(!(GLOB.almayer_aa_cannon.protecting_section in GLOB.almayer_ship_sections))
				GLOB.almayer_aa_cannon.protecting_section = ""
				return
			message_admins("[key_name(usr)] настроил ПВО на [html_encode(GLOB.almayer_aa_cannon.protecting_section)].")
			log_ares_antiair("[usr] настроил ПВО на [html_encode(GLOB.almayer_aa_cannon.protecting_section)].")
			. = TRUE
		if("deactivate")
			GLOB.almayer_aa_cannon.protecting_section = ""
			message_admins("[key_name(usr)] отключил ПВО.")
			log_ares_antiair("[usr] отключил системы ПВО.")
			. = TRUE

	add_fingerprint(usr)

// based on big copypasta from the orbital console
// the obvious improvement here is to port to nanoui but i'm too lazy to do that from the get go
/obj/structure/machinery/computer/aa_console/attack_hand(mob/user)
	if(..())
		return TRUE

	if(!skillcheck(user, SKILL_ENGINEER, SKILL_ENGINEER_TRAINED))
		to_chat(user, SPAN_WARNING("Вы не знаете, как пользоваться этой консолью."))
		return TRUE

	if(!allowed(user))
		to_chat(user, SPAN_WARNING("У вас нет доступа к этому."))
		return TRUE

	tgui_interact(user)
	return TRUE
