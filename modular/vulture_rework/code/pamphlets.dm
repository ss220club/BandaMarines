/obj/item/pamphlet/trait/vulture/on_use(mob/living/carbon/human/user)
	. = ..()
	user.rank_fallback = "vulture"
	user.hud_set_squad()

	var/obj/item/card/id/ID = user.get_idcard()
	ID.set_assignment("Оператор ПТО" + " " + (user.assigned_squad ? (user.assigned_squad.get_name_ru()) : ""))
	ID.minimap_icon_override = "vulture"
	user.update_minimap_icon()
	GLOB.data_core.manifest_modify(user.real_name, WEAKREF(user), "Оператор ПТО")
