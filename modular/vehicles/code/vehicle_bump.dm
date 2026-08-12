// Vehicle bump override
/turf/closed/wall/handle_vehicle_bump(obj/vehicle/multitile/V)
	if(!(turf_flags & TURF_HULL) && !(V.vehicle_flags & VEHICLE_CLASS_WEAK))
		var/damage_to_wall = V.wall_ram_damage
		var/obj/item/hardpoint/armor/snowplow/SP = locate() in V.hardpoints
		if(SP && SP.health > 0 && V.last_move_dir == V.dir) 
			damage_to_wall += SP.wall_ram_damage_bonus
			SP.take_damage(SP.wall_ram_self_damage)
		take_damage(damage_to_wall)
		V.take_damage_type(10, "blunt", src)
		playsound(V, 'sound/effects/metal_crash.ogg', 35)
		visible_message(SPAN_DANGER("[V] врезается в [src]!"))
	return FALSE

// Resin door bump
/obj/structure/mineral_door/resin/handle_vehicle_bump(obj/vehicle/multitile/V)
	if((density) && !(V.vehicle_flags & VEHICLE_CLASS_WEAK))
		take_damage(V.wall_ram_damage)
		V.take_damage_type(10, "blunt", src)
		playsound(V, 'sound/effects/metal_crash.ogg', 35)
		visible_message(SPAN_DANGER("[V] врезается в [src]!"))
		qdel(src)
	return FALSE
