/datum/modpack/tents
	name = "Палатки"
	desc = "Добавляет возможность заказа палаток в карго и новую инженерную палатку."
	author = "cnaper_dodo, pavlovvn"

/datum/modpack/tents/pre_initialize()
	. = ..()

/datum/modpack/tents/initialize()
	. = ..()

/datum/modpack/tents/post_initialize()
	. = ..()

/*
Изменено:
code/game/supplyshuttle.dm
code/modules/tents/templates.dm

Добавлено:

modular/supply_packs/code/tent_packs.dm
*/
