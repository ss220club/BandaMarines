#define SPECIES_ISRG_SYNTH_K9 "ISRG Synthetic K9"
#define ISRG_K9_PULL_SPEED -1.5

/datum/species/synthetic/synth_k9/isrg
	name = SPECIES_ISRG_SYNTH_K9
	icobase = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	deform = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	blood_mask = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	flags = IS_WHITELISTED|NO_BREATHE|NO_CLONE_LOSS|NO_POISON|IS_SYNTHETIC|NO_CHEM_METABOLIZATION|NO_NEURO|NO_OVERLAYS
	unarmed_type = /datum/unarmed_attack/bite/synthetic
	/// Full-body K9 damage overlays. Both brute and burn damage use brute_1..3.
	var/icon/damage_overlay_icon = 'modular/lv733/icons/isrg_k9/isrg_k9_damage.dmi'
	/// Speech state to restore if the mob stops being an ISRG K9.
	var/previous_able_to_speak = TRUE
	var/added_mute_disability = FALSE

/datum/species/synthetic/synth_k9/isrg/handle_post_spawn(mob/living/carbon/human/spawned_k9)
	. = ..()
	spawned_k9.pull_speed = ISRG_K9_PULL_SPEED
	previous_able_to_speak = spawned_k9.able_to_speak
	spawned_k9.able_to_speak = FALSE
	if(!(spawned_k9.sdisabilities & DISABILITY_MUTE))
		spawned_k9.sdisabilities |= DISABILITY_MUTE
		added_mute_disability = TRUE
	RegisterSignal(spawned_k9, COMSIG_HUMAN_EQUIPPED_ITEM, PROC_REF(on_equipped_item))
	RegisterSignal(spawned_k9, COMSIG_HUMAN_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(spawned_k9, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))
	RegisterSignal(spawned_k9, COMSIG_HUMAN_REVIVED, PROC_REF(on_revived))
	RegisterSignal(spawned_k9, COMSIG_HUMAN_OVERLAY_APPLIED, PROC_REF(on_overlay_applied))
	give_action(spawned_k9, /datum/action/isrg_k9_voice_panel)

/datum/species/synthetic/synth_k9/isrg/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	H.pull_speed = initial(H.pull_speed)
	H.able_to_speak = previous_able_to_speak
	if(added_mute_disability)
		H.sdisabilities &= ~DISABILITY_MUTE
	remove_action(H, /datum/action/isrg_k9_voice_panel)
	UnregisterSignal(H, list(
		COMSIG_HUMAN_EQUIPPED_ITEM,
		COMSIG_HUMAN_UNARMED_ATTACK,
		COMSIG_MOB_WEED_SLOWDOWN,
		COMSIG_HUMAN_REVIVED,
		COMSIG_HUMAN_OVERLAY_APPLIED,
	))
	added_mute_disability = FALSE

// Чуть быстрее по смоле/паутине ксено, чем обычный человек
/datum/species/synthetic/synth_k9/isrg/proc/handle_weed_slowdown(mob/user, list/slowdata)
	SIGNAL_HANDLER
	slowdata["movement_slowdown"] *= 0.7

/// Replaces humanoid per-limb damage sprites with full-body K9 damage layers.
/datum/species/synthetic/synth_k9/isrg/proc/on_overlay_applied(mob/living/carbon/human/k9, cache_index, list/overlay_images)
	SIGNAL_HANDLER
	if(cache_index != DAMAGE_LAYER)
		return

	overlay_images.Cut()
	if(!damage_overlay_icon || k9.stat == DEAD)
		return

	var/damage_stage = get_damage_overlay_stage(k9.getBruteLoss() + k9.getFireLoss())
	if(damage_stage)
		overlay_images += image(
			icon = damage_overlay_icon,
			icon_state = "brute_[damage_stage]",
			layer = -DAMAGE_LAYER,
		)

/datum/species/synthetic/synth_k9/isrg/proc/get_damage_overlay_stage(damage)
	if(damage < 40)
		return 0
	if(damage < 100)
		return 1
	if(damage < 150)
		return 2
	return 3

/datum/species/synthetic/synth_k9/isrg/proc/on_equipped_item(mob/living/carbon/human/wearer, obj/item/equipped_item, slot)
	SIGNAL_HANDLER
	if(slot == WEAR_L_STORE || slot == WEAR_R_STORE)
		show_store_item_on_hud(wearer, equipped_item, slot)
		return
	if(slot == WEAR_BACK && istype(equipped_item, /obj/item/storage/satchel/marine/k9_synth/medicalpack/isrg))
		set_medpack_state(wearer, wearer.stat == DEAD ? "dead_medpack" : "isrg_medicalpack")
		return
	if(slot != WEAR_FEET)
		return
	to_chat(wearer, SPAN_WARNING("Лапам не подходит [equipped_item] - обувь тут же соскальзывает."))
	wearer.drop_inv_item_on_ground(equipped_item)

/datum/species/synthetic/synth_k9/isrg/proc/show_store_item_on_hud(mob/living/carbon/human/k9, obj/item/store_item, slot)
	if(!k9.client || !k9.hud_used?.hud_shown || !k9.hud_used.ui_datum)
		return

	var/screen_location = slot == WEAR_L_STORE ? k9.hud_used.ui_datum.ui_storage1 : k9.hud_used.ui_datum.ui_storage2
	store_item.screen_loc = k9.hud_used.ui_datum.hud_slot_offset(store_item, screen_location)
	k9.client.add_to_screen(store_item)

// Постройки ксено не обрабатывают обычную атаку без оружия. Для них отдельно
// переиспользуем штатную логику attackby(), не меняя урон укуса по живым целям.
/datum/species/synthetic/synth_k9/isrg/proc/on_unarmed_attack(mob/living/carbon/human/user, atom/target)
	SIGNAL_HANDLER
	if(user.a_intent == INTENT_HELP && istype(target, /obj/structure/machinery/door))
		var/obj/structure/machinery/door/door = target
		var/is_unpowered = door.stat & NOPOWER
		if(istype(door, /obj/structure/machinery/door/airlock))
			var/obj/structure/machinery/door/airlock/airlock = door
			is_unpowered = !airlock.arePowerSystemsOn()
		if(is_unpowered)
			INVOKE_ASYNC(src, PROC_REF(do_door_crowbar), user, door)
			return

	if(!is_type_in_list(target, list(
		/turf/closed/wall/resin,
		/obj/structure/alien/movable_wall,
		/obj/effect/alien/resin,
		/obj/effect/alien/weeds,
		/obj/effect/alien/egg,
		/obj/structure/bed/nest,
		/obj/structure/mineral_door,
	)))
		return
	INVOKE_ASYNC(src, PROC_REF(do_structure_damage), user, target)

// attackby() имеет оверрайды, которые могут sleep() (например, у дверей) - линтер запрещает
// вызывать такое напрямую из SIGNAL_HANDLER-проки, поэтому выносим сюда через INVOKE_ASYNC.
/datum/species/synthetic/synth_k9/isrg/proc/do_structure_damage(mob/living/carbon/human/user, atom/target)
	var/obj/item/attachable/bayonet/rmc/phantom_knife = new(user)
	target.attackby(phantom_knife, user)
	qdel(phantom_knife)

/datum/species/synthetic/synth_k9/isrg/proc/do_door_crowbar(mob/living/carbon/human/user, obj/structure/machinery/door/door)
	var/obj/item/tool/crowbar/phantom_crowbar = new(user)
	door.attackby(phantom_crowbar, user)
	qdel(phantom_crowbar)

/datum/species/synthetic/synth_k9/isrg/handle_death(mob/living/carbon/human/dead_k9, gibbed)
	. = ..()
	if(gibbed)
		return
	INVOKE_NEXT_TICK(src, PROC_REF(apply_dead_appearance), dead_k9)

/datum/species/synthetic/synth_k9/isrg/proc/apply_dead_appearance(mob/living/carbon/human/dead_k9)
	if(QDELETED(dead_k9) || dead_k9.stat != DEAD)
		return

	dead_k9.set_lying_angle(0)
	dead_k9.remove_overlay(BODYPARTS_LAYER)
	dead_k9.overlays_standing[BODYPARTS_LAYER] = image(
		icon = icobase,
		icon_state = "dead",
		layer = -BODYPARTS_LAYER,
	)
	dead_k9.apply_overlay(BODYPARTS_LAYER)
	dead_k9.remove_overlay(DAMAGE_LAYER)
	set_medpack_state(dead_k9, "dead_medpack")

/datum/species/synthetic/synth_k9/isrg/proc/on_revived(mob/living/carbon/human/revived_k9)
	SIGNAL_HANDLER
	set_medpack_state(revived_k9, "isrg_medicalpack")

/datum/species/synthetic/synth_k9/isrg/proc/set_medpack_state(mob/living/carbon/human/k9, new_icon_state)
	var/obj/item/storage/satchel/marine/k9_synth/medicalpack/isrg/medical_pack = k9.back
	if(!istype(medical_pack))
		return
	LAZYSET(medical_pack.item_state_slots, WEAR_BACK, new_icon_state)
	k9.update_inv_back()

/datum/species/synthetic/synth_k9/isrg/open_emote_panel()
	var/datum/isrg_k9_voice_panel/panel = new(usr)
	panel.ui_interact(usr)

/datum/action/isrg_k9_voice_panel
	name = "Open K9 Voice Synthesizer"
	action_icon_state = "looc_toggle"

/datum/action/isrg_k9_voice_panel/can_use_action()
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/k9 = owner
	return istype(k9?.species, /datum/species/synthetic/synth_k9/isrg)

/datum/action/isrg_k9_voice_panel/action_activate()
	. = ..()
	if(!can_use_action())
		return
	var/mob/living/carbon/human/k9 = owner
	var/datum/species/synthetic/synth_k9/isrg/k9_species = k9.species
	k9_species.open_emote_panel()

/datum/isrg_k9_voice_panel
	COOLDOWN_DECLARE(panel_emote_cooldown)

/datum/isrg_k9_voice_panel/proc/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Emotes", "ISRG K9 Voice Synthesizer")
		ui.open()

/datum/isrg_k9_voice_panel/ui_state(mob/user)
	return GLOB.conscious_state

/datum/isrg_k9_voice_panel/ui_data(mob/user)
	return list("on_cooldown" = !COOLDOWN_FINISHED(src, panel_emote_cooldown))

/datum/isrg_k9_voice_panel/ui_static_data(mob/user)
	var/list/data = list(
		"theme" = "crtgreen",
		"categories" = list(),
		"emotes" = list(),
	)

	for(var/datum/emote/living/carbon/human/synthetic/isrg_k9/emote as anything in subtypesof(/datum/emote/living/carbon/human/synthetic/isrg_k9))
		if(!initial(emote.key) || !initial(emote.category) || !initial(emote.message))
			continue
		data["categories"] |= initial(emote.category)
		data["emotes"] += list(list(
			"id" = initial(emote.key),
			"text" = (initial(emote.override_say) || initial(emote.message)),
			"category" = initial(emote.category),
			"path" = "[emote]",
		))

	return data

/datum/isrg_k9_voice_panel/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(. || action != "emote" || !params["emotePath"])
		return

	var/datum/emote/living/carbon/human/synthetic/isrg_k9/emote_path = text2path(params["emotePath"])
	if(!emote_path || !COOLDOWN_FINISHED(src, panel_emote_cooldown))
		return
	if(!(emote_path in subtypesof(/datum/emote/living/carbon/human/synthetic/isrg_k9)))
		return

	COOLDOWN_START(src, panel_emote_cooldown, 2.5 SECONDS)
	usr.emote(initial(emote_path.key))
	return TRUE

/datum/emote/living/carbon/human/synthetic/isrg_k9
	species_type_allowed_typecache = list(/datum/species/synthetic/synth_k9/isrg)
	keybind_category = CATEGORY_SYNTH_EMOTE
	volume = 75
	var/category = ""
	var/override_say = ""

/datum/emote/living/carbon/human/synthetic/isrg_k9/status/bark
	key = "isrgk9bark"
	category = "Status"
	message = "лает."
	override_say = "Лай"
	sound = 'modular/lv733/sound/voice/isrg_k9/bark.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/isrg_k9/status/bark2
	key = "isrgk9bark2"
	category = "Status"
	message = "лает."
	override_say = "Двойной Лай"
	sound = 'modular/lv733/sound/voice/isrg_k9/wbark.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/isrg_k9/status/growl1
	key = "isrgk9growl1"
	category = "Status"
	message = "рычит."
	override_say = "Рычание 1"
	sound = 'modular/lv733/sound/voice/isrg_k9/growl1.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/isrg_k9/status/growl2
	key = "isrgk9growl2"
	category = "Status"
	message = "рычит."
	override_say = "Рычание 2"
	sound = 'modular/lv733/sound/voice/isrg_k9/growl2.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

/datum/emote/living/carbon/human/synthetic/isrg_k9/status/growl3
	key = "isrgk9growl3"
	category = "Status"
	message = "рычит."
	override_say = "Рычание 3"
	sound = 'modular/lv733/sound/voice/isrg_k9/growl3.ogg'
	emote_type = EMOTE_AUDIBLE|EMOTE_VISIBLE

#undef ISRG_K9_PULL_SPEED
