/obj/item/clothing/head/helmet/heavy/steam
	name = "steamknight helmet"
	desc = "Part of the the steamknight armor. Requires knowledge in engineering to operate."
	icon_state = "steamknight_helm"
	icon = 'icons/roguetown/clothing/steamknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/steamknight_onmob.dmi'
	anvilrepair = /datum/skill/craft/engineering
	block2add = null // no fov block, was trying to make it so theres a fov block if its unpowered but it didn't really work out sadly, was too buggy
	item_weight = 9 * BRONZE_MULTIPLIER
	smeltresult = /obj/item/ingot/bronze

/obj/item/clothing/head/helmet/heavy/steam/equipped(mob/living/user, slot)
	update_armor(user, slot)
	. = ..()

/obj/item/clothing/head/helmet/heavy/steam/dropped(mob/living/user)
	update_armor(user)
	. = ..()

/obj/item/clothing/head/helmet/heavy/steam/proc/update_armor(mob/living/user, slot)
	if(QDELETED(user))
		return
	var/list/equipped_types = list()
	var/list/equipped_items = list()
	for(var/obj/item/clothing/V as anything in user.get_equipped_items(FALSE))
		if(!is_type_in_list(V, GLOB.steam_armor))
			continue
		equipped_types |= V.type
		equipped_items |= V

	if(length(equipped_types) != length(GLOB.steam_armor))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing as anything in equipped_items)
			clothing:power_off(user)
		return

	if(!slot || !(slot_flags & slot))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing as anything in equipped_items)
			clothing:power_off(user)
		return

	if(user.get_skill_level(/datum/skill/craft/engineering) <= 3)
		to_chat(user, span_warning("I don't know how to operate [src]!"))
		power_off(user)
		remove_status_effect(user)
		for(var/obj/item/clothing/clothing as anything in equipped_items)
			clothing:power_off(user)
		return

	power_on(user)
	apply_status_effect(user)
	for(var/obj/item/clothing/clothing as anything in equipped_items)
		clothing:power_on(user)

/obj/item/clothing/head/helmet/heavy/steam/proc/power_on(mob/living/user)
	return

/obj/item/clothing/head/helmet/heavy/steam/proc/power_off(mob/living/user)
	return

/obj/item/clothing/head/helmet/heavy/steam/proc/apply_status_effect(mob/living/user)
	user.apply_status_effect(/datum/status_effect/buff/powered_steam_armor)

/obj/item/clothing/head/helmet/heavy/steam/proc/remove_status_effect(mob/living/user)
	user.remove_status_effect(/datum/status_effect/buff/powered_steam_armor)

