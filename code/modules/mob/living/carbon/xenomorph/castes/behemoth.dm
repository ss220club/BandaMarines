/mob/living/carbon/xenomorph/behemoth

	caste_type = XENO_CASTE_BEHEMOTH
	name = XENO_CASTE_BEHEMOTH
	desc = "A beefy alien with an armored carapace."
	icon = 'icons/mob/xenos/castes/tier_2/behemoth.dmi'
	icon_size = 64
	icon_state = "Behemoth Running"
	plasma_types = list(PLASMA_CHITIN)
	pixel_x = -16
	old_x = -16
	tier = 2
	pull_speed = 2
	organ_value = 2000
	base_actions = list(
		/datum/action/xeno_action/onclick/xeno_resting,
		/datum/action/xeno_action/onclick/release_haul,
		/datum/action/xeno_action/watch_xeno,
		/datum/action/xeno_action/onclick/tacmap,
	)

	claw_type = CLAW_TYPE_SHARP

	icon_xeno = 'icons/mob/xenos/castes/tier_2/behemoth.dmi'
	icon_xenonid = 'icons/mob/xenonids/castes/tier_1/runner.dmi'

	weed_food_icon = 'icons/mob/xenos/weeds_64x64.dmi'
	weed_food_states = list("Warrior_1","Warrior_2","Warrior_3")
	weed_food_states_flipped = list("Warrior_1","Warrior_2","Warrior_3")

	skull = /obj/item/skull/runner
	pelt = /obj/item/pelt/runner

/datum/caste_datum/behemoth
	caste_type = XENO_CASTE_BEHEMOTH
	tier = 2
	display_name ="Behemoth"
	caste_desc = "Behemoths are known to like rocks. Perhaps we should give them one!"
	melee_damage_lower = XENO_DAMAGE_TIER_3
	melee_damage_upper = XENO_DAMAGE_TIER_3
	melee_vehicle_damage = XENO_DAMAGE_TIER_5
	max_health = XENO_HEALTH_TIER_7
	plasma_gain = XENO_PLASMA_GAIN_TIER_9
	plasma_max = XENO_PLASMA_TIER_5
	xeno_explosion_resistance = XENO_EXPLOSIVE_ARMOR_TIER_4
	armor_deflection = XENO_ARMOR_MOD_MED
	evasion = XENO_EVASION_NONE
	speed = XENO_SPEED_TIER_5


	evolves_to = list(XENO_CASTE_CRUSHER)
	deevolves_to = list(XENO_CASTE_RUNNER)
	caste_desc = "A powerful front line combatant."
	can_vent_crawl = 0

	tackle_min = 2
	tackle_max = 4

	heal_resting = 1.4

	minimum_evolve_time = 9 MINUTES

	minimap_icon = "runner"


