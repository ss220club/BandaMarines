#define SPECIES_ISRG_SYNTH_K9 "ISRG Synthetic K9"

// Слабый укус против живых целей (mob-урон идёт через unarmed_attack.damage),
// но полноценный "нож" против построек ксено - см. on_unarmed_attack ниже.
/datum/unarmed_attack/bite/synthetic/isrg
	damage = 8

/datum/species/synthetic/synth_k9/isrg
	name = SPECIES_ISRG_SYNTH_K9
	icobase = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	deform = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	blood_mask = 'modular/lv733/icons/isrg_k9/isrg_k9.dmi'
	flags = IS_WHITELISTED|NO_BREATHE|NO_CLONE_LOSS|NO_POISON|IS_SYNTHETIC|NO_CHEM_METABOLIZATION|NO_NEURO|NO_OVERLAYS
	unarmed_type = /datum/unarmed_attack/bite/synthetic/isrg

/datum/species/synthetic/synth_k9/isrg/handle_post_spawn(mob/living/carbon/human/spawned_k9)
	. = ..()
	RegisterSignal(spawned_k9, COMSIG_HUMAN_EQUIPPED_ITEM, PROC_REF(on_equipped_item))
	RegisterSignal(spawned_k9, COMSIG_HUMAN_UNARMED_ATTACK, PROC_REF(on_unarmed_attack))
	RegisterSignal(spawned_k9, COMSIG_MOB_WEED_SLOWDOWN, PROC_REF(handle_weed_slowdown))

/datum/species/synthetic/synth_k9/isrg/post_species_loss(mob/living/carbon/human/H)
	. = ..()
	UnregisterSignal(H, list(COMSIG_HUMAN_EQUIPPED_ITEM, COMSIG_HUMAN_UNARMED_ATTACK, COMSIG_MOB_WEED_SLOWDOWN))

// Чуть быстрее по смоле/паутине ксено, чем обычный человек
/datum/species/synthetic/synth_k9/isrg/proc/handle_weed_slowdown(mob/user, list/slowdata)
	SIGNAL_HANDLER
	slowdata["movement_slowdown"] *= 0.7

/datum/species/synthetic/synth_k9/isrg/proc/on_equipped_item(mob/living/carbon/human/wearer, obj/item/equipped_item, slot)
	SIGNAL_HANDLER
	if(slot != WEAR_FEET)
		return
	to_chat(wearer, SPAN_WARNING("Лапам не подходит [equipped_item] - обувь тут же соскальзывает."))
	wearer.drop_inv_item_on_ground(equipped_item)

// Постройки ксено (в отличие от мобов) вообще не реагируют на голые руки/укус - attack_hand() у них
// либо no-op, либо "You scrape ineffectively". Поэтому для них отдельно дёргаем attackby() с временным
// штык-ножом - это переиспользует уже готовую и проверенную логику урона/разрушения каждой постройки,
// не трогая урон по живым целям (тот идёт через unarmed_attack.damage выше, отдельно).
/datum/species/synthetic/synth_k9/isrg/proc/on_unarmed_attack(mob/living/carbon/human/user, atom/target)
	SIGNAL_HANDLER
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
	var/obj/item/attachable/bayonet/rmc/phantom_knife = new(user)
	target.attackby(phantom_knife, user)
	qdel(phantom_knife)
