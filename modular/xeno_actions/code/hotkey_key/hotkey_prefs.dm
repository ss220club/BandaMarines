/datum/preferences/save_preferences()
	. = ..()
	if(!.)
		return
	if(owner?.mob)
		SEND_SIGNAL(owner.mob, COMSIG_MOB_PREFERENCES_SAVED)
