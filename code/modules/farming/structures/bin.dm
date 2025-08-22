//Not adding this yet

/obj/item/bin
	name = "wood bin"
	desc = "A washbin, a trashbin, a bloodbin... Your choices are limitless."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "washbin"
	var/base_state
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	max_integrity = 80
	w_class = WEIGHT_CLASS_GIGANTIC
	var/kover = FALSE
	drag_slowdown = 2
	throw_speed = 1
	throw_range = 1
	blade_dulling = DULLING_BASHCHOP
	obj_flags = CAN_BE_HIT

/obj/item/bin/Initialize()
	. = ..()
	if(!base_state)
		create_reagents(600, TRANSFERABLE | AMOUNT_VISIBLE)
		base_state = icon_state
	AddComponent(/datum/component/storage/concrete/grid/bin)
	update_appearance(UPDATE_ICON)

/obj/item/bin/Destroy()
	layer = 2.8
	icon_state = "washbin_destroy"
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))
	return ..()


/obj/item/bin/update_icon_state()
	. = ..()
	icon_state = "[base_state][kover ? "over" : ""]"

/obj/item/bin/update_overlays()
	. = ..()
	if(!reagents?.total_volume)
		return
	var/mutable_appearance/filling = mutable_appearance('icons/roguetown/misc/structure.dmi', "liquid2")
	filling.color = mix_color_from_reagents(reagents.reagent_list)
	filling.alpha = mix_alpha_from_reagents(reagents.reagent_list)
	. += filling

/obj/item/bin/onkick(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(kover)
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")
			return
		if(prob(L.STASTR * 8))
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks over [src]!</span>", \
				"<span class='warning'>I kick over [src]!</span>")
			kover = TRUE
			playsound(loc, pick('sound/foley/water_land1.ogg','sound/foley/water_land2.ogg', 'sound/foley/water_land3.ogg'), 100, FALSE)
			chem_splash(loc, 2, list(reagents), adminlog = TRUE)
			var/datum/component/storage/STR = GetComponent(/datum/component/storage)
			if(STR)
				var/list/things = STR.contents()
				for(var/obj/item/I in things)
					STR.remove_from_storage(I, get_turf(src))
			update_appearance(UPDATE_ICON_STATE)
		else
			playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
			user.visible_message("<span class='warning'>[user] kicks [src]!</span>", \
				"<span class='warning'>I kick [src]!</span>")

/obj/item/bin/attack_hand_secondary(mob/user, params)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	if(kover)
		user.visible_message("<span class='notice'>[user] starts to pick up [src]...</span>", \
			"<span class='notice'>I start to pick up [src]...</span>")
		if(do_after(user, 3 SECONDS, src))
			kover = FALSE
			update_appearance(UPDATE_ICON_STATE)
		return

	if(user.cmode)
		return

	try_wash(user, user)

/obj/item/bin/attackby_secondary(obj/item/weapon, mob/user, params)
	. = SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

	if(user.cmode)
		return

	try_wash(weapon, user)

/obj/item/bin/proc/try_wash(atom/to_wash, mob/user)
	if(istype(to_wash, /obj/item/natural/cloth))
		var/obj/item/item = to_wash
		item.attack_obj(src, user)
		return
	if(!reagents || !reagents.maximum_volume || kover)
		return
	var/removereg = /datum/reagent/water
	if(!reagents.has_reagent(/datum/reagent/water, 5))
		removereg = /datum/reagent/water/gross
		if(!reagents.has_reagent(/datum/reagent/water/gross, 5))
			to_chat(user, "<span class='warning'>No water to wash these stains.</span>")
			return

	var/list/wash = list('sound/foley/waterwash (1).ogg','sound/foley/waterwash (2).ogg')
	if(to_wash == user)
		user.visible_message("<span class='info'>[user] starts to wash in [src].</span>")
	else
		user.visible_message("<span class='info'>[user] starts to wash [to_wash] in [src].</span>")

	reagents.remove_reagent(removereg, 5)

	playsound(user, pick_n_take(wash), 100, FALSE)
	if(do_after(user, 3 SECONDS, src))
		to_wash.wash(CLEAN_WASH)
		playsound(user, pick(wash), 100, FALSE)

	var/datum/reagent/water_to_dirty = reagents.has_reagent(/datum/reagent/water, 5)
	if(water_to_dirty)
		var/amount_to_dirty = water_to_dirty.volume
		if(amount_to_dirty)
			reagents.remove_reagent(/datum/reagent/water, amount_to_dirty)
			reagents.add_reagent(/datum/reagent/water/gross, amount_to_dirty)

//We need to use this or the object will be put in storage instead of attacking it
/obj/item/bin/StorageBlock(obj/item/I, mob/user)
	if(user?.used_intent)
		if(user.used_intent.type in list(/datum/intent/fill,/datum/intent/pour,/datum/intent/splash))
			return TRUE
	if(istype(I, /obj/item/weapon/tongs))
		var/obj/item/weapon/tongs/T = I
		if(T.held_item && istype(T.held_item, /obj/item/ingot))
			return TRUE
	return FALSE

/obj/item/bin/attackby(obj/item/I, mob/user, params)
	if(kover)
		return ..()

	if(istype(I, /obj/item/dye_pack))
		var/obj/item/dye_pack/pack = I
		user.visible_message(span_info("[user] begins to add [pack] to [src]..."))
		if(do_after(user, 3 SECONDS, src))
			playsound(src, "bubbles", 50, 1)
			new /obj/structure/dye_bin(get_turf(src), pack)
			qdel(src)
		return

	if(!reagents || !reagents.maximum_volume) //trash
		return ..()

	if(istype(I, /obj/item/weapon/tongs))
		var/obj/item/weapon/tongs/T = I
		if(T.held_item && istype(T.held_item, /obj/item/ingot))
			var/obj/item/ingot/ingot = T.held_item
			var/removereg = /datum/reagent/water
			if(!reagents.has_reagent(/datum/reagent/water, 5))
				removereg = /datum/reagent/water/gross
				if(!reagents.has_reagent(/datum/reagent/water/gross, 5))
					to_chat(user, "<span class='warning'>Need more water to quench in.</span>")
					return
			if(!T.held_item:currecipe)
				to_chat(user, "<span class='warning'>Huh?</span>")
				return
			if(ingot.currecipe.progress != 100)
				to_chat(user, "<span class='warning'>It's not finished yet.</span>")
				return
			if(!T.hott)
				to_chat(user, "<span class='warning'>I need to heat it to temper the metal.</span>")
				return
			var/used_turf = user.loc
			if(!isturf(used_turf))
				used_turf = get_turf(src)
			// This behemoth of a chunk of code is necessary to create copies of an altered item
			// Because engine is dumb and doesn't have a copy object proc
			// We take all values of a recipe, apply them to floating vars, then assign them to every extra copy
			// (substracting one every time it runs) until we run out of that number
			var/datum/anvil_recipe/R = T.held_item:currecipe
			var/obj/item/crafteditem = R.created_item
			for(var/i in 1 to R.createditem_extra + 1)
				var/obj/item/IT = new crafteditem(used_turf, TRUE)
				R.handle_creation(IT)
				IT.OnCrafted(user.dir, user)
				record_featured_stat(FEATURED_STATS_SMITHS, user)
				record_featured_object_stat(FEATURED_STATS_FORGED_ITEMS, IT.name)

			playsound(src,pick('sound/items/quench_barrel1.ogg','sound/items/quench_barrel2.ogg'), 100, FALSE)
			user.visible_message("<span class='info'>[user] tempers \the [T.held_item.name] in \the [src], hot metal sizzling.</span>")
			QDEL_NULL(T.held_item)
			T.update_appearance(UPDATE_ICON)
			reagents.remove_reagent(removereg, 5)
			var/datum/reagent/water_to_dirty = reagents.has_reagent(/datum/reagent/water, 5)
			if(water_to_dirty)
				var/amount_to_dirty = water_to_dirty.volume
				if(amount_to_dirty)
					reagents.remove_reagent(/datum/reagent/water, amount_to_dirty)
					reagents.add_reagent(/datum/reagent/water/gross, amount_to_dirty)
			update_appearance(UPDATE_ICON)
			return
	. = ..()

/obj/item/bin/trash
	name = "trash bin"
	desc = "An eyesore that is meant to make things look cleaner."
	icon_state = "trashbin"
	base_state = "trashbin"

/obj/item/bin/trash/StorageBlock(obj/item/I, mob/user)
	return FALSE

/obj/item/bin/trash/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/dye_pack)) //it works... but we can do better, surely?
		return
	. = ..()
