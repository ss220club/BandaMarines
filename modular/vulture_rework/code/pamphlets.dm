#define VULTURE_MAP_ICONS 'modular/vulture_rework/icons/vulture_map.dmi'

/mob/living/carbon/human/hud_set_squad()
    ..()
    var/datum/faction/F = get_faction(faction)
    if(!F)
        F = get_faction("Marine")
    var/image/holder = hud_list[F.hud_type]
    if(rank_fallback == "vulture")
        var/image/vulture_icon = image('modular/vulture_rework/icons/vulture_hud.dmi', src, "hudsquad_vulture")
        holder.overlays += vulture_icon

/datum/equipment_preset/get_minimap_icon(mob/living/carbon/human/user)
    var/image/final_icon = image(null)
    var/obj/item/card/id/ID = user.get_idcard()

    var/background_state = user.assigned_squad?.background_icon || minimap_background
    final_icon.overlays += mutable_appearance(VULTURE_MAP_ICONS, background_state)

    var/icon_state
    if(ID?.assignment && ("Оператор ПТО" in ID.assignment))
        icon_state = ID.minimap_icon_override || "vulture"
    else
        icon_state = islist(minimap_icon) ? "unknown" : (ID?.minimap_icon_override || minimap_icon || "unknown")

    var/mutable_appearance/icon = mutable_appearance(VULTURE_MAP_ICONS, icon_state)
    icon.appearance_flags = RESET_COLOR

    if(islist(minimap_icon) && minimap_icon[icon_state])
        icon.color = minimap_icon[icon_state]
    final_icon.overlays += icon

    if(user.stat == DEAD || user.stat == UNCONSCIOUS)
        final_icon.overlays += mutable_appearance(VULTURE_MAP_ICONS, "defibable")

    return final_icon

/obj/item/pamphlet/trait/vulture/on_use(mob/living/carbon/human/user)
    . = ..()

    if(user.job != JOB_SQUAD_MARINE)
        to_chat(user, SPAN_WARNING("Only squad riflemen can use this."))
        return

    var/obj/item/card/id/ID = user.get_idcard()

    if(!ID) //not wearing an ID
        to_chat(user, SPAN_WARNING("You should wear your ID before doing this."))
        return FALSE

    if(!ID.check_biometrics(user))
        to_chat(user, SPAN_WARNING("You should wear your ID before doing this."))
        return FALSE

    user.rank_fallback = "vulture"
    user.job = "Оператор ПТО"

    ID.set_assignment("Оператор ПТО" + " " + (user.assigned_squad ? (user.assigned_squad.get_name_ru()) : ""))
    ID.assignment = "Оператор ПТО" + (user.assigned_squad ? " " + user.assigned_squad.get_name_ru() : "")
    ID.minimap_icon_override = "vulture"
    ID.name = "[ID.registered_name]'s ID Card ([ID.assignment])"

    user.hud_set_squad()

    var/obj/item/device/radio/headset/headset = user.get_type_in_ears(/obj/item/device/radio/headset)
    if(headset)
        headset.update_minimap_icon()

    GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "Оператор ПТО")
#undef VULTURE_MAP_ICONS
