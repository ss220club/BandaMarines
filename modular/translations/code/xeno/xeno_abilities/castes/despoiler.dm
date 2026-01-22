/datum/action/xeno_action/activable/tail_stab/despoiler

/datum/action/xeno_action/activable/tail_stab/despoiler/apply_replaces_in_desc()
	. = ..()
	desc += " <br><br>Также наносит %DAMAGE_PER_TIER% урона ожогами за уровень кислоты с пробитием брони %ARMOR_PIERCE_PER_TIER% за уровень кислоты."
	replace_in_desc("%DAMAGE_PER_TIER%", 15)
	replace_in_desc("%ARMOR_PIERCE_PER_TIER%", 15)

// Handled in basic acid
/datum/action/xeno_action/activable/corrosive_acid/strong

// Handled in ammo description
/datum/action/xeno_action/activable/xeno_spit/despoiler

/datum/action/xeno_action/onclick/corrosive_slash
	desc = "Cледующие %TIME% удары будут быстрее и смогут усиливать кислоту на целях до третьего уровня."

/datum/action/xeno_action/onclick/corrosive_slash/apply_replaces_in_desc()
	replace_in_desc("%TIME%", buff_duration / 10, DESCRIPTION_REPLACEMENT_TIME)

/datum/action/xeno_action/onclick/decomposing_enzymes
	desc = "Создаёт вокруг вас газ, который снимает %CHEM% ед. химикатов в сек. и улучшает кислоту на целях до второго уровня. \
		Существует %TIME%"

/datum/action/xeno_action/onclick/decomposing_enzymes/apply_replaces_in_desc()
	replace_in_desc("%TIME%", /obj/effect/particle_effect/smoke/decomposing_enzymes::time_to_live, DESCRIPTION_REPLACEMENT_TIME)
	replace_in_desc("%CHEM%", /obj/effect/particle_effect/smoke/decomposing_enzymes::remove_chem)
