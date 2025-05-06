/datum/action/xeno_action/onclick/burrow
	name = "Burrow"
	action_icon_state = "agility_on"
	macro_path = /datum/action/xeno_action/verb/verb_burrow
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_3

/datum/action/xeno_action/onclick/burrow/use_ability(atom/atom)
	var/mob/living/carbon/xenomorph/xenomorph = owner

	if(SSticker?.mode?.hardcore)
		to_chat(xenomorph, SPAN_XENOWARNING("A certain presence is preventing us from burrowing here."))
		return

	if(HAS_TRAIT(xenomorph, TRAIT_ABILITY_BURROWED))
		if(do_after(xenomorph, 1.5 SECONDS, INTERRUPT_ALL | BEHAVIOR_IMMOBILE, BUSY_ICON_HOSTILE))
			xenomorph.burrow_off()
	else
		xenomorph.burrow()
	return ..()

/datum/action/xeno_action/activable/burrowed_spikes
	name = "Burrowed Spikes"
	icon_file = 'modular/impaler_strain/icons/actions_xeno.dmi'
	action_icon_state = "burrowed_spikes"
	macro_path = /datum/action/xeno_action/verb/verb_burrowed_spikes
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_1
	xeno_cooldown = 8 SECONDS
	plasma_cost = 50

	/// Ability stats config
	var/base_damage = 35
	var/chain_separation_delay = 0.2 SECONDS ///Delay between each tile hit
	var/max_distance = 4
	var/reinforced_range_bonus = 2
	var/reinforced_damage_bonus = 30

/datum/action/xeno_action/activable/sunken_tail
	name = "Sunken Tail"
	icon_file = 'modular/impaler_strain/icons/actions_xeno.dmi'
	action_icon_state = "sunken_tail"
	macro_path = /datum/action/xeno_action/verb/verb_sunken_tail
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_2
	xeno_cooldown = 13 SECONDS
	plasma_cost = 100

	/// Ability stats config
	var/base_damage = 60
	var/windup_delay = 0.8 SECONDS
	var/max_distance = 7
	var/reinforced_range_bonus = 2
	var/reinforced_damage_bonus = 30
	var/reinforced_spread_range = 2

/datum/action/xeno_action/onclick/ensconce
	name = "Ensconce"
	icon_file = 'modular/impaler_strain/icons/actions_xeno.dmi'
	action_icon_state = "ensconce"
	macro_path = /datum/action/xeno_action/verb/verb_ensconce
	action_type = XENO_ACTION_CLICK
	ability_primacy = XENO_PRIMARY_ACTION_4
	xeno_cooldown = 3 SECONDS
	plasma_cost = 0

	/// Ability stats config
	var/windup_delay = 1 SECONDS
	var/reinforced_vision_range = 10

	var/armor_deflection_buff = 25
	var/armor_explosive_buff = 50
