/// Availability for this server run. Configuration reloads must not change vendor indices.
GLOBAL_VAR_INIT(m83a2c_rpg_enabled, FALSE)

/datum/modpack/weapons
	name = "weapons modpack"
	desc = "Дополнительное вооружение"
	author = "phantomru"

/datum/modpack/weapons/pre_initialize()
	. = ..()
	GLOB.m83a2c_rpg_enabled = CONFIG_GET(flag/enable_m83a2c_rpg)
	var/datum/supply_packs/rpg_crate = GLOB.supply_packs_datums[/datum/supply_packs/rockets_launchers_common]
	rpg_crate.buyable = GLOB.m83a2c_rpg_enabled

	if(!GLOB.m83a2c_rpg_enabled)
		for(var/list/products as anything in list(GLOB.cm_vending_gear_tl, GLOB.cm_vending_gear_engi))
			for(var/index in 1 to length(products))
				var/list/product = products[index]
				if(product[3] == /obj/item/prop/folded_anti_tank_sadar/common)
					products.Cut(index, index + 1)
					break

/datum/modpack/weapons/initialize()
	. = ..()

/datum/modpack/weapons/post_initialize()
	. = ..()
