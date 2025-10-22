// Military truck M35b — минимальный, наследует от van
/obj/vehicle/multitile/van/m35b
    name = "Военный грузовик M35b"
    desc = "Крепкий старый военный грузовик, вы знаете, что делать, вход сзади и сбоку."
    icon = 'icons/obj/vehicles/van.dmi'
    icon_state = "van_base"
    interior_map = /datum/map_template/interior/van

    vehicle_flags = VEHICLE_CLASS_WEAK
    passengers_slots = 8
    xenos_slots = 2

    move_max_momentum = 3
    move_turn_momentum_loss_factor = 1

    movement_sound = 'sound/vehicles/tank_driving.ogg'
    honk_sound = 'sound/vehicles/honk_2_truck.ogg'

    misc_multipliers = list(
        "move" = 0.5,
        "accuracy" = 1,
        "cooldown" = 1
    )

    hardpoints_allowed = list(
        /obj/item/hardpoint/locomotion/van_wheels,
    )

    overdrive_next = 0
    overdrive_cooldown = 15 SECONDS
    overdrive_duration = 4 SECONDS
    overdrive_speed_mult = 0.3

    // если нужно — переопределяем поведение инициализации
/obj/vehicle/multitile/van/m35b/Initialize()
        . = ..() // вызов родителя — всё остальное остаётся как у van
        // при необходимости можно добавить кастомную инициализацию здесь

// Spawner для M35b
/obj/effect/vehicle_spawner/m35b
    name = "M35b Spawner"
    icon = 'icons/obj/vehicles/van.dmi'
    icon_state = "van_base"
    pixel_x = -16
    pixel_y = -16

/obj/effect/vehicle_spawner/m35b/Initialize()
    . = ..()
    spawn_vehicle()
    qdel(src)

/obj/effect/vehicle_spawner/m35b/spawn_vehicle()
    var/obj/vehicle/multitile/van/m35b/TRUCK = new (loc)
    load_misc(TRUCK)
    TRUCK.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)
    handle_direction(TRUCK)
    TRUCK.update_icon()

/obj/effect/vehicle_spawner/m35b/load_hardpoints(obj/vehicle/multitile/van/V)
	V.add_hardpoint(new /obj/item/hardpoint/locomotion/van_wheels)
