/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common
	name = "РПГ M83A2-C"
	desc = "M83A2 типа \"Common\"  — это легкое распространенное одноразовое противотанковое оружие, \
		способное поражать вражескую технику на расстоянии до 1000 м. \
		Полностью одноразовая, пусковая установка ракеты сбрасывается после выстрела. \
		Система состоит из водонепроницаемой взрывной трубы из углеродного волокна, \
		внутри которой находится алюминиевая пусковая труба с ракетой. \
		Оружие стреляет нажатием кнопки заряда на спусковой рукоятке. \
		Прицеливание и стрельба производятся с плеча."
	icon = 'modular/weapons/icons/rocket_launchers.dmi'
	icon_state = "m83a2"
	item_state = "m83a2"
	item_icons = list(
		WEAR_BACK = 'modular/weapons/icons/wear/rocket_launchers.dmi',
		WEAR_J_STORE = 'modular/weapons/icons/wear/rocket_launchers.dmi',
		WEAR_L_HAND = 'modular/weapons/icons/inhands/rocket_launchers_lefthand.dmi',
		WEAR_R_HAND = 'modular/weapons/icons/inhands/rocket_launchers_righthand.dmi'
	)
	flags_equip_slot = SLOT_BACK
	unacidable = TRUE // Их можно расплавить уничтожить
	flags_gun_features = GUN_TRIGGER_SAFETY // Нужно сейфер переключить, так как GUN_WIELDED_FIRING_ONLY больше нет

/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/Fire(atom/target, mob/living/user, params, reflex, dual_wield)
	if(!(flags_item & WIELDED))
		user.visible_message(SPAN_DANGER("[user] выстрелил с [src] направленным в землю!"), SPAN_USERDANGER("БЛЯТЬ!!! Я ЗАБЫЛ НАПРАВИТЬ ТРУБУ!!!!!"))
		ammo.accurate_range = 1
		ammo.max_range = 2
	. = ..()

/obj/item/prop/folded_anti_tank_sadar/common
	name = "Раскладной РПГ M83A2-C"
	desc = "Одноразовый распространеннный противотанковый гранатомет M83A2, сложенный для удобства хранения и безопасности. \
		Раскладывается с помощью клавиши Z."
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

/obj/item/prop/folded_anti_tank_sadar/common/unfold(mob/user)
	var/obj/O = new /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common(src.loc)
	transfer_label_component(O)
	qdel(src)
	user.put_in_active_hand(O)
