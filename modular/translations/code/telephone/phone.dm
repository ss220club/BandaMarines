GLOBAL_LIST_INIT(telephone_ru_names, list(
	// Almayer
    "Almayer" = "Алмаер",
    "Saferoom" = "Комната безопасности",
    "Flight Deck" = "Центр управления полётами",
    "Ordnance Tech" = "Оружейный техник",
    "Kitchen" = "Кухня",
    "Requisition" = "Снабжение",
    "Intelligence Center Telephone" = "Телефон центра разведки",
    "Reporter" = "Корреспондент",

    // Medical & Research Dept.
    "Medical & Research Dept." = "Медицина и исследования",
    "Medical Storage" = "Медицинский склад",
    "Chemistry Laboratory" = "Химическая лаборатория",
    "Main Medbay Reception" = "Приёмная медблока",
    "Operation Theatre 1" = "Операционная 1",
    "Operation Theatre 2" = "Операционная 2",
    "Operation Theatre 3" = "Операционная 3",
    "Operation Theatre 4" = "Операционная 4",
    "Morgue" = "Морг",
    "Main Research Laboratory" = "Главная лаборатория",
    "Research Containment" = "Комната исследовательского содержания",

    // Offices
    "Offices" = "Офисы",
    "RO Office" = "Офис квартирмейстера",
    "Senior Enlisted Advisor's Office" = "Офис старшего инструктора",
    "Commanding Officer's Office" = "Офис командующего офицера",
    "Executive Officer's Office" = "Офис исполнительного офицера",
    "Aux. Support Officer's Office" = "Офис офицера поддержки",
    "CMO Office" = "Офис главного врача",
    "CL Office" = "Офис связного корпорации",
    "CE Office" = "Офис главного инженера",

    // ARES
    "ARES" = "ARES",
    "AI Core" = "Ядро ИИ",
    "AI Reception" = "Приёмная ИИ",

    // MP Dept.
    "MP Dept." = "Бриг",
    "Brig Cells" = "Камеры содержания брига",
    "Brig Main Offices" = "Офисы брига",
    "Brig Warden's Office" = "Офис военного смотрителя",
    "Brig CMP's Office" = "Офис шефа военной плиции",

	// Command
    "Command" = "Штаб",
    "Starboard Railgun Control" = "Пост управления правым рельсотроном",
    "Port Railgun Control" = "Пост управления левым рельсотроном",
    "Alpha Overwatch" = "Альфа координатор",
    "Bravo Overwatch" = "Браво координатор",
    "Charlie Overwatch" = "Чарли координатор",
    "Delta Overwatch" = "Дельта координатор",
    "Combat Information Center" = "Боевой информационный центр",
    "CIC Reception" = "Приёмная БИЦ",

    // Dropship
    "Dropship" = "Десантные корабли",
    "Alamo" = "Аламо",
    "Normandy" = "Нормандия",
))

/obj/structure/transmitter
	/// Used for searching in UI using original EN name
	var/phone_id_en

/obj/structure/transmitter/Initialize(mapload, ...)
	. = ..()
	phone_id_en = phone_id
	phone_id = GLOB.telephone_ru_names[phone_id] || phone_id
	phone_category = GLOB.telephone_ru_names[phone_category] || phone_category
