#define ATTACHMENT_SLOT_UNDER "under"
#define ATTACHMENT_SLOT_RAIL "rail"
#define ATTACHMENT_SLOT_STOCK "stock"
#define ATTACHMENT_SLOT_MUZZLE "muzzle"

/datum/action/item_action/give_to(mob/L)
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/get_hotkey_combo()
	. = ..()
	if(!.)
		. = get_hotkey_on_slot()
	return .

/datum/action/item_action/proc/get_hotkey_on_slot()
	var/static/list/slot_keybinds_to_name = list(
		"[ATTACHMENT_SLOT_UNDER]" = /datum/keybinding/human/combat/underbarrel::name,
		"[ATTACHMENT_SLOT_STOCK]" = /datum/keybinding/human/combat/stock_attachment::name,
		"[ATTACHMENT_SLOT_RAIL]" = /datum/keybinding/human/combat/attachment_rail::name,
	)

	if(!istype(target, /obj/item/attachable))
		return

	var/obj/item/attachable/attachable = target

	if(!length(owner.user_binds[slot_keybinds_to_name["[attachable.slot]"]]))
		return null
	return get_first_unbound_hotkey(owner.user_binds[slot_keybinds_to_name["[attachable.slot]"]])

#undef ATTACHMENT_SLOT_UNDER
#undef ATTACHMENT_SLOT_RAIL
#undef ATTACHMENT_SLOT_STOCK
#undef ATTACHMENT_SLOT_MUZZLE

// MARK: Smartgunner

/datum/action/item_action/smartgun/toggle_motion_detector/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/smartgun/toggle_auto_fire/update_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/smartgun/toggle_frontline_mode/action_activate()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/smartgun/toggle_accuracy_improvement/action_activate()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/smartgun/toggle_lethal_mode/action_activate()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/smartgun/toggle_ammo_type/action_activate()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/co_sg/toggle_id_lock/action_activate()
	. = ..()
	update_hotkey_visual()

// MARK: Attachments

/datum/action/item_action/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/stock/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/scope/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/vulture_scope/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/motion_detector/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/lamp/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/m56goggles/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/hudgoggles/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/flashlight/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/flashlight_grip/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/rail_flashlight/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/bipod/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/nozzle/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/ubs/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/ext/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/flamer/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/flare_launcher/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/ugl/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/adjust_mask/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/neckerchief/update_button_icon()
	. = ..()
	update_hotkey_visual()

/datum/action/item_action/toggle/helmet_nvg/update_button_icon()
	. = ..()
	update_hotkey_visual()
