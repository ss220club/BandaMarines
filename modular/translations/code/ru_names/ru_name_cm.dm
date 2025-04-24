// Создаем ассоциативный список для переводов
GLOBAL_LIST_INIT(cm_vending_translations, list(
    "ENGINEER SET (MANDATORY)" = "ИНЖЕНЕРНЫЙ НАБОР (ОБЯЗАТЕЛЕН)",
    "Essential Engineer Set" = "Базовый инженерный набор",
    "HANDHELD DEFENSE (ВЫБЕРИТЕ 1)" = "РУЧНАЯ ОБОРОНА (ВЫБЕРИТЕ 1)",
    "21S Tesla Coil" = "21S Катушка Тесла",
    "JIMA Planted Flag" = "Флаг JIMA"
))

// Функция для получения перевода
/proc/get_translated_text(text)
    return GLOB.cm_vending_translations[text] || text

// Пример использования в вашем коде
GLOBAL_LIST_INIT(cm_vending_gear_engi, list(
    list(get_translated_text("ENGINEER SET (MANDATORY)"), 0, null, null, null),
    list(get_translated_text("Essential Engineer Set"), 0, /obj/effect/essentials_set/engi, MARINE_CAN_BUY_ESSENTIALS, VENDOR_ITEM_MANDATORY),

    list(get_translated_text("HANDHELD DEFENSE (ВЫБЕРИТЕ 1)"), 0, null, null, null),
    list(get_translated_text("21S Tesla Coil"), 0, /obj/item/defenses/handheld/tesla_coil, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
    list(get_translated_text("JIMA Planted Flag"), 0, /obj/item/defenses/handheld/planted_flag, MARINE_CAN_BUY_ATTACHMENT, VENDOR_ITEM_MANDATORY),
))