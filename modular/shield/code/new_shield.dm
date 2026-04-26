#define SHIELD_CHANCE_MAX 100

/mob
	var/knockback_resistance = 1

/mob/living/proc/get_shield_armor_bonus()
	var/obj/item/weapon/shield/S = get_readied_shield()
	if(!S)
		return 0

	if(S.shield_readied)
		return 85

	return 60

/mob/living/carbon/human/getarmor_organ(obj/limb/E, type)
	var/armor = ..()

	if(type == ARMOR_BOMB)
		armor += get_shield_armor_bonus()

	return armor

/obj/item/weapon/shield/riot
	var/skilllock = SKILL_POLICE_SKILLED
	icon_state = "ballisticshield"
	item_state = "ballisticshield"
	base_icon_state = "ballisticshield"
	passive_block = 80
	passive_projectile_mult = PROJECTILE_BLOCK_PERC_80
	readied_block = SHIELD_CHANCE_MAX
	readied_projectile_mult = PROJECTILE_BLOCK_PERC_100

/obj/item/weapon/shield/riot/raise_shield(mob/user)
	if(skilllock && !skillcheck(user, SKILL_POLICE, skilllock))
		to_chat(user, SPAN_WARNING("Похоже, вы не знаете, как правильно использовать [src]..."))
		return

	..()

	if(ismob(user))
		user.knockback_resistance = 0.3


/obj/item/weapon/shield/riot/lower_shield(mob/user)
	if(ismob(user))
		user.knockback_resistance = 1

	..()

/obj/item/weapon/shield/riot/dropped(mob/user)
	..()
	if(ismob(user))
		user.knockback_resistance = 1

/obj/item/weapon/shield/riot/Destroy()
	var/mob/M = loc
	if(ismob(M))
		M.knockback_resistance = 1
	return ..()

/mob/living/carbon/explosion_throw(severity, direction)
	var/mod_severity = severity

	if(knockback_resistance != 1)
		mod_severity *= knockback_resistance

	return ..(mod_severity, direction)

/mob/living/carbon/human/pull_response(mob/puller)
	if(get_readied_shield())
		playsound(loc, 'sound/items/block_shield.ogg', 25, TRUE)
		visible_message(SPAN_WARNING("[src] отбивает попытку захвата своим щитом!"))
		puller.apply_effect(1, WEAKEN)
		return FALSE

	return TRUE

/mob/living/proc/get_readied_shield()
	var/obj/item/weapon/shield/S

	S = l_hand
	if(istype(S) && S.shield_readied)
		return S

	S = r_hand
	if(istype(S) && S.shield_readied)
		return S

	return null

/obj/item/weapon/shield/riot/yautja/bracer_shield
	passive_projectile_mult = PROJECTILE_BLOCK_PERC_40
	readied_projectile_mult = PROJECTILE_BLOCK_PERC_60