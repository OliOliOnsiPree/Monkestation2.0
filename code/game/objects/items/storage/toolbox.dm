/obj/item/storage/toolbox
	name = "toolbox"
	desc = "Danger. Very robust."
	icon = 'icons/obj/storage/toolbox.dmi'
	icon_state = "toolbox_default"
	inhand_icon_state = "toolbox_default"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	flags_1 = CONDUCT_1
	force = 12
	throwforce = 12
	throw_speed = 2
	throw_range = 7
	demolition_mod = 1.25
	w_class = WEIGHT_CLASS_BULKY
	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT*5)
	attack_verb_continuous = list("robusts")
	attack_verb_simple = list("robust")
	hitsound = 'sound/weapons/smash.ogg'
	drop_sound = 'sound/items/handling/toolbox_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbox_pickup.ogg'
	material_flags = MATERIAL_EFFECTS | MATERIAL_COLOR
	var/latches = "single_latch"
	var/has_latches = TRUE
	wound_bonus = 5

/obj/item/storage/toolbox/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	if(has_latches)
		if(prob(10))
			latches = "double_latch"
			if(prob(1))
				latches = "triple_latch"
	update_appearance()

	AddElement(/datum/element/falling_hazard, damage = force, wound_bonus = wound_bonus, hardhat_safety = TRUE, crushes = FALSE, impact_sound = hitsound)

/obj/item/storage/toolbox/update_overlays()
	. = ..()
	if(has_latches)
		. += latches

/obj/item/storage/toolbox/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] robusts [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/storage/toolbox/emergency
	name = "emergency toolbox"
	icon_state = "red"
	inhand_icon_state = "toolbox_red"
	material_flags = NONE

/obj/item/storage/toolbox/emergency/PopulateContents()
	new /obj/item/crowbar/red(src)
	new /obj/item/weldingtool/mini(src)
	new /obj/item/extinguisher/mini(src)
	switch(rand(1,3))
		if(1)
			new /obj/item/flashlight(src)
		if(2)
			new /obj/item/flashlight/glowstick(src)
		if(3)
			new /obj/item/flashlight/flare(src)
	new /obj/item/radio/off(src)
	new /obj/item/oxygen_candle(src) //monkestation edit

/obj/item/storage/toolbox/emergency/old
	name = "rusty red toolbox"
	icon_state = "toolbox_red_old"
	has_latches = FALSE
	material_flags = NONE

/obj/item/storage/toolbox/mechanical
	name = "mechanical toolbox"
	icon_state = "blue"
	inhand_icon_state = "toolbox_blue"
	material_flags = NONE
	/// If FALSE, someone with a ensouled soulstone can sacrifice a spirit to change the sprite of this toolbox.
	var/has_soul = FALSE

/obj/item/storage/toolbox/mechanical/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/analyzer(src)
	new /obj/item/wirecutters(src)

/obj/item/storage/toolbox/mechanical/old
	name = "rusty blue toolbox"
	icon_state = "toolbox_blue_old"
	has_latches = FALSE
	has_soul = TRUE

/obj/item/storage/toolbox/mechanical/old/heirloom
	name = "toolbox" //this will be named "X family toolbox"
	desc = "It's seen better days."
	force = 5
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/toolbox/mechanical/old/heirloom/Initialize(mapload)
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_SMALL

/obj/item/storage/toolbox/mechanical/old/heirloom/PopulateContents()
	return

/obj/item/storage/toolbox/mechanical/old/clean // the assistant traitor toolbox, damage scales with TC inside
	name = "toolbox"
	desc = "An old, blue toolbox, it looks robust."
	icon_state = "oldtoolboxclean"
	inhand_icon_state = "toolbox_blue"
	has_latches = FALSE
	force = 19
	throwforce = 22

/obj/item/storage/toolbox/mechanical/old/clean/proc/calc_damage()
	var/power = 0
	for (var/obj/item/stack/telecrystal/stored_crystals in get_all_contents())
		power += (stored_crystals.amount / 2)
	force = 19 + power
	throwforce = 22 + power

/obj/item/storage/toolbox/mechanical/old/clean/attack(mob/target, mob/living/user)
	calc_damage()
	..()

/obj/item/storage/toolbox/mechanical/old/clean/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	calc_damage()
	..()

/obj/item/storage/toolbox/mechanical/old/clean/PopulateContents()
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/clothing/gloves/color/yellow(src)

/obj/item/storage/toolbox/electrical
	name = "electrical toolbox"
	icon_state = "yellow"
	inhand_icon_state = "toolbox_yellow"
	material_flags = NONE

/obj/item/storage/toolbox/electrical/PopulateContents()
	var/pickedcolor = pick(GLOB.cable_colors)
	new /obj/item/screwdriver(src)
	new /obj/item/wirecutters(src)
	new /obj/item/t_scanner(src)
	new /obj/item/crowbar(src)
	var/obj/item/stack/cable_coil/new_cable_one = new(src, MAXCOIL)
	new_cable_one.set_cable_color(pickedcolor)
	var/obj/item/stack/cable_coil/new_cable_two = new(src, MAXCOIL)
	new_cable_two.set_cable_color(pickedcolor)
	if(prob(5))
		new /obj/item/clothing/gloves/color/yellow(src)
	else
		var/obj/item/stack/cable_coil/new_cable_three = new(src, MAXCOIL)
		new_cable_three.set_cable_color(pickedcolor)

/obj/item/storage/toolbox/syndicate
	name = "suspicious looking toolbox"
	icon_state = "syndicate"
	inhand_icon_state = "toolbox_syndi"
	force = 15
	throwforce = 18
	material_flags = NONE

/obj/item/storage/toolbox/syndicate/Initialize(mapload)
	. = ..()
	atom_storage.silent = TRUE

/obj/item/storage/toolbox/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar/red(src)
	new /obj/item/wirecutters(src, "red")
	new /obj/item/multitool(src)
	new /obj/item/clothing/gloves/combat(src)

/obj/item/storage/toolbox/drone
	name = "mechanical toolbox"
	icon_state = "blue"
	inhand_icon_state = "toolbox_blue"
	material_flags = NONE

/obj/item/storage/toolbox/drone/PopulateContents()
	var/pickedcolor = pick("red","yellow","green","blue","pink","orange","cyan","white")
	new /obj/item/screwdriver(src)
	new /obj/item/wrench(src)
	new /obj/item/weldingtool(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/cable_coil(src,MAXCOIL,pickedcolor)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)

/obj/item/storage/toolbox/artistic
	name = "artistic toolbox"
	desc = "A toolbox painted bright green. Why anyone would store art supplies in a toolbox is beyond you, but it has plenty of extra space."
	icon_state = "green"
	inhand_icon_state = "artistic_toolbox"
	w_class = WEIGHT_CLASS_GIGANTIC //Holds more than a regular toolbox!
	material_flags = NONE

/obj/item/storage/toolbox/artistic/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 20
	atom_storage.max_slots = 11

/obj/item/storage/toolbox/artistic/PopulateContents()
	new /obj/item/storage/crayons(src)
	new /obj/item/crowbar(src)
	new /obj/item/stack/pipe_cleaner_coil/red(src)
	new /obj/item/stack/pipe_cleaner_coil/yellow(src)
	new /obj/item/stack/pipe_cleaner_coil/blue(src)
	new /obj/item/stack/pipe_cleaner_coil/green(src)
	new /obj/item/stack/pipe_cleaner_coil/pink(src)
	new /obj/item/stack/pipe_cleaner_coil/orange(src)
	new /obj/item/stack/pipe_cleaner_coil/cyan(src)
	new /obj/item/stack/pipe_cleaner_coil/white(src)
	new /obj/item/stack/pipe_cleaner_coil/brown(src)

/obj/item/storage/toolbox/ammobox
	name = "ammo canister"
	desc = "A metal canister designed to hold ammunition"
	icon_state = "ammobox"
	inhand_icon_state = "ammobox"
	lefthand_file = 'icons/mob/inhands/equipment/toolbox_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/toolbox_righthand.dmi'
	has_latches = FALSE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'
	var/ammo_to_spawn

/obj/item/storage/toolbox/ammobox/PopulateContents()
	if(!isnull(ammo_to_spawn))
		for(var/i in 1 to 6)
			new ammo_to_spawn(src)

/obj/item/storage/toolbox/ammobox/a762
	name = "7.62mm ammo box (Surplus?)"
	desc = "It contains a few clips. Goddamn, this thing smells awful. \
		Has this been sitting in a warehouse for the last several centuries?"
	ammo_to_spawn = /obj/item/ammo_box/a762

/obj/item/storage/toolbox/ammobox/a762/surplus
	ammo_to_spawn = /obj/item/ammo_box/a762/surplus

/obj/item/storage/toolbox/ammobox/wt550m9
	name = "4.6x30mm ammo box"
	ammo_to_spawn = /obj/item/ammo_box/magazine/wt550m9

/obj/item/storage/toolbox/ammobox/wt550m9ap
	name = "4.6x30mm AP ammo box"
	ammo_to_spawn = /obj/item/ammo_box/magazine/wt550m9/wtap

/obj/item/storage/toolbox/maint_kit
	name = "gun maintenance kit"
	desc = "It contains some gun maintenance supplies"
	icon_state = "maint_kit"
	inhand_icon_state = "ammobox"
	has_latches = FALSE
	drop_sound = 'sound/items/handling/ammobox_drop.ogg'
	pickup_sound = 'sound/items/handling/ammobox_pickup.ogg'

/obj/item/storage/toolbox/maint_kit/PopulateContents()
	new /obj/item/gun_maintenance_supplies(src)
	new /obj/item/gun_maintenance_supplies(src)
	new /obj/item/gun_maintenance_supplies(src)

//floorbot assembly
/obj/item/storage/toolbox/attackby(obj/item/stack/tile/iron/T, mob/user, params)
	var/list/allowed_toolbox = list(/obj/item/storage/toolbox/emergency, //which toolboxes can be made into floorbots
							/obj/item/storage/toolbox/electrical,
							/obj/item/storage/toolbox/mechanical,
							/obj/item/storage/toolbox/artistic,
							/obj/item/storage/toolbox/syndicate)

	if(!istype(T, /obj/item/stack/tile/iron))
		..()
		return
	if(!is_type_in_list(src, allowed_toolbox) && (type != /obj/item/storage/toolbox))
		return
	if(contents.len >= 1)
		balloon_alert(user, "not empty!")
		return
	if(T.use(10))
		var/obj/item/bot_assembly/floorbot/B = new
		B.toolbox = type
		switch(B.toolbox)
			if(/obj/item/storage/toolbox)
				B.toolbox_color = "r"
			if(/obj/item/storage/toolbox/emergency)
				B.toolbox_color = "r"
			if(/obj/item/storage/toolbox/electrical)
				B.toolbox_color = "y"
			if(/obj/item/storage/toolbox/artistic)
				B.toolbox_color = "g"
			if(/obj/item/storage/toolbox/syndicate)
				B.toolbox_color = "s"
		user.put_in_hands(B)
		B.update_appearance()
		B.balloon_alert(user, "tiles added")
		qdel(src)
	else
		balloon_alert(user, "needs 10 tiles!")
		return


/obj/item/storage/toolbox/haunted
	name = "old toolbox"
	custom_materials = list(/datum/material/hauntium = SMALL_MATERIAL_AMOUNT*5)

//guncases are defined in a blueshift module folder. Note to Self: move that here.
/obj/item/storage/toolbox/guncase/monkeycase
	name = "monkey gun case"
	desc = "Everything a monkey needs to truly go ape-shit. There's a paw-shaped hand scanner lock on the front of the case."

/obj/item/storage/toolbox/guncase/monkeycase/Initialize(mapload)
	. = ..()
	atom_storage.locked = STORAGE_SOFT_LOCKED

/obj/item/storage/toolbox/guncase/monkeycase/attack_self(mob/user, modifiers)
	if(!monkey_check(user))
		return
	return ..()

/obj/item/storage/toolbox/guncase/monkeycase/attack_self_secondary(mob/user, modifiers)
	attack_self(user, modifiers)
	return

/obj/item/storage/toolbox/guncase/monkeycase/attack_hand(mob/user, list/modifiers)
	if(!monkey_check(user))
		return
	return ..()

/obj/item/storage/toolbox/guncase/monkeycase/proc/monkey_check(mob/user)
	if(atom_storage.locked == STORAGE_NOT_LOCKED)
		return TRUE

	if(is_simian(user))
		atom_storage.locked = STORAGE_NOT_LOCKED
		to_chat(user, span_notice("You place your paw on the paw scanner, and hear a soft click as [src] unlocks!"))
		playsound(src, 'sound/machines/click.ogg', 25, TRUE)
		return TRUE
	to_chat(user, span_warning("You put your hand on the hand scanner, and it rejects it with an angry chimpanzee screech!"))
	playsound(src, "sound/creatures/monkey/monkey_screech_[rand(1,7)].ogg", 75, TRUE)
	return FALSE

/obj/item/storage/toolbox/guncase/monkeycase/PopulateContents()
	switch(rand(1, 3))
		if(1)
			// Uzi with a boxcutter.
			new /obj/item/gun/ballistic/automatic/mini_uzi/chimpgun(src)
			new /obj/item/ammo_box/magazine/uzim9mm(src)
			new /obj/item/ammo_box/magazine/uzim9mm(src)
			new /obj/item/boxcutter(src)
		if(2)
			// Thompson with a boxcutter.
			new /obj/item/gun/ballistic/automatic/tommygun/chimpgun(src)
			new /obj/item/ammo_box/magazine/tommygunm45(src)
			new /obj/item/ammo_box/magazine/tommygunm45(src)
			new /obj/item/boxcutter(src)
		if(3)
			// M1911 with a switchblade and an extra banana bomb.
			new /obj/item/gun/ballistic/automatic/pistol/m1911/chimpgun(src)
			new /obj/item/ammo_box/magazine/m45(src)
			new /obj/item/ammo_box/magazine/m45(src)
			new /obj/item/switchblade(src)
			new /obj/item/food/grown/banana/bunch/monkeybomb(src)

	// Banana bomb! Basically a tiny flashbang for monkeys.
	new /obj/item/food/grown/banana/bunch/monkeybomb(src)
	// Somewhere to store it all.
	new /obj/item/storage/backpack/satchel(src)
