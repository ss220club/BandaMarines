/obj/item/device/flashlight/flare/chem
    name = "chemical lightstick"
    desc = "A disposable chemical light. Bend it to activate."
    icon = 'icons/obj/items/lighting.dmi'
    icon_state = "chem"
    item_state = "chem"
    w_class = SIZE_SMALL

    light_power = 1.5
    light_range = 5

    raillight_compatible = FALSE
    can_be_broken = FALSE
    rotation_on_throw = TRUE

    var/burnt_out = FALSE
    var/fuel = 30 MINUTES
    var/fuel_rate = AMOUNT_PER_TIME(1 SECONDS, 1 SECONDS)

    var/show_flame = FALSE


/obj/item/device/flashlight/flare/chem/Initialize()
    . = ..()
    set_light_color(light_color)


/obj/item/device/flashlight/flare/chem/update_icon()
    . = ..()
    if(on)
        icon_state = "[initial(icon_state)]-on"
    else if(burnt_out)
        icon_state = "[initial(icon_state)]-empty"
    else
        icon_state = initial(icon_state)


/obj/item/device/flashlight/flare/chem/process(delta_time)
    fuel -= fuel_rate * delta_time

    flare_burn_down()

    if(fuel <= 0 || !on)
        burn_out()


/obj/item/device/flashlight/flare/chem/proc/flare_burn_down()
    switch(fuel)

        if(25 MINUTES to 30 MINUTES)
            set_light_range(5)
            set_light_power(1.5)

        if(20 MINUTES to 24.99 MINUTES)
            set_light_range(4)
            set_light_power(1.4)

        if(15 MINUTES to 19.99 MINUTES)
            set_light_range(4)
            set_light_power(1.2)

        if(10 MINUTES to 14.99 MINUTES)
            set_light_range(3)
            set_light_power(1.0)

        if(5 MINUTES to 9.99 MINUTES)
            set_light_range(2)
            set_light_power(0.8)

        if(2 MINUTES to 4.99 MINUTES)
            set_light_range(1)
            set_light_power(0.6)

        if(0 MINUTES to 1.99 MINUTES)
            set_light_range(1)
            set_light_power(0.3)


/obj/item/device/flashlight/flare/chem/proc/turn_on()
    on = TRUE
    set_light_on(TRUE)
    set_light_range(light_range)
    update_icon()
    START_PROCESSING(SSobj, src)


/obj/item/device/flashlight/flare/chem/proc/burn_out()
    on = FALSE
    set_light_on(FALSE)
    fuel = 0
    burnt_out = TRUE
    update_icon()
    STOP_PROCESSING(SSobj, src)


/obj/item/device/flashlight/flare/chem/attack_self(mob/living/user)
    if(burnt_out)
        to_chat(user, SPAN_NOTICE("It's already spent."))
        return FALSE

    if(on)
        to_chat(user, SPAN_NOTICE("It's already active."))
        return FALSE

    user.visible_message(
        SPAN_NOTICE("[capitalize(user.declent_ru(NOMINATIVE))] bends [src], activating it."),
        SPAN_NOTICE("You bend [src], and it starts glowing!")
    )

    turn_on()
    return TRUE

    /obj/item/device/flashlight/flare/chem/green
        name = "green lightstick"
        icon_state = "chem_green"
        light_color = "#00ff00"

    /obj/item/device/flashlight/flare/chem/red
        name = "red lightstick"
        icon_state = "chem_red"
        light_color = "#ff0000"

    /obj/item/device/flashlight/flare/chem/blue
        name = "blue lightstick"
        icon_state = "chem_blue"
        light_color = "#3399ff"

    /obj/item/device/flashlight/flare/chem/white
        name = "white lightstick"
        icon_state = "chem_white"
        light_color = "#ffffff"
