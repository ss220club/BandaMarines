/area/interior/vehicle/humvee
	name = "\improper vehicle interior"
	icon_state = "apc"

/area/interior/vehicle/humvee/medical
	name = "\improper vehicle interior"
	icon_state = "apc"

/area/interior/vehicle/humvee/transport
	name = "\improper vehicle interior"
	icon_state = "apc"

/area/interior/vehicle/van/uscm
	name = "\improper vehicle interior"
	icon_state = "van"

/area/interior/vehicle/van/uscm/med
	name = "\improper vehicle interior"
	icon_state = "van"

//Запрет на операции в траспорте
/area/interior/vehicle
    var/allow_surgery = FALSE 

/area/interior/vehicle/Initialize(mapload, ...)
    . = ..()
    for(var/turf/open/T in src)
        T.supports_surgery = allow_surgery

/area/interior/vehicle/humvee/medical
    allow_surgery = TRUE

/area/interior/vehicle/van/uscm/med
    allow_surgery = TRUE
