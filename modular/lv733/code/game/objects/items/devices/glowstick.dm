/obj/item/device/flashlight/flare/glowstick
	name = "химический источник света"
	desc = "Химический светильник в прочном пластиковом корпусе. Согните, чтобы смешать реагенты и активировать."
	w_class = SIZE_TINY
	show_flame = FALSE
	fuel = 22 MINUTES
	item_icons = list(
		WEAR_L_HAND = 'modular/lv733/icons/glowstick/glowstick_lefthand.dmi',
		WEAR_R_HAND = 'modular/lv733/icons/glowstick/glowstick_righthand.dmi',
	)

/obj/item/device/flashlight/flare/glowstick/blue
	name = "синий химический источник света"
	icon = 'modular/lv733/icons/glowstick/glowstick_blue.dmi'
	icon_state = "glowstick_blue"
	item_state = "glowstick_blue"
	flame_tint = "#2487ff"

/obj/item/device/flashlight/flare/glowstick/green
	name = "зелёный химический источник света"
	icon = 'modular/lv733/icons/glowstick/glowstick_green.dmi'
	icon_state = "glowstick_green"
	item_state = "glowstick_green"
	flame_tint = "#9cff9c"

/obj/item/device/flashlight/flare/glowstick/red
	name = "красный химический источник света"
	icon = 'modular/lv733/icons/glowstick/glowstick_red.dmi'
	icon_state = "glowstick_red"
	item_state = "glowstick_red"
	flame_tint = "#ff1f1f"

/obj/item/device/flashlight/flare/glowstick/yellow
	name = "жёлтый химический источник света"
	icon = 'modular/lv733/icons/glowstick/glowstick_yellow.dmi'
	icon_state = "glowstick_yellow"
	item_state = "glowstick_yellow"
	flame_tint = "#ffe100"

/obj/item/storage/box/glowstick
	name = "\improper коробка синих химических источников света"
	desc = "Упаковка из 8 химических источников света. Горят значительно дольше стандартных сигнальных фаеров."
	icon = 'modular/lv733/icons/glowstick/glowstick_box_blue.dmi'
	icon_state = "glowstick_box_blue"
	w_class = SIZE_MEDIUM
	storage_slots = 8
	max_storage_space = 8
	can_hold = list(/obj/item/device/flashlight/flare/glowstick)
	var/glowstick_type = /obj/item/device/flashlight/flare/glowstick/blue
	var/box_icon_base = "glowstick_box_blue"

/obj/item/storage/box/glowstick/fill_preset_inventory()
	for(var/i = 1 to max_storage_space)
		new glowstick_type(src)

/obj/item/storage/box/glowstick/update_icon()
	icon_state = length(contents) ? box_icon_base : "[box_icon_base]_e"

/obj/item/storage/box/glowstick/blue

/obj/item/storage/box/glowstick/green
	name = "\improper коробка зелёных химических источников света"
	icon = 'modular/lv733/icons/glowstick/glowstick_box_green.dmi'
	icon_state = "glowstick_box_green"
	box_icon_base = "glowstick_box_green"
	glowstick_type = /obj/item/device/flashlight/flare/glowstick/green

/obj/item/storage/box/glowstick/red
	name = "\improper коробка красных химических источников света"
	icon = 'modular/lv733/icons/glowstick/glowstick_box_red.dmi'
	icon_state = "glowstick_box_red"
	box_icon_base = "glowstick_box_red"
	glowstick_type = /obj/item/device/flashlight/flare/glowstick/red

/obj/item/storage/box/glowstick/yellow
	name = "\improper коробка жёлтых химических источников света"
	icon = 'modular/lv733/icons/glowstick/glowstick_box_yellow.dmi'
	icon_state = "glowstick_box_yellow"
	box_icon_base = "glowstick_box_yellow"
	glowstick_type = /obj/item/device/flashlight/flare/glowstick/yellow
