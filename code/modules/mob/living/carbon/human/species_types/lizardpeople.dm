/datum/species/lizard
	// Reptilian humanoids with scaled skin and tails.
	name = "\improper Lizardperson"
	id = SPECIES_LIZARD
	bodyflag = FLAG_LIZARD
	default_color = "00FF00"
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS)
	inherent_biotypes = list(MOB_ORGANIC, MOB_HUMANOID, MOB_REPTILE)
	mutant_bodyparts = list("tail_lizard", "snout", "spines", "horns", "frills", "body_markings", "legs")
	mutant_heart = /obj/item/organ/heart/lizard
	mutanttongue = /obj/item/organ/tongue/lizard
	mutanttail = /obj/item/organ/tail/lizard
	coldmod = 1.5
	heatmod = 0.67
	default_features = list("mcolor" = "0F0", "tail_lizard" = "Smooth", "snout" = "Round", "horns" = "None", "frills" = "None", "spines" = "None", "body_markings" = "None", "legs" = "Normal Legs", "body_size" = "Normal")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	attack_verb = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	miss_sound = 'sound/weapons/slashmiss.ogg'
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/lizard
	skinned_type = /obj/item/stack/sheet/animalhide/lizard
	exotic_bloodtype = "L"
	inert_mutation = FIREBREATH
	deathsound = 'sound/voice/lizard/deathsound.ogg'
	species_language_holder = /datum/language_holder/lizard
	digitigrade_customization = DIGITIGRADE_OPTIONAL

	species_chest = /obj/item/bodypart/chest/lizard
	species_head = /obj/item/bodypart/head/lizard
	species_l_arm = /obj/item/bodypart/l_arm/lizard
	species_r_arm = /obj/item/bodypart/r_arm/lizard
	species_l_leg = /obj/item/bodypart/l_leg/lizard
	species_r_leg = /obj/item/bodypart/r_leg/lizard


/datum/species/lizard/random_name(gender, unique, lastname, attempts)
	if(gender == MALE)
		. = "[pick(GLOB.lizard_names_male)]-[pick(GLOB.lizard_names_male)]"
	else
		. = "[pick(GLOB.lizard_names_female)]-[pick(GLOB.lizard_names_female)]"

	if(unique && attempts < 10)
		if(findname(.))
			. = .(gender, TRUE, null, ++attempts)

//I wag in death
/datum/species/lizard/spec_death(gibbed, mob/living/carbon/human/H)
	if(H)
		stop_wagging_tail(H)

/datum/species/lizard/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/datum/species/lizard/on_species_gain(mob/living/carbon/C, datum/species/old_species, pref_load)
	. = ..()
	if(pref_load)
		C.bodytemperature = T20C //If we're spawning in as a lizard, we should be same temp as the normal air temp

/datum/species/lizard/get_scream_sound(mob/living/carbon/user)
	return pick('sound/voice/lizard/lizard_scream_1.ogg', 'sound/voice/lizard/lizard_scream_2.ogg', 'sound/voice/lizard/lizard_scream_3.ogg', 'sound/voice/lizard/lizard_scream_4.ogg')

/datum/species/lizard/get_cough_sound(mob/living/carbon/user)
	return SPECIES_DEFAULT_COUGH_SOUND(user)

/datum/species/lizard/get_gasp_sound(mob/living/carbon/user)
	return SPECIES_DEFAULT_GASP_SOUND(user)

/datum/species/lizard/get_sigh_sound(mob/living/carbon/user)
	return SPECIES_DEFAULT_SIGH_SOUND(user)

/datum/species/lizard/get_sneeze_sound(mob/living/carbon/user)
	return SPECIES_DEFAULT_SNEEZE_SOUND(user)

/datum/species/lizard/get_sniff_sound(mob/living/carbon/user)
	return SPECIES_DEFAULT_SNIFF_SOUND(user)

/*
 Lizard subspecies: ASHWALKERS
*/
/datum/species/lizard/ashwalker
	name = "Ash Walker"
	id = SPECIES_ASHWALKER
	examine_limb_id = SPECIES_LIZARD
	species_traits = list(MUTCOLORS,EYECOLOR,LIPS, NO_UNDERWEAR)
	inherent_traits = list(TRAIT_NOGUNS)
	species_language_holder = /datum/language_holder/lizard/ash
	mutantlungs = /obj/item/organ/lungs/ashwalker
	digitigrade_customization = DIGITIGRADE_FORCED
