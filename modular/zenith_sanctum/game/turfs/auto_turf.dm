// LV new auto-turf

/turf/open/auto_turf/lv_grass
	name = "jungle grass"
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "grass_0"
	icon_prefix = "grass"
	layer_name = list("ground","lush thick grass")
	desc = "grass, dirt, mud, and other assorted high moisture cave flooring."
	is_weedable = SEMI_WEEDABLE

/turf/open/auto_turf/lv_grass/insert_self_into_baseturfs()
	baseturfs += /turf/open/auto_turf/lv_grass/layer0

/turf/open/auto_turf/lv_grass/layer0
	icon_state = "grass_0"
	bleed_layer = 0
	variant_prefix_name = "matted grass"

/turf/open/auto_turf/lv_grass/layer0_mud
	name = "thick mud"
	icon_state = "grass_0_mud"
	bleed_layer = 0
	variant = "mud"
	variant_prefix_name = "muddy"

/turf/open/auto_turf/lv_grass/layer0_mud_alt
	name = "cave mud"
	icon_state = "grass_0_mud_alt"
	bleed_layer = 0
	variant = "mud_alt"
	variant_prefix_name = "muddy"

/turf/open/auto_turf/lv_grass/layer1
	icon_state = "grass_1"
	bleed_layer = 1

// LV grass auto but with HUGE edges - seriously big, will fit over half a tile.

/turf/open/auto_turf/lv_grass_big_edges
	name = "jungle grass"
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "altgrass_0"
	icon_prefix = "altgrass"
	layer_name = list("ground","lush thick grass")
	desc = "grass, dirt, mud, and other assorted high moisture cave flooring."
	is_weedable = SEMI_WEEDABLE

/turf/open/auto_turf/lv_grass_big_edges/insert_self_into_baseturfs()
	baseturfs += /turf/open/auto_turf/lv_grass_big_edges/layer0

/turf/open/auto_turf/lv_grass_big_edges/layer0
	icon_state = "altgrass_0"
	bleed_layer = 0
	variant_prefix_name = "matted grass"

/turf/open/auto_turf/lv_grass_big_edges/layer1
	icon_state = "altgrass_1"
	bleed_layer = 1

// LV new auto-turf  WEEDABLE

/turf/open/auto_turf/lv_grass_weedable
	name = "jungle grass"
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "grass_0"
	icon_prefix = "grass"
	layer_name = list("ground","lush thick grass")
	desc = "grass, dirt, mud, and other assorted high moisture cave flooring."

/turf/open/auto_turf/lv_grass_weedable/insert_self_into_baseturfs()
	baseturfs += /turf/open/auto_turf/lv_grass_weedable/layer0

/turf/open/auto_turf/lv_grass_weedable/layer0
	icon_state = "grass_0"
	bleed_layer = 0
	variant_prefix_name = "matted grass"

/turf/open/auto_turf/lv_grass_weedable/layer0_mud
	name = "thick mud"
	icon_state = "grass_0_mud"
	bleed_layer = 0
	variant = "mud"
	variant_prefix_name = "muddy"

/turf/open/auto_turf/lv_grass_weedable/layer0_mud_alt
	name = "cave mud"
	icon_state = "grass_0_mud_alt"
	bleed_layer = 0
	variant = "mud_alt"
	variant_prefix_name = "muddy"

/turf/open/auto_turf/lv_grass_weedable/layer1
	icon_state = "grass_1"
	bleed_layer = 1

// LV grass auto but with HUGE edges - seriously big, will fit over half a tile. WEEDABLE

/turf/open/auto_turf/lv_grass_weedable_big_edges
	name = "jungle grass"
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	icon_state = "altgrass_0"
	icon_prefix = "altgrass"
	layer_name = list("ground","lush thick grass")
	desc = "grass, dirt, mud, and other assorted high moisture cave flooring."

/turf/open/auto_turf/lv_grass_weedable_big_edges/insert_self_into_baseturfs()
	baseturfs += /turf/open/auto_turf/lv_grass_weedable_big_edges/layer0

/turf/open/auto_turf/lv_grass_weedable_big_edges/layer0
	icon_state = "altgrass_0"
	bleed_layer = 0
	variant_prefix_name = "matted grass"

/turf/open/auto_turf/lv_grass_weedable_big_edges/layer1
	icon_state = "altgrass_1"
	bleed_layer = 1

/// Sand

/turf/open/auto_turf/lv_sand
	name = "mud"
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	layer_name = list("red dirt", "sand", "rocky sand", "this layer does not exist", "call a coder")

/turf/open/auto_turf/lv_sand/insert_self_into_baseturfs()
	baseturfs += /turf/open/auto_turf/lv_sand/layer0

/turf/open/auto_turf/lv_sand/get_dirt_type()
	return DIRT_TYPE_SAND

/turf/open/auto_turf/lv_sand/layer0 //still have to manually define the layers for the editor
	icon_state = "sand_0"
	bleed_layer = 0

/turf/open/auto_turf/lv_sand/layer1
	icon_state = "sand_1"
	bleed_layer = 1

/turf/open/auto_turf/lv_sand_alt
	icon = 'modular/zenith_sanctum/icons/turf/floors/auto_lv_turf.dmi'
	layer_name = list("aged igneous", "wind swept dunes", "warn a coder", "warn a coder", "warn a coder")
	icon_state = "varadero_1"
	icon_prefix = "varadero"

/turf/open/auto_turf/lv_sand_alt/get_dirt_type()
	return DIRT_TYPE_SAND

/turf/open/auto_turf/lv_sand_alt/layer0
	icon_state = "varadero_0"
	bleed_layer = 0

/turf/open/auto_turf/lv_sand_alt/layer1
	icon_state = "varadero_1"
	bleed_layer = 1
