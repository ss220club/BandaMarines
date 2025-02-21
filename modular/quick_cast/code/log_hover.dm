/client
	var/atom/hovered_over

/atom/MouseEntered(location, control, params)
	. = ..()
	usr.client.hovered_over = src

/atom/MouseExited(location, control, params)
	. = ..()
	usr.client.hovered_over = null
