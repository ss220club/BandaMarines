#define XENO_CUSTOMIZATION_SHOW_ALL "Show All"
#define XENO_CUSTOMIZATION_SHOW_LORE_FRIENDLY "Show Lore Friendly"
#define XENO_CUSTOMIZATION_SHOW_NONE "Show None"

GLOBAL_LIST_INIT(xeno_customization_visibility_options, list(
	XENO_CUSTOMIZATION_SHOW_ALL,
	XENO_CUSTOMIZATION_SHOW_LORE_FRIENDLY,
	XENO_CUSTOMIZATION_SHOW_NONE,
))

/// from base of mob/living/carbon/xenomorph/update_icons(): (status_state)
#define COMSIG_XENO_UPDATE_ICONS_STATE "xeno_update_icons_status"
