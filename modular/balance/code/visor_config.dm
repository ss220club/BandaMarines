#define ACCESSORY_SLOT_VISOR_MODULE "Visor Module"
#define NVG_VISOR_USAGE(delta_time) (power_cell.use(power_use * (delta_time ? delta_time : 1)))

/obj/item/device/helmet_visor/night_vision/normal
	icon = 'modular/balance/icons/visor.dmi'
	helmet_overlay_icon = 'modular/balance/icons/visor.dmi'
	visor_glows = FALSE

/obj/item/device/helmet_visor/night_vision/normal/change_view(mob/user, new_size)
	return

/obj/item/device/helmet_visor/night_vision/normal/can_toggle(mob/living/carbon/human/user)
	if(!NVG_VISOR_USAGE(FALSE))
		to_chat(user, SPAN_NOTICE("Your [src] is out of power! You'll need to recharge it."))
		return FALSE
	return TRUE

/obj/item/device/helmet_visor/night_vision/normal/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()
	user.clear_fullscreen("nvg_visor")
	user.clear_fullscreen("nvg_visor_blur")
	add_vision_overlay(attached_helmet)

/obj/item/device/helmet_visor/night_vision/normal/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()
	remove_vision_overlay()

/obj/item/device/helmet_visor/night_vision/normal/Initialize(mapload, ...)
	. = ..()
	if(istype(loc, /obj/item/clothing/head/helmet/marine))
		var/obj/item/clothing/head/helmet/marine/helmet = loc
		helmet.stored_nvg = src
		helmet.refresh_nvg_overlay()

/obj/item/device/helmet_visor/night_vision/normal/Destroy()
	var/obj/item/clothing/head/helmet/marine/helmet = loc
	if(istype(helmet))
		helmet.stored_nvg = null
		helmet.remove_nvg_overlay()
	remove_vision_overlay()
	. = ..()

/obj/item/device/helmet_visor/night_vision/normal/forceMove(atom/destination)
	var/obj/item/clothing/head/helmet/marine/old_helmet = loc
	if(istype(old_helmet))
		old_helmet.stored_nvg = null
		old_helmet.remove_nvg_overlay()
	remove_vision_overlay()
	. = ..()
	if(istype(destination, /obj/item/clothing/head/helmet/marine))
		var/obj/item/clothing/head/helmet/marine/new_helmet = destination
		new_helmet.stored_nvg = src
		new_helmet.refresh_nvg_overlay()

/obj/item/clothing/head/helmet/marine
	var/obj/item/device/helmet_visor/night_vision/normal/stored_nvg = null
	var/image/nvg_overlay_image = null
	var/mob/living/carbon/human/nvg_overlay_mob = null

/obj/item/clothing/head/helmet/marine/proc/remove_nvg_overlay()
	if(nvg_overlay_mob && nvg_overlay_image)
		nvg_overlay_mob.overlays -= nvg_overlay_image
	nvg_overlay_image = null
	nvg_overlay_mob = null

/obj/item/clothing/head/helmet/marine/proc/refresh_nvg_overlay()
	remove_nvg_overlay()
	if(!stored_nvg)
		return
	var/mob/living/carbon/human/H = loc
	if(!istype(H) || H.head != src)
		return
	nvg_overlay_image = image('modular/balance/icons/visor.dmi', "nvo_installed")
	nvg_overlay_image.layer = 10
	nvg_overlay_image.appearance_flags = RESET_COLOR | RESET_ALPHA
	H.overlays += nvg_overlay_image
	nvg_overlay_mob = H

/obj/item/clothing/head/helmet/marine/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		refresh_nvg_overlay()

/obj/item/clothing/head/helmet/marine/unequipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		remove_nvg_overlay()

/obj/item/clothing/head/helmet/marine/Destroy()
	remove_nvg_overlay()
	return ..()

/obj/item/device/helmet_visor/night_vision/normal/var/list/overlay_data = list()

/obj/item/device/helmet_visor/night_vision/normal/proc/add_vision_overlay(obj/item/clothing/head/helmet/marine/attached_helmet)
	var/mob/living/carbon/human/wearer = attached_helmet.loc
	if(!istype(wearer))
		return
	for(var/client/C in GLOB.clients)
		var/mob/M = C.mob
		if(!M)
			continue
		if(!(GLOB.huds[HEALTH_HUD_XENO]?.hudusers[M]) && !isxeno(M))
			continue
		var/image/glow = image('modular/balance/icons/visor.dmi', "nvo_installed")
		glow.appearance_flags = RESET_COLOR | RESET_ALPHA
		glow.color = "#00FF00"
		glow.alpha = 220
		glow.blend_mode = BLEND_ADD
		glow.layer = 10
		glow.loc = wearer
		C.images += glow
		overlay_data += list(list("client" = C, "image" = glow))

/obj/item/device/helmet_visor/night_vision/normal/proc/remove_vision_overlay()
	for(var/list/data in overlay_data)
		var/client/C = data["client"]
		var/image/ov = data["image"]
		if(C)
			C.images -= ov
	overlay_data.Cut()

/obj/item/device/helmet_visor/night_vision/normal/marine_raider
	helmet_overlay = "nvg_sight_right_raider"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_MEDICAL_ADVANCED)
	power_use = 0

/obj/item/device/helmet_visor/night_vision/normal/marine_raider/can_install_module(obj/item/device/helmet_visor_module/module, mob/user)
	to_chat(user, SPAN_WARNING("[src] cannot accept this module."))
	return FALSE

/obj/item/device/helmet_visor/night_vision
	var/obj/item/device/helmet_visor_module/installed_module = null

/obj/item/device/helmet_visor/night_vision/proc/can_install_module(obj/item/device/helmet_visor_module/module, mob/user)
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
		icon_state = "nvg_sight_upgrade"
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
	icon = 'modular/balance/icons/visor.dmi'
	icon_state = "night_vision_upgrade"
	w_class = SIZE_TINY
	var/slot = ACCESSORY_SLOT_VISOR_MODULE

/obj/item/device/helmet_visor_module/night_vision_power_efficiency
	name = "Night Vision Optimizer"
	desc = "A module that reduces power consumption of night vision optic, extending its battery life."
	icon = 'modular/balance/icons/visor.dmi'
	var/power_use_setting = 22
