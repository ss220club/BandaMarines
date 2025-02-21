#define QUICK_CAST_OVERRIDE(subtype)\
/datum/action##subtype/action_activate(){\
	if(hidden){\
		return ..();\
	}\
	if(owner.get_ability_mouse_key() != XENO_ABILITY_CLICK_INSTANT){\
		return ..();\
	}\
	var/atom/target = owner.client.hovered_over;\
	if(!target){\
		return;\
	}\
	if(istype(target, /atom/movable/screen)){\
		return;\
	}\
	if(owner.get_selected_ability() == src){\
		call(src, /datum/action::action_activate())();\
	}\else{\
		. = ..();\
	}\
	use_ability(target);\
}

QUICK_CAST_OVERRIDE(/xeno_action/activable)
QUICK_CAST_OVERRIDE(/human_action/activable)
QUICK_CAST_OVERRIDE(/item_action/hover)
QUICK_CAST_OVERRIDE(/item_action/specialist/aimed_shot)
QUICK_CAST_OVERRIDE(/item_action/specialist/spotter_target)
