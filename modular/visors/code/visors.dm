#define ACCESSORY_SLOT_VISOR_MODULE "Visor Module"

/obj/item/device/helmet_visor/night_vision/normal
	name = "night vision optic"
	desc = "An insertable visor HUD into a standard USCM helmet. This type gives a form of night vision and is standard issue in units with regular funding."
	icon = 'modular/visors/icons/icons.dmi'
	icon_state = "nvg_sight"
	hud_type = null
	action_icon_string = "nvg_sight_down"
	helmet_overlay = "nvg_sight_right"
	helmet_overlay_icon = 'modular/visors/icons/icons.dmi'
	toggle_on_sound = 'sound/handling/toggle_nv1.ogg'
	toggle_off_sound = 'sound/handling/toggle_nv2.ogg'
	matrix_color = NV_COLOR_GREEN
	power_use = 33
	lighting_alpha = 100
	visor_glows = FALSE

/obj/item/device/helmet_visor/night_vision/normal/change_view(mob/user, new_size)
	return

/obj/item/device/helmet_visor/night_vision/normal/marine_raider
	name = "advanced night vision optic"
	desc = "An insertable visor HUD into a standard USCM helmet. This type gives a form of night vision and is standard issue in special forces units."
	icon = 'modular/visors/icons/icons.dmi'
	helmet_overlay_icon = 'modular/visors/icons/icons.dmi'
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_MEDICAL_ADVANCED)
	helmet_overlay = "nvg_sight_right_raider"
	power_use = 0
	visor_glows = FALSE

/obj/item/device/helmet_visor/night_vision/normal/marine_raider/can_install_module(obj/item/device/helmet_visor_module/module, mob/user)
	to_chat(user, SPAN_WARNING("[src] cannot accept this module."))
	return FALSE

/obj/item/device/helmet_visor/night_vision/normal/marine_raider/change_view(mob/user, new_size)
	return

/obj/item/device/helmet_visor/night_vision
	var/obj/item/device/helmet_visor_module/installed_module = null

/obj/item/device/helmet_visor/night_vision/proc/can_install_module(obj/item/device/helmet_visor_module/module, mob/user)
	if(istype(src, /obj/item/device/helmet_visor/night_vision/marine_raider) || istype(src, /obj/item/device/helmet_visor/night_vision/normal/marine_raider))
		to_chat(user, SPAN_WARNING("[src] cannot accept this module."))
		return FALSE
	if(installed_module)
		to_chat(user, SPAN_WARNING("[src] already has a module installed."))
		return FALSE
	if(module.slot != ACCESSORY_SLOT_VISOR_MODULE)
		to_chat(user, SPAN_WARNING("[module] doesn't fit into [src]."))
		return FALSE
	if(istype(loc, /obj/item/clothing/head/helmet/marine))
		to_chat(user, SPAN_WARNING("You must remove [src] from the helmet first."))
		return FALSE
	return TRUE

/obj/item/device/helmet_visor/night_vision/proc/install_module(obj/item/device/helmet_visor_module/module, mob/user)
	if(!can_install_module(module, user))
		return
	if(!user.temp_drop_inv_item(module))
		return
	module.forceMove(src)
	installed_module = module
	if(istype(module, /obj/item/device/helmet_visor_module/night_vision_power_efficiency))
		var/obj/item/device/helmet_visor_module/night_vision_power_efficiency/efficiency_module = module
		power_use = efficiency_module.power_use_setting
		icon = 'modular/visors/icons/icons.dmi'
		icon_state = "nvg_sight_upgraded"
		update_icon()
	to_chat(user, SPAN_NOTICE("You install [module] into [src]."))

/obj/item/device/helmet_visor/night_vision/proc/uninstall_module(mob/user)
	if(!installed_module)
		if(user)
			to_chat(user, SPAN_WARNING("[src] has no module installed."))
		return
	if(istype(loc, /obj/item/clothing/head/helmet/marine))
		if(user)
			to_chat(user, SPAN_WARNING("You must remove [src] from the helmet first."))
		return
	var/obj/item/device/helmet_visor_module/module = installed_module
	installed_module = null
	power_use = initial(power_use)
	icon = initial(icon)
	icon_state = initial(icon_state)
	action_icon_string = initial(action_icon_string)
	update_icon()
	if(user)
		if(!user.put_in_hands(module))
			module.forceMove(get_turf(src))
		to_chat(user, SPAN_NOTICE("You remove [module] from [src]."))
	else
		module.forceMove(get_turf(src))

/obj/item/device/helmet_visor/night_vision/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(.)
		return
	if(istype(I, /obj/item/device/helmet_visor_module))
		install_module(I, user)
		return TRUE

/obj/item/device/helmet_visor/night_vision/verb/remove_module()
	set name = "Remove Visor Module"
	set category = "Object"
	set src in view(1)
	if(!installed_module)
		to_chat(usr, SPAN_WARNING("[src] has no module installed."))
		return
	if(!ishuman(usr))
		return
	var/mob/living/carbon/human/H = usr
	if(H.stat || H.is_mob_restrained() || !in_range(src, H))
		return
	uninstall_module(H)

/obj/item/device/helmet_visor_module
	name = "visor module"
	desc = "A module that can be installed into a helmet visor."
	icon = 'modular/visors/icons/icons.dmi'
	icon_state = "night_vision_upgrade"
	w_class = SIZE_TINY
	var/slot = ACCESSORY_SLOT_VISOR_MODULE

/obj/item/device/helmet_visor_module/night_vision_power_efficiency
	name = "Night Vision Optimizer"
	desc = "A module that reduces power consumption of night vision optic, extending its battery life."
	icon = 'modular/visors/icons/icons.dmi'
	var/power_use_setting = 22   ///extra 5 minutes, 15 minutes total
