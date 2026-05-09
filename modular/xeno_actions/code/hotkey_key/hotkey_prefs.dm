/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return
	owner?.mob?.update_keybinds()

/datum/preferences
	var/xeno_show_hotkeys

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "xeno_show_hotkeys")
		xeno_show_hotkeys = !xeno_show_hotkeys
	. = ..()
