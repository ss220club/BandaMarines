/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return
	owner?.mob?.update_keybinds()

/datum/preferences
	var/show_hotkeys

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "show_hotkeys")
		show_hotkeys = !show_hotkeys
	. = ..()
