/obj/structure/barricade/deployable/isrg
	name = "\improper Переносной барьер ISRG"
	desc = "Облегчённый композитный барьер поисковой группы ISRG. Складывается в компактный пакет с помощью двух защёлок. Ремонтируется горелкой."
	icon = 'modular/lv733/icons/isrg_barricade/isrg_barricade.dmi'
	icon_state = "folding_0"
	health = 400
	maxhealth = 400
	burn_multiplier = 0.75
	brute_multiplier = 0.75
	crusher_resistant = TRUE
	force_level_absorption = 15
	source_type = /obj/item/stack/folding_barricade/isrg

/obj/item/stack/folding_barricade/isrg
	name = "Складной барьер ISRG"
	desc = "Складной барьер ISRG, позволяющий быстро развернуть защитную баррикаду кругового обзора."
	stack_id = "isrg_folding_barricade"
	singular_type = /obj/item/stack/folding_barricade/isrg
	icon = 'modular/lv733/icons/isrg_barricade/isrg_barricade_item.dmi'
	icon_state = "folding-1"
	item_icons = list(
		WEAR_BACK = 'modular/lv733/icons/isrg_barricade/isrg_barricade_back.dmi',
		WEAR_L_HAND = 'modular/lv733/icons/isrg_barricade/isrg_barricade_lhand.dmi',
		WEAR_R_HAND = 'modular/lv733/icons/isrg_barricade/isrg_barricade_rhand.dmi',
	)
	deployed_type = /obj/structure/barricade/deployable/isrg

/obj/item/stack/folding_barricade/isrg/three
	amount = 3
