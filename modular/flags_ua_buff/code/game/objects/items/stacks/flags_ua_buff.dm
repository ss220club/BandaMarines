// UA Flag Hold Buff - Добавляет бонус Hold для флага United Americas
// Когда флаг установлен на земле или держится в руках, дает бонус как от командирского приказа "Держать позицию" в радиусе 7 тайлов

/// Общая процедура для применения ауры бонуса Hold от флага
/proc/apply_flag_aura(atom/source, buff_range, buff_faction, buff_intensity)
	var/turf/T = get_turf(source)
	if(!T)
		return

	for(var/mob/living/carbon/human/H in range(buff_range, T))
		if(H.stat == DEAD)
			continue
		if(!ishumansynth_strict(H))
			continue
		// Давать бонус только союзникам той же фракции
		if(H.faction != buff_faction)
			continue

		H.activate_order_buff(COMMAND_ORDER_HOLD, buff_intensity, 2 SECONDS)

// Переопределения для флага UA в руках
/obj/item/flag/plantable/ua
	/// Радиус эффекта бонуса приказа "Держать позицию"
	var/buff_range = COMMAND_ORDER_RANGE
	/// Интенсивность бонуса приказа "Держать позицию"
	var/buff_intensity = 2
	/// Фракция, которая получает бонус
	var/buff_faction = FACTION_MARINE

/obj/item/flag/plantable/ua/equipped(mob/user, slot, silent)
	. = ..()
	// Запускать обработку когда флаг держат в руках
	if(slot == WEAR_L_HAND || slot == WEAR_R_HAND)
		START_PROCESSING(SSobj, src)

/obj/item/flag/plantable/ua/dropped(mob/user)
	. = ..()
	STOP_PROCESSING(SSobj, src)

/obj/item/flag/plantable/ua/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/flag/plantable/ua/process()
	if(!ismob(loc))
		STOP_PROCESSING(SSobj, src)
		return

	var/mob/M = loc
	// Проверить что флаг все еще в руках
	if(M.l_hand != src && M.r_hand != src)
		STOP_PROCESSING(SSobj, src)
		return

	if(!get_turf(M))
		return

	apply_area_effect(M)

/obj/item/flag/plantable/ua/proc/apply_area_effect(mob/flag_holder)
	if(!flag_holder || !flag_holder.loc)
		return
	apply_flag_aura(flag_holder, buff_range, buff_faction, buff_intensity)

// Переопределения для установленного флага UA
/obj/structure/flag/plantable/ua
	/// Радиус эффекта бонуса приказа "Держать позицию"
	var/buff_range = COMMAND_ORDER_RANGE
	/// Интенсивность бонуса приказа "Держать позицию"
	var/buff_intensity = 2
	/// Фракция, которая получает бонус
	var/buff_faction = FACTION_MARINE

/obj/structure/flag/plantable/ua/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/flag/plantable/ua/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/flag/plantable/ua/process()
	apply_area_effect()

/obj/structure/flag/plantable/ua/proc/apply_area_effect()
	if(!loc || health <= 0)
		return
	apply_flag_aura(src, buff_range, buff_faction, buff_intensity)

