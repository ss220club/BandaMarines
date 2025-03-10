#define XENO_CUSTOMIZATION_LORE_FRIENDLY "xeno_customization_lore_friendly"
#define XENO_CUSTOMIZATION_NON_LORE_FRIENDLY "xeno_customization_non_lore_friendly"

/datum/component/xeno_customization
	dupe_mode = COMPONENT_DUPE_ALLOWED
	var/customization_type
	var/icon_path = null
	var/image/customization
	/// List of mobs who can see the customization
	var/list/mob/seeables = list()

/datum/component/xeno_customization/Initialize(customization_type = XENO_CUSTOMIZATION_NON_LORE_FRIENDLY, icon_path)
	if(!isxeno(parent))
		return COMPONENT_INCOMPATIBLE
	src.customization_type = customization_type
	src.icon_path = icon_path
	customization = image(icon_path, parent)
	RegisterSignal(SSdcs, COMSIG_GLOB_MOB_LOGGED_IN, PROC_REF(add_to_player_view))
	for(var/mob/player in GLOB.player_list)
		add_to_player_view(SSdcs, player)

/datum/component/xeno_customization/RegisterWithParent()
	RegisterSignal(parent, COMSIG_XENO_UPDATE_ICONS, PROC_REF(update_customization_icons))

/datum/component/xeno_customization/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_XENO_UPDATE_ICONS)

/datum/component/xeno_customization/Destroy(force, silent)
	qdel(customization)
	. = ..()

/datum/component/xeno_customization/proc/add_to_player_view(subsystem, mob/user)
	SIGNAL_HANDLER
	if(!user.client)
		return
	user.client.images |= customization
	seeables |= user

/datum/component/xeno_customization/proc/remove_from_player_view(mob/user)
	SIGNAL_HANDLER
	if(!user.client)
		return
	user.client.images -= customization
	seeables -= user

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
