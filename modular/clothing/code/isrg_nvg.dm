// Есть шанс, что заравотает
#define ISRG_OLD_NVG_WORK_CHANCE 5

/obj/item/prop/helmetgarb/helmet_nvg/cosmetic/isrg
	name = "старый прибор ночного видения"
	desc = "Старое устройство ночного видения, из-за недавних событий оно временно не работает."
	icon = 'modular/clothing/icon/isrg/isrg_nvg_item.dmi'
	item_icons = list(
		WEAR_AS_GARB = 'modular/clothing/onmob/isrg/isrg_nvg_worn.dmi',
	)

/obj/item/prop/helmetgarb/helmet_nvg/cosmetic/isrg/Initialize(mapload, ...)
	. = ..()
	GLOB.allowed_helmet_items[type] = PREFIX_HELMET_GARB_OVERRIDE
	if(prob(ISRG_OLD_NVG_WORK_CHANCE))
		shape = 3 // NVG_SHAPE_PATCHED
		desc += " Впрочем, судя по индикатору, этот экземпляр всё ещё в рабочем состоянии."

#undef ISRG_OLD_NVG_WORK_CHANCE
