/datum/paygrade/marine
	name = "Морпех"

// ENLISTED PAYGRADES

/datum/paygrade/marine/e1
	name = "Рядовой"
	prefix = "РЯД"

/datum/paygrade/marine/e2	// Медики, техники, каргонцы, повышенные рядовые.
	name = "Ефрейтор"
	prefix = "ЕФР"

/datum/paygrade/marine/e3	// Промежуточный, повышение
	name = "Младший Сержант"
	prefix = "МлСЕРЖ"

/datum/paygrade/marine/e4	// Выдается крювманам, SG, ФТЛ, Спекам, корреспонденту, военной полиции
	name = "Сержант"
	prefix = "СЕРЖ"

/datum/paygrade/marine/e5	// Выдается сквадным, Вардену
	name = "Старший Сержант"
	prefix = "СтСЕРЖ"
	rank_pin = /obj/item/clothing/accessory/ranks/marine/e5
	ranking = 4
	pay_multiplier = 2.2

/datum/paygrade/marine/e6	// Промежуточный
	name = "Старшина"
	prefix = "СТАРШ"

/datum/paygrade/marine/e7	// Квартирмейстер, советник
	name = "Прапорщик"
	prefix = "ПРАП"

/datum/paygrade/marine/e8	// Синты-поддержки, старшие квартирмейстеры
	name = "Старший Прапорщик"
	prefix = "СтПРАП"

/datum/paygrade/marine/e8e	// Ивент, щитспавн-советники
	name = "Младший Лейтенант"
	prefix = "МлЛЕЙТ"

/datum/paygrade/marine/e9	// Ивент, щитспавн
	name = "Капитан"
	prefix = "КАПТ"

/datum/paygrade/marine/e9e	// Ивент, щитспавн
	name = "Майор"
	prefix = "МАЙР"

/datum/paygrade/marine/e9c	// Не используется
	name = "Майор Корпуса Колонильных Морпехов"
	prefix = "МАЙРККМ"

// COMMISSIONED PAYGRADES

/datum/paygrade/marine/o1	// Оффицеры: Медбей, ГСБ, СЕ, Пилоты, ИО,
	name = "Лейтенант"
	prefix = "ЛЕЙТ"

/datum/paygrade/marine/o2	// Оффицеры поддержки, FAX'еры
	name = "Старший Лейтенант"
	prefix = "СтЛЕЙТ"

/datum/paygrade/marine/o3	// XO (Executive), Оффицер, повышенный офицер поддержки
	name = "Капитан"
	prefix = "КАПТ"

/datum/paygrade/marine/o4	// CO (Commanding), ВЛ
	name = "Майор"
	prefix = "МАЙР"

/datum/paygrade/marine/o5	// CO+, щитспавн
	name = "Подполковник"
	prefix = "ПОДПОЛК"

//Platoon Commander
/datum/paygrade/marine/o6	// CO++, щитспавн, ивент
	name = "Полковник"
	prefix = "ПОЛК"

/datum/paygrade/marine/o6e	// Ивент
	name = "Старший Полковник"
	prefix = "СтПОЛК"

/datum/paygrade/marine/o6c	// Ивент
	name = "Полковник Дивизии"
	prefix = "Полк Див."

//High Command	----  Ивенты
/datum/paygrade/marine/o7
	name = "Генерал-Бригадир"
	prefix = "ГЕНБриг"

/datum/paygrade/marine/o8
	name = "Генерал-Майор"
	prefix = "ГЕНМайр"

/datum/paygrade/marine/o9
	name = "Генерал-Лейтенант"
	prefix = "ГЕНЛейт"

/datum/paygrade/marine/o10
	name = "Генерал"
	prefix = "ГЕН"

/datum/paygrade/marine/o10c
	name = "Помощник коменданта Корпуса Морской Пехоты"
	prefix = "ПомККМП"

/datum/paygrade/marine/o10s
	name = "Комендант Корпуса Морской Пехота"
	prefix = "ККМП"

// Historical Background: Боевым собакам присвоено самое низкое офицерское звание из возможных,
// у них нет формального командования, но если кто-то жестоко обращался с животным,
// нарушителю могло быть предъявлено обвинение в нападении на офицера.
/datum/paygrade/marine/k9	// Ивент
	name = "Младший лейтенант, Боевой Спаситель"
	prefix = "МлЛЕЙТ, Боевой Спаситель"
