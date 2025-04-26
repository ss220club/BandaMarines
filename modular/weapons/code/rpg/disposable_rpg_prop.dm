// ===============================
// Prop - folded RPG

/obj/item/prop/folded_anti_tank_sadar/common
	name = "Раскладной РПГ M83A2-C"
	desc = "Одноразовый распространеннный противотанковый гранатомет M83A2, сложенный для удобства хранения и безопасности. \
		Морпехи её кличут \"Бум-палкой\"."
	icon = 'modular/weapons/icons/rocket_launchers.dmi'
	icon_state = "m83a2_folded"
	item_state = "m83a2_folded"
	item_icons = list(
		WEAR_BACK = 'modular/weapons/icons/wear/rocket_launchers.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/wear/rocket_launchers.dmi',
		WEAR_L_HAND = 'modular/weapons/icons/inhands/rocket_launchers_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/inhands/rocket_launchers_righthand.dmi'
	)

	flags_equip_slot = SLOT_BACK|SLOT_SUIT_STORE
	flags_atom = FPRINT|QUICK_DRAWABLE|CONDUCT
	w_class = SIZE_LARGE // Больше аналога
	throwforce = 5
	throw_speed = SPEED_VERY_FAST
	throw_range = 5
	force = 5
	var/folded_type = /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common
	// var/unfold_time = 5 SECONDS // Время для развертывания	// Перенесено в родителя из-за хардкода
	// var/skill_req = SKILL_ENGINEER
	// var/skill_skip_fold_time = SKILL_ENGINEER_ENGI

/obj/item/prop/folded_anti_tank_sadar/common/unfold(mob/user)
	// if(!skillcheck(usr, skill_req, skill_skip_fold_time))
	// 	to_chat(usr, SPAN_NOTICE("Вы развертываете [src.name]."))
	// 	if(!do_after(user, unfold_time * user.get_skill_duration_multiplier(skill_req), INTERRUPT_ALL, BUSY_ICON_BUILD))
	// 		to_chat(usr, SPAN_WARNING("Вы прекратили развертывать [src.name]."))
	// 		return FALSE
	// 	to_chat(usr, SPAN_NOTICE("Вы развернули [src.name]."))
	var/obj/O = new folded_type(src.loc)
	transfer_label_component(O)
	qdel(src)
	user.put_in_active_hand(O)

/obj/item/prop/folded_anti_tank_sadar/get_examine_text(mob/user)
	. = ..()
	. += SPAN_NOTICE("Раскладывается с помощью клавиши Z")

// ===============================
// Anti Tank version
/obj/item/prop/folded_anti_tank_sadar/common/at
	folded_type = /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/anti_tank
