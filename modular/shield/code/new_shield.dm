#define SHIELD_CHANCE_MAX 100

/mob
	var/knockback_resistance = 1

/mob/living/proc/get_shield_armor_bonus()
	var/obj/item/weapon/shield/S = get_readied_shield()
	if(S)
		return 80

	if(istype(l_hand, /obj/item/weapon/shield) || istype(r_hand, /obj/item/weapon/shield))
		return 65

	return 0

/mob/living/carbon/human/getarmor_organ(obj/limb/E, type)
	var/armor = ..()

	if(type == ARMOR_BOMB)
		armor = clamp(armor + get_shield_armor_bonus(), 0, 100)

	return armor

/obj/item/weapon/shield/riot/riot_mp
	name = "баллистический щит"
	desc = "Тяжёлый щит производимый Armat Battlefield Systems для проведения штурмовых операций."
	var/skilllock = SKILL_POLICE_SKILLED
	icon_state = "ballisticshield"
	item_state = "ballisticshield"
	base_icon_state = "ballisticshield"
	passive_block = 80
	passive_projectile_mult = PROJECTILE_BLOCK_PERC_80
	readied_block = SHIELD_CHANCE_MAX
	readied_projectile_mult = PROJECTILE_BLOCK_PERC_100
	COOLDOWN_DECLARE(attack_cooldown)
	readied_slowdown = 2
	var/cooldown_time = 25 SECONDS
	
/obj/item/weapon/shield/riot/riot_mp/Initialize()
	. = ..()
	AddElement(/datum/element/corp_label/armat)

/obj/item/weapon/shield/riot/riot_mp/raise_shield(mob/user)
	if(skilllock && !skillcheck(user, SKILL_POLICE, skilllock))
		to_chat(user, SPAN_WARNING("Похоже, вы не знаете, как правильно использовать [src]..."))
		return

	var/mob/living/L = user
	var/obj/item/weapon/shield/riot/riot_mp/other = L.get_readied_shield()

	if(other && other != src)
		to_chat(user, SPAN_WARNING("Вы уже держите поднятый щит в другой руке!"))
		return

	..()

	if(ismob(user))
		user.knockback_resistance = 0.3

/obj/item/weapon/shield/riot/riot_mp/lower_shield(mob/user)
	if(ismob(user))
		user.knockback_resistance = 1

	..()

/obj/item/weapon/shield/riot/riot_mp/dropped(mob/user)
	..()
	if(ismob(user))
		user.knockback_resistance = 1

/obj/item/weapon/shield/riot/riot_mp/Destroy()
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
	if(istype(puller, /mob/living/carbon/human) && get_readied_shield())
		playsound(loc, 'sound/items/block_shield.ogg', 25, TRUE)
		visible_message(SPAN_WARNING("[src] отбивает попытку захвата своим щитом!"))
		puller.apply_effect(1, WEAKEN)
		return FALSE

	return TRUE

/mob/living/proc/get_readied_shield()
	var/obj/item/weapon/shield/riot/riot_mp/S

	S = l_hand
	if(istype(S) && S.shield_readied)
		return S

	S = r_hand
	if(istype(S) && S.shield_readied)
		return S

	return null
	
/obj/item/weapon/shield/riot/riot_mp/attack(mob/living/target, mob/living/user)
	. = ..()
	if(. && (COOLDOWN_FINISHED(src, attack_cooldown)))
		COOLDOWN_START(src, attack_cooldown, cooldown_time)
		target.throw_atom(get_step(target, user.dir), 1, SPEED_AVERAGE, user, FALSE)
		target.apply_effect(3, DAZE)
		target.apply_effect(6, SLOW)

/obj/item/clothing/suit/armor/riot/marine
	allowed = list(/obj/item/weapon/gun, /obj/item/storage/backpack/general_belt, /obj/item/storage/belt/gun)