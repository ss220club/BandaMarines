/datum/component/xeno_customization
	dupe_mode = COMPONENT_DUPE_ALLOWED
	/// The thing to show
	var/datum/xeno_customization_option/option
	/// What the selected option is showing, be it an overlay or full body replacement
	var/image/to_show
	/// Our filter that allows to subtract parts of (or an entire) icon
	var/subtract_filter
	/// List of players who are ready/already see customization
	var/list/mob/seeables = list()
	/// A specific set of players set to see the customizations; used in preferences
	var/list/mob/override_list

	/// Where images are stored
	var/atom/movable/xeno_customization_vis_obj/render_source_atom
	/// Is the customization allowed to be showed right now? Usually for checking icon_state existing.
	var/active = TRUE
	/// Is customization currently allowed to update? Used for strain check.
	var/updating = TRUE

/datum/component/xeno_customization/Initialize(datum/xeno_customization_option/option, list/mob/override_viewers)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/carbon/xenomorph/xeno = parent
	override_list = override_viewers

	src.option = option
	to_show = image(option.icon_path, parent)

	setup_render_source()
	add_images()

	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(on_new_player_login))
	var/list/to_show_list = override_list || GLOB.player_list
	for(var/mob/player in to_show_list)
		add_to_player_view(player)
	if(option.strain)
		strain_check()
	update_customization_icons(xeno, xeno.icon_state)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))
	RegisterSignal(parent, COMSIG_ALTER_GHOST, PROC_REF(on_ghost))
	RegisterSignal(parent, COMSIG_ATOM_UPDATE_FILTERS, PROC_REF(on_update_filters))
	RegisterSignal(parent, COMSIG_XENO_STRAIN_ADD, PROC_REF(on_strain_change))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)
	UnregisterSignal(parent, COMSIG_ALTER_GHOST)
	UnregisterSignal(parent, COMSIG_ATOM_UPDATE_FILTERS)
	UnregisterSignal(parent, COMSIG_XENO_STRAIN_ADD)

/datum/component/xeno_customization/Destroy(force, silent)
	remove_from_everyone_view()
	var/list/datum/component/remaining_customizations = parent.GetComponents(/datum/component/xeno_customization)
	if(length(remaining_customizations) == 1)
		QDEL_NULL(render_source_atom)
	else
		remove_images()
	. = ..()

/// Called when the component is created and is modifying the image
/datum/component/xeno_customization/proc/add_images()
	apply_subtract()
	render_source_atom.non_lore_image.overlays |= to_show
	if(option.customization_type == XENO_CUSTOMIZATION_LORE_FRIENDLY)
		render_source_atom.lore_image.overlays |= to_show

/// Called when the component is being deleted to clear image from itself
/datum/component/xeno_customization/proc/remove_images()
	render_source_atom.lore_image?.overlays -= to_show
	render_source_atom.non_lore_image?.overlays -= to_show
	remove_subtract()

/// Creates a reference to a render_source_atom, which holds the main image to show
/datum/component/xeno_customization/proc/setup_render_source()
	// Find existing
	for(var/datum/component/xeno_customization/current_customization in parent.GetComponents(/datum/component/xeno_customization))
		if(current_customization.render_source_atom)
			render_source_atom = current_customization.render_source_atom
			return
	// Well, time to create new ones
	render_source_atom = new(parent)

/// What image is created when the ghost is created
/datum/component/xeno_customization/proc/on_ghost(mob/user, mob/dead/observer/ghost)
	SIGNAL_HANDLER

	if(option.full_body_customization)
		ghost.icon = option.icon_path
		return
	/*
	if(option.subtract_icon_path)
		ghost.icon.Blend(icon(option.subtract_icon_path, "Walking"), BLEND_SUBTRACT)
	ghost.icon.Blend(icon(option.icon_path, "Walking"))
	*/

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

/// Remove the image from a specific player's screen
/datum/component/xeno_customization/proc/remove_from_player_view(mob/user)
	SIGNAL_HANDLER

	if(!user.client)
		return
	user.client.images -= render_source_atom.lore_image
	user.client.images -= render_source_atom.non_lore_image
	user.client.images -= to_show

/// Hide this customization from all seeables
/datum/component/xeno_customization/proc/remove_from_everyone_view()
	active = FALSE
	for(var/mob/player as anything in seeables)
		remove_from_player_view(player)
	remove_subtract()

/// Show this customization to all seeables
/datum/component/xeno_customization/proc/add_to_everyone_view()
	active = TRUE
	for(var/mob/player as anything in seeables)
		add_to_player_view(player)
	apply_subtract()

/// When user is destroyed we clear our seeables list
/datum/component/xeno_customization/proc/on_viewer_destroy(mob/user)
	SIGNAL_HANDLER

	seeables -= user
	UnregisterSignal(user, COMSIG_XENO_CUSTOMIZATION_VISIBILITY)
	UnregisterSignal(user, COMSIG_PARENT_QDELETING)

/// Adding images to player's screen
/datum/component/xeno_customization/proc/check_visibility_pref(mob/user)
	remove_from_player_view(user)
	switch(user.client.prefs.xeno_customization_visibility)
		if(XENO_CUSTOMIZATION_SHOW_ALL)
			if(!(isxeno(user) || isobserver(user) || isnewplayer(user)))
				return
			user.client.images |= render_source_atom.non_lore_image
			user.client.images |= to_show

		if(XENO_CUSTOMIZATION_SHOW_LORE_FRIENDLY)
			user.client.images |= render_source_atom.lore_image
			if(option.customization_type != XENO_CUSTOMIZATION_LORE_FRIENDLY)
				return
			user.client.images |= to_show

		if(XENO_CUSTOMIZATION_SHOW_NONE)
			return

/datum/component/xeno_customization/proc/on_update_filters(mob/owner)
	SIGNAL_HANDLER

	if(!option.full_body_customization)
		return
	to_show.filters = owner.filters

/datum/component/xeno_customization/proc/apply_subtract()
	remove_subtract()
	var/mob/living/carbon/xenomorph/xeno = parent
	if(option.full_body_customization)
		subtract_filter = filter(type="alpha", icon = xeno.icon)
	else if(option.subtract_icon_path)
		var/icon/mask = icon(option.subtract_icon_path, "Sleeping")
		subtract_filter = filter(type="alpha", icon = mask, flags = MASK_INVERSE)
	render_source_atom.non_lore_image.filters += subtract_filter
	if(option.customization_type == XENO_CUSTOMIZATION_LORE_FRIENDLY)
		render_source_atom.lore_image.filters += subtract_filter

/datum/component/xeno_customization/proc/remove_subtract()
	if(isnull(subtract_filter))
		return
	render_source_atom.lore_image?.filters -= subtract_filter
	render_source_atom.non_lore_image?.filters -= subtract_filter

/// Check if the strain is correct
/datum/component/xeno_customization/proc/strain_check()
	// If the option is Normal-specific, don't remove it
	if(option.strain == "Normal")
		return
	var/mob/living/carbon/xenomorph/xeno = parent
	// Correct strain, do nothing
	if(xeno.strain && (xeno.strain.name == option.strain))
		return
	remove_from_everyone_view()
	updating = FALSE

/// Changing to non-strain is creating a new mob
/datum/component/xeno_customization/proc/on_strain_change(mob/living/carbon/xenomorph/xeno, datum/xeno_strain/new_strain)
	SIGNAL_HANDLER

	// Coming back to Normal will create a new mob anyway
	if(option.strain == "Normal")
		qdel(src)
		return

	if(new_strain.name != option.strain)
		return
	updating = TRUE
	add_to_everyone_view()
	update_customization_icons(xeno, xeno.icon_state)

/// Update the image's icon_state and other important stuff like layers.
/datum/component/xeno_customization/proc/update_customization_icons(mob/living/carbon/xenomorph/xeno, icon_state)
	SIGNAL_HANDLER

	if(!updating)
		return

	to_show.layer = xeno.layer
	render_source_atom.non_lore_image.icon_state = icon_state
	render_source_atom.lore_image.icon_state = icon_state

	if(option.full_body_customization)
		if(active && !(icon_exists(to_show.icon, xeno.icon_state)))
			remove_from_everyone_view()
			return
		if(!active && ((icon_exists(to_show.icon, xeno.icon_state))))
			add_to_everyone_view()
		to_show.icon_state = icon_state
		return

	// It's an overlay over the icon; we don't need "Normal Runner", only the last part.
	var/icon_state_to_show
	if(findtext(icon_state, "Knocked Down"))
		icon_state_to_show = "Knocked Down"
	else
		var/list/split = splittext(icon_state, " ")
		icon_state_to_show = split[length(split)]
	to_show.icon_state = icon_state_to_show

/atom/movable/xeno_customization_vis_obj
	vis_flags = VIS_INHERIT_ID | VIS_INHERIT_PLANE | VIS_INHERIT_LAYER | VIS_UNDERLAY
	var/mob/living/carbon/xenomorph/parent_xeno
	/// The image players with "Non-Lore Friendly" preference enabled see, replacing the original xeno icon
	var/image/non_lore_image
	/// The image players with "Lore-Friendly" preference enabled see, replacing the original xeno icon
	var/image/lore_image
	/// The mob's original render_target value, when all components are deleted
	var/initial_render_target_value

/atom/movable/xeno_customization_vis_obj/Initialize(mapload, ...)
	. = ..()
	parent_xeno = loc
	render_source = "*xeno_customization_[REF(parent_xeno)]"

	initial_render_target_value = parent_xeno.render_target
	parent_xeno.render_target = "*xeno_customization_[REF(parent_xeno)]"

	parent_xeno.vis_contents += src

	non_lore_image = image(src, src)
	lore_image = image(src, src)
	//non_lore_image.loc = xeno
	//lore_image.loc = xeno
	non_lore_image.override = TRUE
	lore_image.override = TRUE
	non_lore_image.pixel_x = 0
	lore_image.pixel_x = 0
	non_lore_image.pixel_y = 0
	lore_image.pixel_y = 0

/atom/movable/xeno_customization_vis_obj/Destroy(force)
	parent_xeno.render_target = initial_render_target_value
	parent_xeno.vis_contents -= src
	QDEL_NULL(non_lore_image)
	QDEL_NULL(lore_image)
	. = ..()
