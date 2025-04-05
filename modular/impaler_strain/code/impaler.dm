/datum/xeno_strain/impaler
	name = BURROWER_IMPALER
	description = "You mutate your ability to burrow to only work on weeds which allows you to use your tail to attack them from below. You can also fortify on weeds to increase your range, vision, and damage on abilities."
	flavor_description = "Watch them flee, as even the ground has rebelled against their forces."
	icon_state_prefix = "Impaler"

	actions_to_remove = list(
		/datum/action/xeno_action/onclick/build_tunnel,
		/datum/action/xeno_action/activable/burrow,
		/datum/action/xeno_action/onclick/tremor,
		/datum/action/xeno_action/activable/corrosive_acid,
		/datum/action/xeno_action/activable/place_construction,
		/datum/action/xeno_action/onclick/plant_weeds,
		/datum/action/xeno_action/onclick/place_trap,
	)
	actions_to_add = list(
		/datum/action/xeno_action/activable/burrowed_spikes,
		/datum/action/xeno_action/activable/sunken_tail,
		/datum/action/xeno_action/onclick/burrow,
		/datum/action/xeno_action/onclick/ensconce,
	)

	behavior_delegate_type = /datum/behavior_delegate/burrower_impaler

/datum/xeno_strain/impaler/apply_strain(mob/living/carbon/xenomorph/burrower/burrower)
	burrower.acid_level = 0

	burrower.recalculate_everything()


/datum/behavior_delegate/burrower_impaler
	name = "Impaler Burrower Behavior Delegate"

/datum/behavior_delegate/burrower_impaler/on_update_icons()
	if(bound_xeno.stat == DEAD)
		return

	if(HAS_TRAIT(bound_xeno, TRAIT_ABILITY_BURROWED))
		bound_xeno.icon_state = "Impaler Burrower Burrowed"
		return TRUE

	if(bound_xeno.fortify)
		bound_xeno.icon_state = "Impaler Burrower Fortify"
		return TRUE
