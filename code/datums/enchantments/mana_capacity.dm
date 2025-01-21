/datum/enchantment/mana_capacity
	enchantment_name = "Mana Capacity"
	examine_text = "I can feel this objects mana and use it freely."

	var/softcap_increase = 100
	var/hardcap_increase = 100

	var/list/affecting_mobs = list()

/datum/enchantment/mana_capacity/on_equip(obj/item/source, mob/living/carbon/equipper, slot)
	affecting_mobs |= source
	if(equipper in affecting_mobs[source])
		return
	affecting_mobs[source] |= equipper

	equipper.mana_pool.softcap += softcap_increase
	equipper.mana_pool.maximum_mana_capacity += hardcap_increase


/datum/enchantment/mana_capacity/on_drop(datum/source, mob/living/carbon/user)
	affecting_mobs |= source
	if(!istype(user))
		return
	if(user in affecting_mobs[source])
		return
	affecting_mobs[source] -= user

	user.mana_pool.softcap -= softcap_increase
	user.mana_pool.maximum_mana_capacity -= hardcap_increase
