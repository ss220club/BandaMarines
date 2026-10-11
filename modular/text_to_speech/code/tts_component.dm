/datum/component/tts_component
	var/datum/tts_seed/tts_seed = null
	var/list/effects = list()

/datum/component/tts_component/RegisterWithParent()
	RegisterSignal(parent, COMSIG_ATOM_TTS_SEED_CHANGE, PROC_REF(tts_seed_change))
	RegisterSignal(parent, COMSIG_ATOM_TTS_CAST, PROC_REF(cast_tts))
	if(ismob(parent))
		RegisterSignal(parent, COMSIG_MOB_EQUIPPED_ITEM, PROC_REF(on_item_equip))

/datum/component/tts_component/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_ATOM_TTS_SEED_CHANGE)
	UnregisterSignal(parent, COMSIG_ATOM_TTS_CAST)
	if(ismob(parent))
		UnregisterSignal(parent, COMSIG_MOB_EQUIPPED_ITEM)

/datum/component/tts_component/Initialize(datum/tts_seed/new_tts_seed, list/effects)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	if(ispath(new_tts_seed) && SStts220.tts_seeds[initial(new_tts_seed.name)])
		new_tts_seed = SStts220.tts_seeds[initial(new_tts_seed.name)]
	if(istype(new_tts_seed))
		tts_seed = new_tts_seed
	if(!tts_seed)
		tts_seed = get_random_tts_seed_by_gender()
	if(!tts_seed) // Something went terribly wrong
		return COMPONENT_INCOMPATIBLE
	if(length(effects))
		src.effects |= effects
	if(ismovable(parent))
		var/atom/movable/parent_movable = parent
		if(parent_movable.voice_effect)
			src.effects |= parent_movable.voice_effect

/datum/component/tts_component/proc/return_tts_seed()
	SIGNAL_HANDLER
	return tts_seed

/datum/component/tts_component/proc/select_tts_seed(mob/chooser, silent_target = FALSE, overrides, list/new_sound_effects)
	if(!chooser)
		if(ismob(parent))
			chooser = parent
		else
			return null

	var/atom/being_changed = parent
	var/static/tts_test_str = "Так звучит мой голос."
	var/datum/tts_seed/new_tts_seed

	if(chooser == being_changed)
		var/datum/preferences/prefs = chooser.client.prefs
		var/prefs_tts_seed = prefs?.tts_seed
		if(being_changed.gender == prefs?.gender)
			if(tgui_alert(chooser, "Оставляем голос вашего персонажа [prefs?.real_name] - [prefs_tts_seed]?", "Выбор голоса", list("Нет", "Да")) == "Да")
				if(!SStts220.tts_seeds[prefs_tts_seed])
					to_chat(chooser, span_warning("Отсутствует tts_seed для значения \"[prefs_tts_seed]\". Текущий голос - [tts_seed]"))
					return null
				new_tts_seed = SStts220.tts_seeds[prefs_tts_seed]
				if(length(new_sound_effects))
					effects = new_sound_effects
				INVOKE_ASYNC(SStts220, TYPE_PROC_REF(/datum/controller/subsystem/tts220, get_tts), null, chooser, tts_test_str, new_tts_seed, FALSE, get_effects())
				return new_tts_seed

	var/list/tts_seeds = list()
	// Check gender restrictions
	if(check_rights(R_ADMIN, FALSE, chooser) || overrides & TTS_OVERRIDE_GENDER || !ismob(being_changed))
		tts_seeds |= SStts220.get_tts_by_gender(MALE)
		tts_seeds |= SStts220.get_tts_by_gender(FEMALE)
		tts_seeds |= SStts220.get_tts_by_gender(NEUTER)
		tts_seeds |= SStts220.get_tts_by_gender(PLURAL)
	else
		tts_seeds |= SStts220.get_tts_by_gender(being_changed.gender)
		tts_seeds |= SStts220.get_tts_by_gender(NEUTER)
	// Check donation restrictions
	if(!check_rights(R_ADMIN, FALSE, chooser) && !(overrides & TTS_OVERRIDE_TIER))
		tts_seeds = tts_seeds && SStts220.get_available_seeds(being_changed) // && for lists means intersection
	if(!length(tts_seeds))
		to_chat(chooser, span_warning("Не удалось найти голоса для пола! Текущий голос - [tts_seed.name]"))
		return null

	var/list/tts_seeds_assoc = list()
	for(var/seed_key in tts_seeds)
		tts_seeds_assoc["[seed_key]"] = "[seed_key]"

	var/new_tts_seed_key
	new_tts_seed_key = tgui_input_list(chooser, "Выберите голос персонажа", "Преобразуем голос", tts_seeds_assoc, default = tts_seed.name, associative_list = TRUE)
	if(!new_tts_seed_key || !SStts220.tts_seeds[new_tts_seed_key])
		to_chat(chooser, span_warning("Что-то пошло не так с выбором голоса. Текущий голос - [tts_seed.name]"))
		return null

	new_tts_seed = SStts220.tts_seeds[new_tts_seed_key]
	if(length(new_sound_effects))
		effects = new_sound_effects

	if(!silent_target && being_changed != chooser && ismob(being_changed))
		SStts220.get_tts(
			listener = being_changed,
			message = tts_test_str,
			tts_seed = new_tts_seed,
			is_local = FALSE,
			effect_types = get_effects()
		)

	if(chooser)
		SStts220.get_tts(
			listener = chooser,
			message = tts_test_str,
			tts_seed = new_tts_seed,
			is_local = FALSE,
			effect_types = get_effects()
		)

	return new_tts_seed

/datum/component/tts_component/proc/tts_seed_change(atom/being_changed, mob/chooser, overrides, list/new_sound_effects)
	set waitfor = FALSE
	var/datum/tts_seed/new_tts_seed = select_tts_seed(chooser = chooser, overrides = overrides, new_sound_effects = new_sound_effects)
	if(!new_tts_seed)
		return null
	tts_seed = new_tts_seed

/datum/component/tts_component/proc/get_random_tts_seed_by_gender()
	var/atom/being_changed = parent
	var/tts_choice = SStts220.pick_tts_seed_by_gender(being_changed.gender)
	var/datum/tts_seed/seed = SStts220.tts_seeds[tts_choice]
	if(!seed)
		return null
	return seed

/datum/component/tts_component/proc/get_effects(list/additional_effects)
	var/list/resulting_effects = effects.Copy()
	if(length(additional_effects))
		resulting_effects |= additional_effects
	if(length(resulting_effects))
		resulting_effects = sort_effects(resulting_effects)

	return resulting_effects

/datum/component/tts_component/proc/sort_effects(list/effects_to_sort)
	if(!length(effects_to_sort))
		return list()
	return sort_list(effects_to_sort, GLOBAL_PROC_REF(cmp_sound_effect_priority_asc))

/proc/cmp_sound_effect_priority_asc(datum/singleton/sound_effect/A, datum/singleton/sound_effect/B)
	return A::priority - B::priority

/datum/component/tts_component/proc/cast_tts(
	atom/speaker,
	mob/listener,
	message,
	atom/location,
	is_local = TRUE,
	is_radio = FALSE,
	list/additional_effects = list(),
	traits = TTS_TRAIT_RATE_FASTER,
	preSFX,
	postSFX,
	tts_seed_override,
	tts_channel_override,
	check_deafness = TRUE
)

	SIGNAL_HANDLER

	if(!message)
		return
	if(check_deafness && listener.ear_deaf)
		return
	if(!speaker)
		speaker = parent
	if(!location)
		location = parent
	if(is_radio)
		additional_effects |= /datum/singleton/sound_effect/radio
		is_local = FALSE
		if(isnull(tts_channel_override))
			tts_channel_override = CHANNEL_TTS_RADIO

	var/list/tts_args = list()
	tts_args[TTS_CAST_SPEAKER] = speaker
	tts_args[TTS_CAST_LISTENER] = listener
	tts_args[TTS_CAST_MESSAGE] = message
	tts_args[TTS_CAST_LOCATION] = location
	tts_args[TTS_CAST_LOCAL] = is_local
	tts_args[TTS_CAST_EFFECTS] = get_effects(additional_effects)
	tts_args[TTS_CAST_TRAITS] = traits
	tts_args[TTS_CAST_PRE_SFX] = preSFX
	tts_args[TTS_CAST_POST_SFX] = postSFX
	tts_args[TTS_CAST_SEED] = tts_seed_override || tts_seed
	tts_args[TTS_PRIORITY] = TTS_PRIORITY_VOICE
	tts_args[TTS_CHANNEL_OVERRIDE] = tts_channel_override
	finalize_tts(tts_args)

/datum/component/tts_component/proc/finalize_tts(list/tts_args)
	. = tts_args

	SEND_SIGNAL(parent, COMSIG_TTS_COMPONENT_PRE_CAST_TTS, .)
	if(!.[TTS_CAST_SEED])
		return

	SStts220.get_tts(
		.[TTS_CAST_LOCATION],
		.[TTS_CAST_LISTENER],
		.[TTS_CAST_MESSAGE],
		.[TTS_CAST_SEED],
		.[TTS_CAST_LOCAL],
		.[TTS_CAST_EFFECTS],
		.[TTS_CAST_TRAITS],
		.[TTS_CAST_PRE_SFX],
		.[TTS_CAST_POST_SFX],
		.[TTS_CHANNEL_OVERRIDE]
	)

/datum/component/tts_component/proc/tts_effects_add(list/new_sound_effects)
	if(!length(new_sound_effects))
		return

	effects |= new_sound_effects
	effects = sort_effects(effects)

/datum/component/tts_component/proc/tts_effects_remove(list/sound_effects_to_remove)
	if(!length(sound_effects_to_remove))
		return

	effects -= sound_effects_to_remove
	effects = sort_effects(effects)

/datum/component/tts_component/proc/on_item_equip(mob/user, obj/item/equipped_item, slot)
	SIGNAL_HANDLER
	if(!equipped_item.voice_effect)
		return
	if(!(slotdefine2slotbit(slot) & equipped_item.flags_equip_slot))
		return
	if(equipped_item.should_apply_voice_effect())
		tts_effects_add(equipped_item.voice_effect)
	RegisterSignal(equipped_item, COMSIG_ITEM_UNEQUIPPED, PROC_REF(on_item_unequip))
	RegisterSignal(equipped_item, COMSIG_MOVABLE_UPDATE_VOICE_EFFECT, PROC_REF(on_item_update_voice_effect))

// Item got removed from us
/datum/component/tts_component/proc/on_item_unequip(obj/item/item_dropping, mob/user, slot)
	SIGNAL_HANDLER
	tts_effects_remove(item_dropping.voice_effect)
	UnregisterSignal(item_dropping, COMSIG_ITEM_UNEQUIPPED)
	UnregisterSignal(item_dropping, COMSIG_MOVABLE_UPDATE_VOICE_EFFECT)

/datum/component/tts_component/proc/on_item_update_voice_effect(obj/item/item_affecting, should_apply)
	SIGNAL_HANDLER
	if(should_apply)
		tts_effects_add(item_affecting.voice_effect)
	else
		tts_effects_remove(item_affecting.voice_effect)

/* Commented for future use if we decide to add "tongues"
/datum/component/tts_component/proc/on_organ_gain(mob/living/carbon/user, obj/item/organ/organ_gained, special)
	SIGNAL_HANDLER
	if(organ_gained.voice_effect)
		user.voice_effect = organ_gained.voice_effect
		tts_effects_add(organ_gained.voice_effect)

/datum/component/tts_component/proc/on_organ_lose(mob/living/carbon/user, obj/item/organ/organ_lost, special)
	SIGNAL_HANDLER
	if(organ_lost.voice_effect)
		user.voice_effect = user::voice_effect
		tts_effects_remove(organ_lost.voice_effect)
*/

// Component usage
