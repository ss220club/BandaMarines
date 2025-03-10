/obj/item/hardpoint/locomotion/treads/arm
	name = "\improper Гусеницы АРМ"
	desc = "Необходимы для движения транспорта. Пара гусениц."

	icon_state = "treads"
	disp_icon = "arm"
	disp_icon_state = "tryks"

	slot = HDPT_TREADS

	health = 300

	//with this settings, takes 3 tiles to reach top speed
	move_delay = 5
	move_max_momentum = 1
	move_momentum_build_factor = 1.8
	move_turn_momentum_loss_factor = 0.6
