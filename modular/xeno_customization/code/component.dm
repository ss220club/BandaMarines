/datum/component/xeno_customization
	dupe_mode = COMPONENT_DUPE_ALLOWED
	var/customization_type
	var/icon_path = null
	var/image/customization
	/// List of players who are ready/already see customization
	var/list/mob/seeables = list()

/datum/component/xeno_customization/Initialize(customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY, icon_path)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	src.customization_type = customization_type
	src.icon_path = icon_path
	customization = image(icon_path, parent)
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_new_player_login))
	for(var/mob/player in GLOB.player_list)
		add_to_player_view(player)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)

/datum/component/xeno_customization/Destroy(force, silent)
	qdel(customization)
	. = ..()

/datum/component/xeno_customization/proc/on_new_player_login(subsystem, mob/user)
	SIGNAL_HANDLER

	add_to_player_view(user)

/datum/component/xeno_customization/proc/add_to_player_view(mob/user)
	SIGNAL_HANDLER

	if(!user.client)
		return
	if(!(user in seeables))
		seeables += user
		RegisterSignal(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY, PROC_REF(add_to_player_view))
		RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(on_viewer_destroy))
	if(!check_visibility_pref(user))
		remove_from_player_view(user)
		return
	user.client.images |= customization

/datum/component/xeno_customization/proc/remove_from_player_view(mob/user)
	SIGNAL_HANDLER

	if(!user.client)
		return
	user.client.images -= customization

/datum/component/xeno_customization/proc/on_viewer_destroy(mob/user)
	SIGNAL_HANDLER

	seeables -= user
	UnregisterSignal(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	UnregisterSignal(user, COMSIG_PARENT_QDELETING)

/datum/component/xeno_customization/proc/check_visibility_pref(mob/user)
	switch(user.client.prefs.xeno_customization_visibility)
		if(XENO_CUSTOMIZATION_SHOW_ALL)
			return TRUE
		if(XENO_CUSTOMIZATION_SHOW_NONE)
			return FALSE
		if(XENO_CUSTOMIZATION_SHOW_LORE_FRIENDLY)
			if(customization_type == XENO_CUSTOMIZATION_NON_LORE_FRIENDLY)
				return FALSE
			return TRUE
	return TRUE

/datum/component/xeno_customization/proc/update_customization_icons(mob/living/carbon/xenomorph/xeno, icon_state)
	SIGNAL_HANDLER

	var/state
	if(findtext_char(icon_state, "Walking"))
		state = "Walking"
	else if(findtext_char(icon_state, "Running"))
		state = "Running"
	else if(findtext_char(icon_state, "Knocked Down"))
		state = "Knocked Down"
	else if(findtext_char(icon_state, "Dead"))
		state = "Dead"
	else if(findtext_char(icon_state, "Sleeping"))
		state = "Sleeping"
	customization.icon_state = state
