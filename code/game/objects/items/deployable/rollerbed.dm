/obj/item/deployable/rollerbed
	name = "roller bed"
	desc = "A collapsed roller bed that can be carried around."
	icon = 'icons/obj/beds_chairs/rollerbed.dmi'
	icon_state = "folded"
	w_class = WEIGHT_CLASS_NORMAL // No more excuses, stop getting blood everywhere
	deployed_object = /obj/structure/bed/roller

/obj/item/deployable/rollerbed/robo //ROLLER ROBO DA!
	name = "roller bed dock"
	desc = "A collapsed roller bed that can be ejected for emergency use. Must be collected or replaced after use."
	consumed = FALSE
	loaded = TRUE

/obj/item/deployable/rollerbed/robo/examine(mob/user)
	. = ..()
	. += "The dock is [loaded ? "loaded" : "empty"]."

/obj/item/deployable/rollerbed/robo/update_icon()
	icon_state = "folded[loaded ? "" : "_unloaded"]"
	return ..()

/obj/item/deployable/rollerbed/robo/afterattack(atom/target, mob/user, proximity)
	if(istype(target, /obj/structure/bed/roller))
		return //We only need the error message generated by the bed, not an error for a failed deployment on top of it.
	return ..()
