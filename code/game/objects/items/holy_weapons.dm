// CHAPLAIN CUSTOM ARMORS //

/obj/item/clothing/suit/armor/riot/chaplain/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, null, FALSE)

/obj/item/clothing/suit/hooded/chaplain_hoodie/leader/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, null, FALSE) //makes the leader hoodie immune without giving the follower hoodies immunity

/obj/item/clothing/head/helmet/chaplain
	name = "crusader helmet"
	desc = "Deus Vult."
	icon_state = "knight_templar"
	item_state = "knight_templar"
	armor = list(MELEE = 50,  BULLET = 10, LASER = 10, ENERGY = 10, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 80, STAMINA = 40)
	flags_inv = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH
	strip_delay = 80
	dog_fashion = null

/obj/item/clothing/suit/armor/riot/chaplain
	name = "crusader armour"
	desc = "God wills it!"
	icon_state = "knight_templar"
	item_state = "knight_templar"
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	slowdown = 0
	blocks_shove_knockdown = FALSE
	move_sound = null

/obj/item/choice_beacon/radial/holy
	name = "armaments beacon"
	desc = "Contains a set of armaments for the chaplain that have been reinforced with a silver and beryllium-bronze alloy, providing immunity to magic and its influences."

/obj/item/choice_beacon/radial/holy/canUseBeacon(mob/living/user)
	if(user.mind?.holy_role)
		return ..()
	else
		playsound(src, 'sound/machines/buzz-sigh.ogg', 40, 1)
		return FALSE

/obj/item/choice_beacon/radial/holy/generate_options(mob/living/M)
	var/list/item_list = generate_item_list()
	if(!item_list.len)
		return
	var/choice = show_radial_menu(M, src, item_list, radius = 36, require_near = TRUE, tooltips = TRUE)
	if(!QDELETED(src) && !(isnull(choice)) && !M.incapacitated() && in_range(M,src))
		var/list/temp_list = typesof(/obj/item/storage/box/holy)
		for(var/V in temp_list)
			var/atom/A = V
			if(initial(A.name) == choice)
				spawn_option(A,M)
				uses--
				if(!uses)
					qdel(src)
				else
					balloon_alert(M, "[uses] use[uses > 1 ? "s" : ""] remaining")
					to_chat(M, "<span class='notice'>[uses] use[uses > 1 ? "s" : ""] remaining on the [src].</span>")
				return

/obj/item/choice_beacon/radial/holy/generate_item_list()
	var/static/list/item_list
	if(!item_list)
		item_list = list()
		var/list/templist = typesof(/obj/item/storage/box/holy)
		for(var/V in templist)
			var/obj/item/storage/box/holy/boxy = V
			var/image/outfit_icon = image(initial(boxy.item_icon_file), initial(boxy.item_icon_state))
			var/datum/radial_menu_choice/choice = new
			choice.image = outfit_icon
			var/info_text = "That's [icon2html(outfit_icon, usr)] "
			info_text += initial(boxy.info_text)
			choice.info = info_text
			item_list[initial(boxy.name)] = choice
	return item_list

/obj/item/choice_beacon/radial/holy/spawn_option(obj/choice,mob/living/M)
	..()
	playsound(src, 'sound/effects/pray_chaplain.ogg', 40, 1)
	SSblackbox.record_feedback("tally", "chaplain_armor", 1, "[choice]")

/obj/item/storage/box/holy
	name = "Templar Kit"
	var/icon/item_icon_file = 'icons/misc/premade_loadouts.dmi'
	var/item_icon_state = "templar"
	var/info_text = "Templar Kit, for waging a holy war against the unfaithful. \n<span class='notice'>The armor can hold a variety of religious items.</span>"

/obj/item/storage/box/holy/PopulateContents()
	new /obj/item/clothing/head/helmet/chaplain(src)
	new /obj/item/clothing/suit/armor/riot/chaplain(src)

/obj/item/storage/box/holy/student
	name = "Profane Scholar Kit"
	item_icon_state = "mikolash"
	info_text = "Profane Scholar Kit, for granting the common masses the sight to the beyond. \n<span class='notice'>The robe can hold a variety of religious items.</span>"

/obj/item/storage/box/holy/student/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/studentuni(src)
	new /obj/item/clothing/head/helmet/chaplain/cage(src)

/obj/item/clothing/suit/armor/riot/chaplain/studentuni
	name = "student robe"
	desc = "The uniform of a bygone institute of learning."
	icon_state = "studentuni"
	item_state = "studentuni"
	body_parts_covered = ARMS|CHEST
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)

/obj/item/clothing/head/helmet/chaplain/cage
	name = "cage"
	desc = "A cage that restrains the will of the self, allowing one to see the profane world for what it is."
	worn_icon = 'icons/mob/large-worn-icons/64x64/head.dmi'
	icon_state = "cage"
	item_state = "cage"
	worn_x_dimension = 64
	worn_y_dimension = 64
	dynamic_hair_suffix = ""

/obj/item/storage/box/holy/sentinel
	name = "Stone Sentinel Kit"
	item_icon_state = "giantdad"
	info_text = "Stone Sentinel Kit, for making a stalwart stance against herecy. \n<span class='notice'>The armor can hold a variety of religious items.</span>"

/obj/item/storage/box/holy/sentinel/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/ancient(src)
	new /obj/item/clothing/head/helmet/chaplain/ancient(src)

/obj/item/clothing/head/helmet/chaplain/ancient
	name = "ancient helmet"
	desc = "None may pass!"
	icon_state = "knight_ancient"
	item_state = "knight_ancient"

/obj/item/clothing/suit/armor/riot/chaplain/ancient
	name = "ancient armour"
	desc = "Defend the treasure..."
	icon_state = "knight_ancient"
	item_state = "knight_ancient"

/obj/item/storage/box/holy/witchhunter
	name = "Witchhunter Kit"
	item_icon_state = "witchhunter"
	info_text = "Witchhunter Kit, for burning the wicked at the stake. \n<span class='notice'>The garb can hold a variety of religious items. \nComes with a crucifix that wards against hexes.</span>"

/obj/item/storage/box/holy/witchhunter/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/witchhunter(src)
	new /obj/item/clothing/head/helmet/chaplain/witchunter_hat(src)
	new /obj/item/clothing/neck/crucifix(src)

/obj/item/clothing/suit/armor/riot/chaplain/witchhunter
	name = "witchunter garb"
	desc = "This worn outfit saw much use back in the day."
	icon_state = "witchhunter"
	item_state = "witchhunter"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/head/helmet/chaplain/witchunter_hat
	name = "witchunter hat"
	desc = "This hat saw much use back in the day."
	icon_state = "witchhunterhat"
	item_state = "witchhunterhat"
	flags_cover = HEADCOVERSEYES

/obj/item/storage/box/holy/graverobber
	name = "Grave Robber Kit"
	item_icon_state = "graverobber"
	info_text = "Grave Robber Kit, for finding the treasures of those who parted this world. \n<span class='notice'>The coat can hold a variety of religious items. \nPickaxe not included.</span>"

/obj/item/storage/box/holy/graverobber/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/graverobber_coat(src)
	new /obj/item/clothing/under/rank/civilian/graverobber_under(src)
	new /obj/item/clothing/head/chaplain/graverobber_hat(src)
	new /obj/item/clothing/gloves/graverobber_gloves(src)

/obj/item/clothing/suit/armor/riot/chaplain/graverobber_coat
	name = "grave robber coat"
	desc = "To those with a keen eye, gold gleams like a dagger's point."
	icon_state = "graverobber_coat"
	item_state = "graverobber_coat"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/head/chaplain/graverobber_hat
	name = "grave robber hat"
	desc = "A tattered leather hat. It reeks of death."
	icon_state = "graverobber_hat"
	item_state = "graverobber_hat"
	flags_cover = HEADCOVERSEYES

/obj/item/clothing/gloves/graverobber_gloves
	name = "grave robber gloves"
	desc = "A pair of leather gloves in poor condition."
	icon_state = "graverobber-gloves"
	item_state = "graverobber-gloves"
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = list(MELEE = 0,  BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 20, STAMINA = 0)

/obj/item/clothing/under/rank/civilian/graverobber_under
	name = "grave robber uniform"
	desc = "A shirt and some leather pants in poor condition."
	icon_state = "graverobber_under"
	item_state = "graverobber_under"
	can_adjust = FALSE

/obj/item/storage/box/holy/adept
	name = "Divine Adept Kit"
	item_icon_state = "crusader"
	info_text = "Divine Adept Kit, for standing stalward with unvavering faith. \n<span class='notice'>The robes can hold a variety of religious items.</span>"

/obj/item/storage/box/holy/adept/PopulateContents()
	new /obj/item/clothing/suit/armor/riot/chaplain/adept(src)
	new /obj/item/clothing/head/helmet/chaplain/adept(src)

/obj/item/clothing/head/helmet/chaplain/adept
	name = "adept hood"
	desc = "Its only heretical when others do it."
	icon_state = "crusader"
	item_state = "crusader"
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/armor/riot/chaplain/adept
	name = "adept robes"
	desc = "The ideal outfit for burning the unfaithful."
	icon_state = "crusader"
	item_state = "crusader"

/obj/item/storage/box/holy/follower
	name = "Followers of the Chaplain Kit"
	item_icon_state = "leader"
	info_text = "Divine Adept Kit, for starting a non-heretical cult of your own. \n<span class='notice'>The hoodie can hold a variety of religious items. \nComes with four follower hoodies.</span>"

/obj/item/storage/box/holy/follower/PopulateContents()
	new /obj/item/clothing/suit/hooded/chaplain_hoodie/leader(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)
	new /obj/item/clothing/suit/hooded/chaplain_hoodie(src)

/obj/item/clothing/suit/hooded/chaplain_hoodie
	name = "follower hoodie"
	desc = "Hoodie made for acolytes of the chaplain."
	icon_state = "chaplain_hoodie"
	item_state = "chaplain_hoodie"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/storage/book/bible, /obj/item/nullrod, /obj/item/reagent_containers/food/drinks/bottle/holywater, /obj/item/storage/fancy/candle_box, /obj/item/candle, /obj/item/tank/internals/emergency_oxygen, /obj/item/tank/internals/plasmaman)
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood

/obj/item/clothing/head/hooded/chaplain_hood
	name = "follower hood"
	desc = "Hood made for acolytes of the chaplain."
	icon_state = "chaplain_hood"
	body_parts_covered = HEAD
	flags_inv = HIDEHAIR|HIDEFACE|HIDEEARS

/obj/item/clothing/suit/hooded/chaplain_hoodie/leader
	name = "leader hoodie"
	desc = "Now you're ready for some 50 dollar bling water."
	icon_state = "chaplain_hoodie_leader"
	item_state = "chaplain_hoodie_leader"
	hoodtype = /obj/item/clothing/head/hooded/chaplain_hood/leader

/obj/item/clothing/head/hooded/chaplain_hood/leader
	name = "leader hood"
	desc = "I mean, you don't /have/ to seek bling water. I just think you should."
	icon_state = "chaplain_hood_leader"


// CHAPLAIN NULLROD AND CUSTOM WEAPONS //

/obj/item/nullrod
	name = "null rod"
	desc = "A rod of pure obsidian; its very presence disrupts and dampens the powers of Nar'Sie and Ratvar's followers."
	icon_state = "nullrod"
	item_state = "nullrod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	block_upgrade_walk = 1
	force = 18
	throw_speed = 3
	throw_range = 4
	throwforce = 10
	item_flags = ISWEAPON
	w_class = WEIGHT_CLASS_TINY
	obj_flags = UNIQUE_RENAME
	var/chaplain_spawnable = TRUE

/obj/item/nullrod/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, null, FALSE)
	AddComponent(/datum/component/effect_remover, \
	success_feedback = "You disrupt the magic of %THEEFFECT with %THEWEAPON.", \
	success_forcesay = "BEGONE FOUL MAGIKS!!", \
	on_clear_callback = CALLBACK(src, PROC_REF(on_cult_rune_removed)), \
	effects_we_clear = list(/obj/effect/rune, /obj/effect/heretic_rune))

/obj/item/nullrod/suicide_act(mob/living/user)
	user.visible_message("<span class='suicide'>[user] is killing [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to get closer to god!</span>")
	return (BRUTELOSS|FIRELOSS)

/obj/item/nullrod/attack_self(mob/user)
	if(user.mind && (user.mind.holy_role) && !current_skin)
		reskin_holy_weapon(user)

/obj/item/nullrod/proc/reskin_holy_weapon(mob/M)
	if(isnull(unique_reskin))
		unique_reskin = list(
			"Null Rod" = /obj/item/nullrod,
			"God Hand" = /obj/item/nullrod/godhand,
			"Red Holy Staff" = /obj/item/nullrod/staff,
			"Blue Holy Staff" = /obj/item/nullrod/staff/blue,
			"Claymore" = /obj/item/nullrod/claymore,
			"Dark Blade" = /obj/item/nullrod/claymore/darkblade,
			"Sacred Chainsaw Sword" = /obj/item/nullrod/claymore/chainsaw_sword,
			"Force Weapon" = /obj/item/nullrod/claymore/glowing,
			"Hanzo Steel" = /obj/item/nullrod/claymore/katana,
			"Extradimensional Blade" = /obj/item/nullrod/claymore/multiverse,
			"Light Energy Sword" = /obj/item/nullrod/claymore/saber,
			"Dark Energy Sword" = /obj/item/nullrod/claymore/saber/red,
			"Nautical Energy Sword" = /obj/item/nullrod/claymore/saber/pirate,
			"UNREAL SORD" = /obj/item/nullrod/sord,
			"Reaper Scythe" = /obj/item/nullrod/scythe,
			"High Frequency Blade" = /obj/item/nullrod/scythe/vibro,
			"Dormant Spellblade" = /obj/item/nullrod/scythe/spellblade,
			"Possessed Blade" = /obj/item/nullrod/scythe/talking,
			"Possessed Chainsaw Sword" = /obj/item/nullrod/scythe/talking/chainsword,
			"Relic War Hammer" = /obj/item/nullrod/hammmer,
			"Chainsaw Hand" = /obj/item/nullrod/chainsaw,
			"Clown Dagger" = /obj/item/nullrod/clown,
			"Pride-struck Hammer" = /obj/item/nullrod/pride_hammer,
			"Holy Whip" = /obj/item/nullrod/whip,
			"Atheist's Fedora" = /obj/item/nullrod/fedora,
			"Dark Blessing" = /obj/item/nullrod/armblade,
			"Unholy Blessing" = /obj/item/nullrod/armblade/tentacle,
			"Carp-Sie Plushie" = /obj/item/nullrod/carp,
			"Monk's Staff" = /obj/item/nullrod/claymore/bostaff,
			"Arrythmic Knife" = /obj/item/nullrod/tribal_knife,
			"Unholy Pitchfork" = /obj/item/nullrod/pitchfork,
			"Egyptian Staff" = /obj/item/nullrod/egyptian,
			"Hypertool" = /obj/item/nullrod/hypertool,
			"Ancient Spear" = /obj/item/nullrod/spear
		)
	if(isnull(unique_reskin_icon))
		unique_reskin_icon = list(
			"Null Rod" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "nullrod"),
			"God Hand" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "disintegrate"),
			"Red Holy Staff" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "godstaff-red"),
			"Blue Holy Staff" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "godstaff-blue"),
			"Claymore" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "claymore"),
			"Dark Blade" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "cultblade"),
			"Sacred Chainsaw Sword" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "chainswordon"),
			"Force Weapon" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "swordon"),
			"Hanzo Steel" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "katana"),
			"Extradimensional Blade" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "multiverse"),
			"Light Energy Sword" = image(icon = 'icons/obj/transforming_energy.dmi', icon_state = "swordblue"),
			"Dark Energy Sword" = image(icon = 'icons/obj/transforming_energy.dmi', icon_state = "swordred"),
			"Nautical Energy Sword" = image(icon = 'icons/obj/transforming_energy.dmi', icon_state = "cutlass1"),
			"UNREAL SORD" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "sord"),
			"Reaper Scythe" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "scythe1"),
			"High Frequency Blade" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "hfrequency1"),
			"Dormant Spellblade" = image(icon = 'icons/obj/guns/magic.dmi', icon_state = "spellblade"),
			"Possessed Blade" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "talking_sword"),
			"Possessed Chainsaw Sword" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "chainswordon"),
			"Relic War Hammer" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "hammeron"),
			"Chainsaw Hand" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "chainsaw_on"),
			"Clown Dagger" = image(icon = 'icons/obj/wizard.dmi', icon_state = "clownrender"),
			"Pride-struck Hammer" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "pride"),
			"Holy Whip" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "chain"),
			"Atheist's Fedora" = image(icon = 'icons/obj/clothing/hats.dmi', icon_state = "fedora"),
			"Dark Blessing" = image(icon = 'icons/obj/changeling_items.dmi', icon_state = "arm_blade"),
			"Unholy Blessing" = image(icon = 'icons/obj/changeling_items.dmi', icon_state = "tentacle"),
			"Carp-Sie Plushie" = image(icon = 'icons/obj/plushes.dmi', icon_state = "carpplush"),
			"Monk's Staff" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "bostaff0"),
			"Arrythmic Knife" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "crysknife"),
			"Unholy Pitchfork" = image(icon = 'icons/obj/items_and_weapons.dmi', icon_state = "pitchfork0"),
			"Egyptian Staff" = image(icon = 'icons/obj/guns/magic.dmi', icon_state = "pharoah_sceptre"),
			"Hypertool" = image(icon = 'icons/obj/device.dmi', icon_state = "hypertool"),
			"Ancient Spear" = image(icon = 'icons/obj/clockwork_objects.dmi', icon_state = "ratvarian_spear")
	)
	var/choice = show_radial_menu(M, src, unique_reskin_icon, radius = 42, require_near = TRUE, tooltips = TRUE)
	SSblackbox.record_feedback("tally", "chaplain_weapon", 1, "[choice]") //Keeping this here just in case removing it breaks something
	if(!QDELETED(src) && choice && !current_skin && !M.incapacitated() && in_range(M,src))
		qdel(src)
		var A = unique_reskin[choice]
		var/obj/item/nullrod/holy_weapon = new A
		holy_weapon.current_skin = choice
		M.put_in_active_hand(holy_weapon)


/obj/item/nullrod/proc/on_cult_rune_removed(obj/effect/target, mob/living/user)
	if(!istype(target, /obj/effect/rune))
		return

	var/obj/effect/rune/target_rune = target
	if(target_rune.log_when_erased)
		log_game("[target_rune.cultist_name] rune erased by [key_name(user)] using a null rod.")
		message_admins("[ADMIN_LOOKUPFLW(user)] erased a [target_rune.cultist_name] rune with a null rod.")
	SSshuttle.shuttle_purchase_requirements_met[SHUTTLE_UNLOCK_NARNAR] = TRUE

/obj/item/nullrod/godhand
	icon_state = "disintegrate"
	item_state = "disintegrate"
	lefthand_file = 'icons/mob/inhands/misc/touchspell_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/touchspell_righthand.dmi'
	name = "god hand"
	desc = "This hand of yours glows with an awesome power!"
	item_flags = ABSTRACT | DROPDEL
	w_class = WEIGHT_CLASS_HUGE
	hitsound = 'sound/weapons/sear.ogg'
	damtype = BURN
	attack_verb = list("punched", "cross countered", "pummeled")
	block_upgrade_walk = 0

/obj/item/nullrod/godhand/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/nullrod/staff
	icon_state = "godstaff-red"
	item_state = "godstaff-red"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	name = "red holy staff"
	desc = "It has a mysterious, protective aura."
	w_class = WEIGHT_CLASS_HUGE
	force = 5
	slot_flags = ITEM_SLOT_BACK
	block_flags = BLOCKING_PROJECTILE
	block_level = 1
	block_power = 20
	var/shield_icon = "shield-red"

/obj/item/nullrod/staff/worn_overlays(mutable_appearance/standing, isinhands = FALSE, icon_file, item_layer, atom/origin)
	. = list()
	if(isinhands)
		. += mutable_appearance('icons/effects/effects.dmi', shield_icon, MOB_SHIELD_LAYER)

/obj/item/nullrod/staff/blue
	name = "blue holy staff"
	icon_state = "godstaff-blue"
	item_state = "godstaff-blue"
	shield_icon = "shield-old"

/obj/item/nullrod/claymore
	icon_state = "claymore"
	item_state = "claymore"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "holy claymore"
	desc = "A weapon fit for a crusade!"
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	block_flags = BLOCKING_NASTY | BLOCKING_ACTIVE
	block_level = 1
	block_power = 30
	sharpness = IS_SHARP
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "tore", "ripped", "diced", "cut")

/obj/item/nullrod/claymore/darkblade
	icon_state = "cultblade"
	item_state = "cultblade"
	lefthand_file = 'icons/mob/inhands/64x64_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/64x64_righthand.dmi'
	inhand_x_dimension = 64
	inhand_y_dimension = 64
	name = "dark blade"
	desc = "Spread the glory of the dark gods!"
	slot_flags = ITEM_SLOT_BELT
	hitsound = 'sound/hallucinations/growl1.ogg'

/obj/item/nullrod/claymore/chainsaw_sword
	icon_state = "chainswordon"
	item_state = "chainswordon"
	name = "sacred chainsaw sword"
	desc = "Suffer not a heretic to live."
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("sawed", "tore", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 1.5 //slower than a real saw

/obj/item/nullrod/claymore/glowing
	icon_state = "swordon"
	item_state = "swordon"
	name = "force weapon"
	desc = "The blade glows with the power of faith. Or possibly a battery."
	slot_flags = ITEM_SLOT_BELT

/obj/item/nullrod/claymore/katana
	name = "\improper Hanzo steel"
	desc = "Capable of cutting clean through a holy claymore."
	icon_state = "katana"
	item_state = "katana"
	worn_icon_state = "katana"
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY | BLOCKING_PROJECTILE
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	block_power = 0

/obj/item/nullrod/claymore/multiverse
	name = "extradimensional blade"
	desc = "Once the harbinger of an interdimensional war, its sharpness fluctuates wildly."
	icon_state = "multiverse"
	item_state = "multiverse"
	slot_flags = ITEM_SLOT_BELT

/obj/item/nullrod/claymore/multiverse/attack(mob/living/carbon/M, mob/living/carbon/user)
	force = rand(1, 30)
	..()

/obj/item/nullrod/claymore/saber
	name = "light energy sword"
	hitsound = 'sound/weapons/blade1.ogg'
	icon = 'icons/obj/transforming_energy.dmi'
	icon_state = "swordblue"
	item_state = "swordblue"
	desc = "If you strike me down, I shall become more robust than you can possibly imagine."
	slot_flags = ITEM_SLOT_BELT

/obj/item/nullrod/claymore/saber/red
	name = "dark energy sword"
	icon_state = "swordred"
	item_state = "swordred"
	desc = "Woefully ineffective when used on steep terrain."

/obj/item/nullrod/claymore/saber/pirate
	name = "nautical energy sword"
	icon_state = "cutlass1"
	item_state = "cutlass1"
	desc = "Convincing HR that your religion involved piracy was no mean feat."

/obj/item/nullrod/sord
	name = "\improper UNREAL SORD"
	desc = "This thing is so unspeakably HOLY you are having a hard time even holding it."
	icon_state = "sord"
	item_state = "sord"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 4.13
	throwforce = 1
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "tore", "ripped", "diced", "cut")
	block_level = 1

/obj/item/nullrod/sord/on_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", damage = 0, attack_type = MELEE_ATTACK)
	if(isitem(hitby))
		var/obj/item/I = hitby
		owner.attackby(src)
		owner.attackby(src, owner)
		owner.visible_message("<span class='danger'>[owner] can't get a grip, and stabs himself with both the [I] and the[src] while trying to parry the [I]!</span>")
	return ..()

/obj/item/nullrod/scythe
	icon_state = "scythe1"
	item_state = "scythe1"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "reaper scythe"
	desc = "Ask not for whom the bell tolls..."
	w_class = WEIGHT_CLASS_BULKY
	armour_penetration = 35
	block_level = 1
	block_power = 15
	block_flags = BLOCKING_ACTIVE | BLOCKING_NASTY
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_SHARP
	attack_verb = list("chopped", "sliced", "cut", "reaped")

/obj/item/nullrod/scythe/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/butchering, 70, 110) //the harvest gives a high bonus chance

/obj/item/nullrod/scythe/vibro
	icon_state = "hfrequency0"
	item_state = "hfrequency1"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "high frequency blade"
	desc = "Bad references are the DNA of the soul."
	attack_verb = list("chopped", "sliced", "cut", "zandatsu'd")
	hitsound = 'sound/weapons/rapierhit.ogg'

/obj/item/nullrod/scythe/spellblade
	icon_state = "spellblade"
	item_state = "spellblade"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	icon = 'icons/obj/guns/magic.dmi'
	name = "dormant spellblade"
	desc = "The blade grants the wielder nearly limitless power...if they can figure out how to turn it on, that is."
	hitsound = 'sound/weapons/rapierhit.ogg'

/obj/item/nullrod/scythe/talking
	icon_state = "talking_sword"
	item_state = "talking_sword"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "possessed blade"
	desc = "When the station falls into chaos, it's nice to have a friend by your side."
	attack_verb = list("chopped", "sliced", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	var/possessed = FALSE

/obj/item/nullrod/scythe/talking/relaymove(mob/user)
	return //stops buckled message spam for the ghost.

/obj/item/nullrod/scythe/talking/attack_self(mob/living/user)
	if(possessed)
		return
	if(!(GLOB.ghost_role_flags & GHOSTROLE_STATION_SENTIENCE))
		to_chat(user, "<span class='notice'>Anomalous otherworldly energies block you from awakening the blade!</span>")
		return

	to_chat(user, "You attempt to wake the spirit of the blade...")

	possessed = TRUE

	var/list/mob/dead/observer/candidates = poll_ghost_candidates("Do you want to play as the spirit of [user.real_name]'s blade?", ROLE_SPECTRAL_BLADE, null, 10 SECONDS, ignore_category = POLL_IGNORE_SPECTRAL_BLADE)

	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		var/mob/living/simple_animal/shade/S = new(src)
		S.ckey = C.ckey
		S.fully_replace_character_name(null, "The spirit of [name]")
		S.status_flags |= GODMODE
		S.copy_languages(user, LANGUAGE_MASTER)	//Make sure the sword can understand and communicate with the user.
		S.update_atom_languages()
		grant_all_languages(FALSE, FALSE, TRUE)	//Grants omnitongue
		var/input = sanitize_name(stripped_input(S,"What are you named?", ,"", MAX_NAME_LEN))

		if(src && input)
			name = input
			S.fully_replace_character_name(null, "The spirit of [input]")
	else
		to_chat(user, "The blade is dormant. Maybe you can try again later.")
		possessed = FALSE

/obj/item/nullrod/scythe/talking/Destroy()
	for(var/mob/living/simple_animal/shade/S in contents)
		to_chat(S, "You were destroyed!")
		qdel(S)
	return ..()

/obj/item/nullrod/scythe/talking/chainsword
	icon_state = "chainswordon"
	item_state = "chainswordon"
	name = "possessed chainsaw sword"
	desc = "Suffer not a heretic to live."
	chaplain_spawnable = FALSE
	force = 30
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("sawed", "tore", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5 //faster than normal saw

/obj/item/nullrod/hammmer
	icon_state = "hammeron"
	item_state = "hammeron"
	lefthand_file = 'icons/mob/inhands/weapons/hammers_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/hammers_righthand.dmi'
	name = "relic war hammer"
	desc = "This war hammer cost the chaplain forty thousand space dollars."
	slot_flags = ITEM_SLOT_BELT
	w_class = WEIGHT_CLASS_HUGE
	attack_verb = list("smashed", "bashed", "hammered", "crunched")
	attack_weight = 2

/obj/item/nullrod/chainsaw
	name = "chainsaw hand"
	desc = "Good? Bad? You're the guy with the chainsaw hand."
	icon_state = "chainsaw_on"
	item_state = "mounted_chainsaw"
	lefthand_file = 'icons/mob/inhands/weapons/chainsaw_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/chainsaw_righthand.dmi'
	w_class = WEIGHT_CLASS_HUGE
	item_flags = ABSTRACT | ISWEAPON
	sharpness = IS_SHARP
	attack_verb = list("sawed", "tore", "cut", "chopped", "diced")
	hitsound = 'sound/weapons/chainsawhit.ogg'
	tool_behaviour = TOOL_SAW
	toolspeed = 2 //slower than a real saw
	attack_weight = 2
	block_upgrade_walk = 0


/obj/item/nullrod/chainsaw/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
	AddComponent(/datum/component/butchering, 30, 100, 0, hitsound)

/obj/item/nullrod/clown
	icon = 'icons/obj/wizard.dmi'
	icon_state = "clownrender"
	item_state = "render"
	name = "clown dagger"
	desc = "Used for absolutely hilarious sacrifices."
	hitsound = 'sound/items/bikehorn.ogg'
	sharpness = IS_SHARP
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "tore", "ripped", "diced", "cut")

/obj/item/nullrod/pride_hammer
	icon_state = "pride"
	name = "Pride-struck Hammer"
	desc = "It resonates an aura of Pride."
	force = 16
	throwforce = 15
	w_class = 4
	slot_flags = ITEM_SLOT_BACK
	attack_verb = list("attacked", "smashed", "crushed", "splattered", "cracked")
	hitsound = 'sound/weapons/blade1.ogg'
	attack_weight = 2

/obj/item/nullrod/pride_hammer/afterattack(atom/A as mob|obj|turf|area, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(prob(30) && ishuman(A))
		var/mob/living/carbon/human/H = A
		user.reagents.trans_to(H, user.reagents.total_volume, 1, 1, 0, transfered_by = user)
		to_chat(user, "<span class='notice'>Your pride reflects on [H].</span>")
		to_chat(H, "<span class='userdanger'>You feel insecure, taking on [user]'s burden.</span>")

/obj/item/nullrod/whip
	name = "holy whip"
	desc = "What a terrible night to be on Space Station 13."
	icon_state = "chain"
	item_state = "chain"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	attack_verb = list("whipped", "lashed")
	hitsound = 'sound/weapons/chainhit.ogg'

/obj/item/nullrod/fedora
	name = "atheist's fedora"
	desc = "The brim of the hat is as sharp as your wit. The edge would hurt almost as much as disproving the existence of God."
	icon_state = "fedora"
	item_state = "fedora"
	slot_flags = ITEM_SLOT_HEAD
	icon = 'icons/obj/clothing/hats.dmi'
	force = 0
	throw_speed = 4
	throw_range = 7
	throwforce = 30
	sharpness = IS_SHARP
	attack_verb = list("enlightened", "redpilled")

/obj/item/nullrod/armblade
	name = "dark blessing"
	desc = "Particularly twisted deities grant gifts of dubious value."
	icon = 'icons/obj/changeling_items.dmi'
	icon_state = "arm_blade"
	item_state = "arm_blade"
	lefthand_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
	item_flags = ABSTRACT | ISWEAPON
	w_class = WEIGHT_CLASS_HUGE
	sharpness = IS_SHARP

/obj/item/nullrod/armblade/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)
//	ADD_TRAIT(src, TRAIT_DOOR_PRYER, INNATE_TRAIT)	//uncomment if you want chaplains to have AA as a null rod option. The armblade will behave even more like a changeling one then!
	AddComponent(/datum/component/butchering, 80, 70)

/obj/item/nullrod/armblade/tentacle
	name = "unholy blessing"
	icon_state = "tentacle"
	item_state = "tentacle"

/obj/item/nullrod/carp
	name = "carp-sie plushie"
	desc = "An adorable stuffed toy that resembles the god of all carp. The teeth look pretty sharp. Activate it to receive the blessing of Carp-Sie."
	icon = 'icons/obj/plushes.dmi'
	icon_state = "carpplush"
	item_state = "carp_plushie"
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	force = 15
	attack_verb = list("bitten", "eaten", "fin slapped")
	hitsound = 'sound/weapons/bite.ogg'
	var/used_blessing = FALSE

/obj/item/nullrod/carp/attack_self(mob/living/user)
	if(used_blessing)
	else if(user.mind && (user.mind.holy_role))
		to_chat(user, "You are blessed by Carp-Sie. Wild space carp will no longer attack you.")
		user.faction |= "carp"
		used_blessing = TRUE

/obj/item/nullrod/claymore/bostaff //May as well make it a "claymore" and inherit the blocking
	name = "monk's staff"
	desc = "A long, tall staff made of polished wood. Traditionally used in ancient old-Earth martial arts, it is now used to harass the clown."
	w_class = WEIGHT_CLASS_BULKY
	force = 14
	block_power = 40
	slot_flags = ITEM_SLOT_BACK
	sharpness = IS_BLUNT
	hitsound = "swing_hit"
	attack_verb = list("smashed", "slammed", "whacked", "thwacked")
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "bostaff0"
	item_state = "bostaff0"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'

/obj/item/nullrod/tribal_knife
	icon_state = "crysknife"
	item_state = "crysknife"
	lefthand_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
	name = "arrhythmic knife"
	w_class = WEIGHT_CLASS_HUGE
	desc = "They say fear is the true mind killer, but stabbing them in the head works too. Honour compels you to not sheathe it once drawn."
	sharpness = IS_SHARP
	slot_flags = null
	hitsound = 'sound/weapons/bladeslice.ogg'
	attack_verb = list("attacked", "slashed", "stabbed", "sliced", "tore", "ripped", "diced", "cut")
	item_flags = SLOWS_WHILE_IN_HAND

/obj/item/nullrod/tribal_knife/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	AddComponent(/datum/component/butchering, 50, 100)

/obj/item/nullrod/tribal_knife/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/nullrod/tribal_knife/process()
	slowdown = rand(-10, 10)/10
	if(iscarbon(loc))
		var/mob/living/carbon/wielder = loc
		if(wielder.is_holding(src))
			wielder.update_equipment_speed_mods()

/obj/item/nullrod/pitchfork
	icon_state = "pitchfork0"
	lefthand_file = 'icons/mob/inhands/weapons/polearms_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/polearms_righthand.dmi'
	name = "unholy pitchfork"
	w_class = WEIGHT_CLASS_LARGE
	desc = "Holding this makes you look absolutely devilish."
	attack_verb = list("poked", "impaled", "pierced", "jabbed")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP

/obj/item/nullrod/egyptian
	name = "egyptian staff"
	desc = "A tutorial in mummification is carved into the staff. You could probably craft the wraps if you had some cloth."
	icon = 'icons/obj/guns/magic.dmi'
	icon_state = "pharoah_sceptre"
	item_state = "pharoah_sceptre"
	lefthand_file = 'icons/mob/inhands/weapons/staves_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/staves_righthand.dmi'
	w_class = WEIGHT_CLASS_LARGE
	attack_verb = list("bashes", "smacks", "whacks")

/obj/item/nullrod/hypertool
	icon = 'icons/obj/device.dmi'
	icon_state = "hypertool"
	item_state = "hypertool"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	name = "hypertool"
	desc = "A tool so powerful even you cannot perfectly use it."
	armour_penetration = 35
	damtype = BRAIN
	attack_verb = list("pulsed", "mended", "cut")
	hitsound = 'sound/effects/sparks4.ogg'

/obj/item/nullrod/spear
	name = "ancient spear"
	desc = "An ancient spear made of brass, I mean gold, I mean bronze. It looks highly mechanical."
	icon_state = "ratvarian_spear"
	item_state = "ratvarian_spear"
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	icon = 'icons/obj/clockwork_objects.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	sharpness = IS_SHARP_ACCURATE
	w_class = WEIGHT_CLASS_BULKY
	attack_verb = list("stabbed", "poked", "slashed", "clocked")
	hitsound = 'sound/weapons/bladeslice.ogg'
