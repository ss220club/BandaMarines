/obj/item/pamphlet/skill/vc/low
	trait = /datum/character_trait/skills/vc/low

/datum/character_trait/skills/vc/low
	trait_name = "Vehicle Bike Training"
	trait_desc = "Boosts the engineering and vehicle operation skills to 2. Crewmember received full vehicle crewman training."
	skill = SKILL_VEHICLE
	secondary_skill = SKILL_ENGINEER
	skill_increment = 1

// Внимание!
// Если добавляешь MULTIVEHICLE, то добавляй их в GLOB.all_multi_vehicles
// Чтобы они отслеживались в get_multi_vehicles()
/proc/get_spec_vehicles()
	var/list/spec_vehicles = GLOB.all_spec_vehicles.Copy()
	var/list/names = list()
	var/list/namecounts = list()
	var/list/vehicles = list()
	for(var/obj/vehicle/SV in spec_vehicles)
		var/name = SV.name
		if(name in names)
			namecounts[name]++
			name = "[name] #([namecounts[name]])"
		else
			names.Add(name)
			namecounts[name] = 1
		vehicles[name] = SV

	return vehicles

