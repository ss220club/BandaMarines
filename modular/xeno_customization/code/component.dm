/datum/component/xeno_customization
	dupe_mode = COMPONENT_DUPE_ALLOWED
	/// The thing to show
	var/datum/xeno_customization_option/option
	/// What is actually showed
	var/image/to_show
	/// List of players who are ready/already see customization
	var/list/mob/seeables = list()

/datum/component/xeno_customization/Initialize(datum/xeno_customization_option/option)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/carbon/xenomorph/xeno = parent

	src.option = option
	to_show = image(option.icon_path, parent)
	to_show.layer = xeno.layer
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_new_player_login))
	for(var/mob/player in GLOB.player_list)
		add_to_player_view(player)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)

/datum/component/xeno_customization/Destroy(force, silent)
	remove_from_everyone_view()
	qdel(to_show)
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
	user.client.images |= to_show

/datum/component/xeno_customization/proc/remove_from_player_view(mob/user)
	SIGNAL_HANDLER

	if(!user.client)
		return
	user.client.images -= to_show

/datum/component/xeno_customization/proc/remove_from_everyone_view()
	for(var/mob/player in seeables)
		remove_from_player_view(player)

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
			if(option.customization_type == XENO_CUSTOMIZATION_NON_LORE_FRIENDLY)
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
	to_show.icon_state = state
