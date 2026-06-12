/obj/item/attachable/helmet_beacon
	name = "IFF helmet beacon"
	desc = "An IFF beacon is a small light device mounted on a helmet."
	icon = 'icons/obj/items/weapons/guns/attachments/rail.dmi'
	icon_state = "helmet_beacon"

/obj/item/attachable/helmet_beacon/helmet
	name = "helmet IFF beacon"

/obj/item/attachable/flashlight/glowstick/roaf
	name = "маркер с хим-светом"
	desc = "Компактная палочка с химическим светом, предназначенная для крепления на шлем."
	icon = 'modular/clothing/icon/roaf/misc.dmi'
	icon_state = "icon_glowstick"
	item_icons = list(
		WEAR_AS_GARB = 'modular/clothing/onmob/roaf/misc.dmi',
	)
	item_state = "item_default"
	item_state_slots = list(
		WEAR_AS_GARB = "item_default"
	)
	attach_icon = "item_default"
	original_state = "icon_glowstick"
	original_attach = "item_default"
	flags_obj = OBJ_IS_HELMET_GARB|OBJ_NO_HELMET_BAND
	helm_mounted_light_power = 1
	helm_mounted_light_range = 1.7
	light_range = 2
	light_power = 1
	light_color = COLOR_WHITE
	var/glowstick_light_color = COLOR_WHITE
	var/obj/item/centered_light_item
	var/centered_light_item_original_system = MOVABLE_LIGHT
	var/centered_light_item_original_color

/obj/item/attachable/flashlight/glowstick/roaf/Initialize()
	. = ..()
	update_handheld_light()

/obj/item/attachable/flashlight/glowstick/roaf/unique_action(mob/user)
	return

/obj/item/attachable/flashlight/glowstick/roaf/attackby(obj/item/I, mob/user)
	if(HAS_TRAIT(I, TRAIT_TOOL_SCREWDRIVER))
		to_chat(user, SPAN_WARNING("[src] has no removable flashlight mount."))
		return
	return ..()

/obj/item/attachable/flashlight/glowstick/roaf/on_enter_storage(obj/item/storage/internal/S)
	. = ..()
	set_light_on(FALSE)
	update_squad_appearance(S?.master_object?.loc)

/obj/item/attachable/flashlight/glowstick/roaf/on_exit_storage(obj/item/storage/S)
	. = ..()
	update_handheld_light()

/obj/item/attachable/flashlight/glowstick/roaf/remove_attached_item()
	var/obj/item/old_attached_item = attached_item
	. = ..()
	restore_centered_light(old_attached_item)
	if(!QDELETED(old_attached_item))
		old_attached_item.set_light_on(FALSE)
		old_attached_item.set_light_color(centered_light_item_original_color)

/obj/item/attachable/flashlight/glowstick/roaf/pickup(mob/user)
	. = ..()
	update_handheld_light()

/obj/item/attachable/flashlight/glowstick/roaf/equipped(mob/user, slot)
	. = ..()
	update_handheld_light()

/obj/item/attachable/flashlight/glowstick/roaf/dropped(mob/user)
	. = ..()
	update_handheld_light()

/obj/item/attachable/flashlight/glowstick/roaf/turn_light(mob/user, toggle_on, cooldown, sparks, forced, light_again)
	var/mob/light_owner = user
	if(!light_owner && attached_item && ismob(attached_item.loc))
		light_owner = attached_item.loc

	update_squad_appearance(light_owner)
	if(istype(attached_item, /obj/item/clothing/head/helmet/marine))
		prepare_centered_light(attached_item)
	. = ..()
	if(. != CHECKS_PASSED)
		return

	if(istype(attached_item, /obj/item/clothing/head/helmet/marine))
		icon_state = original_state
		attach_icon = original_attach
		attached_item.set_light_color(glowstick_light_color)
		update_squad_appearance(light_owner)

/obj/item/attachable/flashlight/glowstick/roaf/proc/update_handheld_light()
	if(attached_item)
		set_light_on(FALSE)
		return

	if(ishuman(loc))
		var/mob/living/carbon/human/human_holder = loc
		if(human_holder.l_hand == src || human_holder.r_hand == src)
			set_light_color(COLOR_WHITE)
			set_light_range(initial(light_range))
			set_light_power(initial(light_power))
			set_light_on(TRUE)
			return

	set_light_on(FALSE)

/obj/item/attachable/flashlight/glowstick/roaf/proc/prepare_centered_light(obj/item/light_item)
	if(centered_light_item == light_item)
		return

	restore_centered_light(centered_light_item)
	centered_light_item = light_item
	centered_light_item_original_system = light_item.light_system
	centered_light_item_original_color = light_item.light_color
	var/datum/component/overlay_lighting/light_component = light_item.GetComponent(/datum/component/overlay_lighting)
	qdel(light_component)
	light_item.light_system = MOVABLE_LIGHT
	light_item.AddComponent(/datum/component/overlay_lighting)

/obj/item/attachable/flashlight/glowstick/roaf/proc/restore_centered_light(obj/item/light_item)
	if(QDELETED(light_item) || centered_light_item != light_item)
		centered_light_item = null
		return

	var/datum/component/overlay_lighting/light_component = light_item.GetComponent(/datum/component/overlay_lighting)
	qdel(light_component)
	light_item.light_system = centered_light_item_original_system
	if(light_item.light_system == MOVABLE_LIGHT)
		light_item.AddComponent(/datum/component/overlay_lighting)
	else if(light_item.light_system == DIRECTIONAL_LIGHT)
		light_item.AddComponent(/datum/component/overlay_lighting, is_directional = TRUE)
	centered_light_item = null

/obj/item/attachable/flashlight/glowstick/roaf/proc/update_squad_appearance(mob/user)
	var/squad_name
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		squad_name = human_user.assigned_squad?.name

	var/new_item_state = "item_default"
	glowstick_light_color = COLOR_WHITE
	switch(squad_name)
		if(SQUAD_MARINE_1)
			new_item_state = "item_alpha"
			glowstick_light_color = "#ff1f1f"
		if(SQUAD_MARINE_2)
			new_item_state = "item_bravo"
			glowstick_light_color = "#ffe100"
		if(SQUAD_MARINE_3)
			new_item_state = "item_charlie"
			glowstick_light_color = "#9b4dff"
		if(SQUAD_MARINE_4)
			new_item_state = "item_delta"
			glowstick_light_color = "#2487ff"
		if(SQUAD_MARINE_5)
			new_item_state = "item_echo"
			glowstick_light_color = "#9cff9c"
		if(SQUAD_MARINE_CRYO)
			new_item_state = "item_foxtrot"
			glowstick_light_color = "#ff8a1f"

	if(light_on)
		new_item_state += "_on"

	item_state = new_item_state
	item_state_slots = list(
		WEAR_AS_GARB = new_item_state
	)

	if(attached_item)
		attached_item.update_icon()
