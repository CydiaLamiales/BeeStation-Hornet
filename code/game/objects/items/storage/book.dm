/obj/item/storage/book
	name = "hollowed book"
	desc = "I guess someone didn't like it."
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	throw_speed = 2
	throw_range = 5
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FLAMMABLE
	var/title = "book"
	item_flags = ISWEAPON

/obj/item/storage/book/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 1

/obj/item/storage/book/attack_self(mob/user)
	to_chat(user, "<span class='notice'>The pages of [title] have been cut out!</span>")

/mob/proc/bible_check() //The bible, if held, might protect against certain things
	var/obj/item/storage/book/bible/B = locate() in src
	if(is_holding(B))
		return B
	return 0

/obj/item/storage/book/bible
	name = "bible"
	desc = "Apply to head repeatedly."
	icon = 'icons/obj/storage.dmi'
	icon_state = "bible"
	item_state = "bible"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	var/mob/affecting = null
	var/deity_name = "Christ"
	force_string = "holy"

/obj/item/storage/book/bible/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/anti_magic, FALSE, TRUE, _allowed_slots = ITEM_SLOT_HANDS)

/obj/item/storage/book/bible/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is offering [user.p_them()]self to [deity_name]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (BRUTELOSS)

/obj/item/storage/book/bible/attack_self(mob/living/carbon/human/H)
	if(!istype(H))
		return
	// If H is the Chaplain, we can set the icon_state of the bible (but only once per bible)
	if(!current_skin && H.mind.holy_role == HOLY_ROLE_HIGHPRIEST)
		if(GLOB.bible_icon_state)//If the original has been reskinned but this one hasn't been, we make it look like the original
			icon_state = GLOB.bible_icon_state
			item_state = GLOB.bible_item_state
			if(icon_state == "honk1" || icon_state == "honk2")
				var/mob/living/carbon/C = H
				if(C.has_dna())
					C.dna.add_mutation(CLOWNMUT)
				C.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/clown_hat(C), ITEM_SLOT_MASK)
			src.update_icon()
			return
		if(isnull(unique_reskin_icon))
			unique_reskin_icon = list(
			"Bible" = "bible",
			"Quran" = "koran",
			"Scrapbook" = "scrapbook",
			"Burning Bible" = "burning",
			"Clown Bible" = "honk1",
			"Banana Bible" = "honk2",
			"Creeper Bible" = "creeper",
			"White Bible" = "white",
			"Holy Light" = "holylight",
			"The God Delusion" = "atheist",
			"Tome" = "tome",
			"The King in Yellow" = "kingyellow",
			"Ithaqua" = "ithaqua",
			"Scientology" = "scientology",
			"Melted Bible" = "melted",
			"Necronomicon" = "necronomicon",
			"Insulationism" = "insuls"
		)
		if(isnull(unique_reskin))
			unique_reskin = list( //Unique_reskin is declared here so that the bible can't be reskinned through alt-clicking
				"Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "bible"),
				"Quran" = image(icon = 'icons/obj/storage.dmi', icon_state = "koran"),
				"Scrapbook" = image(icon = 'icons/obj/storage.dmi', icon_state = "scrapbook"),
				"Burning Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "burning"),
				"Clown Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "honk1"),
				"Banana Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "honk2"),
				"Creeper Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "creeper"),
				"White Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "white"),
				"Holy Light" = image(icon = 'icons/obj/storage.dmi', icon_state = "holylight"),
				"The God Delusion" = image(icon = 'icons/obj/storage.dmi', icon_state = "atheist"),
				"Tome" = image(icon = 'icons/obj/storage.dmi', icon_state = "tome"),
				"The King in Yellow" = image(icon = 'icons/obj/storage.dmi', icon_state = "kingyellow"),
				"Ithaqua" = image(icon = 'icons/obj/storage.dmi', icon_state = "ithaqua"),
				"Scientology" = image(icon = 'icons/obj/storage.dmi', icon_state = "scientology"),
				"Melted Bible" = image(icon = 'icons/obj/storage.dmi', icon_state = "melted"),
				"Necronomicon" = image(icon = 'icons/obj/storage.dmi', icon_state = "necronomicon"),
				"Insulationism" = image(icon = 'icons/obj/storage.dmi', icon_state = "insuls")
			)
		reskin_bible(H)

/obj/item/storage/book/bible/proc/reskin_bible(mob/M)//Total override of the proc because I need some new things added to it
	var/choice = show_radial_menu(M, src, unique_reskin, radius = 42, require_near = TRUE, tooltips = TRUE)
	if(!QDELETED(src) && choice && !current_skin && !M.incapacitated() && in_range(M,src))
		if(!unique_reskin[choice])
			return
		current_skin = choice
		icon_state = unique_reskin_icon[choice]
		GLOB.bible_icon_state = icon_state
		item_state = unique_reskin_icon[choice]
		GLOB.bible_item_state = item_state
		if(choice == "Clown Bible" || choice == "Banana Bible")
			var/mob/living/carbon/C = M
			if(C.has_dna())
				C.dna.add_mutation(CLOWNMUT)
			C.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/clown_hat(C), ITEM_SLOT_MASK)
		to_chat(M, "[src] is now skinned as '[choice].'")
		src.update_icon()
		SSblackbox.record_feedback("text", "religion_book", 1, "[choice]")//I don't know why it's here but I'm keeping it in case it breaks something
	return

/obj/item/storage/book/bible/proc/bless(mob/living/L, mob/living/user)
	if(GLOB.religious_sect)
		return GLOB.religious_sect.sect_bless(L,user)
	if(!ishuman(L))
		return

	var/mob/living/carbon/human/H = L

	for(var/X in H.bodyparts)
		var/obj/item/bodypart/BP = X
		if(!IS_ORGANIC_LIMB(BP))
			to_chat(user, "<span class='warning'>[src.deity_name] refuses to heal this metallic taint!</span>")
			return 0

	var/heal_amt = 10
	var/list/hurt_limbs = H.get_damaged_bodyparts(1, 1, null, BODYTYPE_ORGANIC)

	if(hurt_limbs.len)
		for(var/X in hurt_limbs)
			var/obj/item/bodypart/affecting = X
			if(affecting.heal_damage(heal_amt, heal_amt, null, BODYTYPE_ORGANIC))
				H.update_damage_overlays()
		H.visible_message("<span class='notice'>[user] heals [H] with the power of [deity_name]!</span>")
		to_chat(H, "<span class='boldnotice'>May the power of [deity_name] compel you to be healed!</span>")
		playsound(src.loc, "punch", 25, 1, -1)
		SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "blessing", /datum/mood_event/blessing)
	return 1

/obj/item/storage/book/bible/attack(mob/living/M, mob/living/carbon/human/user, heal_mode = TRUE)

	if (!user.IsAdvancedToolUser())
		to_chat(user, "<span class='warning'>You don't have the dexterity to do this!</span>")
		return

	if (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		to_chat(user, "<span class='danger'>[src] slips out of your hand and hits your head.</span>")
		user.take_bodypart_damage(10)
		user.Unconscious(400)
		return

	var/chaplain = 0
	if(user?.mind?.holy_role)
		chaplain = 1

	if(!chaplain)
		to_chat(user, "<span class='danger'>The book sizzles in your hands.</span>")
		user.take_bodypart_damage(0,10)
		return

	if (!heal_mode)
		return ..()

	var/smack = 1

	if (M.stat != DEAD)
		if(chaplain && user == M)
			to_chat(user, "<span class='warning'>You can't heal yourself!</span>")
			return

		if(prob(60) && bless(M, user))
			smack = 0
		else if(iscarbon(M))
			var/mob/living/carbon/C = M
			if(!istype(C.head, /obj/item/clothing/head/helmet))
				C.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, 60)
				to_chat(C, "<span class='danger'>You feel dumber.</span>")

		if(smack)
			M.visible_message("<span class='danger'>[user] beats [M] over the head with [src]!</span>", \
					"<span class='userdanger'>[user] beats [M] over the head with [src]!</span>")
			playsound(src.loc, "punch", 25, 1, -1)
			log_combat(user, M, "attacked", src)

	else
		M.visible_message("<span class='danger'>[user] smacks [M]'s lifeless corpse with [src].</span>")
		playsound(src.loc, "punch", 25, 1, -1)

/obj/item/storage/book/bible/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(isfloorturf(A))
		to_chat(user, "<span class='notice'>You hit the floor with the bible.</span>")
		if(user?.mind?.holy_role)
			for(var/obj/effect/rune/R in orange(2,user))
				R.invisibility = 0
	if(user?.mind?.holy_role)
		if(A.reagents && A.reagents.has_reagent(/datum/reagent/water)) // blesses all the water in the holder
			to_chat(user, "<span class='notice'>You bless [A].</span>")
			var/water2holy = A.reagents.get_reagent_amount(/datum/reagent/water)
			A.reagents.del_reagent(/datum/reagent/water)
			A.reagents.add_reagent(/datum/reagent/water/holywater,water2holy)
		if(A.reagents && A.reagents.has_reagent(/datum/reagent/fuel/unholywater)) // yeah yeah, copy pasted code - sue me
			to_chat(user, "<span class='notice'>You purify [A].</span>")
			var/unholy2clean = A.reagents.get_reagent_amount(/datum/reagent/fuel/unholywater)
			A.reagents.del_reagent(/datum/reagent/fuel/unholywater)
			A.reagents.add_reagent(/datum/reagent/water/holywater,unholy2clean)
		if(istype(A, /obj/item/storage/book/bible) && !istype(A, /obj/item/storage/book/bible/syndicate))
			to_chat(user, "<span class='notice'>You purify [A], conforming it to your belief.</span>")
			var/obj/item/storage/book/bible/B = A
			B.name = name
			B.icon_state = icon_state
			B.item_state = item_state
	if(istype(A, /obj/item/cult_bastard) && !iscultist(user))
		var/obj/item/cult_bastard/sword = A
		to_chat(user, "<span class='notice'>You begin to exorcise [sword].</span>")
		playsound(src,'sound/hallucinations/veryfar_noise.ogg',40,1)
		if(do_after(user, 4 SECONDS, target = sword, show_to_target = TRUE, add_item = src))
			playsound(src,'sound/effects/pray_chaplain.ogg',60,1)
			for(var/obj/item/soulstone/SS in sword.contents)
				SS.usability = TRUE
				for(var/mob/living/simple_animal/shade/EX in SS)
					SSticker.mode.remove_cultist(EX.mind, 1, 0)
					EX.icon_state = "ghost1"
					EX.name = "Purified [EX.name]"
				SS.release_shades(user)
				qdel(SS)
			new /obj/item/nullrod/claymore(get_turf(sword))
			user.visible_message("<span class='notice'>[user] has purified [sword]!</span>")
			qdel(sword)

	else if(istype(A, /obj/item/soulstone) && !iscultist(user))
		var/obj/item/soulstone/SS = A
		if(SS.purified)
			return
		to_chat(user, "<span class='notice'>You begin to exorcise [SS].</span>")
		playsound(src,'sound/hallucinations/veryfar_noise.ogg',40,1)
		if(do_after(user, 4 SECONDS, target = SS, show_to_target = TRUE, add_item = src))
			playsound(src,'sound/effects/pray_chaplain.ogg',60,1)
			SS.usability = TRUE
			SS.purified = TRUE
			SS.icon_state = "purified_soulstone"
			for(var/mob/M in SS.contents)
				if(M.mind)
					SS.icon_state = "purified_soulstone2"
					if(iscultist(M))
						SSticker.mode.remove_cultist(M.mind, FALSE, FALSE)
			for(var/mob/living/simple_animal/shade/EX in SS)
				EX.icon_state = "ghost1"
				EX.name = "Purified [initial(EX.name)]"
			user.visible_message("<span class='notice'>[user] has purified [SS]!</span>")

/obj/item/storage/book/bible/booze
	desc = "To be applied to the head repeatedly."

/obj/item/storage/book/bible/booze/PopulateContents()
	new /obj/item/reagent_containers/food/drinks/bottle/whiskey(src)

/obj/item/storage/book/bible/syndicate
	icon_state ="ebook"
	deity_name = "The Syndicate"
	throw_speed = 2
	throwforce = 18
	throw_range = 7
	force = 18
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	name = "Syndicate Tome"
	attack_verb = list("attacked", "burned", "blessed", "damned", "scorched")
	var/uses = 1

/obj/item/storage/book/bible/syndicate/attack_self(mob/living/carbon/human/H)
	if (uses)
		H.mind.holy_role = HOLY_ROLE_PRIEST
		uses -= 1
		to_chat(H, "<span class='userdanger'>You try to open the book AND IT BITES YOU!</span>")
		playsound(src.loc, 'sound/effects/snap.ogg', 50, 1)
		H.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
		to_chat(H, "<span class='notice'>Your name appears on the inside cover, in blood.</span>")
		var/ownername = H.real_name
		desc += "<span class='warning'>The name [ownername] is written in blood inside the cover.</span>"

/obj/item/storage/book/bible/syndicate/attack(mob/living/M, mob/living/carbon/human/user, heal_mode = TRUE)
	if (user.a_intent == INTENT_HELP)
		return ..()
	else
		return ..(M,user,heal_mode = FALSE)

/obj/item/storage/book/bible/syndicate/add_blood_DNA(list/blood_dna)
	return FALSE
