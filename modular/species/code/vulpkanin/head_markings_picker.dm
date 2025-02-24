/datum/head_markings_picker/ui_static_data(mob/user)
	. = ..()

	.["vulpkanin_head_markings"] = /datum/sprite_accessory/vulpkanin_head_markings::icon

/datum/head_markings_picker/ui_data(mob/user)
	. = ..()

	var/datum/preferences/prefs = user.client.prefs

	.["vulpkanin_head_marking"] = GLOB.vulpkanin_head_markings_list["Vulpkanin Nose"].icon_state
	.["vulpkanin_head_marking_color"] = rgb(prefs.r_hair, prefs.g_hair, prefs.b_hair)

	.["vulpkanin_head_markings"] = list()
	for(var/key in GLOB.vulpkanin_head_markings_list)
		var/datum/sprite_accessory/vulpkanin_head_markings/markings = GLOB.vulpkanin_head_markings_list[key]
		if(!markings.selectable)
			continue
		if(!(prefs.species in markings.species_allowed))
			continue

		.["vulpkanin_head_markings"] += list(
			list("name" = markings.name, "icon" = markings.icon_state)
		)

/datum/head_markings_picker/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	var/datum/preferences/prefs = ui.user.client.prefs

	switch(action)
		if("vulpkanin_head_markings")
			var/datum/sprite_accessory/hair/markings = GLOB.vulpkanin_head_markings_list[params["name"]]
			if(!markings)
				return

			if(!markings.selectable)
				return

			if(!(prefs.species in markings.species_allowed))
				return

			//prefs.markings = params["name"]

		if("vulpkanin_head_marking_color")
			var/param_color = params["color"]
			if(!param_color)
				return

			var/r = hex2num(copytext(param_color, 2, 4))
			var/g = hex2num(copytext(param_color, 4, 6))
			var/b = hex2num(copytext(param_color, 6, 8))

			if(!isnum(r) || !isnum(g) || !isnum(b))
				return

			prefs.r_hair = clamp(r, 0, 255)
			prefs.g_hair = clamp(g, 0, 255)
			prefs.b_hair = clamp(b, 0, 255)

	prefs.ShowChoices(ui.user)
	return TRUE

/datum/head_markings_picker/tgui_interact(mob/user, datum/tgui/ui)
	. = ..()

	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "HairPicker", "Hair Picker")
		ui.open()
		ui.set_autoupdate(FALSE)

	winset(user, ui.window.id, "focus=true")

/datum/head_markings_picker/ui_state(mob/user)
	return GLOB.always_state
