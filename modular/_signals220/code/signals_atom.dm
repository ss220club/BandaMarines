/atom/update_filters()
	. = ..()
	SEND_SIGNAL(src, COMSIG_ATOM_UPDATE_FILTERS)

/atom/get_orbit_size()
	. = ..()
	var/list/orbit_size = list(.)
	SEND_SIGNAL(src, COMSIG_ATOM_GET_ORBIT_SIZE, orbit_size)
	return orbit_size[1]
