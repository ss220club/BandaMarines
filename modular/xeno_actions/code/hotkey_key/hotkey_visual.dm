/atom/movable/screen/action_button
	var/image/maptext_hotkey_overlay

/atom/movable/screen/action_button/proc/set_maptext_hotkey(new_maptext, new_maptext_x, new_maptext_y)
	overlays -= maptext_hotkey_overlay
	if(!new_maptext)
		return
	maptext_hotkey_overlay = image(null, null, null, layer + 0.1)
	maptext_hotkey_overlay.maptext = new_maptext
	if(new_maptext_x)
		maptext_hotkey_overlay.maptext_x = new_maptext_x
	if(new_maptext_y)
		maptext_hotkey_overlay.maptext_y = new_maptext_y
	overlays += maptext_hotkey_overlay
