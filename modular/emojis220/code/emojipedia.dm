/client/verb/emojipedia()
	set name = "Emojipedia"
	set category = "OOC"
	set desc = "Literally an emojipedia, a list of all the emoji available for OOC use."

	var/datum/ui_module/emojipedia/emojipedia = new()
	emojipedia.tgui_interact(usr)

/datum/ui_module/emojipedia
	name = "Emojipedia"
	/// Store the list of potential emojis here.
	var/static/list/emoji_list = icon_states(icon(EMOJI_SET))

/datum/ui_module/emojipedia/ui_state(mob/user)
	return GLOB.always_state

/datum/ui_module/emojipedia/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Emojipedia", name)
		ui.autoupdate = FALSE
		ui.open()

/datum/ui_module/emojipedia/ui_static_data(mob_user)
	var/list/data = list()
	data["emoji_list"] = list()

	for(var/emoji in emoji_list)
		data["emoji_list"] += list(list(
			"name" = emoji,
		))

	return data

/datum/ui_module/emojipedia/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/chat),
	)

/datum/ui_module
	var/name
	var/datum/host

/datum/ui_module/New(datum/_host)
	host = _host

/datum/ui_module/Destroy()
	host = null
	return ..()

/datum/ui_module/ui_host()
	return host ? host : src

/datum/ui_module/ui_close(mob/user)
	if(host)
		host.ui_close(user)
