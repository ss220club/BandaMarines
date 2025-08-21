/obj/item/folded_tent/eng
	name = "Складная инженерная палатка ККМП"
	icon = 'modular/tents/icons/tent.dmi'
	icon_state = "eng_tent"
	desc = "Обычная инженерная палатка ККМП. В неё входят: 2 генератора, телефон, раздатчик инженеров, зарядник батареи. Разверните где есть свободное место для извлечения пользы. Штаб офицер не прилагается. ВХОД С ЮГА."
	template_preset = "tent_eng"

/obj/structure/tent/eng
	icon = 'modular/tents/icons/eng_tent_deployed_classic.dmi'
	x_dim = 4
	y_dim = 4
	icon_state = "eng_interior"
	roof_state = "eng_top"
	desc = "Обычная инженерная палатка ККМП. В неё входят: 2 генератора, телефон, раздатчик инженеров, зарядник батареи. Разверните где есть свободное место для извлечения пользы. Штаб офицер не прилагается. ВХОД С ЮГА."

/obj/structure/tent/eng/Initialize(mapload, ...)
	. = ..()
	if(roof_image)
		overlays -= roof_image

	switch(SSmapping.configs[GROUND_MAP].camouflage_type)
		if("jungle")
			icon = 'modular/tents/icons/eng_tent_deployed_jungle.dmi'
		if("desert")
			icon = 'modular/tents/icons/eng_tent_deployed_desert.dmi'
		if("snow")
			icon = 'modular/tents/icons/eng_tent_deployed_snow.dmi'
		if("urban")
			icon = 'modular/tents/icons/eng_tent_deployed_urban.dmi'
		else
			icon = initial(icon)

	if(roof_state)
		roof_image = image(icon, src, roof_state)
		roof_image.plane = ROOF_PLANE
		roof_image.appearance_flags = KEEP_APART
		src.overlays += roof_image
