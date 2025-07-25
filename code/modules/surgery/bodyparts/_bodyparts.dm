#define AUGGED_LIMB_EMP_BRUTE_DAMAGE 3
#define AUGGED_LIMB_EMP_BURN_DAMAGE 2

/obj/item/bodypart
	name = "limb"
	desc = "Why is it detached..."
	force = 3
	throwforce = 3
	w_class = WEIGHT_CLASS_SMALL
	icon = 'icons/mob/species/human/bodyparts.dmi'
	icon_state = "" //Leave this blank! Bodyparts are built using overlays
	/// The icon for Organic limbs using greyscale
	VAR_PROTECTED/icon_greyscale = DEFAULT_BODYPART_ICON_ORGANIC
	///The icon for non-greyscale limbs
	VAR_PROTECTED/icon_static = 'icons/mob/species/human/bodyparts.dmi'
	///The icon for husked limbs
	VAR_PROTECTED/icon_husk = 'icons/mob/species/human/bodyparts.dmi'
	///The icon for invisible limbs
	VAR_PROTECTED/icon_invisible = 'icons/mob/species/human/bodyparts.dmi'
	///The type of husk for building an iconstate
	var/husk_type = "humanoid"
	layer = BELOW_MOB_LAYER //so it isn't hidden behind objects when on the floor
	grind_results = list(/datum/reagent/bone_dust = 10, /datum/reagent/consumable/liquidgibs = 5) // robotic bodyparts and chests/heads cannot be ground
	/// The mob that "owns" this limb
	/// DO NOT MODIFY DIRECTLY. Use set_owner()
	var/mob/living/carbon/owner

	/// If this limb can be scarred.
	var/scarrable = TRUE

	/**
	 * A bitfield of biological states, exclusively used to determine which wounds this limb will get,
	 * as well as how easily it will happen.
	 * Set to BIO_STANDARD_UNJOINTED because most species have both flesh bone and blood in their limbs.
	 */
	var/biological_state = BIO_STANDARD_UNJOINTED
	///A bitfield of bodytypes for clothing, surgery, and misc information
	var/bodytype = BODYTYPE_HUMANOID | BODYTYPE_ORGANIC
	///Defines when a bodypart should not be changed. Example: BP_BLOCK_CHANGE_SPECIES prevents the limb from being overwritten on species gain
	var/change_exempt_flags = NONE
	///Random flags that describe this bodypart
	var/bodypart_flags = NONE

	///Whether the bodypart (and the owner) is husked.
	var/is_husked = FALSE
	///Whether the bodypart (and the owner) is invisible through invisibleman trait.
	var/is_invisible = FALSE
	///The ID of a species used to generate the icon. Needs to match the icon_state portion in the limbs file!
	var/limb_id = SPECIES_HUMAN
	//Defines what sprite the limb should use if it is also sexually dimorphic.
	var/limb_gender = "m"
	///Is there a sprite difference between male and female?
	var/is_dimorphic = FALSE
	///The actual color a limb is drawn as, set by /proc/update_limb()
	var/draw_color //NEVER. EVER. EDIT THIS VALUE OUTSIDE OF UPDATE_LIMB. I WILL FIND YOU. It ruins the limb icon pipeline.
	///If this limb should have emissive overlays
	var/is_emissive = FALSE

	/// BODY_ZONE_CHEST, BODY_ZONE_L_ARM, etc , used for def_zone
	var/body_zone
	/// The body zone of this part in english ("chest", "left arm", etc) without the species attached to it
	var/plaintext_zone
	var/aux_zone // used for hands
	var/aux_layer
	/// bitflag used to check which clothes cover this bodypart
	var/body_part
	/// List of obj/item's embedded inside us. Managed by embedded components, do not modify directly
	var/list/embedded_objects = list()
	/// are we a hand? if so, which one!
	var/held_index = 0
	/// A speed modifier we apply to the owner when attached, if any. Positive numbers make it move slower, negative numbers make it move faster.
	var/speed_modifier = 0

	// Limb disabling variables
	///Whether it is possible for the limb to be disabled whatsoever. TRUE means that it is possible.
	var/can_be_disabled = FALSE //Defaults to FALSE, as only human limbs can be disabled, and only the appendages.
	///Controls if the limb is disabled. TRUE means it is disabled (similar to being removed, but still present for the sake of targeted interactions).
	var/bodypart_disabled = FALSE
	///Handles limb disabling by damage. If 0 (0%), a limb can't be disabled via damage. If 1 (100%), it is disabled at max limb damage. Anything between is the percentage of damage against maximum limb damage needed to disable the limb.
	var/disabling_threshold_percentage = 0

	// Damage state variables
	///A mutiplication of the burn and brute damage that the limb's stored damage contributes to its attached mob's overall wellbeing.
	var/body_damage_coeff = 1
	///The current amount of brute damage the limb has
	var/brute_dam = 0
	///The current amount of burn damage the limb has
	var/burn_dam = 0
	///The maximum brute OR burn damage a bodypart can take. Once we hit this cap, no more damage of either type!
	var/max_damage = 0

	///Used in determining overlays for limb damage states. As the mob receives more burn/brute damage, their limbs update to reflect.
	var/brutestate = 0
	var/burnstate = 0

	///Gradually increases while burning when at full damage, destroys the limb when at 100
	var/cremation_progress = 0

	//Multiplicative damage modifiers
	/// Brute damage gets multiplied by this on receive_damage()
	var/brute_modifier = 1
	/// Burn damage gets multiplied by this on receive_damage()
	var/burn_modifier = 1

	//Coloring and proper item icon update
	var/skin_tone = ""
	var/species_color = ""
	///Limbs need this information as a back-up incase they are generated outside of a carbon (limbgrower)
	var/should_draw_greyscale = TRUE
	///An "override" color that can be applied to ANY limb, greyscale or not.
	var/variable_color = ""
	/// Color of the damage overlay
	var/damage_color = COLOR_BLOOD

	var/px_x = 0
	var/px_y = 0

	///the type of damage overlay (if any) to use when this bodypart is bruised/burned.
	var/dmg_overlay_type = "human"
	/// If we're bleeding, which icon are we displaying on this part
	var/bleed_overlay_icon

	//Damage messages used by help_shake_act()
	var/light_brute_msg = "bruised"
	var/medium_brute_msg = "battered"
	var/heavy_brute_msg = "mangled"

	var/light_burn_msg = "numb"
	var/medium_burn_msg = "blistered"
	var/heavy_burn_msg = "peeling away"

	//Damage messages used by examine(). the desc that is most common accross all bodyparts gets shown
	var/list/damage_examines = list(BRUTE = DEFAULT_BRUTE_EXAMINE_TEXT, BURN = DEFAULT_BURN_EXAMINE_TEXT, CLONE = DEFAULT_CLONE_EXAMINE_TEXT)

	// Wounds related variables
	/// The wounds currently afflicting this body part
	var/list/wounds

	/// The scars currently afflicting this body part
	var/list/scars
	/// Our current stored wound damage multiplier
	var/wound_damage_multiplier = 1

	/// This number is subtracted from all wound rolls on this bodypart, higher numbers mean more defense, negative means easier to wound
	var/wound_resistance = 0
	/// When this bodypart hits max damage, this number is added to all wound rolls. Obviously only relevant for bodyparts that have damage caps.
	var/disabled_wound_penalty = 15

	/// A hat won't cover your face, but a shirt covering your chest will cover your... you know, chest
	var/scars_covered_by_clothes = TRUE
	/// So we know if we need to scream if this limb hits max damage
	var/last_maxed
	/// Our current bleed rate. Cached, update with refresh_bleed_rate()
	var/cached_bleed_rate = 0
	/// How much generic bleedstacks we have on this bodypart
	var/generic_bleedstacks
	/// If we have a gauze wrapping currently applied (not including splints)
	var/obj/item/stack/current_gauze
	/// If something is currently grasping this bodypart and trying to staunch bleeding (see [/obj/item/hand_item/self_grasp])
	var/obj/item/hand_item/self_grasp/grasped_by

	///A list of all the external organs we've got stored to draw horns, wings and stuff with (special because we are actually in the limbs unlike normal organs :/ )
	///If someone ever comes around to making all organs exist in the bodyparts, you can just remove this and use a typed loop
	var/list/obj/item/organ/external/external_organs = list()
	///A list of all bodypart overlays to draw
	var/list/bodypart_overlays = list()

	/// Type of an attack from this limb does. Arms will do punches, Legs for kicks, and head for bites. (TO ADD: tactical chestbumps)
	var/attack_type = BRUTE
	/// the verb used for an unarmed attack when using this limb, such as arm.unarmed_attack_verb = punch
	var/unarmed_attack_verb = "bump"
	/// what visual effect is used when this limb is used to strike someone.
	var/unarmed_attack_effect = ATTACK_EFFECT_PUNCH
	/// Sounds when this bodypart is used in an umarmed attack
	var/sound/unarmed_attack_sound = 'sound/weapons/punch1.ogg'
	var/sound/unarmed_miss_sound = 'sound/weapons/punchmiss.ogg'
	///Lowest possible punch damage this bodypart can give. If this is set to 0, unarmed attacks will always miss.
	var/unarmed_damage_low = 1
	///Highest possible punch damage this bodypart can ive.
	var/unarmed_damage_high = 1
	///Damage at which attacks from this bodypart will stun
	var/unarmed_stun_threshold = 2

	/// Traits that are given to the holder of the part. If you want an effect that changes this, don't add directly to this. Use the add_bodypart_trait() proc
	var/list/bodypart_traits = list()
	/// The name of the trait source that the organ gives. Should not be altered during the events of gameplay, and will cause problems if it is.
	var/bodypart_trait_source = BODYPART_TRAIT
	/// List of the above datums which have actually been instantiated, managed automatically
	var/list/feature_offsets = list()

	/// In the case we dont have dismemberable features, or literally cant get wounds, we will use this percent to determine when we can be dismembered.
	/// Compared to our ABSOLUTE maximum. Stored in decimal; 0.8 = 80%.
	var/hp_percent_to_dismemberable = 0.8
	/// If true, we will use [hp_percent_to_dismemberable] even if we are dismemberable via wounds. Useful for things with extreme wound resistance.
	var/use_alternate_dismemberment_calc_even_if_mangleable = FALSE
	/// If false, no wound that can be applied to us can mangle our exterior. Used for determining if we should use [hp_percent_to_dismemberable] instead of normal dismemberment.
	var/any_existing_wound_can_mangle_our_exterior
	/// If false, no wound that can be applied to us can mangle our interior. Used for determining if we should use [hp_percent_to_dismemberable] instead of normal dismemberment.
	var/any_existing_wound_can_mangle_our_interior

	///an assoc list of type to % for limbs that share id's useful for traits or components we want to add that should require more than 1 limb being added
	var/list/composition_effects
	///a list of different limb_ids that we share composition with
	var/list/shared_composition
	///this is our color palette we pull colors from
	var/datum/color_palette/palette
	var/palette_key

/obj/item/bodypart/apply_fantasy_bonuses(bonus)
	. = ..()
	unarmed_damage_low = modify_fantasy_variable("unarmed_damage_low", unarmed_damage_low, bonus, minimum = 1)
	unarmed_damage_high = modify_fantasy_variable("unarmed_damage_high", unarmed_damage_high, bonus, minimum = 1)
	brute_modifier = modify_fantasy_variable("brute_modifier", brute_modifier, bonus * 0.02, minimum = 0.7)
	burn_modifier = modify_fantasy_variable("burn_modifier", burn_modifier, bonus * 0.02, minimum = 0.7)
	wound_resistance = modify_fantasy_variable("wound_resistance", wound_resistance, bonus)

/obj/item/bodypart/remove_fantasy_bonuses(bonus)
	unarmed_damage_low = reset_fantasy_variable("unarmed_damage_low", unarmed_damage_low)
	unarmed_damage_high = reset_fantasy_variable("unarmed_damage_high", unarmed_damage_high)
	brute_modifier = reset_fantasy_variable("brute_modifier", brute_modifier)
	burn_modifier = reset_fantasy_variable("burn_modifier", burn_modifier)
	wound_resistance = reset_fantasy_variable("wound_resistance", wound_resistance)
	return ..()


/obj/item/bodypart/Initialize(mapload)
	. = ..()
	if(can_be_disabled)
		RegisterSignal(src, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_gain))
		RegisterSignal(src, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_loss))

	RegisterSignal(src, COMSIG_ATOM_RESTYLE, PROC_REF(on_attempt_feature_restyle))

	if(!IS_ORGANIC_LIMB(src))
		grind_results = null

	name = "[limb_id] [parse_zone(body_zone)]"
	update_icon_dropped()
	refresh_bleed_rate()

/obj/item/bodypart/Destroy()
	if(owner)
		owner.remove_bodypart(src)
		set_owner(null)
	for(var/wound in wounds)
		qdel(wound) // wounds is a lazylist, and each wound removes itself from it on deletion.
	if(length(wounds))
		stack_trace("[type] qdeleted with [length(wounds)] uncleared wounds")
		wounds.Cut()

	if(length(external_organs))
		for(var/obj/item/organ/external/external_organ as anything in external_organs)
			external_organs -= external_organ
			qdel(external_organ) // It handles removing its references to this limb on its own.

		external_organs = list()
	QDEL_LIST_ASSOC_VAL(feature_offsets)

	return ..()

/obj/item/bodypart/forceMove(atom/destination) //Please. Never forcemove a limb if its's actually in use. This is only for borgs.
	SHOULD_CALL_PARENT(TRUE)

	. = ..()
	if(isturf(destination))
		update_icon_dropped()

/obj/item/bodypart/examine(mob/user)
	SHOULD_CALL_PARENT(TRUE)

	. = ..()
	if(brute_dam > DAMAGE_PRECISION)
		. += span_warning("This limb has [brute_dam > 30 ? "severe" : "minor"] bruising.")
	if(burn_dam > DAMAGE_PRECISION)
		. += span_warning("This limb has [burn_dam > 30 ? "severe" : "minor"] burns.")

	if(locate(/datum/wound/blunt) in wounds)
		. += span_warning("The bones in this limb appear badly cracked.")
	if(locate(/datum/wound/slash) in wounds)
		. += span_warning("The flesh on this limb appears badly lacerated.")
	if(locate(/datum/wound/pierce) in wounds)
		. += span_warning("The flesh on this limb appears badly perforated.")
	if(locate(/datum/wound/burn) in wounds)
		. += span_warning("The flesh on this limb appears badly cooked.")

/**
 * Called when a bodypart is checked for injuries.
 *
 * Modifies the check_list list with the resulting report of the limb's status.
 */
/obj/item/bodypart/proc/check_for_injuries(mob/living/carbon/human/examiner, list/check_list)

	var/list/limb_damage = list(BRUTE = brute_dam, BURN = burn_dam)

	SEND_SIGNAL(src, COMSIG_BODYPART_CHECKED_FOR_INJURY, examiner, check_list, limb_damage)
	SEND_SIGNAL(examiner, COMSIG_CARBON_CHECKING_BODYPART, src, check_list, limb_damage)

	var/shown_brute = limb_damage[BRUTE]
	var/shown_burn = limb_damage[BURN]
	var/status = ""
	var/self_aware = HAS_TRAIT(examiner, TRAIT_SELF_AWARE)

	if(self_aware)
		if(!shown_brute && !shown_burn)
			status = "no damage"
		else
			status = "[shown_brute] brute damage and [shown_burn] burn damage"

	else
		if(shown_brute > (max_damage * 0.8))
			status += heavy_brute_msg
		else if(shown_brute > (max_damage * 0.4))
			status += medium_brute_msg
		else if(shown_brute > DAMAGE_PRECISION)
			status += light_brute_msg

		if(shown_brute > DAMAGE_PRECISION && shown_burn > DAMAGE_PRECISION)
			status += " and "

		if(shown_burn > (max_damage * 0.8))
			status += heavy_burn_msg
		else if(shown_burn > (max_damage * 0.2))
			status += medium_burn_msg
		else if(shown_burn > DAMAGE_PRECISION)
			status += light_burn_msg

		if(status == "")
			status = "OK"

	var/no_damage
	if(status == "OK" || status == "no damage")
		no_damage = TRUE

	var/is_disabled = ""
	if(bodypart_disabled)
		is_disabled = " is disabled"
		if(no_damage)
			is_disabled += " but otherwise"
		else
			is_disabled += " and"

	check_list += "\t<span class='[no_damage ? "notice" : "warning"]'>Your [name][is_disabled][self_aware ? " has " : " is "][status].</span>"

	for(var/datum/wound/wound as anything in wounds)
		var/wound_desc = wound.get_self_check_description(src, examiner)
		if(wound_desc)
			check_list += "\t\t[wound_desc]"

	for(var/obj/item/embedded_thing in embedded_objects)
		var/stuck_word = embedded_thing.isEmbedHarmless() ? "stuck" : "embedded"
		check_list += "\t <a href='byond://?src=[REF(examiner)];embedded_object=[REF(embedded_thing)];embedded_limb=[REF(src)]' class='warning'>There is \a [embedded_thing] [stuck_word] in your [name]!</a>"

	if(current_gauze)
		check_list += span_notice("\t There is some <a href='byond://?src=[REF(examiner)];gauze_limb=[REF(src)]'>[current_gauze.name]</a> wrapped around your [name].")


/obj/item/bodypart/blob_act()
	receive_damage(max_damage, wound_bonus = CANT_WOUND)

/obj/item/bodypart/attack(mob/living/carbon/victim, mob/user)
	SHOULD_CALL_PARENT(TRUE)

	if(ishuman(victim))
		var/mob/living/carbon/human/human_victim = victim
		if(HAS_TRAIT(victim, TRAIT_LIMBATTACHMENT))
			if(!human_victim.get_bodypart(body_zone))
				user.temporarilyRemoveItemFromInventory(src, TRUE)
				if(!try_attach_limb(victim))
					to_chat(user, span_warning("[human_victim]'s body rejects [src]!"))
					forceMove(human_victim.loc)
					return
				if(check_for_frankenstein(victim))
					bodypart_flags |= BODYPART_IMPLANTED
				if(human_victim == user)
					human_victim.visible_message(span_warning("[human_victim] jams [src] into [human_victim.p_their()] empty socket!"),\
					span_notice("You force [src] into your empty socket, and it locks into place!"))
				else
					human_victim.visible_message(span_warning("[user] jams [src] into [human_victim]'s empty socket!"),\
					span_notice("[user] forces [src] into your empty socket, and it locks into place!"))
				return
	return ..()

/obj/item/bodypart/attackby(obj/item/weapon, mob/user, params)
	SHOULD_CALL_PARENT(TRUE)

	if(weapon.get_sharpness())
		add_fingerprint(user)
		if(!contents.len)
			to_chat(user, span_warning("There is nothing left inside [src]!"))
			return
		playsound(loc, 'sound/weapons/slice.ogg', 50, TRUE, -1)
		user.visible_message(span_warning("[user] begins to cut open [src]."),\
			span_notice("You begin to cut open [src]..."))
		if(do_after(user, 54, target = src))
			drop_organs(user, TRUE)
	else
		return ..()

/obj/item/bodypart/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	SHOULD_CALL_PARENT(TRUE)

	..()
	if(IS_ORGANIC_LIMB(src))
		playsound(get_turf(src), 'sound/misc/splort.ogg', 50, TRUE, -1)
	pixel_x = rand(-3, 3)
	pixel_y = rand(-3, 3)

/obj/item/bodypart/drop_location()
	return ..() || owner?.drop_location()

//empties the bodypart from its organs and other things inside it
/obj/item/bodypart/proc/drop_organs(mob/user, violent_removal)
	SHOULD_CALL_PARENT(TRUE)

	var/atom/drop_loc = drop_location()
	if(IS_ORGANIC_LIMB(src) && violent_removal)
		playsound(drop_loc, 'sound/misc/splort.ogg', 50, TRUE, -1)
	seep_gauze(9999) // destroy any existing gauze if any exists
	for(var/obj/item/organ/organ as anything in get_organs())
		if(owner)
			organ.Remove(owner)
		else
			organ.remove_from_limb(src)
		organ.forceMove(drop_loc)
		if(violent_removal)
			organ.fly_away(drop_loc)
	for(var/obj/item/item_in_bodypart in src)
		item_in_bodypart.forceMove(drop_loc)
		if(violent_removal && owner)
			item_in_bodypart.transfer_mob_blood_dna(owner)

	if(owner)
		owner.update_body()
	else
		update_icon_dropped()


///since organs aren't actually stored in the bodypart themselves while attached to a person, we have to query the owner for what we should have
/obj/item/bodypart/proc/get_organs()
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	if(!owner)
		return FALSE

	var/list/bodypart_organs
	for(var/obj/item/organ/organ_check as anything in owner.organs) //internal organs inside the dismembered limb are dropped.
		if(check_zone(organ_check.zone) == body_zone)
			LAZYADD(bodypart_organs, organ_check) // this way if we don't have any, it'll just return null

	return bodypart_organs

//Return TRUE to get whatever mob this is in to update health.
/obj/item/bodypart/proc/on_life(seconds_per_tick, times_fired)
	SHOULD_CALL_PARENT(TRUE)

//Applies brute and burn damage to the organ. Returns 1 if the damage-icon states changed at all.
//Damage will not exceed max_damage using this proc
//Cannot apply negative damage
/obj/item/bodypart/proc/receive_damage(brute = 0, burn = 0, blocked = 0, updating_health = TRUE, forced = FALSE, required_bodytype = null, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE, attack_direction = null, damage_source)
	SHOULD_CALL_PARENT(TRUE)
	var/area/target_area = get_area(src.owner)
	if(target_area)
		if((target_area.area_flags & PASSIVE_AREA))
			return FALSE

	var/hit_percent = (100-blocked)/100
	if((!brute && !burn) || hit_percent <= 0)
		return FALSE
	if (!forced)
		if(!isnull(owner))
			if (HAS_TRAIT(owner, TRAIT_GODMODE))
				return FALSE
			if (SEND_SIGNAL(owner, COMSIG_CARBON_LIMB_DAMAGED, src, brute, burn) & COMPONENT_PREVENT_LIMB_DAMAGE)
				return FALSE
		if(required_bodytype && !(bodytype & required_bodytype))
			return FALSE

	var/dmg_multi = CONFIG_GET(number/damage_multiplier) * hit_percent
	var/datum/species/owner_species = owner.dna?.species
	if(owner_species)
		dmg_multi *= (100 - owner_species.armor) / 100 // species.armor is a 0-100 percentage of damage reduction, so we have to convert that to a 0-1 multiplier
		brute *= owner_species.brutemod
		burn *= owner_species.burnmod
	brute = round(max(brute * dmg_multi * brute_modifier, 0), DAMAGE_PRECISION)
	burn = round(max(burn * dmg_multi * burn_modifier, 0), DAMAGE_PRECISION)

	if(!brute && !burn)
		return FALSE

	brute *= wound_damage_multiplier
	burn *= wound_damage_multiplier

	if(bodytype & (BODYTYPE_ALIEN|BODYTYPE_LARVA_PLACEHOLDER)) //aliens take double burn //nothing can burn with so much snowflake code around
		burn *= 2

	/*
	// START WOUND HANDLING
	*/

	// what kind of wounds we're gonna roll for, take the greater between brute and burn, then if it's brute, we subdivide based on sharpness
	var/wounding_type = (brute > burn ? WOUND_BLUNT : WOUND_BURN)
	var/wounding_dmg = max(brute, burn)

	if(wounding_type == WOUND_BLUNT && sharpness)
		if(sharpness & SHARP_EDGED)
			wounding_type = WOUND_SLASH
		else if (sharpness & SHARP_POINTY)
			wounding_type = WOUND_PIERCE

	if(owner) // i tried to modularize the below, but the modifications to wounding_dmg and wounding_type cant be extracted to a proc
		var/mangled_state = get_mangled_state()
		var/easy_dismember = HAS_TRAIT(owner, TRAIT_EASYDISMEMBER) // if we have easydismember, we don't reduce damage when redirecting damage to different types (slashing weapons on mangled/skinless limbs attack at 100% instead of 50%)

		var/bio_status = get_bio_state_status()

		var/has_exterior = ((bio_status & ANATOMY_EXTERIOR))
		var/has_interior = ((bio_status & ANATOMY_INTERIOR))

		var/exterior_ready_to_dismember = (!has_exterior || ((mangled_state & BODYPART_MANGLED_EXTERIOR)))

		// if we're bone only, all cutting attacks go straight to the bone
		if(!has_exterior && has_interior)
			if(wounding_type == WOUND_SLASH)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.6)
			else if(wounding_type == WOUND_PIERCE)
				wounding_type = WOUND_BLUNT
				wounding_dmg *= (easy_dismember ? 1 : 0.75)
		else
			// if we've already mangled the skin (critical slash or piercing wound), then the bone is exposed, and we can damage it with sharp weapons at a reduced rate
			// So a big sharp weapon is still all you need to destroy a limb
			if(has_interior && exterior_ready_to_dismember && !(mangled_state & BODYPART_MANGLED_INTERIOR) && sharpness)
				if(wounding_type == WOUND_SLASH && !easy_dismember)
					wounding_dmg *= 0.6 // edged weapons pass along 60% of their wounding damage to the bone since the power is spread out over a larger area
				if(wounding_type == WOUND_PIERCE && !easy_dismember)
					wounding_dmg *= 0.75 // piercing weapons pass along 75% of their wounding damage to the bone since it's more concentrated
				wounding_type = WOUND_BLUNT
		if ((dismemberable_by_wound() || dismemberable_by_total_damage()) && try_dismember(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus))
			return
		// now we have our wounding_type and are ready to carry on with wounds and dealing the actual damage
		if(wounding_dmg >= WOUND_MINIMUM_DAMAGE && wound_bonus != CANT_WOUND)
			check_wounding(wounding_type, wounding_dmg, wound_bonus, bare_wound_bonus, attack_direction)

	for(var/datum/wound/iter_wound as anything in wounds)
		iter_wound.receive_damage(wounding_type, wounding_dmg, wound_bonus, damage_source)

	/*
	// END WOUND HANDLING
	*/

	//back to our regularly scheduled program, we now actually apply damage if there's room below limb damage cap
	var/can_inflict = max_damage - get_damage()
	var/total_damage = brute + burn
	if(total_damage > can_inflict && total_damage > 0) // TODO: the second part of this check should be removed once disabling is all done
		brute = round(brute * (can_inflict / total_damage),DAMAGE_PRECISION)
		burn = round(burn * (can_inflict / total_damage),DAMAGE_PRECISION)

	if(can_inflict <= 0)
		return FALSE
	if(brute)
		set_brute_dam(brute_dam + brute)
	if(burn)
		set_burn_dam(burn_dam + burn)

	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()
	return update_bodypart_damage_state() || .

/// Returns a bitflag using ANATOMY_EXTERIOR or ANATOMY_INTERIOR. Used to determine if we as a whole have a interior or exterior biostate, or both.
/obj/item/bodypart/proc/get_bio_state_status()
	SHOULD_BE_PURE(TRUE)

	var/bio_status = NONE

	for (var/state as anything in GLOB.bio_state_anatomy)
		var/flag = text2num(state)
		if (!(biological_state & flag))
			continue

		var/value = GLOB.bio_state_anatomy[state]
		if (value & ANATOMY_EXTERIOR)
			bio_status |= ANATOMY_EXTERIOR
		if (value & ANATOMY_INTERIOR)
			bio_status |= ANATOMY_INTERIOR

		if ((bio_status & ANATOMY_EXTERIOR_AND_INTERIOR) == ANATOMY_EXTERIOR_AND_INTERIOR)
			break

	return bio_status

/// Returns if our current mangling status allows us to be dismembered. Requires both no exterior/mangled exterior and no interior/mangled interior.
/obj/item/bodypart/proc/dismemberable_by_wound()
	SHOULD_BE_PURE(TRUE)

	var/mangled_state = get_mangled_state()

	var/bio_status = get_bio_state_status()

	var/has_exterior = ((bio_status & ANATOMY_EXTERIOR))
	var/has_interior = ((bio_status & ANATOMY_INTERIOR))

	var/exterior_ready_to_dismember = (!has_exterior || ((mangled_state & BODYPART_MANGLED_EXTERIOR)))
	var/interior_ready_to_dismember = (!has_interior || ((mangled_state & BODYPART_MANGLED_INTERIOR)))

	return (exterior_ready_to_dismember && interior_ready_to_dismember)

/// Returns TRUE if our total percent damage is more or equal to our dismemberable percentage, but FALSE if a wound can cause us to be dismembered.
/obj/item/bodypart/proc/dismemberable_by_total_damage()

	update_wound_theory()

	var/bio_status = get_bio_state_status()

	var/has_interior = ((bio_status & ANATOMY_INTERIOR))
	var/can_theoretically_be_dismembered_by_wound = (any_existing_wound_can_mangle_our_interior || (any_existing_wound_can_mangle_our_exterior && has_interior))

	var/wound_dismemberable = dismemberable_by_wound()
	var/ready_to_use_alternate_formula = (use_alternate_dismemberment_calc_even_if_mangleable || (!wound_dismemberable && !can_theoretically_be_dismembered_by_wound))

	if (ready_to_use_alternate_formula)
		var/percent_to_total_max = (get_damage() / max_damage)
		if (percent_to_total_max >= hp_percent_to_dismemberable)
			return TRUE

	return FALSE

/// Updates our "can be theoretically dismembered by wounds" variables by iterating through all wound static data.
/obj/item/bodypart/proc/update_wound_theory()
	// We put this here so we dont increase init time by doing this all at once on initialization
	// Effectively, we "lazy load"
	if (isnull(any_existing_wound_can_mangle_our_interior) || isnull(any_existing_wound_can_mangle_our_exterior))
		any_existing_wound_can_mangle_our_interior = FALSE
		any_existing_wound_can_mangle_our_exterior = FALSE
		for (var/datum/wound/wound_type as anything in GLOB.all_wound_pregen_data)
			var/datum/wound_pregen_data/pregen_data = GLOB.all_wound_pregen_data[wound_type]
			if (!pregen_data.can_be_applied_to(src, random_roll = TRUE)) // we only consider randoms because non-randoms are usually really specific
				continue
			if (initial(pregen_data.wound_path_to_generate.wound_flags) & MANGLES_EXTERIOR)
				any_existing_wound_can_mangle_our_exterior = TRUE
			if (initial(pregen_data.wound_path_to_generate.wound_flags) & MANGLES_INTERIOR)
				any_existing_wound_can_mangle_our_interior = TRUE

			if (any_existing_wound_can_mangle_our_interior && any_existing_wound_can_mangle_our_exterior)
				break

//Heals brute and burn damage for the organ. Returns 1 if the damage-icon states changed at all.
//Damage cannot go below zero.
//Cannot remove negative damage (i.e. apply damage)
/obj/item/bodypart/proc/heal_damage(brute, burn, required_bodytype, updating_health = TRUE)
	SHOULD_CALL_PARENT(TRUE)
	if(HAS_TRAIT(owner, TRAIT_NO_HEALS))
		return
	if(required_bodytype && !(bodytype & required_bodytype)) //So we can only heal certain kinds of limbs, ie robotic vs organic.
		return

	if(brute)
		set_brute_dam(round(max(brute_dam - brute, 0), DAMAGE_PRECISION))
	if(burn)
		set_burn_dam(round(max(burn_dam - burn, 0), DAMAGE_PRECISION))

	if(owner)
		if(can_be_disabled)
			update_disabled()
		if(updating_health)
			owner.updatehealth()

		//monkestation edit start
		if(HAS_TRAIT(owner, TRAIT_REVIVES_BY_HEALING))
			owner.cure_husk() // If it has TRAIT_REVIVES_BY_HEALING, it probably can't be cloned. No husk cure, so we cure that here.
			if(owner.stat == DEAD && !HAS_TRAIT(owner, TRAIT_DEFIB_BLACKLISTED) && owner.health > 50)
				owner.revive(FALSE)
		//monkestation edit end

	cremation_progress = min(0, cremation_progress - ((brute_dam + burn_dam)*(100/max_damage)))
	return update_bodypart_damage_state()

///Sets the damage of a bodypart when it is created.
/obj/item/bodypart/proc/set_initial_damage(brute_damage, burn_damage)
	set_brute_dam(brute_damage)
	set_burn_dam(burn_damage)

///Proc to hook behavior associated to the change of the brute_dam variable's value.
/obj/item/bodypart/proc/set_brute_dam(new_value)
	PROTECTED_PROC(TRUE)

	if(brute_dam == new_value)
		return
	. = brute_dam
	brute_dam = new_value


///Proc to hook behavior associated to the change of the burn_dam variable's value.
/obj/item/bodypart/proc/set_burn_dam(new_value)
	PROTECTED_PROC(TRUE)

	if(burn_dam == new_value)
		return
	. = burn_dam
	burn_dam = new_value

//Returns total damage.
/obj/item/bodypart/proc/get_damage()
	var/total = brute_dam + burn_dam
	return total

//Checks disabled status thresholds
/obj/item/bodypart/proc/update_disabled()
	SHOULD_CALL_PARENT(TRUE)

	if(!owner)
		return

	if(!can_be_disabled)
		set_disabled(FALSE)

	if(HAS_TRAIT(src, TRAIT_PARALYSIS))
		set_disabled(TRUE)
		return

	var/total_damage = brute_dam + burn_dam

	// this block of checks is for limbs that can be disabled, but not through pure damage (AKA limbs that suffer wounds, human/monkey parts and such)
	if(!disabling_threshold_percentage)
		if(total_damage < max_damage)
			last_maxed = FALSE
		else
			if(!last_maxed && owner.stat < UNCONSCIOUS)
				INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
			last_maxed = TRUE
		set_disabled(FALSE) // we only care about the paralysis trait
		return

	// we're now dealing solely with limbs that can be disabled through pure damage, AKA robot parts
	if(total_damage >= max_damage * disabling_threshold_percentage)
		if(!last_maxed)
			if(owner.stat < UNCONSCIOUS)
				INVOKE_ASYNC(owner, TYPE_PROC_REF(/mob, emote), "scream")
			last_maxed = TRUE
		set_disabled(TRUE)
		return

	if(bodypart_disabled && total_damage <= max_damage * 0.5) // reenable the limb at 50% health
		last_maxed = FALSE
		set_disabled(FALSE)


///Proc to change the value of the `disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_disabled(new_disabled)
	SHOULD_CALL_PARENT(TRUE)
	PROTECTED_PROC(TRUE)

	if(bodypart_disabled == new_disabled)
		return
	. = bodypart_disabled
	bodypart_disabled = new_disabled

	if(!owner)
		return
	owner.update_health_hud() //update the healthdoll
	owner.update_body()


///Proc to change the value of the `owner` variable and react to the event of its change.
/obj/item/bodypart/proc/set_owner(new_owner)
	SHOULD_CALL_PARENT(TRUE)
	if(owner == new_owner)
		return FALSE //`null` is a valid option, so we need to use a num var to make it clear no change was made.
	var/mob/living/carbon/old_owner = owner
	owner = new_owner
	SEND_SIGNAL(src, COMSIG_BODYPART_CHANGED_OWNER, new_owner, old_owner)
	var/needs_update_disabled = FALSE //Only really relevant if there's an owner
	if(old_owner)
		if(length(bodypart_traits))
			old_owner.remove_traits(bodypart_traits, bodypart_trait_source)
		if(speed_modifier)
			old_owner.update_bodypart_speed_modifier()
		if(initial(can_be_disabled))
			if(HAS_TRAIT(old_owner, TRAIT_NOLIMBDISABLE))
				if(!owner || !HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
					set_can_be_disabled(initial(can_be_disabled))
					needs_update_disabled = TRUE
			UnregisterSignal(old_owner, list(
				SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE),
				SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE),
				SIGNAL_REMOVETRAIT(TRAIT_NOBLOOD),
				SIGNAL_ADDTRAIT(TRAIT_NOBLOOD),
				))
		UnregisterSignal(old_owner, COMSIG_ATOM_RESTYLE)
		UnregisterSignal(old_owner, list(COMSIG_CARBON_ATTACH_LIMB, COMSIG_CARBON_REMOVE_LIMB))
		check_removal_composition(old_owner)
	if(owner)
		if(length(bodypart_traits))
			owner.add_traits(bodypart_traits, bodypart_trait_source)
		if(speed_modifier)
			owner.update_bodypart_speed_modifier()
		if(initial(can_be_disabled))
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				set_can_be_disabled(FALSE)
				needs_update_disabled = FALSE
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_NOLIMBDISABLE), PROC_REF(on_owner_nolimbdisable_trait_loss))
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_NOLIMBDISABLE), PROC_REF(on_owner_nolimbdisable_trait_gain))
			// Bleeding stuff
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_NOBLOOD), PROC_REF(on_owner_nobleed_loss))
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_NOBLOOD), PROC_REF(on_owner_nobleed_gain))
			RegisterSignals(owner, list(COMSIG_CARBON_ATTACH_LIMB, COMSIG_CARBON_REMOVE_LIMB), PROC_REF(reassess_body_composition))

		if(needs_update_disabled)
			update_disabled()

		RegisterSignal(owner, COMSIG_ATOM_RESTYLE, PROC_REF(on_attempt_feature_restyle_mob))
		check_adding_composition(owner)

	refresh_bleed_rate()
	return old_owner

/obj/item/bodypart/proc/on_removal()
	if(!length(bodypart_traits))
		return

	owner.remove_traits(bodypart_traits, bodypart_trait_source)
	check_removal_composition(owner)

///Proc to change the value of the `can_be_disabled` variable and react to the event of its change.
/obj/item/bodypart/proc/set_can_be_disabled(new_can_be_disabled)
	PROTECTED_PROC(TRUE)
	SHOULD_CALL_PARENT(TRUE)

	if(can_be_disabled == new_can_be_disabled)
		return
	. = can_be_disabled
	can_be_disabled = new_can_be_disabled
	if(can_be_disabled)
		if(owner)
			if(HAS_TRAIT(owner, TRAIT_NOLIMBDISABLE))
				CRASH("set_can_be_disabled to TRUE with for limb whose owner has TRAIT_NOLIMBDISABLE")
			RegisterSignal(owner, SIGNAL_ADDTRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_gain))
			RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS), PROC_REF(on_paralysis_trait_loss))
		update_disabled()
	else if(.)
		if(owner)
			UnregisterSignal(owner, list(
				SIGNAL_ADDTRAIT(TRAIT_PARALYSIS),
				SIGNAL_REMOVETRAIT(TRAIT_PARALYSIS),
				))
		set_disabled(FALSE)


///Called when TRAIT_PARALYSIS is added to the limb.
/obj/item/bodypart/proc/on_paralysis_trait_gain(obj/item/bodypart/source)
	PROTECTED_PROC(TRUE)
	SIGNAL_HANDLER

	if(can_be_disabled)
		set_disabled(TRUE)


///Called when TRAIT_PARALYSIS is removed from the limb.
/obj/item/bodypart/proc/on_paralysis_trait_loss(obj/item/bodypart/source)
	PROTECTED_PROC(TRUE)
	SIGNAL_HANDLER

	if(can_be_disabled)
		update_disabled()


///Called when TRAIT_NOLIMBDISABLE is added to the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_gain(mob/living/carbon/source)
	PROTECTED_PROC(TRUE)
	SIGNAL_HANDLER

	set_can_be_disabled(FALSE)


///Called when TRAIT_NOLIMBDISABLE is removed from the owner.
/obj/item/bodypart/proc/on_owner_nolimbdisable_trait_loss(mob/living/carbon/source)
	PROTECTED_PROC(TRUE)
	SIGNAL_HANDLER

	set_can_be_disabled(initial(can_be_disabled))

//Updates an organ's brute/burn states for use by update_damage_overlays()
//Returns 1 if we need to update overlays. 0 otherwise.
/obj/item/bodypart/proc/update_bodypart_damage_state()
	SHOULD_CALL_PARENT(TRUE)

	var/tbrute = round( (brute_dam/max_damage)*3, 1 )
	var/tburn = round( (burn_dam/max_damage)*3, 1 )
	if((tbrute != brutestate) || (tburn != burnstate))
		brutestate = tbrute
		burnstate = tburn
		return TRUE
	return FALSE

//we inform the bodypart of the changes that happened to the owner, or give it the informations from a source mob.
//set is_creating to true if you want to change the appearance of the limb outside of mutation changes or forced changes.
/obj/item/bodypart/proc/update_limb(dropping_limb = FALSE, is_creating = FALSE)
	SHOULD_CALL_PARENT(TRUE)

	if(IS_ORGANIC_LIMB(src))
		if(HAS_TRAIT(owner, TRAIT_HUSK))
			dmg_overlay_type = "" //no damage overlay shown when husked
			is_husked = TRUE
		else if(HAS_TRAIT(owner, TRAIT_INVISIBLE_MAN))
			dmg_overlay_type = "" //no damage overlay shown when invisible since the wounds themselves are invisible.
			is_invisible = TRUE
		else
			dmg_overlay_type = initial(dmg_overlay_type)
			is_husked = FALSE
			is_invisible = FALSE

	if(variable_color)
		draw_color = variable_color
	else if(should_draw_greyscale)
		draw_color = (species_color) || (skin_tone && skintone2hex(skin_tone))
	else
		draw_color = null

	damage_color = owner?.get_blood_type()?.color || COLOR_BLOOD

	if(!is_creating || !owner)
		return

	// There should technically to be an ishuman(owner) check here, but it is absent because no basetype carbons use bodyparts
	// No, xenos don't actually use bodyparts. Don't ask.
	var/mob/living/carbon/human/human_owner = owner
	limb_gender = (human_owner.physique == MALE) ? "m" : "f"
	if(HAS_TRAIT(human_owner, TRAIT_USES_SKINTONES))
		skin_tone = human_owner.skin_tone
	else if(HAS_TRAIT(human_owner, TRAIT_MUTANT_COLORS))
		skin_tone = ""
		if(palette)
			var/datum/color_palette/located = human_owner.dna.color_palettes[palette]
			if(!located)
				species_color = initial(palette.default_color)
			species_color = located.return_color(palette_key)
		else
			var/datum/species/owner_species = human_owner.dna.species
			if(owner_species.fixed_mut_color)
				species_color = owner_species.fixed_mut_color
			else
				if(should_draw_greyscale)
					CRASH("Forgot to move something to new color_palette system [src]")
	else
		skin_tone = ""
		species_color = ""

	draw_color = variable_color
	if(should_draw_greyscale) //Should the limb be colored?
		draw_color ||= species_color || (skin_tone ? skintone2hex(skin_tone) : null)

	recolor_external_organs()
	return TRUE

//to update the bodypart's icon when not attached to a mob
/obj/item/bodypart/proc/update_icon_dropped()
	SHOULD_CALL_PARENT(TRUE)

	cut_overlays()
	var/list/standing = get_limb_icon(TRUE)
	if(!standing.len)
		icon_state = initial(icon_state)//no overlays found, we default back to initial icon.
		return
	for(var/image/img as anything in standing)
		img.pixel_x = px_x
		img.pixel_y = px_y
	add_overlay(standing)

///Generates an /image for the limb to be used as an overlay
/obj/item/bodypart/proc/get_limb_icon(dropped)
	SHOULD_CALL_PARENT(TRUE)
	RETURN_TYPE(/list)

	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	var/image_dir = NONE
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				var/image/bruteimage = image('icons/mob/effects/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
				bruteimage.color = damage_color
				. += bruteimage
			if(burnstate)
				. += image('icons/mob/effects/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	var/image/aux

	// Handles making bodyparts look husked
	if(is_husked)
		limb.icon = icon_husk
		limb.icon_state = "[husk_type]_husk_[body_zone]"
		icon_exists_or_scream(limb.icon, limb.icon_state) //Prints a stack trace on the first failure of a given iconstate. //MONKESTATION EDIT - Refactored to `icon_exists_or_scream`.
		. += limb
		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[husk_type]_husk_[aux_zone]", -aux_layer, image_dir)
			. += aux

	// Handles invisibility (not alpha or actual invisibility but invisibility)
	if(is_invisible)
		limb.icon = icon_invisible
		limb.icon_state = "invisible_[body_zone]"
		. += limb
		return .

	// Normal non-husk handling
	if(!is_husked)
		// This is the MEAT of limb icon code
		limb.icon = icon_greyscale
		if(!should_draw_greyscale || !icon_greyscale)
			limb.icon = icon_static

		if(is_dimorphic) //Does this type of limb have sexual dimorphism?
			limb.icon_state = "[limb_id]_[body_zone]_[limb_gender]"
		else
			limb.icon_state = "[limb_id]_[body_zone]"

		icon_exists_or_scream(limb.icon, limb.icon_state) //Prints a stack trace on the first failure of a given iconstate.

		. += limb

		if(aux_zone) //Hand shit
			aux = image(limb.icon, "[limb_id]_[aux_zone]", -aux_layer, image_dir)
			. += aux

		draw_color = variable_color
		if(should_draw_greyscale) //Should the limb be colored outside of a forced color?
			draw_color ||= (species_color) || (skin_tone && skintone2hex(skin_tone))

		if(draw_color)
			limb.color = "[draw_color]"
			if(aux_zone)
				aux.color = "[draw_color]"

		//EMISSIVE CODE START
		// For some reason this was applied as an overlay on the aux image and limb image before.
		// I am very sure that this is unnecessary, and i need to treat it as part of the return list
		// to be able to mask it proper in case this limb is a leg.
	if(!is_husked)
		var/atom/location = loc || owner || src
		if(blocks_emissive != EMISSIVE_BLOCK_NONE)
			var/mutable_appearance/limb_em_block = emissive_blocker(limb.icon, limb.icon_state, location, layer = limb.layer, alpha = limb.alpha)
			limb_em_block.dir = image_dir
			. += limb_em_block

			if(aux_zone)
				var/mutable_appearance/aux_em_block = emissive_blocker(aux.icon, aux.icon_state, location, layer = aux.layer, alpha = aux.alpha)
				aux_em_block.dir = image_dir
				. += aux_em_block
		if(is_emissive)
			var/mutable_appearance/limb_em = emissive_appearance(limb.icon, "[limb.icon_state]_e", location, layer = limb.layer, alpha = limb.alpha)
			limb_em.dir = image_dir
			. += limb_em

			if(aux_zone)
				var/mutable_appearance/aux_em = emissive_appearance(aux.icon, "[aux.icon_state]_e", location, layer = aux.layer, alpha = aux.alpha)
				aux_em.dir = image_dir
				. += aux_em
	//EMISSIVE CODE END

		//No need to handle leg layering if dropped, we only face south anyways
	if(!dropped && ((body_zone == BODY_ZONE_R_LEG) || (body_zone == BODY_ZONE_L_LEG)))
	//Legs are a bit goofy in regards to layering, and we will need two images instead of one to fix that
		var/obj/item/bodypart/leg/leg_source = src
		for(var/image/limb_image in .)
			//remove the old, unmasked image
			. -= limb_image
			//add two masked images based on the old one
			. += leg_source.generate_masked_leg(limb_image, image_dir)

	// And finally put bodypart_overlays on if not husked
	if(!is_husked)
		//Draw external organs like horns and frills
		for(var/datum/bodypart_overlay/overlay as anything in bodypart_overlays)
			if(!dropped && !overlay.can_draw_on_bodypart(owner)) //if you want different checks for dropped bodyparts, you can insert it here
				continue
			//Some externals have multiple layers for background, foreground and between
			for(var/external_layer in overlay.all_layers)
				if(overlay.layers & external_layer)
					. += overlay.get_overlay(external_layer, src)
					if(overlay.get_secondary_overlay(external_layer, src))
						. += overlay.get_secondary_overlay(external_layer, src)
					if(overlay.get_extended_overlay(external_layer, src))
						for(var/mutable_appearance/item as anything in overlay.get_extended_overlay(external_layer, src))
							. += item

	return .

///Add a bodypart overlay and call the appropriate update procs
/obj/item/bodypart/proc/add_bodypart_overlay(datum/bodypart_overlay/overlay)
	bodypart_overlays += overlay
	overlay.added_to_limb(src)

///Remove a bodypart overlay and call the appropriate update procs
/obj/item/bodypart/proc/remove_bodypart_overlay(datum/bodypart_overlay/overlay)
	bodypart_overlays -= overlay
	overlay.removed_from_limb(src)

/obj/item/bodypart/deconstruct(disassembled = TRUE)
	SHOULD_CALL_PARENT(TRUE)

	drop_organs()
	return ..()

/// INTERNAL PROC, DO NOT USE
/// Properly sets us up to manage an inserted embeded object
/obj/item/bodypart/proc/_embed_object(obj/item/embed)
	if(embed in embedded_objects) // go away
		return
	// We don't need to do anything with projectile embedding, because it will never reach this point
	RegisterSignal(embed, COMSIG_ITEM_EMBEDDING_UPDATE, PROC_REF(embedded_object_changed))
	embedded_objects += embed
	refresh_bleed_rate()

/// INTERNAL PROC, DO NOT USE
/// Cleans up any attachment we have to the embedded object, removes it from our list
/obj/item/bodypart/proc/_unembed_object(obj/item/unembed)
	UnregisterSignal(unembed, COMSIG_ITEM_EMBEDDING_UPDATE)
	embedded_objects -= unembed
	refresh_bleed_rate()

/obj/item/bodypart/proc/embedded_object_changed(obj/item/embedded_source)
	SIGNAL_HANDLER
	/// Embedded objects effect bleed rate, gotta refresh lads
	refresh_bleed_rate()

/// Sets our generic bleedstacks
/obj/item/bodypart/proc/setBleedStacks(set_to)
	SHOULD_CALL_PARENT(TRUE)
	adjustBleedStacks(set_to - generic_bleedstacks)

/// Modifies our generic bleedstacks. You must use this to change the variable
/// Takes the amount to adjust by, and the lowest amount we're allowed to have post adjust
/obj/item/bodypart/proc/adjustBleedStacks(adjust_by, minimum = -INFINITY)
	if(!adjust_by)
		return
	var/old_bleedstacks = generic_bleedstacks
	generic_bleedstacks = max(generic_bleedstacks + adjust_by, minimum)

	// If we've started or stopped bleeding, we need to refresh our bleed rate
	if((old_bleedstacks <= 0 && generic_bleedstacks > 0) \
		|| old_bleedstacks > 0 && generic_bleedstacks <= 0)
		refresh_bleed_rate()

/obj/item/bodypart/proc/on_owner_nobleed_loss(datum/source)
	SIGNAL_HANDLER
	refresh_bleed_rate()

/obj/item/bodypart/proc/on_owner_nobleed_gain(datum/source)
	SIGNAL_HANDLER
	refresh_bleed_rate()

/// Refresh the cache of our rate of bleeding sans any modifiers
/// ANYTHING ADDED TO THIS PROC NEEDS TO CALL IT WHEN IT'S EFFECT CHANGES
/obj/item/bodypart/proc/refresh_bleed_rate()
	SHOULD_NOT_OVERRIDE(TRUE)

	var/old_bleed_rate = cached_bleed_rate
	cached_bleed_rate = 0
	if(!owner)
		return

	if(!can_bleed())
		if(cached_bleed_rate != old_bleed_rate)
			update_part_wound_overlay()
		return

	if(generic_bleedstacks > 0)
		cached_bleed_rate += 0.5

	for(var/obj/item/embeddies in embedded_objects)
		if(!embeddies.isEmbedHarmless())
			cached_bleed_rate += 0.25

	for(var/datum/wound/iter_wound as anything in wounds)
		cached_bleed_rate += iter_wound.blood_flow

	// Our bleed overlay is based directly off bleed_rate, so go aheead and update that would you?
	if(cached_bleed_rate != old_bleed_rate)
		update_part_wound_overlay()

	return cached_bleed_rate

/// Returns our bleed rate, taking into account laying down and grabbing the limb
/obj/item/bodypart/proc/get_modified_bleed_rate()
	var/bleed_rate = cached_bleed_rate
	if(owner.body_position == LYING_DOWN)
		bleed_rate *= 0.75
	if(grasped_by)
		bleed_rate *= 0.7
	return bleed_rate

// how much blood the limb needs to be losing per tick (not counting laying down/self grasping modifiers) to get the different bleed icons
#define BLEED_OVERLAY_LOW 0.5
#define BLEED_OVERLAY_MED 1.5
#define BLEED_OVERLAY_GUSH 3.25

/obj/item/bodypart/proc/update_part_wound_overlay()
	if(!owner)
		return FALSE
	if(!can_bleed())
		if(bleed_overlay_icon)
			bleed_overlay_icon = null
			owner.update_wound_overlays()
		return FALSE

	var/bleed_rate = cached_bleed_rate
	var/new_bleed_icon = null

	switch(bleed_rate)
		if(-INFINITY to BLEED_OVERLAY_LOW)
			new_bleed_icon = null
		if(BLEED_OVERLAY_LOW to BLEED_OVERLAY_MED)
			new_bleed_icon = "[body_zone]_1"
		if(BLEED_OVERLAY_MED to BLEED_OVERLAY_GUSH)
			if(owner.body_position == LYING_DOWN || HAS_TRAIT(owner, TRAIT_STASIS) || owner.stat == DEAD)
				new_bleed_icon = "[body_zone]_2s"
			else
				new_bleed_icon = "[body_zone]_2"
		if(BLEED_OVERLAY_GUSH to INFINITY)
			if(HAS_TRAIT(owner, TRAIT_STASIS) || owner.stat == DEAD)
				new_bleed_icon = "[body_zone]_2s"
			else
				new_bleed_icon = "[body_zone]_3"

	if(new_bleed_icon != bleed_overlay_icon)
		bleed_overlay_icon = new_bleed_icon
		owner.update_wound_overlays()

#undef BLEED_OVERLAY_LOW
#undef BLEED_OVERLAY_MED
#undef BLEED_OVERLAY_GUSH

/obj/item/bodypart/proc/can_bleed()
	SHOULD_BE_PURE(TRUE)

	return ((biological_state & BIO_BLOODED) && (!owner || !HAS_TRAIT(owner, TRAIT_NOBLOOD)))

///Loops through all of the bodypart's external organs and update's their color.
/obj/item/bodypart/proc/recolor_external_organs()
	for(var/datum/bodypart_overlay/mutant/overlay in bodypart_overlays)
		overlay.inherit_color(src, force = TRUE)

///A multi-purpose setter for all things immediately important to the icon and iconstate of the limb.
/obj/item/bodypart/proc/change_appearance(icon, id, greyscale, dimorphic)
	var/icon_holder
	if(greyscale)
		icon_greyscale = icon
		icon_holder = icon
		should_draw_greyscale = TRUE
	else
		icon_static = icon
		icon_holder = icon
		should_draw_greyscale = FALSE

	if(id) //limb_id should never be falsey
		limb_id = id

	if(!isnull(dimorphic))
		is_dimorphic = dimorphic

	if(owner)
		owner.update_body_parts()
	else
		update_icon_dropped()

	//This foot gun needs a safety
	if(!icon_exists(icon_holder, "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"))
		reset_appearance()
		stack_trace("change_appearance([icon], [id], [greyscale], [dimorphic]) generated null icon")

///Resets the base appearance of a limb to it's default values.
/obj/item/bodypart/proc/reset_appearance()
	icon_static = initial(icon_static)
	icon_greyscale = initial(icon_greyscale)
	limb_id = initial(limb_id)
	is_dimorphic = initial(is_dimorphic)
	should_draw_greyscale = initial(should_draw_greyscale)

	if(owner)
		owner.update_body_parts()
	else
		update_icon_dropped()

/obj/item/bodypart/emp_act(severity)
	. = ..()
	if((. & EMP_PROTECT_WIRES) || !IS_ROBOTIC_LIMB(src))
		return FALSE
	owner?.visible_message(span_danger("[owner]'s [src.name] seems to malfunction!"))

	// with defines at the time of writing, this is 3 brute and 2 burn
	// 3 + 2 = 5, with 6 limbs thats 30, on a heavy 60
	// 60 * 0.8 = 48
	var/time_needed = 10 SECONDS
	var/brute_damage = AUGGED_LIMB_EMP_BRUTE_DAMAGE
	var/burn_damage = AUGGED_LIMB_EMP_BURN_DAMAGE
	if(severity == EMP_HEAVY)
		time_needed *= 2
		brute_damage *= 2
		burn_damage *= 2

	receive_damage(brute_damage, burn_damage)
	do_sparks(number = 1, cardinal_only = FALSE, source = owner)
	ADD_TRAIT(src, TRAIT_PARALYSIS, EMP_TRAIT)
	addtimer(CALLBACK(src, PROC_REF(un_paralyze)), time_needed, TIMER_DELETE_ME)
	return TRUE

/obj/item/bodypart/proc/un_paralyze()
	REMOVE_TRAITS_IN(src, EMP_TRAIT)

/// Returns the generic description of our BIO_EXTERNAL feature(s), prioritizing certain ones over others. Returns error on failure.
/obj/item/bodypart/proc/get_external_description()
	if (biological_state & BIO_FLESH)
		return "flesh"
	if (biological_state & BIO_WIRED)
		return "wiring"

	return "error"

/// Returns the generic description of our BIO_INTERNAL feature(s), prioritizing certain ones over others. Returns error on failure.
/obj/item/bodypart/proc/get_internal_description()
	if (biological_state & BIO_BONE)
		return "bone"
	if (biological_state & BIO_METAL)
		return "metal"

	return "error"

/// Returns what message is displayed when the bodypart is on the cusp of being dismembered.
/obj/item/bodypart/proc/get_soon_dismember_message()
	return ", threatening to sever it entirely"

/obj/item/bodypart/chest/get_soon_dismember_message()
	return ", threatening to split it open" // we don't sever, we dump organs when "dismembered"

/obj/item/bodypart/head/get_soon_dismember_message()
	return ", threatening to split it open" // we don't sever, we cranial fissure when "dismembered" // we also don't dismember i think

/obj/item/bodypart/proc/return_compoostion_precent(mob/living/carbon/checker)
	var/matching_ids = 0
	for(var/obj/item/bodypart/bodypart as anything in checker.bodyparts)
		if((bodypart.limb_id != limb_id) && !(bodypart.limb_id in shared_composition))
			continue
		matching_ids++

	return matching_ids / TOTAL_BODYPART_COUNT

/obj/item/bodypart/proc/check_removal_composition(mob/living/carbon/remover)
	var/precent = return_compoostion_precent(remover)

	for(var/item as anything in composition_effects)
		if(composition_effects[item] < precent)
			continue
		if(!ispath(item))
			REMOVE_TRAIT(remover, item, BODYPART_TRAIT)
		else
			if(ispath(item, /datum/component))
				var/datum/component/component = remover.GetComponent(item)
				if(component)
					qdel(component)
			else if(ispath(item, /datum/element))
				if(!HasElement(remover, item))
					continue
				remover.RemoveElement(item)

/obj/item/bodypart/proc/check_adding_composition(mob/living/carbon/adder)
	var/precent = return_compoostion_precent(adder)

	for(var/item as anything in composition_effects)
		if(composition_effects[item] > precent)
			continue
		if(!ispath(item))
			if(HAS_TRAIT_FROM(adder, item, BODYPART_TRAIT))
				continue
			ADD_TRAIT(adder, item, BODYPART_TRAIT)
		else
			if(ispath(item, /datum/component))
				if(adder.GetComponent(item))
					continue
				adder.AddComponent(item)
			else if(ispath(item, /datum/element))
				if(HasElement(adder, item))
					continue
				adder.AddElement(item)

/obj/item/bodypart/proc/reassess_body_composition(mob/living/carbon/adder)
	SIGNAL_HANDLER

	check_removal_composition(adder) //remove first
	check_adding_composition(adder) //then
