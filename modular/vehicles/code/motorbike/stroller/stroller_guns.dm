// /obj/item/device/m2c_gun
// /obj/item/device/m56d_gun

// /obj/structure/bed/chair/stroller/attackby(obj/item/O as obj, mob/user as mob)
// 	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
// 		return ..()

// 	if(HAS_TRAIT(O, TRAIT_TOOL_WRENCH))
// 		playsound(loc, 'sound/items/Ratchet.ogg', 25, 1)
// 		if(stroller)
// 			stroller.disconnect()
// 			stroller = null
// 		else
// 			if(!try_connect(user))
// 				return ..()
// 		to_chat(user, SPAN_NOTICE("Вы [anchored ? "присоединили" : "отсоединили"] коляску."))
// 		return TRUE
// 	. = ..()
