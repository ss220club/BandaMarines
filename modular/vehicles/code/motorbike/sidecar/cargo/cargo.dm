/obj/structure/bed/chair/sidecar/cargo
	name = "Мотоциклетная грузовая коляска"
	desc = "Создана для перевозки ящиков. В эту коляску встроены темные технологии. Она принимает только предметы похожие на ящики"

	//======= Для отображения в игре ==============
	icon_state = "moto_ural_sidecar_cargo_classic"
	icon_base = "moto_ural_sidecar_cargo"

	//=============== Перемещение =================
	drag_delay_heavy = 5 // Тяжеленько. Внутри тяжелый ящик? Значит скорость упадет.

	//=========== Смещение при коннекте ===========
	pixel_east = list(2, -18)

	//================ Buckling ===============
	can_buckle = FALSE

/obj/structure/bed/chair/sidecar/cargo/update_overlay()
	.=..()
	// Если загружен, то отображаем покрывало на коляске
	if(loaded)
		icon_state = "[icon_base]_[icon_skin]_loaded"
	var/image/I = new(icon = 'modular/vehicles/icons/moto48x48.dmi', icon_state = "[icon_state]-layer", layer = layer_above) //over mobs //отвечает за отображение по слоям
	overlays += I
