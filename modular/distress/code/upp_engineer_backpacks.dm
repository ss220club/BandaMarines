/obj/item/storage/backpack/marine/engineerpack/upp/distress
	name = "\improper топливный инженерный рюкзак UPP M113"
	desc = "Прочный инженерный рюкзак со встроенным топливным баком. Приложите к нему сварочный аппарат, чтобы дозаправить его; сам рюкзак можно заправить от напольного топливного бака таким же образом."
	icon = 'modular/distress/icons/backpacks/icons/upp_fuel_engineerpack.dmi'
	icon_state = "upp_fuel_engineerpack"
	item_icons = list(
		WEAR_BACK = 'modular/distress/icons/backpacks/onmob/upp_fuel_engineerpack_onmob.dmi',
	)
	max_storage_space = 14
	max_fuel = 220

/obj/item/tool/weldingtool/upp_tethered
	name = "привязная сварочная горелка UPP"
	desc = "Мощная режущая горелка, питаемая от увеличенного бака на спине носителя. Она привязана к рюкзаку."
	max_fuel = 400
	var/obj/item/upp_weldpack/source_pack

/obj/item/tool/weldingtool/upp_tethered/dropped(mob/user)
	. = ..()
	source_pack = null

/obj/item/upp_weldpack
	name = "\improper привязной сварочный ранец UPP"
	desc = "Сварочная установка на баке, закреплённая на спине. В этой обвязке нет места для чего-либо ещё."
	icon = 'modular/distress/icons/backpacks/icons/upp_tethered_weldpack.dmi'
	icon_state = "upp_tethered_weldpack"
	item_icons = list(
		WEAR_BACK = 'modular/distress/icons/backpacks/onmob/upp_tethered_weldpack_onmob.dmi',
	)
	w_class = SIZE_LARGE
	flags_equip_slot = SLOT_BACK
	actions_types = list(/datum/action/item_action/upp_weldpack_draw)
	var/obj/item/tool/weldingtool/upp_tethered/torch

/obj/item/upp_weldpack/Initialize(mapload, ...)
	. = ..()
	torch = new(src)
	torch.source_pack = src

/obj/item/upp_weldpack/Destroy()
	QDEL_NULL(torch)
	return ..()

/obj/item/upp_weldpack/item_action_slot_check(mob/user, slot)
	return slot == SLOT_BACK

/obj/item/upp_weldpack/proc/draw_torch(mob/user)
	if(QDELETED(torch))
		return
	if(torch.loc == src)
		user.put_in_hands(torch)
		to_chat(user, SPAN_NOTICE("Вы достаёте горелку на топливном шланге."))
	else if(torch.loc == user)
		user.drop_held_item(torch)
		torch.forceMove(src)
		to_chat(user, SPAN_NOTICE("Вы втягиваете горелку обратно в \the [src]."))
	else
		to_chat(user, SPAN_WARNING("Горелка находится вне досягаемости своего топливного шланга!"))

/obj/item/upp_weldpack/proc/stow_torch(mob/user)
	if(QDELETED(torch) || torch.loc != user)
		return
	user?.drop_held_item(torch)
	torch.forceMove(src)

/obj/item/upp_weldpack/dropped(mob/user)
	. = ..()
	stow_torch(user)

/obj/item/upp_weldpack/unequipped(mob/user, slot)
	. = ..()
	stow_torch(user)

/datum/action/item_action/upp_weldpack_draw
	name = "Достать горелку"

/datum/action/item_action/upp_weldpack_draw/update_button_icon()
	button.overlays.Cut()
	var/obj/item/upp_weldpack/pack = holder_item
	if(QDELETED(pack) || QDELETED(pack.torch))
		return
	button.overlays += mutable_appearance(pack.torch.icon, pack.torch.icon_state, plane = ABOVE_TACMAP_PLANE)

/datum/action/item_action/upp_weldpack_draw/action_activate()
	. = ..()
	var/obj/item/upp_weldpack/pack = holder_item
	if(!QDELETED(pack))
		pack.draw_torch(owner)
