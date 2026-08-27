/obj/item/attachable/sling //Mostly cosmetic, some one-handed fire adjustments
	name = "two-point sling"
	desc = "A traditional strip of toughened nylon fabric with clips on either end for attaching to suitable mounting points on most longarms in the UA armed forces arsenals."
	icon = 'modular/weapons/icons/under.dmi'
	icon_state = "pve-sling"
	attach_icon = "pve-sling_a"
	slot = "rail"

/obj/item/attachable/sling/New()
	..()
	accuracy_unwielded_mod = -HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_2
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_2

/obj/item/attachable/attached_gun/grenade/m20a
	name = "\improper M20 integrated grenade launcher"
	desc = "Unorthodox design, this single-round grenade launchers was made specifically for use with Type 71 pulse rifles. It can be quickly connected to electronic firing mechanism of the rifle, albeit wiring is prone to failures."
//	icon = 'modular/weapons/icons/under.dmi'
	icon_state = "m20a"
	attach_icon = "m20a"
	current_rounds = 0
	max_rounds = 3
	max_range = 14
	attachment_firing_delay = 5
	pixel_shift_x = 20
	pixel_shift_y = 13

/obj/item/attachable/attached_gun/shotgun/m20a
	name = "\improper U3 underbarrel shotgun"
	desc = "An ARMAT U3 tactical shotgun. Integrated into the M20A Harrington rifle. Only capable of loading up to five buckshot shells."
	icon_state = "masterkey"
	attach_icon = "masterkey_a"
	flags_attach_features = ATTACH_ACTIVATION|ATTACH_PROJECTILE|ATTACH_RELOADABLE|ATTACH_WEAPON
	hidden = TRUE

/obj/item/attachable/attached_gun/shotgun/m20a/set_bullet_traits()
	return

/obj/item/attachable/attached_gun/shotgun/m20a/unloaded
	current_rounds = 0

/obj/item/attachable/stock/m20a
	name = "\improper M20A stock"
	desc = "The M20A's standard polymer collapsible stock. When extended, it improves scatter, accuracy, and recoil, but slightly hinders agility."
	icon = 'modular/weapons/icons/stock.dmi'
	slot = "stock"
	melee_mod = 5
	size_mod = 1
	icon_state = "m20astock"
	attach_icon = "m20astock_a"
	pixel_shift_x = 40
	pixel_shift_y = 14
	hud_offset_mod = 3

/obj/item/attachable/stock/m20a/New()
	..()

/obj/item/attachable/flashlight/m20a
	name = "integrated flashlight"
	desc = "shouldnt be seeing this. . ."
	icon = 'modular/weapons/icons/under.dmi'
	icon_state = "m20a_flashlight"
	slot = "special"
	attach_icon = "m20a_flashlight_a"
	original_state = "m20a_flashlight"
	original_attach = "m20a_flashlight_a"

/obj/item/attachable/m49a_barrel/pve
	icon = 'modular/weapons/icons/barrel.dmi'
	name = "M49A6 muzzle break"
	icon_state = "pve_m49a_barrel"
	attach_icon = "pve_m49a_barrel"

/obj/item/attachable/scope/variable_zoom/fal
	name = "ODS R94 telescopic variable scope"
	icon = 'modular/weapons/icons/scopes.dmi'
	icon_state = "sniperscope_fal"
	attach_icon = "sniperscope_fal"
	desc = "A Orion Defence Systems telescopic scope used mainly for the R81M1D. Can switch between 2x and 4x magnification."
	aim_speed_mod = 0

/obj/item/attachable/scope/mini/r81
	name = "ODS R92 2x advanced telescopic mini-scope"
	desc = "An Orion Defence Systems R81M1D 2x advanced telescopic mini-scope, used mainly for the R81M1A and it's variants."
	icon = 'modular/weapons/icons/scopes.dmi'
	icon_state = "miniscope_fal"
	attach_icon = "miniscope_fal"

/obj/item/attachable/bipod/r81
	name = "R81M1D bipod"
	desc = "An integral bipod for the R81M1D Pulse Squad Automatic Weapon."
	icon = 'modular/weapons/icons/under.dmi'
	icon_state = "bipod_fal_saw_a"
	attach_icon = "bipod_fal_saw_a"
	slot = "under"
	size_mod = 0
	melee_mod = 0
	flags_attach_features = ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle

/obj/item/attachable/bipod/r81/New()
	..()

	delay_mod = 0
	wield_delay_mod = WEAPON_DELAY_FAST
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_5
	scatter_mod = SCATTER_AMOUNT_TIER_9
	recoil_mod = -RECOIL_AMOUNT_TIER_2

/obj/item/attachable/stock/r81_saw
	name = "\improper R81M1D stock"
	desc = "You kinda need this to even use the gun properly."
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "fal_saw_stock"
	attach_icon = "fal_saw_stock"
	wield_delay_mod = WEAPON_DELAY_MIN
	flags_attach_features = NO_FLAGS
	hud_offset_mod = 3

/obj/item/attachable/stock/r81_saw/New()//no stats, its cosmetic
	..()

/obj/item/attachable/stock/r81_sniper
	name = "\improper R81M1B stock"
	desc = "You kinda need this to even use the gun properly."
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "fal_sniper_stock"
	attach_icon = "fal_sniper_stock"
	wield_delay_mod = WEAPON_DELAY_MIN
	flags_attach_features = NO_FLAGS
	hud_offset_mod = 3

/obj/item/attachable/stock/r81_sniper/New()
	..()

/obj/item/attachable/stock/isr
	name = "ISR stock"
	desc = "If you can read this, someone screwed up. Go Github this and bug a coder."
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "isr_stock"
	slot = "stock"
	wield_delay_mod = WEAPON_DELAY_NONE
	melee_mod = 5
	size_mod = 2
	pixel_shift_x = 21
	pixel_shift_y = 20
	hud_offset_mod = 2

//FN107
/obj/item/attachable/stock/fn107
	name = "FN107 Carbine Stock"
	desc = "This isn't supposed to be separated from the gun, how'd this happen?"
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "fn107_stock"
	attach_icon = "fn107_stock"
	slot = "stock"
	wield_delay_mod = WEAPON_DELAY_NONE
	flags_attach_features = NO_FLAGS
	melee_mod = 15
	size_mod = 0

//MASM
/obj/item/attachable/bipod/masm
	name = "MASM55 bipod"
	desc = "An integrated bipod for the MASM55 Medium Machinegun."
	icon = 'modular/weapons/icons/under.dmi'
	icon_state = "masm_bipod"
	attach_icon = "masm_bipod"
	slot = "under"
	size_mod = 0
	melee_mod = 0
	flags_attach_features = ATTACH_ACTIVATION
	attachment_action_type = /datum/action/item_action/toggle

/obj/item/attachable/bipod/masm/New()
	..()

	delay_mod = 0
	wield_delay_mod = WEAPON_DELAY_FAST
	accuracy_mod = -HIT_ACCURACY_MULT_TIER_5
	scatter_mod = SCATTER_AMOUNT_TIER_9

//FPSA
/obj/item/attachable/stock/fpsa
	name = "FPSA DMR Stock"
	desc = "This isn't supposed to be separated from the gun, how'd this happen?"
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "fpsa_stock"
	attach_icon = "fpsa_stock"
	slot = "stock"
	wield_delay_mod = WEAPON_DELAY_NONE
	flags_attach_features = NO_FLAGS
	melee_mod = 15
	size_mod = 0

//SSR
/obj/item/attachable/supsniperbarrel
	name = "suppressed sniper barrel"
	icon = 'modular/weapons/icons/barrel.dmi'
	icon_state = "supsniperbarrel"
	desc = "A heavy barrel. CANNOT BE REMOVED."
	slot = "muzzle"
	flags_attach_features = NO_FLAGS
	gun_traits = list(TRAIT_GUN_SILENCED)
	hud_offset_mod = -3

/obj/item/attachable/supsniperbarrel/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_3
	scatter_mod = -SCATTER_AMOUNT_TIER_8

//L64A3
/obj/item/attachable/scope/mini/rmcdmr
	name = "L5A2 SUMMR scope"
	icon_state = "sniperscope"
	attach_icon = "sniperscope_a"
	desc = "Sight Unit, Marine Marksman Rifle. A 4x power optic commonly fielded on the Royal Marines L64A3 DMRs."
	dynamic_aim_slowdown = SLOWDOWN_ADS_QUICK
	zoom_offset = 8
	zoom_viewsize = 9

/obj/item/attachable/stock/rmcdmr
	name = "L64A3 stock"
	desc = "The non-detachable stock of a L64A3 DMR."
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "rmcdmr_stock"
	pixel_shift_x = 40
	pixel_shift_y = 10
	flags_attach_features = NO_FLAGS
	hud_offset_mod = 6

/obj/item/attachable/stock/rmcdmr/New()
	..()
	accuracy_mod = 0
	recoil_mod = 0
	scatter_mod = 0
	movement_onehanded_acc_penalty_mod = 0
	accuracy_unwielded_mod = 0
	recoil_unwielded_mod = 0
	scatter_unwielded_mod = 0
	aim_speed_mod = 0
	wield_delay_mod = WEAPON_DELAY_NONE

//P79s
/obj/item/attachable/stock/p79s
	name = "\improper P79S stock"
	desc = "A stock made for the P79S semi-automatic shotgun."
	icon = 'modular/weapons/icons/stock.dmi'
	icon_state = "p79s_stock"
	hud_offset_mod = 6

/obj/item/attachable/stock/p79s/New()
	..()
	accuracy_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_mod = -RECOIL_AMOUNT_TIER_5
	scatter_mod = -SCATTER_AMOUNT_TIER_10
	movement_onehanded_acc_penalty_mod = -MOVEMENT_ACCURACY_PENALTY_MULT_TIER_5
	accuracy_unwielded_mod = HIT_ACCURACY_MULT_TIER_1
	recoil_unwielded_mod = -RECOIL_AMOUNT_TIER_5
	scatter_unwielded_mod = -SCATTER_AMOUNT_TIER_10

//Xm51
/obj/item/attachable/stock/xm51/military
	name = "\improper XM51 stock"
	icon = 'modular/weapons/icons/stock.dmi'
	desc = "A specialized stock designed for XM51 shotguns. Helps the user absorb the recoil of the weapon while also reducing scatter."
	icon_state = "xm51_military_stock"
	attach_icon = "xm51_military_stock_a"

//M38
/obj/item/attachable/stock/m60/m38
	name = "M38 stock"
	icon_state = "m38_stock"
	attach_icon = "m38_stock"

/obj/item/attachable/flashlight/tactical
	name = "tactical flashlight"
	desc = "Robust and handy tactical flashlight, produced by WiseFire Inc."
	icon_state = "flashlight_tactical"
	attach_icon = "flashlight_tactical_a"
	original_state = "flashlight_tactical"
	original_attach = "flashlight_tactical_a"

/obj/item/attachable/scope/mini/rmcgl
	name = "L164A3 collimator sight assembly"
	desc = "L164A3 sight system."
	zoom_offset = 3
	icon_state = "reflex"

/obj/item/attachable/scope/m79
	name = "M79 sight"
	desc = "You shouldn't be seeing this!"
	icon_state = "m79_sight"
	zoom_offset = 3
	zoom_viewsize = 7
	allows_movement = TRUE
	attach_icon = null
	hidden = TRUE
