// CLF-WP - Colonial Liberation Front of WP (LV-733 survivor cell)
// FACTION_CLF_WY / MOB_HUD_FACTION_CLF_WY / CLF_WY_FREQ live in modular/clothing/code/defines_clf_wy.dm
// since modular/clothing is compiled before modular/lv733.

#define FACTION_LIST_SURVIVOR_CLF_WY list(FACTION_SURVIVOR, FACTION_CLF_WY, FACTION_CLF)

#define JOB_CLF_WY_CURATOR "CLF-WP Curator"
#define JOB_CLF_WY_LEADER "CLF-WP Leader"
#define JOB_CLF_WY_ENGI "CLF-WP Engineer"
#define JOB_CLF_WY_MEDIC "CLF-WP Medic"
#define JOB_CLF_WY_REBEL "CLF-WP Rebel"
#define JOB_CLF_WY_SYNTH "CLF-WP Synthetic"

#define PAY_SHORT_CLFWYE1 "CWYE1"
#define PAY_SHORT_CLFWYE2 "CWYE2"
#define PAY_SHORT_CLFWYO1 "CWYO1"
#define PAY_SHORT_CLFWYO2 "CWYO2"
#define PAY_SHORT_CLFWYS1 "CWYS1"

/// CLF-WP Rank and file

/datum/paygrade/clf_wy
	name = "CLF-WP"

/datum/paygrade/clf_wy/e1
	paygrade = PAY_SHORT_CLFWYE1
	name = "Повстанец"
	prefix = "Повст."

/datum/paygrade/clf_wy/e2
	paygrade = PAY_SHORT_CLFWYE2
	name = "Специалист Ячейки"
	prefix = "Спец."

/// CLF-WP Officers

/datum/paygrade/clf_wy/o1
	paygrade = PAY_SHORT_CLFWYO1
	name = "Лидер Ячейки"
	prefix = "Л-р."

/datum/paygrade/clf_wy/o2
	paygrade = PAY_SHORT_CLFWYO2
	name = "Куратор"
	prefix = "Кур."

/// CLF-WP Synthetic

/datum/paygrade/clf_wy/s1
	paygrade = PAY_SHORT_CLFWYS1
	name = "Синтетик"
	prefix = "Синт."
