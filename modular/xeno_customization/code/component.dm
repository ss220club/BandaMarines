/datum/component/xeno_customization
	dupe_mode = COMPONENT_DUPE_ALLOWED
	/// The thing to show
	var/datum/xeno_customization_option/option
	/// What is actually showed
	var/image/to_show
	/// List of players who are ready/already see customization
	var/list/mob/seeables = list()
	/// A specific set of players set to see the customizations; used in preferences
	var/list/mob/override_list
	/// Holds xeno's icon for full body customization
	var/icon/original_icon
	/// Holds xeno's image for showing default icon for those who have full body customization disabled
	var/image/original_image
	/// Icon State currently duplicating
	var/icon_state_to_show

/datum/component/xeno_customization/Initialize(datum/xeno_customization_option/option, list/mob/override_viewers)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/carbon/xenomorph/xeno = parent
	override_list = override_viewers

	src.option = option
	to_show = image(option.icon_path, parent)
	if(option.full_body_customization)
		original_icon = xeno.icon
		original_image = image(xeno.icon, xeno)
		original_image.layer = xeno.layer
		original_image.plane = xeno.plane
	update_customization_icons(xeno, xeno.icon_state)
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_new_player_login))
	var/list/to_show_list = override_list || GLOB.player_list
	for(var/mob/player in to_show_list)
		add_to_player_view(player)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))
	RegisterSignal(parent, COMSIG_ALTER_GHOST, PROC_REF(on_ghost))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_FILTERS, PROC_REF(on_update_filters))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)
	UnregisterSignal(parent, COMSIG_ALTER_GHOST)
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_FILTERS)

/datum/component/xeno_customization/Destroy(force, silent)
	remove_from_everyone_view(full_remove = TRUE)
	qdel(to_show)
	if(option.full_body_customization)
		var/mob/living/carbon/xenomorph/xeno = parent
		xeno.icon = original_icon
		qdel(original_image)
		original_icon = null
	. = ..()

/datum/component/xeno_customization/proc/on_ghost(mob/user, mob/dead/observer/ghost)
	SIGNAL_HANDLER

	if(option.full_body_customization)
		ghost.icon = original_icon
		return
	// TODO: show customizations for everyone on ghost?

/datum/component/xeno_customization/proc/on_update_filters(atom/owner)
	SIGNAL_HANDLER

	to_show?.filters = owner.filters
	original_image?.filters = owner.filters

/datum/component/xeno_customization/proc/on_new_player_login(subsystem, mob/user)
	SIGNAL_HANDLER

	if(length(override_list))
		return
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
	if(option.full_body_customization)
		user.client.images -= original_image

/datum/component/xeno_customization/proc/remove_from_player_view(mob/user, full_remove = FALSE)
	SIGNAL_HANDLER

	if(!user.client)
		return
	user.client.images -= to_show
	if(full_remove)
		user.client.images -= original_image
		return
	if(option.full_body_customization)
		user.client.images |= original_image

/datum/component/xeno_customization/proc/remove_from_everyone_view(full_remove = FALSE)
	for(var/mob/player as anything in seeables)
		remove_from_player_view(player, full_remove)

/datum/component/xeno_customization/proc/on_viewer_destroy(mob/user)
	SIGNAL_HANDLER

	seeables -= user
	UnregisterSignal(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	UnregisterSignal(user, COMSIG_PARENT_QDELETING)

/datum/component/xeno_customization/proc/check_visibility_pref(mob/user)
	switch(user.client.prefs.xeno_customization_visibility)
		if(XENO_CUSTOMIZATION_SHOW_ALL)
			if(option.customization_type == XENO_CUSTOMIZATION_NON_LORE_FRIENDLY && !(isxeno(user) || isobserver(user) || isnewplayer(user)))
				return FALSE
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

	to_show.layer = xeno.layer
	icon_state_to_show = icon_state

	if(option.full_body_customization)
		xeno.icon = null
		to_show.icon_state = icon_state_to_show
		original_image.icon_state = icon_state_to_show
		original_image.layer = xeno.layer
		if(!(icon_state_to_show in icon_states(option.icon_path)))
			xeno.icon = original_icon
			original_image.icon_state = null
		return

	// It's an overlay over the icon; we don't need "Normal Runner", only the last part.
	var/list/split = splittext(icon_state, " ")
	icon_state_to_show = split[length(split)]
	if(icon_state_to_show == "Down" && split[length(split) - 1] == "Knocked")
		icon_state_to_show = "Knocked Down"
	to_show.icon_state = icon_state_to_show
