
/datum/game_mode/extended/faction_clash/post_setup()
	. = ..()

	// Убираем бадабумки, ибо взрывы в этом режиме нежелательны
	// Вендинг ФТЛов
	for(var/i in 1 to GLOB.cm_vending_gear_tl.len)
		var/list/item = GLOB.cm_vending_gear_tl[i]
		if(item[3] == /obj/item/prop/folded_anti_tank_sadar/common)
			GLOB.cm_vending_gear_tl.Cut(i, i+1)
			break

	// Вендинг Инженеров
	for(var/i in 1 to GLOB.cm_vending_gear_engi.len)
		var/list/item = GLOB.cm_vending_gear_engi[i]
		if(item[3] == /obj/item/prop/folded_anti_tank_sadar/common)
			GLOB.cm_vending_gear_engi.Cut(i, i+1)
			break
