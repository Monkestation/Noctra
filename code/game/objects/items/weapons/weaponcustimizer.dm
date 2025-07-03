/obj/item/weapcustomizer
	name = "weapon customizer kit"
	desc = "a small box of cheaply made miniture tools and specialist gear. can be used once to change to look of your weapon."
	icon_state = ""
	icon = 'icons/roguetown/weapons/32.dmi'
	flags_1 = null
	force = 10
	throwforce = 3
	throw_speed = 1
	throw_range = 2
	w_class = WEIGHT_CLASS_BULKY
	possible_item_intents = list(/datum/itent/use)
	wlength = WLENGTH_SHORT
	resistance_flags = FLAMMABLE
	destroy_sound = 'sound/foley/shielddestroy.ogg'
	max_integrity = 20

/obj/item/weapcustomizer/attack_obj(obj/O, mob/living/user)
	if(istype(O, obj/item/weapon))
		var/obj/item/weapon/B = O
		if(uniquestyle)
			to_chat(user, "[B] can't be customized.")
			return
		if(madeof)

			var/metal = madeof
			var/picked_name = input(user, "Choose a Heraldry", "VANDERLIN", name) as null|anything in sortList(GLOB.IconStates_cache['icons/roguetown/weapons/shield_heraldry.dmi'])
			if(!picked_name)
				picked_name = "none"
			var/mutable_appearance/M = mutable_appearance('icons/roguetown/weapons/shield_heraldry.dmi', picked_name)
			M.alpha = 190
			add_overlay(M)
			var/mutable_appearance/MU = mutable_appearance(icon, "ironsh_detail")
			MU.alpha = 90
			add_overlay(MU)
			if(alert("Are you pleased with your heraldry?", "Heraldry", "Yes", "No") != "Yes")
				cut_overlays(MU)
	return
	. = ..()

