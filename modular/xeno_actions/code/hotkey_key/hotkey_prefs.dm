/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return
	if(owner?.mob)
		SEND_SIGNAL(owner.mob, COMSIG_MOB_PREFERENCES_SAVED)

/datum/preferences
	var/xeno_show_hotkeys

/datum/preferences/process_link(mob/user, list/href_list)
	if(href_list["preference"] == "xeno_show_hotkeys")
		xeno_show_hotkeys = !xeno_show_hotkeys
	. = ..()
