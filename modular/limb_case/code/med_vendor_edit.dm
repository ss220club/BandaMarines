//Разделяем вендоры доктора и полевого доктора
/obj/structure/machinery/cm_vending/clothing/medical_crew/get_listed_products(mob/user)
	if(!user)
		var/list/combined = list()
		combined += GLOB.cm_vending_clothing_nurse
		combined += GLOB.cm_vending_clothing_researcher
		combined += GLOB.cm_vending_clothing_cmo
		combined += GLOB.cm_vending_clothing_doctor
		combined += GLOB.cm_vending_clothing_field_doctor
		return combined
	else if (user.job == JOB_FIELD_DOCTOR)
		return GLOB.cm_vending_clothing_field_doctor
	. = ..()

//Заполняем вендора для полевого и подключаем новый вендор к переводу
/datum/modpack/limb_case/post_initialize()
	. = ..()
	GLOB.cm_vending_clothing_field_doctor += GLOB.cm_vending_clothing_doctor
	LAZYINSERT(GLOB.cm_vending_clothing_field_doctor,list(list("НАБОР ЗАПАСНЫХ КОНЕЧНОСТЕЙ", 0, null, null, null)),6)
	LAZYINSERT(GLOB.cm_vending_clothing_field_doctor,list(list("Кейс с роботизированными конечностями", 0, /obj/item/storage/robot_parts_kit, MARINE_CAN_BUY_KIT, VENDOR_ITEM_REGULAR)),7)
	translate_vendor_entries_to_ru(GLOB.cm_vending_clothing_field_doctor)

//Готовим глобалку для вендора полевого
GLOBAL_LIST_EMPTY(cm_vending_clothing_field_doctor)

//Добавляем в карго заказ конечностей
/datum/supply_packs/medical_limb_kit
	name = "Набор запасных конечностей (Набор синтетических конечностей х 3)"
	contains = list(
		/obj/item/storage/robot_parts_kit,
		/obj/item/storage/robot_parts_kit,
		/obj/item/storage/robot_parts_kit,
	)
	cost = 10
	containertype = /obj/structure/closet/crate/medical
	containername = "medical crate"
	group = "Medical"
