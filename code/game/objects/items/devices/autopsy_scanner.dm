
//moved these here from code/defines/obj/weapon.dm
//please preference put stuff where it's easy to find - C

/obj/item/device/autopsy_scanner
	name = "autopsy scanner"
	desc = "Extracts information on wounds."
	icon_state = "autopsy_scanner"
	flags_atom = FPRINT|CONDUCT
	w_class = SIZE_SMALL

	var/list/datum/autopsy_data_scanner/wdata = list()
	var/list/datum/autopsy_data_scanner/chemtraces = list()
	var/target_name = null
	var/timeofdeath = null

/obj/item/device/autopsy_scanner/Initialize()
	. = ..()

	LAZYADD(GLOB.objects_of_interest, src)

/obj/item/device/autopsy_scanner/Destroy()
	. = ..()

	LAZYREMOVE(GLOB.objects_of_interest, src)

/datum/autopsy_data_scanner
	var/weapon = null // this is the DEFINITE weapon type that was used
	var/list/organs_scanned = list() // this maps a number of scanned organs to the wounds to those organs with this data's weapon type
	var/organ_names = ""

/datum/autopsy_data
	var/weapon = null
	var/pretend_weapon = null
	var/damage = 0
	var/hits = 0
	var/time_inflicted = 0

/datum/autopsy_data/proc/copy()
	var/datum/autopsy_data/W = new()
	W.weapon = weapon
	W.pretend_weapon = pretend_weapon
	W.damage = damage
	W.hits = hits
	W.time_inflicted = time_inflicted
	return W

/obj/item/device/autopsy_scanner/proc/add_data(obj/limb/O)
	if(!length(O.autopsy_data) && !length(O.trace_chemicals))
		return

	for(var/V in O.autopsy_data)
		var/datum/autopsy_data/W = O.autopsy_data[V]

		if(!W.pretend_weapon)
			/*
			// the more hits, the more likely it is that we get the right weapon type
			if(prob(50 + W.hits * 10 + W.damage))
			*/

			// Buffing this stuff up for now!
			W.pretend_weapon = W.weapon

		var/datum/autopsy_data_scanner/D = wdata[V]
		if(!D)
			D = new()
			D.weapon = W.weapon
			wdata[V] = D

		if(!D.organs_scanned[O.name])
			if(D.organ_names == "")
				D.organ_names = O.display_name
			else
				D.organ_names += ", [O.display_name]"

		qdel(D.organs_scanned[O.name])
		D.organs_scanned[O.name] = W.copy()

	for(var/V in O.trace_chemicals)
		if(O.trace_chemicals[V] > 0 && !chemtraces.Find(V))
			chemtraces += V

/obj/item/device/autopsy_scanner/verb/print_data()
	set category = "Object"
	set src in view(usr, 1)
	set name = "Print Data"
	if(usr.stat || !(istype(usr,/mob/living/carbon/human)))
		to_chat(usr, "No.")
		return

	var/scan_data = ""

	if(timeofdeath)
		scan_data += "<b>Time of death:</b> [worldtime2text("hh:mm", timeofdeath)] [time2text(timeofdeath, "DDD MMM DD [GLOB.game_year]")]<br><br>"

	var/n = 1
	for(var/wdata_idx in wdata)
		var/datum/autopsy_data_scanner/D = wdata[wdata_idx]
		var/total_hits = 0
		var/total_score = 0
		var/list/weapon_chances = list() // maps weapon names to a score
		var/age = 0

		for(var/wound_idx in D.organs_scanned)
			var/datum/autopsy_data/W = D.organs_scanned[wound_idx]
			total_hits += W.hits

			var/wname = W.pretend_weapon

			if(weapon_chances[wname])
				weapon_chances[wname] += W.damage
			else
				weapon_chances[wname] = max(W.damage, 1)
			total_score+=W.damage


			var/wound_age = W.time_inflicted
			age = max(age, wound_age)

		var/damage_desc

		var/damaging_weapon = (total_score != 0)

		// total score happens to be the total damage
		switch(total_score)
			if(0)
				damage_desc = "Unknown"
			if(1 to 5)
				damage_desc = "<font color='green'>negligible</font>"
			if(5 to 15)
				damage_desc = "<font color='green'>light</font>"
			if(15 to 30)
				damage_desc = "<font color='orange'>moderate</font>"
			if(30 to 1000)
				damage_desc = "<font color='red'>severe</font>"

		if(!total_score)
			total_score = length(D.organs_scanned)

		scan_data += "<b>Weapon #[n]</b><br>"
		if(damaging_weapon)
			scan_data += "Severity: [damage_desc]<br>"
			scan_data += "Hits by weapon: [total_hits]<br>"
		scan_data += "Approximate time of wound infliction: [worldtime2text("hh:mm", age)] [time2text(age, "DDD MMM DD [GLOB.game_year]")]<br>"
		scan_data += "Affected limbs: [D.organ_names]<br>"
		scan_data += "Possible weapons:<br>"
		for(var/weapon_name in weapon_chances)
			scan_data += "\t[100*weapon_chances[weapon_name]/total_score]% [weapon_name]<br>"

		scan_data += "<br>"

		n++

	if(length(chemtraces))
		scan_data += "<b>Trace Chemicals: </b><br>"
		for(var/chemID in chemtraces)
			scan_data += chemID
			scan_data += "<br>"

	for(var/mob/O in viewers(usr))
		O.show_message(SPAN_DANGER("\the [src] rattles and prints out a sheet of paper."), SHOW_MESSAGE_VISIBLE)

	sleep(10)

	var/obj/item/paper/P = new(usr.loc)
	P.name = "Autopsy Data ([target_name])"
	P.info = "<tt>[scan_data]</tt>"
	P.icon_state = "paper_words"

	if(istype(usr,/mob/living/carbon))
		// place the item in the usr's hand if possible
		usr.put_in_hands(P)
	if (ismob(src.loc))
		var/mob/M = src.loc
		M.update_inv_l_hand()
		M.update_inv_r_hand()

/obj/item/device/autopsy_scanner/attack(mob/living/carbon/human/M as mob, mob/living/carbon/user as mob)
	if(!istype(M) || !M.is_mob_incapacitated())
		return

	var/table
	for(var/obj/surface in get_turf(M)) //An autopsy needs a surgery table, or a field surgery bed.
		if(surface.surgery_duration_multiplier <= SURGERY_SURFACE_MULT_ADEQUATE)
			table = TRUE
			break

	if(!table)
		to_chat(usr, "<b>You can't work here, you need to put [M] on a proper surgical bed.</b>")
		return

	if(target_name != M.name)
		target_name = M.name
		src.wdata = list()
		src.chemtraces = list()
		src.timeofdeath = null
		to_chat(user, SPAN_DANGER("A new patient has been registered. Purging data for previous patient."))

	src.timeofdeath = M.timeofdeath

	var/obj/limb/S = M.get_limb(user.zone_selected)
	if(!S)
		to_chat(usr, "<b>You can't scan this body part.</b>")
		return
	if(M.incision_depths[S.name] == SURGERY_DEPTH_SURFACE)
		to_chat(usr, "<b>You have to cut the limb open first!</b>")
		return
	for(var/mob/O in viewers(M))
		O.show_message(SPAN_DANGER("[user.name] scans the wounds on [M.name]'s [S.display_name] with \the [src.name]"), SHOW_MESSAGE_VISIBLE)

	src.add_data(S)

	return TRUE
