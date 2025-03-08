/obj/structure/bed/chair/stroller
	var/obj/structure/machinery/m56d_hmg/mounted
	var/allowed_types_to_mount = list(
		/obj/item/device/m56d_gun,
		/obj/item/device/m2c_gun)
	var/allowed_types_to_reload = list(
		/obj/item/ammo_magazine/m56d,
		/obj/item/ammo_magazine/m2c)
	var/mounted_type
	var/mounted_time_to_disassembly = 20 SECONDS
	var/mounted_time_to_assembly = 7 SECONDS
	var/buckled_mob_last_signal // Для контроля сигналов.

/obj/structure/bed/chair/stroller/attackby(obj/item/O as obj, mob/user as mob)
	if(!ishuman(user) && !HAS_TRAIT(user, TRAIT_OPPOSABLE_THUMBS))
		return ..()

	// Установка пулеметов
	for(var/allowed_type in allowed_types_to_mount)
		if(istype(O, allowed_type))
			assembly(O, user)
			return TRUE

	if(!mounted)
		return ..()

	// Перезарядка
	for(var/allowed_type in allowed_types_to_reload)
		if(istype(O, allowed_type))
			reload(O, user)
			return TRUE

	// Разборка уже установленного объекта
	if(HAS_TRAIT(O, TRAIT_TOOL_SCREWDRIVER)) // Lets take it apart.
		return dissasemble(O, user)

	. = ..()

// Сборка
/obj/structure/bed/chair/stroller/proc/assembly(obj/item/O, mob/user)
	to_chat(user, "Вы устанавливаете [mounted] на коляску...")
	if(!do_after(user, mounted_time_to_assembly * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		return FALSE

	var/rounds_temp = 0

	if(istype(O, /obj/item/device/m56d_gun))
		//var/obj/structure/machinery/m56d_post/post = new(src)
		var/obj/item/device/m56d_gun/D = O
		var/obj/structure/machinery/m56d_hmg/G = new(src)
		mounted = G
		mounted_type = G.type
		rounds_temp = D.rounds

	else if(istype(O, /obj/item/device/m2c_gun))
		var/obj/item/device/m2c_gun/D = O
		var/obj/structure/machinery/m56d_hmg/auto/G = new(src)	// Да, это тип M2C
		mounted = G
		mounted_type = G.type
		rounds_temp = D.rounds

	if(mounted)
		mounted.setDir(dir) // Make sure we face the right direction
		mounted.rounds = rounds_temp
		mounted.health = O.health // retain damage
		mounted.anchored = TRUE
		O.transfer_label_component(mounted)
		to_chat(user, SPAN_NOTICE("Вы установили [O] на коляску."))
		update_overlay()
		qdel(O)


// Разборка
/obj/structure/bed/chair/stroller/proc/dissasemble(obj/item/O, mob/user)
	if(!mounted)
		return FALSE
	if(mounted.locked)
		to_chat(user, "Установленное [mounted] невозможно отсоединить...")
		return FALSE
	to_chat(user, "Вы отсоединяете [mounted] на коляске...")
	if(!do_after(user, mounted_time_to_disassembly * user.get_skill_duration_multiplier(SKILL_ENGINEER), INTERRUPT_ALL|BEHAVIOR_IMMOBILE, BUSY_ICON_BUILD))
		to_chat(user, SPAN_DANGER("Вы прекратили отсоединение [O] на коляске."))
		return FALSE
	user.visible_message(SPAN_NOTICE("[user] отсоединил [O] от [src.name]!"), SPAN_NOTICE("Вы отсоединили [O] от [src.name]!"))
	playsound(src.loc, 'sound/items/Screwdriver.ogg', 25, 1)

	var/obj/item/device/m56d_gun/HMG = new mounted_type(loc)
	mounted.transfer_label_component(HMG)
	HMG.rounds = mounted.rounds
	HMG.health = mounted.health
	HMG.update_icon()

	qdel(mounted)
	mounted = null
	update_overlay()
	return TRUE

// Перезарядка
/obj/structure/bed/chair/stroller/proc/reload(obj/item/O, mob/user)
	if(!skillcheck(user, SKILL_FIREARMS, SKILL_FIREARMS_TRAINED))
		to_chat(user, SPAN_WARNING("Вы недостаточно натренированы чтобы работать с этим калибром!"))
		return
	// Тыкаем магазином в них же и совершаем "перезарядку"
	// Он должен тыканьем заполненного магазина менять магазин внутри.
	mounted.attackby(O, user)
	update_overlay()

#define COMSIG_MOB_MG_ENTER "mob_mg_enter"

// Стрельба
/obj/structure/bed/chair/stroller/proc/update_mob_gun_signal()
	if(mounted && buckled_mob)
		buckled_mob_last_signal = buckled_mob
		on_set_gun_interaction()
		give_action(buckled_mob, /datum/action/human_action/mg_enter)
		RegisterSignal(buckled_mob, COMSIG_MOB_MG_ENTER, PROC_REF(on_set_gun_interaction))	// Теперь мы можем перезайти за пулемет
	else if (buckled_mob_last_signal)
		mounted.on_unset_interaction(buckled_mob_last_signal)
		remove_action(buckled_mob, /datum/action/human_action/mg_enter)
		UnregisterSignal(buckled_mob, COMSIG_MOB_MG_ENTER)

/obj/structure/bed/chair/stroller/proc/on_set_gun_interaction()
	SIGNAL_HANDLER
	mounted.on_set_interaction(buckled_mob)

/obj/structure/bed/chair/stroller/proc/update_gun_dir()
	mounted.setDir(dir)

// Действие для захода за пулемет обратно
/datum/action/human_action/mg_enter
	name = "Enter MG"
	action_icon_state = "frontline_toggle_on"

/datum/action/human_action/mg_enter/action_activate()
	. = ..()
	if(!can_use_action())
		return

	var/mob/living/carbon/human/human_user = owner
	SEND_SIGNAL(human_user, COMSIG_MOB_MG_ENTER)

#undef COMSIG_MOB_MG_EXIT
