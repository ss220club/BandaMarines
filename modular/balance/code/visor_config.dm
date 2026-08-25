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

/obj/item/device/helmet_visor/night_vision/normal/proc/update_mob_overlay(obj/item/clothing/head/helmet/marine/helmet, add)
	if(!helmet)
		return
	var/mob/living/carbon/human/H = helmet.loc
	if(!istype(H))
		return
	var/image/nvg_overlay = image('modular/balance/icons/visor.dmi', "nvo_installed")
	if(add)
		if(!(nvg_overlay in H.overlays))
			H.overlays += nvg_overlay
	else
		H.overlays -= nvg_overlay

/obj/item/device/helmet_visor/night_vision/normal/Initialize(mapload, ...)
	. = ..()
	if(istype(loc, /obj/item/clothing/head/helmet/marine))
		var/obj/item/clothing/head/helmet/marine/helmet = loc
		helmet.stored_nvg = src
		update_mob_overlay(helmet, TRUE)

/obj/item/device/helmet_visor/night_vision/normal/Destroy()
	var/obj/item/clothing/head/helmet/marine/helmet = loc
	if(istype(helmet))
		helmet.stored_nvg = null
		update_mob_overlay(helmet, FALSE)
	. = ..()

/obj/item/device/helmet_visor/night_vision/normal/forceMove(atom/destination)
	var/obj/item/clothing/head/helmet/marine/old_helmet = loc
	if(istype(old_helmet))
		old_helmet.stored_nvg = null
		update_mob_overlay(old_helmet, FALSE)
	. = ..()
	if(istype(destination, /obj/item/clothing/head/helmet/marine))
		var/obj/item/clothing/head/helmet/marine/new_helmet = destination
		new_helmet.stored_nvg = src
		update_mob_overlay(new_helmet, TRUE)

/obj/item/clothing/head/helmet/marine
	var/obj/item/device/helmet_visor/night_vision/normal/stored_nvg = null

/obj/item/clothing/head/helmet/marine/proc/update_nvg_overlay(add)
	var/mob/living/carbon/human/H = loc
	if(!istype(H))
		return
	var/image/nvg_overlay = image('modular/balance/icons/visor.dmi', "nvo_installed")
	if(add)
		if(!(nvg_overlay in H.overlays))
			H.overlays += nvg_overlay
	else
		H.overlays -= nvg_overlay

/obj/item/clothing/head/helmet/marine/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		if(stored_nvg)
			update_nvg_overlay(TRUE)

/obj/item/clothing/head/helmet/marine/unequipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_HEAD)
		update_nvg_overlay(FALSE)

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
