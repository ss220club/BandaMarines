/datum/modpack/map_blips
	name = "Map Blips"
	desc = "Добавляет наши иконки на тактическую карту"

/datum/modpack/map_blips/initialize()
	. = ..()

	for(var/iconstate in icon_states('modular/map_blips/icons/map_blips.dmi'))
		var/icon/blip = icon('modular/map_blips/icons/map_blips.dmi', icon_state = iconstate)
		GLOB.minimap_icons[iconstate] = icon2base64(blip)
