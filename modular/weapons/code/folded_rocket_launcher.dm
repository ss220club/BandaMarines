/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common
	name = "РПГ M83A2-C"
	desc = "M83A2 типа \"Common\"  — это легкое распространенное одноразовое противотанковое оружие, \
		способное поражать вражескую технику на расстоянии до 1000 м. \
		Полностью одноразовая, пусковая установка ракеты сбрасывается после выстрела. \
		Система состоит из водонепроницаемой взрывной трубы из углеродного волокна, \
		внутри которой находится алюминиевая пусковая труба с ракетой. \
		Оружие стреляет нажатием кнопки заряда на спусковой рукоятке. \
		Прицеливание и стрельба производятся с плеча. \
		Место позади выстрела должно быть очищено во избежания задевания реактивной струей."
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

	current_mag = /obj/item/ammo_magazine/rocket/he_c // больше не АП. Среднее между АП и обычной.
	var/folded_type = /obj/item/prop/folded_anti_tank_sadar/common

	// Backblast parameters
	var/backblast_range = 2 // How many tiles behind the shooter are affected
	var/backblast_damage = 15 // Damage to living beings
	var/backblast_burn_damage = 40 // Additional burn damage
	var/backblast_knockdown = 3 // Seconds of knockdown
	var/backblast_stun = 3 // Seconds of stun

/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/anti_tank
	current_mag = /obj/item/ammo_magazine/rocket/anti_tank

/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/Fire(atom/target, mob/living/user, params, reflex, dual_wield)
	if(fired)
		to_chat(user, SPAN_NOTICE("[src.name] уже использован и более с него нельзя выстрелить!"))
		return FALSE
	apply_backblast(user)
	ammo.accurate_range = initial(ammo.accurate_range)
	ammo.max_range = initial(ammo.max_range)
	if(!(flags_item & WIELDED))
		user.visible_message(SPAN_DANGER("[user] выстрелил с [src.name] направленным в землю!"), SPAN_USERDANGER("БЛЯТЬ!!! Я ЗАБЫЛ НАПРАВИТЬ ТРУБУ!!!!!"))
		ammo.accurate_range = 1
		ammo.max_range = 2
	. = ..()

/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/fold(mob/user)
	if(fired)
		to_chat(user, SPAN_NOTICE("[src.name] уже использован и более его нельзя сложить!"))
		return
	var/obj/O = new folded_type(src.loc)
	transfer_label_component(O)
	qdel(src)
	user.put_in_active_hand(O)

/// Applies backblast damage to anyone standing behind the shooter
/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/proc/apply_backblast(mob/living/user)
	if(!istype(user) || !user.loc)
		return

	// Get direction opposite to where user is facing
	var/backblast_dir = turn(user.dir, 180)
	var/turf/starting_turf = get_turf(user)

	// Create visual effect
	var/datum/effect_system/smoke_spread/chem/smoke = new()
	smoke.set_up(n = 2, loca = starting_turf)
	smoke.attach(starting_turf)
	smoke.start()

	// Check tiles in backblast direction
	for(var/i in 1 to backblast_range)
		var/turf/affected_turf = get_step(starting_turf, backblast_dir)
		if(!affected_turf)
			break

		// Damage mobs in the affected tile
		for(var/mob/living/victim in affected_turf)
			if(victim == user) // Don't damage the shooter
				continue

			victim.visible_message(SPAN_DANGER("[victim] попадает под струю раскаленных газов из [src]!"),
								SPAN_USERDANGER("Меня накрывает струя раскаленных газов из [src]!"))
			victim.apply_damage(backblast_damage, BRUTE)
			victim.apply_damage(backblast_burn_damage, BURN)
			victim.KnockDown(backblast_knockdown)
			victim.Stun(backblast_stun)

		starting_turf = affected_turf

// ===============================
// Prop - folded RPG

/obj/item/prop/folded_anti_tank_sadar/common
	name = "Раскладной РПГ M83A2-C"
	desc = "Одноразовый распространеннный противотанковый гранатомет M83A2, сложенный для удобства хранения и безопасности. \
		Раскладывается с помощью клавиши Z. Нельзя сложить обратно."
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

/obj/item/prop/folded_anti_tank_sadar/common/unfold(mob/user)
	var/obj/O = new folded_type(src.loc)
	transfer_label_component(O)
	qdel(src)
	user.put_in_active_hand(O)

/obj/item/prop/folded_anti_tank_sadar/common/at
	folded_type = /obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/common/anti_tank

// ===============================
// Вспомогательно

// Оффы наговнокодили заряжалку через ракету... Поэтому приходится так
/obj/item/ammo_magazine/rocket/attack(mob/living/carbon/human/M, mob/living/carbon/human/user)
	if(!istype(M) || !istype(user) || get_dist(user, M) > 1)
		return
	var/obj/item/weapon/gun/launcher/rocket/anti_tank/disposable/in_hand = M.get_active_hand()
	if(in_hand)
		to_chat(M, SPAN_NOTICE("Он уже использован и более его нельзя зарядить!"))
		return
	. = ..()
