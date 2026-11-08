/obj/item/clothing/mask/gas/yautja/unfunctional
	name = "ancient alien mask"
	desc = "Выкованная из металла неизвестного происхождения боевая маска с ритуальными насечками. Эта выглядит древней, сильно поврежденной и едва функционирующей."
	armor_melee = CLOTHING_ARMOR_VERYLOW
	armor_bullet = CLOTHING_ARMOR_LOW
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_VERYLOW
	armor_bio = CLOTHING_ARMOR_LOW
	armor_rad = CLOTHING_ARMOR_LOW
	armor_internaldamage = CLOTHING_ARMOR_VERYLOW
	eye_protection = 0
	anti_hug = 1
	mask_huds = list()
	mask_actions = list()

/obj/item/clothing/mask/gas/yautja/unfunctional/Initialize(mapload, ...)
	. = ..()
	src.verbs -= /obj/item/clothing/mask/gas/yautja/verb/toggle_zoom
	src.verbs -= /obj/item/clothing/mask/gas/yautja/verb/togglesight
