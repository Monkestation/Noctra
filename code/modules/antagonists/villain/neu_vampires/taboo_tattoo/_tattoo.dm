/mob/proc/has_taboo(datum/tattoo_name)
	return

/mob/living/has_taboo(datum/taboo_tattoo/tattoo_name)
	if (!tattoo_name)
		return
	if(ispath(tattoo_name))
		tattoo_name = initial(tattoo_name.name)

	for (var/tattoo in taboos)
		var/datum/taboo_tattoo/CT = taboos[tattoo]
		if (CT.name == tattoo_name)
			return CT
	return null

/mob/living/proc/add_taboo(taboo_type)
	if (!taboos)
		taboos = list()

	var/datum/taboo_tattoo/new_taboo = new taboo_type()
	new_taboo.bearer = src
	taboos[new_taboo.name] = new_taboo

	new_taboo.apply_effects()
	if (new_taboo.feature)
		var/obj/item/bodypart/target_part = get_bodypart(new_taboo.feature.body_zone)
		if (target_part)
			target_part.add_bodypart_feature(new_taboo.feature)

	to_chat(src, "<span class='warning'>You feel the weight of a new taboo settling upon your soul...</span>")
	return new_taboo

/mob/living/proc/remove_taboo(taboo_name)
	var/datum/taboo_tattoo/taboo = has_taboo(taboo_name)
	if (!taboo)
		return FALSE

	taboo.remove_effects()
	taboos -= taboo_name
	qdel(taboo)
	return TRUE

/datum/taboo_tattoo
	var/name = "taboo"
	var/desc = ""
	var/tier = 1 // 1, 2 or 3 - higher tiers have more severe effects
	var/datum/bodypart_feature/feature
	var/mob/bearer = null
	var/list/effects = list() // List of active effects this taboo provides


/datum/taboo_tattoo/New()
	. = ..()
	if (feature)
		feature = new feature()

/datum/taboo_tattoo/Destroy()
	if (bearer)
		remove_effects()
	. = ..()

/datum/taboo_tattoo/proc/apply_effects()
	return

/datum/taboo_tattoo/proc/remove_effects()
	return
