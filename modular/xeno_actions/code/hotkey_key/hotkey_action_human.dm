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

/datum/action/item_action/smartgun/action_activate()
	. = ..()
	update_hotkey_visual()
