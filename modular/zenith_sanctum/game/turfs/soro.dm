/turf/open/floor/brown_dirt/random_rocks
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "sand_1_1_N"

/turf/open/floor/brown_dirt/random_rocks/New()
		..()
		icon_state = pick("sand_1_1_N", "sand_1_1_NE", "sand_1_1_E", "sand_1_1_SE", "sand_1_1_S", "sand_1_1_SW", "sand_1_1_W", "sand_1_1_NW")
		dir = null

/turf/open/floor/brown_dirt/random_rocks/break_tile()
	return

/turf/open/floor/brown_dirt/random_rocks/burn_tile()
	return

/turf/open/floor/brown_dirt/random_rocks_alt
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "sand_1_2_N"

/turf/open/floor/brown_dirt/random_rocks_alt/New()
		..()
		icon_state = pick("sand_1_2_N", "sand_1_2_NE", "sand_1_2_E", "sand_1_2_SE", "sand_1_2_S", "sand_1_2_SW", "sand_1_2_W", "sand_1_2_NW")
		dir = null

/turf/open/floor/brown_dirt/random_rocks_alt/break_tile()
	return

/turf/open/floor/brown_dirt/random_rocks_alt/burn_tile()
	return

/turf/open/gm/river/soro/weedable
	is_weedable = TRUE
	base_river_slowdown = 0

/turf/open/gm/river/soro/no_overlay
	no_overlay = TRUE

/turf/open/gm/river/soro/no_overlay/weedable
	is_weedable = TRUE
	base_river_slowdown = 0
