/client
	var/atom/hovered_over

/atom/MouseEntered(location, control, params)
	. = ..()
	var/client/client = usr.client
	if(client.prefs?.xeno_ability_click_mode != XENO_ABILITY_CLICK_INSTANT)
		return // Limited only to quick-cast, for now
	if(istype(src, /atom/movable/screen/click_catcher))
		var/list/mods = params2list(params)
		client.hovered_over = params2turf(mods["screen-loc"], get_turf(client.eye), client)
		return
	client.hovered_over = src

/atom/MouseExited(location, control, params)
	. = ..()
	var/client/client = usr.client
	if(client.prefs?.xeno_ability_click_mode != XENO_ABILITY_CLICK_INSTANT)
		return // Quick-cast only
	client.hovered_over = null
