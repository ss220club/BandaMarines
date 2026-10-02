// это категория арка для фикса оповещения
/obj/effect/vehicle_spawner/arc
	category = "ARC"

// Убрана проверка на выбранный танк
/datum/tech/arc/can_unlock(mob/unlocking_mob)
	. = ..()
	return TRUE
