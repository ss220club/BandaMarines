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


	///The mob's original render_target value
	var/initial_render_target_value
	var/atom/movable/render_source_atom
	var/image/non_lore_image
	var/image/lore_image

/datum/component/xeno_customization/Initialize(datum/xeno_customization_option/option, list/mob/override_viewers)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/carbon/xenomorph/xeno = parent
	override_list = override_viewers

	src.option = option
	to_show = image(option.icon_path, parent)

	setup_render_source()
	add_images()

	update_customization_icons(xeno, xeno.icon_state)
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_new_player_login))
	var/list/to_show_list = override_list || GLOB.player_list
	for(var/mob/player in to_show_list)
		add_to_player_view(player)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))
	RegisterSignal(parent, COMSIG_ALTER_GHOST, PROC_REF(on_ghost))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)
	UnregisterSignal(parent, COMSIG_ALTER_GHOST)

/datum/component/xeno_customization/Destroy(force, silent)
	remove_from_everyone_view()
	var/mob/owner = parent
	var/list/datum/component/remaining_customizations = parent.GetComponents(/datum/component/xeno_customization)
	if(length(remaining_customizations) == 1)
		owner.vis_contents -= render_source_atom
		owner.render_target = initial_render_target_value
	else
		remove_images()
	QDEL_NULL(render_source_atom)
	. = ..()

/datum/component/xeno_customization/proc/add_images()
	if(option.full_body_customization)
		non_lore_image.icon = to_show.icon
		if(option.customization_type == XENO_CUSTOMIZATION_LORE_FRIENDLY)
			lore_image.icon = to_show.icon
		return

	non_lore_image.overlays |= to_show
	if(option.customization_type == XENO_CUSTOMIZATION_LORE_FRIENDLY)
		lore_image.overlays |= to_show

/datum/component/xeno_customization/proc/remove_images()
	var/mob/owner = parent
	if(option.full_body_customization)
		lore_image.icon = owner.icon
		non_lore_image.icon = owner.icon
		return
	lore_image.overlays -= to_show
	non_lore_image.overlays -= to_show

/datum/component/xeno_customization/proc/setup_render_source()
	// Find existing
	for(var/datum/component/xeno_customization/current_customization in parent.GetComponents(/datum/component/xeno_customization))
		if(current_customization.render_source_atom)
			render_source_atom = current_customization.render_source_atom
			non_lore_image = current_customization.non_lore_image
			lore_image = current_customization.lore_image
			initial_render_target_value = current_customization.initial_render_target_value
			return
	// Well, time to create new ones
	var/mob/owner = parent

	render_source_atom = new()

	render_source_atom.appearance_flags |= (RESET_COLOR | RESET_TRANSFORM)
	render_source_atom.vis_flags |= (VIS_INHERIT_ID | VIS_INHERIT_PLANE | VIS_INHERIT_LAYER | VIS_UNDERLAY)
	render_source_atom.render_source = "*xeno_customization_[REF(parent)]"

	initial_render_target_value = owner.render_target
	owner.render_target = "*xeno_customization_[REF(parent)]"
	owner.vis_contents.Add(render_source_atom)

	non_lore_image = new(render_source_atom)
	lore_image = new(render_source_atom)
	non_lore_image.loc = render_source_atom
	lore_image.loc = render_source_atom
	non_lore_image.override = TRUE
	lore_image.override = TRUE

	non_lore_image.pixel_x = 0
	lore_image.pixel_x = 0
	non_lore_image.pixel_y = 0
	lore_image.pixel_y = 0

/datum/component/xeno_customization/proc/on_ghost(mob/user, mob/dead/observer/ghost)
	SIGNAL_HANDLER

	if(option.full_body_customization)
		ghost.icon = non_lore_image.icon
		return
	// TODO: show customizations for everyone on ghost?

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
	check_visibility_pref(user)

/datum/component/xeno_customization/proc/remove_from_player_view(mob/user)
	SIGNAL_HANDLER

	if(!user.client)
		return

	user.client.images -= lore_image
	user.client.images -= non_lore_image
	user.client.images -= to_show

/datum/component/xeno_customization/proc/remove_from_everyone_view()
	for(var/mob/player as anything in seeables)
		remove_from_player_view(player)

/datum/component/xeno_customization/proc/on_viewer_destroy(mob/user)
	SIGNAL_HANDLER

	seeables -= user
	UnregisterSignal(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	UnregisterSignal(user, COMSIG_PARENT_QDELETING)

/datum/component/xeno_customization/proc/check_visibility_pref(mob/user)
	remove_from_player_view(user)
	switch(user.client.prefs.xeno_customization_visibility)
		if(XENO_CUSTOMIZATION_SHOW_ALL)
			if(!(isxeno(user) || isobserver(user) || isnewplayer(user)))
				return
			user.client.images |= non_lore_image
			user.client.images |= to_show
		if(XENO_CUSTOMIZATION_SHOW_LORE_FRIENDLY)
			user.client.images |= lore_image
			user.client.images |= to_show
		if(XENO_CUSTOMIZATION_SHOW_NONE)
			return

/datum/component/xeno_customization/proc/update_customization_icons(mob/living/carbon/xenomorph/xeno, icon_state)
	SIGNAL_HANDLER

	if(option.full_body_customization)
		if(!(xeno.icon_state in icon_states(to_show.icon)))
			non_lore_image.icon = xeno.icon
			lore_image.icon = xeno.icon
		else
			add_images()
		return

	// It's an overlay over the icon; we don't need "Normal Runner", only the last part.
	var/list/split = splittext(icon_state, " ")
	var/icon_state_to_show = split[length(split)]
	if(icon_state_to_show == "Down" && split[length(split) - 1] == "Knocked")
		icon_state_to_show = "Knocked Down"
	to_show.icon_state = icon_state_to_show
