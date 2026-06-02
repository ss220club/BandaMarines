#define JOB_TWE_ROAF_LIEUTENANT "ROAF Lieutenant"
#define JOB_TWE_ROAF_SQUAD_LEADER "ROAF Squad Leader"
#define JOB_TWE_ROAF_OPERATOR "ROAF Operator"
#define JOB_TWE_ROAF_MEDIC "ROAF Medic"
#define JOB_TWE_ROAF_RIFLEMAN "ROAF Rifleman"
#define JOB_TWE_ROAF_PILOT "ROAF Pilot"
#define JOB_TWE_ROAF_ENGI "ROAF Engineer"
#define JOB_TWE_ROAF_SNIPER "ROAF Sniper"
#define JOB_TWE_ROAF_SYNTH "ROAF Synthetic"
#define JOB_TWE_ROAF_COMMANDER "ROAF Commander"

#define JOB_TWE_RAF_LIEUTENANT JOB_TWE_ROAF_LIEUTENANT
#define JOB_TWE_RAF_SQUAD_LEADER JOB_TWE_ROAF_SQUAD_LEADER
#define JOB_TWE_RAF_OPERATOR JOB_TWE_ROAF_OPERATOR
#define JOB_TWE_RAF_MEDIC JOB_TWE_ROAF_MEDIC
#define JOB_TWE_RAF_RIFLEMAN JOB_TWE_ROAF_RIFLEMAN
#define JOB_TWE_RAF_PILOT JOB_TWE_ROAF_PILOT
#define JOB_TWE_RAF_ENGI JOB_TWE_ROAF_ENGI
#define JOB_TWE_RAF_SNIPER JOB_TWE_ROAF_SNIPER
#define JOB_TWE_RAF_SYNTH JOB_TWE_ROAF_SYNTH

#define PROB_WEATHER_LV733 100

#define PAY_SHORT_ROAFE1 PAY_SHORT_IASFE1
#define PAY_SHORT_ROAFE2 PAY_SHORT_IASFE2
#define PAY_SHORT_ROAFE3 PAY_SHORT_IASFE3
#define PAY_SHORT_ROAFE4 PAY_SHORT_IASFE4
#define PAY_SHORT_ROAFE5 PAY_SHORT_IASFE5
#define PAY_SHORT_ROAFE6 PAY_SHORT_IASFE6
#define PAY_SHORT_ROAFE7 PAY_SHORT_IASFE7
#define PAY_SHORT_ROAFS1 PAY_SHORT_SYN
#define PAY_SHORT_ROAFO1 PAY_SHORT_IASFO1
#define PAY_SHORT_ROAFO2 PAY_SHORT_IASFO2
#define PAY_SHORT_ROAFO3 PAY_SHORT_IASFO3
#define PAY_SHORT_ROAFO4 PAY_SHORT_IASFO4
#define PAY_SHORT_ROAFO5 PAY_SHORT_IASFO5
#define PAY_SHORT_ROAFO6 PAY_SHORT_IASFO6
#define PAY_SHORT_ROAFO7 PAY_SHORT_IASFO7
#define PAY_SHORT_ROAFO8 PAY_SHORT_IASFO8
#define PAY_SHORT_ROAFO9 PAY_SHORT_IASFO9

/// ROAF Enlisted

/datum/paygrade/twe/roaf/e1
	paygrade = PAY_SHORT_ROAFE1
	name = "Aircraftman"
	prefix = "Acm."

/datum/paygrade/twe/roaf/e2
	paygrade = PAY_SHORT_ROAFE2
	name = "Aircraftman Second Class"
	prefix = "Acm2."
	pay_multiplier = 2.1

/datum/paygrade/twe/roaf/e3
	paygrade = PAY_SHORT_ROAFE3
	name = "Lance Corporal"
	prefix = "LCpl."
	pay_multiplier = 2.2

/datum/paygrade/twe/roaf/e4
	paygrade = PAY_SHORT_ROAFE4
	name = "Corporal"
	prefix = "Cpl."
	pay_multiplier = 2.3

/datum/paygrade/twe/roaf/e5
	paygrade = PAY_SHORT_ROAFE5
	name = "Sergeant"
	prefix = "Sgt."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/e6
	paygrade = PAY_SHORT_ROAFE6
	name = "Flight Sergeant"
	prefix = "FSgt."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/e7
	paygrade = PAY_SHORT_ROAFE7
	name = "Warrant Officer"
	prefix = "WO."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/s1
	paygrade = PAY_SHORT_ROAFS1
	name = "Flight Support Sergeant"
	prefix = "FlSSgt."
	pay_multiplier = 2.7
/// ROAF Officer

/datum/paygrade/twe/roaf/o1
	paygrade = PAY_SHORT_ROAFO1
	name = "Flying Officer"
	prefix = "Fg Off."

/datum/paygrade/twe/roaf/o2
	paygrade = PAY_SHORT_ROAFO2
	name = "Flight Lieutenant"
	prefix = "Flt Lt."
	pay_multiplier = 2.1

/datum/paygrade/twe/roaf/o3
	paygrade = PAY_SHORT_ROAFO3
	name = "Squadron Leader"
	prefix = "Sqn Ldr."
	pay_multiplier = 2.2

/datum/paygrade/twe/roaf/o4
	paygrade = PAY_SHORT_ROAFO4
	name = "Major"
	prefix = "Maj."
	pay_multiplier = 2.3

/datum/paygrade/twe/roaf/o5
	paygrade = PAY_SHORT_ROAFO5
	name = "Wing Commander"
	prefix = "Wg Cdr."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/o6
	paygrade = PAY_SHORT_ROAFO6
	name = "Group Captain"
	prefix = "Gp Capt."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/o7
	paygrade = PAY_SHORT_ROAFO7
	name = "Air Commodore"
	prefix = "Air Cdre."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/o8
	paygrade = PAY_SHORT_ROAFO8
	name = "Air Vice-Marshal"
	prefix = "AVM."
	pay_multiplier = 2.7

/datum/paygrade/twe/roaf/o9
	paygrade = PAY_SHORT_ROAFO9
	name = "Air Chief Marshal"
	prefix = "ACM."
	pay_multiplier = 2.7
