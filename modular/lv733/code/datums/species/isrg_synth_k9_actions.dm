#define ISRG_K9_TAKEDOWN_DAMAGE 40
#define ISRG_K9_TAKEDOWN_STUN ((1.5 SECONDS) / GLOBAL_STATUS_MULTIPLIER)
#define ISRG_K9_TAKEDOWN_COOLDOWN 10 SECONDS
#define ISRG_K9_TAKEDOWN_ANIMATION_DURATION 4
#define ISRG_K9_POUNCE_DISTANCE 4
#define ISRG_K9_POUNCE_STUN ((1 SECONDS) / GLOBAL_STATUS_MULTIPLIER)
#define ISRG_K9_POUNCE_SELF_STUN ((1.5 SECONDS) / GLOBAL_STATUS_MULTIPLIER)
#define ISRG_K9_POUNCE_COOLDOWN 6 SECONDS

/// Shared targeted-action framework for the ISRG synthetic K9.
/datum/action/human_action/activable/isrg_k9
	icon_file = 'modular/lv733/icons/isrg_k9/isrg_k9_actions.dmi'
	var/ability_cooldown = 0

/datum/action/human_action/activable/isrg_k9/can_use_action()
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/carbon/human/k9 = owner
	return istype(k9?.species, /datum/species/synthetic/synth_k9/isrg)

/datum/action/human_action/activable/isrg_k9/proc/deselect_ability()
	var/mob/living/carbon/human/k9 = owner
	if(k9?.selected_ability != src)
		return
	k9.set_selected_ability(null)
	if(button)
		button.icon_state = "template"

/datum/action/human_action/activable/isrg_k9/proc/check_ready(mob/living/carbon/human/k9)
	if(!action_cooldown_check())
		to_chat(k9, SPAN_WARNING("Эта способность ещё восстанавливается."))
		return FALSE
	return can_use_action()

/datum/action/human_action/activable/isrg_k9/proc/add_combat_log(mob/living/carbon/human/k9, mob/living/target, action_name)
	k9.attack_log += "\[[time_stamp()]\] <font color='red'>Used [action_name] on [key_name(target)]</font>"
	target.attack_log += "\[[time_stamp()]\] <font color='orange'>Was hit by [key_name(k9)] with [action_name]</font>"

/// A 40-damage bite which only knocks down tier-one xenomorphs.
/datum/action/human_action/activable/isrg_k9/takedown
	name = "Повалить на землю"
	action_icon_state = "headbite"
	ability_cooldown = ISRG_K9_TAKEDOWN_COOLDOWN

/datum/action/human_action/activable/isrg_k9/takedown/use_ability(atom/target_atom)
	var/mob/living/carbon/human/k9 = owner
	if(!check_ready(k9))
		return FALSE
	if(!isliving(target_atom))
		to_chat(k9, SPAN_WARNING("Для сильного укуса нужна живая цель."))
		return FALSE

	var/mob/living/target = target_atom
	if(target == k9 || target.stat == DEAD)
		return FALSE
	if(target.z != k9.z || get_dist(k9, target) > 1)
		to_chat(k9, SPAN_WARNING("Цель слишком далеко."))
		return FALSE

	deselect_ability()
	enter_cooldown(ability_cooldown)
	playsound(k9, 'modular/sounds/sound/voice/isrg_k9/growl2.ogg', 75, FALSE)
	var/image/bite_overlay = image(
		"icon" = 'modular/lv733/icons/isrg_k9/attacks.dmi',
		"icon_state" = "bite",
		"layer" = 0,
	)
	bite_overlay.pixel_x = -target.pixel_x
	bite_overlay.pixel_y = -target.pixel_y
	bite_overlay.flick_overlay(target, ISRG_K9_TAKEDOWN_ANIMATION_DURATION)
	k9.animation_attack_on(target, pixel_offset = 16)
	target.last_damage_data = create_cause_data("K9 takedown", k9)
	target.apply_damage(ISRG_K9_TAKEDOWN_DAMAGE, BRUTE)
	add_combat_log(k9, target, "K9 takedown")
	log_attack("[key_name(k9)] used K9 takedown on [key_name(target)] at [get_area_name(k9)].")

	if(isxeno(target))
		var/mob/living/carbon/xenomorph/xeno_target = target
		if(isqueen(xeno_target) || xeno_target.tier > 1)
			k9.visible_message(
				SPAN_DANGER("[capitalize(k9.declent_ru(NOMINATIVE))] сильно кусает [target.declent_ru(ACCUSATIVE)], но не может повалить на землю!"),
				SPAN_WARNING("Цель слишком большая, чтобы ее повалить на землю!"),
				null,
				5,
			)
			return TRUE

	target.KnockDown(ISRG_K9_TAKEDOWN_STUN)
	target.Stun(ISRG_K9_TAKEDOWN_STUN)
	k9.visible_message(
		SPAN_DANGER("[capitalize(k9.declent_ru(NOMINATIVE))] сильно кусает [target.declent_ru(ACCUSATIVE)] и валит на землю!"),
		SPAN_DANGER("Вы повалили цель на землю сильным ударом"),
		null,
		5,
	)
	return TRUE

/// A short lurker-style leap. Colliding with a living target resolves the tier rules below.
/datum/action/human_action/activable/isrg_k9/pounce
	name = "Прыжок"
	action_icon_state = "pounce"
	ability_cooldown = ISRG_K9_POUNCE_COOLDOWN

/datum/action/human_action/activable/isrg_k9/pounce/use_ability(atom/target_atom)
	var/mob/living/carbon/human/k9 = owner
	if(!check_ready(k9))
		return FALSE
	if(!isturf(k9.loc))
		to_chat(k9, SPAN_WARNING("Отсюда нельзя прыгнуть."))
		return FALSE
	if(!target_atom || target_atom.layer >= FLY_LAYER)
		return FALSE

	var/turf/target_turf = get_turf(target_atom)
	if(!target_turf || target_turf.z != k9.z)
		to_chat(k9, SPAN_WARNING("Туда нельзя допрыгнуть."))
		return FALSE
	if(target_turf == k9.loc)
		return FALSE

	var/atom/jump_target = isliving(target_atom) ? target_atom : target_turf
	var/list/collision_callbacks = list(/mob/living = CALLBACK(src, PROC_REF(on_mob_collision)))

	deselect_ability()
	enter_cooldown(ability_cooldown)
	k9.face_dir(get_cardinal_dir(k9, jump_target))
	playsound(k9, 'modular/sounds/sound/voice/isrg_k9/growl3.ogg', 75, FALSE)
	RegisterSignal(k9, COMSIG_CLIENT_MOB_MOVE, PROC_REF(block_movement_during_jump))
	k9.throw_atom(
		jump_target,
		ISRG_K9_POUNCE_DISTANCE,
		SPEED_FAST,
		k9,
		launch_type = LOW_LAUNCH,
		pass_flags = PASS_OVER_THROW_MOB,
		collision_callbacks = collision_callbacks,
		tracking = TRUE,
	)
	UnregisterSignal(k9, COMSIG_CLIENT_MOB_MOVE)
	return TRUE

/datum/action/human_action/activable/isrg_k9/pounce/proc/block_movement_during_jump()
	SIGNAL_HANDLER
	return COMPONENT_OVERRIDE_MOVE

/datum/action/human_action/activable/isrg_k9/pounce/proc/on_mob_collision(mob/living/target)
	var/mob/living/carbon/human/k9 = owner
	if(!istype(k9) || !target || target == k9 || target.stat == DEAD)
		return

	if(isxeno(target))
		var/mob/living/carbon/xenomorph/xeno_target = target
		if(isqueen(xeno_target) || xeno_target.tier >= 3)
			k9.KnockDown(ISRG_K9_POUNCE_SELF_STUN)
			k9.Stun(ISRG_K9_POUNCE_SELF_STUN)
			playsound(k9, 'modular/sounds/sound/voice/isrg_k9/pounce_fail.ogg', 30, FALSE)
			k9.visible_message(
				SPAN_DANGER("[capitalize(k9.declent_ru(NOMINATIVE))] врезается в [target.declent_ru(ACCUSATIVE)] и теряет равновесие!"),
				SPAN_DANGER("Вы прыгнули в слишком огромную цель, из-за чего сильно ударились и потеряли равновесие"),
				null,
				5,
			)
			add_combat_log(k9, target, "K9 pounce")
			log_attack("[key_name(k9)] was stunned after K9 pouncing [key_name(target)] at [get_area_name(k9)].")
			return

	target.KnockDown(ISRG_K9_POUNCE_STUN)
	target.Stun(ISRG_K9_POUNCE_STUN)
	k9.visible_message(
		SPAN_DANGER("[capitalize(k9.declent_ru(NOMINATIVE))] прыгает на [target.declent_ru(ACCUSATIVE)] и валит на землю!"),
		SPAN_DANGER("Вы прыгнули на цель и повалили ее на землю"),
		null,
		5,
	)
	add_combat_log(k9, target, "K9 pounce")
	log_attack("[key_name(k9)] K9 pounced and stunned [key_name(target)] at [get_area_name(k9)].")

#undef ISRG_K9_TAKEDOWN_DAMAGE
#undef ISRG_K9_TAKEDOWN_STUN
#undef ISRG_K9_TAKEDOWN_COOLDOWN
#undef ISRG_K9_TAKEDOWN_ANIMATION_DURATION
#undef ISRG_K9_POUNCE_DISTANCE
#undef ISRG_K9_POUNCE_STUN
#undef ISRG_K9_POUNCE_SELF_STUN
#undef ISRG_K9_POUNCE_COOLDOWN
