#define WAITING_HEALTH_THRESHOLD 300

/datum/tutorial/xenomorph/basic
	name = "Ксеноморфы - База"
	desc = "Туториал познакомит вас с базой за игру за ксеноморфа."
	icon_state = "xeno"
	tutorial_id = "xeno_basic_1"
	tutorial_template = /datum/map_template/tutorial/s12x12
	starting_xenomorph_type = /mob/living/carbon/xenomorph/drone
	required_tutorial = "ss13_intents_1"

// START OF SCRITPING

/datum/tutorial/xenomorph/basic/start_tutorial(mob/starting_mob)
	. = ..()
	if(!.)
		return

	init_mob()

	xeno.plasma_stored = 0
	xeno.plasma_max = 0
	xeno.melee_damage_lower = 40
	xeno.melee_damage_upper = 40
	xeno.lock_evolve = TRUE

	message_to_player("Добро пожаловать в базовый туториал за ксеноморфов. Вы [xeno.name], дрон, работяга улья.")

	addtimer(CALLBACK(src, PROC_REF(on_stretch_legs)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_stretch_legs()
	message_to_player("Как дрон, вы можете делать базу которую могут делать почти все ксеноморфы в улье. Например, сажать траву, строить, садить яйца и захватывать новых людей.")
	addtimer(CALLBACK(src, PROC_REF(on_inform_health)), 5 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_inform_health()
	message_to_player("Зелёная икона <b>справа</b> в вашем экране показывает ваше количество здоровья.")
	addtimer(CALLBACK(src, PROC_REF(on_give_plasma)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_give_plasma()
	message_to_player("Вам дали <b>плазму</b>, ресурс необходимый для ваших способностей. Отображается он при помощи иконки <b>справа</b> вашего экрана и синей полоской на ксеноморфе.")
	xeno.plasma_max = 200
	xeno.plasma_stored = 200
	addtimer(CALLBACK(src, PROC_REF(on_damage_xenomorph)), 15 SECONDS)

/datum/tutorial/xenomorph/basic/proc/on_damage_xenomorph()
	xeno.apply_damage(350)
	xeno.emote("hiss")
	message_to_player("О нет! Вы получили ранения. Заметьте, что зелёная иконка уменьшилась. Ксеноморфы могут восстановить своё здоровье отдыхая или стоя на траве.")
	addtimer(CALLBACK(src, PROC_REF(request_player_plant_weed)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/request_player_plant_weed()
	update_objective("Посадите узел травы, используя новую способность <b>Посадить узел травы</b> которую вам только что дали.")
	give_action(xeno, /datum/action/xeno_action/onclick/plant_weeds)
	message_to_player("Посадите узел травы используя способность которую вам дали, в верху экрана. Трава лечит ксеноморфов и даёт им плазмы. Она также замедляет людей, что делает их лёгкой целью.")
	RegisterSignal(xeno, COMSIG_XENO_PLANT_RESIN_NODE, PROC_REF(on_plant_resinode))

/datum/tutorial/xenomorph/basic/proc/on_plant_resinode()
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_PLANT_RESIN_NODE)
	message_to_player("Отлично. Вы можете подлечиться быстрее если будете <b>Отдыхать</b> при помощи клавиши [retrieve_bind("rest")].")
	message_to_player("Мы увеличили ваш запаз плазмы. Заметьте, что плазма будет восстанавливаться если вы стоите на траве.")
	give_action(xeno, /datum/action/xeno_action/onclick/xeno_resting)
	update_objective("Отдохните или подождите, пока вы не достигните [WAITING_HEALTH_THRESHOLD] здоровья.")
	xeno.plasma_max = 500
	RegisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS, PROC_REF(on_xeno_gain_health))

/datum/tutorial/xenomorph/basic/proc/on_xeno_gain_health()
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS)
	message_to_player("Даже на траве, процесс лечения довольно таки медленный. Его можно ускорить феромонами. Испустите \"Recovery\" феромоны используя вашу новую способность что бы увеличить скорость лечения.")
	give_action(xeno, /datum/action/xeno_action/onclick/emit_pheromones)
	update_objective("Испустите феромоны что бы быстрее подлечиться.")
	RegisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES, PROC_REF(on_xeno_emit_pheromone))

/datum/tutorial/xenomorph/basic/proc/on_xeno_emit_pheromone(emitter, pheromone)
	SIGNAL_HANDLER
	if(!(pheromone == "recovery"))
		message_to_player("Это не феромоны восстановления. Нажмите на свою способность ещё раз, что бы прекратить выпускать феромоны, и выберите <b>Recovery</b> феромоны.")
	else if(xeno.health > WAITING_HEALTH_THRESHOLD)
		reach_health_threshold()
		UnregisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES)
	else
		UnregisterSignal(xeno, COMSIG_XENO_START_EMIT_PHEROMONES)
		message_to_player("Отлично. Феромоны поддержки значительно увеличят скорость вашего лечения. Отдохните или подождите пока ваше здоровье не будет приблизительно [WAITING_HEALTH_THRESHOLD].")
		message_to_player("Феромоны также дают свои способности всем сёстрам вблизи!")
		RegisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS, PROC_REF(reach_health_threshold))

/datum/tutorial/xenomorph/basic/proc/reach_health_threshold()
	SIGNAL_HANDLER
	if(xeno.health < WAITING_HEALTH_THRESHOLD)
		return

	UnregisterSignal(xeno, COMSIG_XENO_ON_HEAL_WOUNDS)

	message_to_player("Отлично. Хорошо.")
	message_to_player("Враждебный человек или же \"хост\" появился. Используйте свой <b>интент вреда</b> что бы убить его вблизи!")
	update_objective("Убейте человека!")

	var/mob/living/carbon/human/human_dummy = new(loc_from_corner(7,7))
	add_to_tracking_atoms(human_dummy)
	add_highlight(human_dummy, COLOR_RED)
	RegisterSignal(human_dummy, COMSIG_MOB_DEATH, PROC_REF(on_human_death_phase_one))

/datum/tutorial/xenomorph/basic/proc/on_human_death_phase_one()
	SIGNAL_HANDLER

	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)

	UnregisterSignal(human_dummy, COMSIG_MOB_DEATH)
	message_to_player("Отлично. Убивая людей, вы помогаете улью.")
	message_to_player("Другим путём вы можете <b>захватить</b> их. Это позволит вырастить в нём нового играбельного ксеноморфа!")
	update_objective("")
	addtimer(CALLBACK(human_dummy, TYPE_PROC_REF(/mob/living, rejuvenate)), 8 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(proceed_to_tackle_phase)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/proceed_to_tackle_phase()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	remove_highlight(human_dummy)
	RegisterSignal(human_dummy, COMSIG_MOB_TAKE_DAMAGE, PROC_REF(on_tackle_phase_human_damage))
	RegisterSignal(human_dummy, COMSIG_MOB_TACKLED_DOWN, PROC_REF(proceed_to_cap_phase))
	message_to_player("Повалите человека на землю, используя свой <b>обезоруживающий интент</b>. Может занять до четырёх попыток за дрона.")
	update_objective("Повалите человека на землю!")

/datum/tutorial/xenomorph/basic/proc/on_tackle_phase_human_damage(source, damagedata)
	SIGNAL_HANDLER
	if(damagedata["damage"] <= 0)
		return
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	// Rejuvenate the dummy if it's less than half health so our player can't kill it and softlock themselves.
	if(human_dummy.health < (human_dummy.maxHealth / 2))
		message_to_player("Не вредите человеку!")
		human_dummy.rejuvenate()

/datum/tutorial/xenomorph/basic/proc/proceed_to_cap_phase()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)

	UnregisterSignal(human_dummy, COMSIG_MOB_TACKLED_DOWN)

	ADD_TRAIT(human_dummy, TRAIT_KNOCKEDOUT, TRAIT_SOURCE_TUTORIAL)
	ADD_TRAIT(human_dummy, TRAIT_FLOORED, TRAIT_SOURCE_TUTORIAL)
	xeno.melee_damage_lower = 0
	xeno.melee_damage_upper = 0
	message_to_player("Отлично. В реальном поле боя вам понадобиться валить человека постоянно, что бы он не вырвался, но ради этого туториала, мы сделаем так, что бы он не смог встать.")
	update_objective("")
	addtimer(CALLBACK(src, PROC_REF(cap_phase)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/cap_phase()
	var/obj/effect/alien/resin/special/eggmorph/morpher = new(loc_from_corner(2,2), GLOB.hive_datum[XENO_HIVE_TUTORIAL])
	morpher.stored_huggers = 1
	add_to_tracking_atoms(morpher)
	add_highlight(morpher, COLOR_YELLOW)
	message_to_player("На юго западе находиться огромное яйцо. Нажмите на яйцо что бы достать <b>фейсхагера</b>.")
	update_objective("Возьмите фейсхагера из яйца.")
	RegisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER, PROC_REF(take_facehugger_phase))

/datum/tutorial/xenomorph/basic/proc/take_facehugger_phase(source, hugger)
	SIGNAL_HANDLER
	UnregisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/effect/alien/resin/special/eggmorph, morpher)
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	add_to_tracking_atoms(hugger)
	remove_highlight(morpher)

	add_highlight(hugger, COLOR_YELLOW)
	message_to_player("Это фейсхагер, выделенный жёлтым. Поднимите его, просто кликнув по нему.")
	message_to_player("Стойте над упавшим человеком, и нажмите на него фейсхагером. Или бросьте его рядом с ним что бы он автоматом зацепил его лицо.")
	update_objective("Нацепите фейсхагера на человека.")
	RegisterSignal(hugger, COMSIG_PARENT_QDELETING, PROC_REF(on_hugger_deletion))
	RegisterSignal(human_dummy, COMSIG_HUMAN_IMPREGNATE, PROC_REF(nest_cap_phase), override = TRUE)

/datum/tutorial/xenomorph/basic/proc/on_hugger_deletion(hugger)
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/obj/effect/alien/resin/special/eggmorph, morpher)
	morpher.stored_huggers = 1
	add_highlight(morpher, COLOR_YELLOW)
	message_to_player("Нажмите на большоей яйцо что бы взять <b>фейсхагера</b>.")
	update_objective("Возьмите фейсхагера из большого яйца.")
	RegisterSignal(xeno, COMSIG_XENO_TAKE_HUGGER_FROM_MORPHER, PROC_REF(take_facehugger_phase))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	TUTORIAL_ATOM_FROM_TRACKING(/obj/item/clothing/mask/facehugger, hugger)
	UnregisterSignal(human_dummy, COMSIG_MOB_TAKE_DAMAGE)
	UnregisterSignal(human_dummy, COMSIG_HUMAN_IMPREGNATE)
	UnregisterSignal(hugger, COMSIG_PARENT_QDELETING)
	remove_highlight(hugger)

	message_to_player("Мы должны поместить заражённого человека в гнезд, что бы он точно не убежал.")
	message_to_player("Люди не смогут убежать без помощи, а наше гнездо сможет продержать их достаточно долго, что бы родилась новая сестра.")
	update_objective("")
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_two)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_two()

	loc_from_corner(8,0).ChangeTurf(/turf/closed/wall/resin/tutorial)
	loc_from_corner(8,1).ChangeTurf(/turf/closed/wall/resin/tutorial)
	loc_from_corner(9,1).ChangeTurf(/turf/closed/wall/resin/tutorial)

	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_three)), 5 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_three()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	message_to_player("Возьмите человека с интентом захвата, или просто нажав ctrl + клик.")
	update_objective("Возьмите человека в интенте захвата или просто ctrl-кликом.")
	RegisterSignal(human_dummy, COMSIG_MOVABLE_XENO_START_PULLING, PROC_REF(nest_cap_phase_four))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_four()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOVABLE_XENO_START_PULLING)
	message_to_player("Отлично. Теперь поглотите человека, имея его захват в активной руке и кликая на себя.Вы не должны двигаться во время этого процесса.")
	update_objective("Поглотите человека, нажимая на него с его захватом.")
	RegisterSignal(human_dummy, COMSIG_MOB_DEVOURED, PROC_REF(nest_cap_phase_five))

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_five()
	SIGNAL_HANDLER
	message_to_player("Отлично, вы можете выпленуть человека с помощью своей новой способности.")
	message_to_player("Будьте осторожны. Реальные люди смогут попытаться вырваться из вас просто прорезав вас изнутри!")
	give_action(xeno, /datum/action/xeno_action/onclick/regurgitate)
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_six)), 15 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_six()
	message_to_player("Люди могут быть загнездованны только на <b>траве улья</b>. Это особая трава, созданная такими структурами, как ядро улья, или кластер улья.")
	message_to_player("Мы установили ульи с травой и стенами на юго востоке.")
	addtimer(CALLBACK(src, PROC_REF(nest_cap_phase_seven)), 10 SECONDS)

/datum/tutorial/xenomorph/basic/proc/nest_cap_phase_seven()
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOB_DEVOURED)
	RegisterSignal(human_dummy, COMSIG_MOB_NESTED, PROC_REF(on_mob_nested))
	message_to_player("Насадите пленного человека!")
	update_objective("Насадите пленного человека!")
	message_to_player("Подтащите человека к стене так, что бы и вы, и человек непосредственно оказались рядом со стеной.")
	message_to_player("С захватом в вашей руке. Нажмите на стену. Или зажмите кнопкой мыши человека и перетащите его на стену. Вы не должны двигаться во время этого процесса.")
	new /obj/effect/alien/resin/special/cluster(loc_from_corner(9,0), GLOB.hive_datum[XENO_HIVE_TUTORIAL])

/datum/tutorial/xenomorph/basic/proc/on_mob_nested()
	SIGNAL_HANDLER
	TUTORIAL_ATOM_FROM_TRACKING(/mob/living/carbon/human, human_dummy)
	UnregisterSignal(human_dummy, COMSIG_MOB_NESTED)

	message_to_player("Отлично. Вот вся база которую вам надо знать за игру за ксеноморфа.")
	message_to_player("Этот туториал закончиться скоро.")
	tutorial_end_in(10 SECONDS)

// END OF SCRIPTING

/datum/tutorial/xenomorph/basic/init_map()
	loc_from_corner(9,0).ChangeTurf(/turf/closed/wall/resin/tutorial)

#undef WAITING_HEALTH_THRESHOLD
