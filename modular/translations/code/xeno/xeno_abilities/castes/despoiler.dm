/datum/action/xeno_action/activable/tail_stab/despoiler

/datum/action/xeno_action/activable/tail_stab/despoiler/apply_replaces_in_desc()
	. = ..()
	desc += " <br><br>Также наносит %DAMAGE_PER_TIER% урона ожогами за уровень кислоты с пробитием брони %ARMOR_PIERCE_PER_TIER% за уровень кислоты."
	replace_in_desc("%DAMAGE_PER_TIER%", 15)
	replace_in_desc("%ARMOR_PIERCE_PER_TIER%", 15)

// Handled in basic acid
/datum/action/xeno_action/activable/corrosive_acid/strong
