/obj/structure/window
	var/obj/effect/abstract/smart_window_overlay

/obj/structure/window/proc/make_smart_window_overlay()
	var/turf/monitored = get_turf(src)
	if (!monitored)
		QDEL_NULL(smart_window_overlay)
		remove_filter("smartWindow")
		return

	if (is_full_window() || (dir in list(EAST, WEST)) || pixel_y == 0)
		QDEL_NULL(smart_window_overlay)
		remove_filter("smartWindow")
		return

	// Smart window sprite overlays
	// If something below window, it will placed above window, ignoring layers
	var/icon/my_icon = icon(icon, icon_state, dir)
	if (my_icon.Height() + pixel_y <= 0)
		QDEL_NULL(smart_window_overlay)
		remove_filter("smartWindow")
		return

	// Null here means, we was disabled
	if (smart_window_overlay == null)
		// Currently not working. Should making icon have normal transparency
		my_icon.Blend("#ffffffff", ICON_SUBTRACT)

		layer = BELOW_TABLE_LAYER
		smart_window_overlay = new(src)
		smart_window_overlay.icon = icon
		smart_window_overlay.icon_state = icon_state
		smart_window_overlay.dir = dir
		smart_window_overlay.vis_flags = VIS_INHERIT_ID
		smart_window_overlay.add_filter("smartWindow", 1, alpha_mask_filter(0, dir==NORTH ? pixel_y : -pixel_y, icon = my_icon))
		add_filter("smartWindow", 1, alpha_mask_filter(0, dir==NORTH ? -pixel_y : pixel_y, icon = my_icon))
		smart_window_overlay.layer = ABOVE_MOB_LAYER
		vis_contents += smart_window_overlay

