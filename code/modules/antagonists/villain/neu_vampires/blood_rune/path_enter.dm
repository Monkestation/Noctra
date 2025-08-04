
/datum/rune_spell/portalentrance
	name = "Path Entrance"
	desc = "Take a shortcut through the veil between this world and the other one."
	desc_talisman = "Use to remotely trigger the rune and force objects and creatures on top through the Path."
	invocation = "Sas'so c'arta forbici!"
	word1 = /datum/rune_word/travel
	word2 = /datum/rune_word/self
	word3 = /datum/rune_word/other
	talisman_absorb = RUNE_CAN_ATTUNE
	can_conceal = 1
	page = "This rune lets you set teleportation networks between any two tiles in the worlds, when used in combination with the Path Exit rune. \
		Upon its first use, the rune asks you to set a path for it to attune to. There are 10 possible paths, each corresponding to a cult word.\
		<br><br> Upon subsequent uses the rune will, after a 1 second delay, teleport everything not anchored above it to the Path Exit attuned to the same word (if there aren't any, no teleportation will occur).\
		<br><br>Talismans will remotely activate this rune.\
		<br><br>You can deactivate a Path Entrance by simply using the Erase Word spell on it once, and rewrite Other afterwards.\
		<br><br>Lastly if the crew destroys this rune using salt or holy salts, they will learn the direction toward the corresponding Exit if it's on the same level."
	var/network = ""

/datum/rune_spell/portalentrance/cast()
	var/obj/effect/blood_rune/R = spell_holder
	R.one_pulse()

	var/list/available_networks = GLOB.rune_words_english.Copy()

	network = input(activator, "Choose an available Path, you may change paths later by erasing the rune.", "Path Entrance") as null|anything in available_networks
	if (!network)
		qdel(src)
		return

	var/datum/rune_word/W = GLOB.rune_words[network]

	invoke(activator, "[W.rune]")
	var/image/I_crystals = image('icons/effects/vampire.dmi', "path_pad")
	I_crystals.plane = GAME_PLANE
	var/image/I_stone = image('icons/effects/vampire.dmi', "path_entrance")
	I_stone.plane = GAME_PLANE_UPPER
	I_stone.appearance_flags |= RESET_COLOR//we don't want the stone to pulse

	var/image/I_network
	var/lookup = "[W.english]-0-[COLOR_BLOOD]"//0 because the rune will pulse anyway, and make this overlay pulse along
	if (lookup in GLOB.rune_appearances_cache)
		I_network = image(GLOB.rune_appearances_cache[lookup])
	else
		I_network = image('icons/deityrunes.dmi', src, W.english)
		I_network.color = COLOR_BLOOD
	I_network.plane = GAME_PLANE
	I_network.transform /= 1.5
	I_network.pixel_x = round(W.offset_x*0.75)
	I_network.pixel_y = -3 + round(W.offset_y*0.75)

	spell_holder.overlays.len = 0
	spell_holder.overlays += I_crystals
	spell_holder.overlays += I_stone
	spell_holder.overlays += I_network
	custom_rune = TRUE

	to_chat(activator, span_notice("This rune will now let you travel through the \"[network]\" Path.") )

	talisman_absorb = RUNE_CAN_ATTUNE//once the network has been set, talismans will attune instead of imbue

/datum/rune_spell/portalentrance/midcast(mob/add_cultist, turf/cast_from)
	if (istype(spell_holder, /obj/item/talisman))
		invoke(add_cultist, invocation, 1)
	else
		invoke(add_cultist, invocation)

	var/turf/destination = null
	for (var/datum/rune_spell/portalexit/P in GLOB.bloodcult_exitportals)
		if (P.network == network)
			destination = get_turf(P.spell_holder)
			break

	if (!destination)
		to_chat(activator, span_warning("The \"[network]\" Path is closed. Set up a Path Exit rune to establish a Path.") )
		return

	var/turf/T = get_turf(spell_holder)
	if(cast_from)
		T = cast_from
	var/obj/effect/abstract/landing_animation = anim(target = T, a_icon = 'icons/effects/vampire.dmi', flick_anim = "cult_jaunt_prepare", plane = GAME_PLANE_UPPER)
	playsound(T, 'sound/effects/vampire/cultjaunt_prepare.ogg', 75, 0, -3)
	spawn(10)
		playsound(T, 'sound/effects/vampire/cultjaunt_land.ogg', 30, 0, -3)
		new /obj/effect/bloodcult_jaunt(T, null, destination, T, activator = activator)
		flick("cult_jaunt_land", landing_animation)

/datum/rune_spell/portalentrance/midcast_talisman(mob/add_cultist)
	midcast(add_cultist, get_turf(add_cultist))

/datum/rune_spell/portalentrance/salt_act(turf/T)
	var/turf/destination = null
	for (var/datum/rune_spell/portalexit/P in GLOB.bloodcult_exitportals)
		if (P.network == network)
			destination = get_turf(P.spell_holder)
			new /obj/effect/bloodcult_jaunt/traitor(T, null, destination, null)
			break
