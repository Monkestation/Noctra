// These do not all confirm to spell standards but if someone wants to go through all 60 odd of these and add proper
// Valid target / Can cast then be my guest
/datum/action/cooldown/spell/essence
	name = "Utility Spell"
	desc = "A minor utility spell."
	school = "utility"
	spell_cost = 5
	charge_drain = 0
	charge_required = FALSE
	cooldown_time = 30 SECONDS
	point_cost = 2
	spell_type = SPELL_ESSENCE
	experience_modifer = 0

/datum/action/cooldown/spell/essence/get_adjusted_charge_time()
	return charge_time

/datum/action/cooldown/spell/essence/get_adjusted_cost(cost_override)
	if(cost_override)
		return cost_override
	return spell_cost

/datum/action/cooldown/spell/essence/breeze
	name = "Gentle Breeze"
	desc = "Creates a small breeze that can blow out candles or scatter light objects."
	button_icon_state = "breeze"
	//sound = 'sound/magic/whiff.ogg'
	cast_range = 3
	attunements = list(/datum/attunement/aeromancy = 0.2)

/datum/action/cooldown/spell/essence/breeze/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE

	owner.visible_message(span_notice("[owner] gestures, creating a gentle breeze."))

	for(var/obj/item/candle/C in range(1, target_turf))
		if(C.lit)
			C.extinguish()

	for(var/obj/item/I in target_turf)
		if(I.w_class <= WEIGHT_CLASS_SMALL && prob(50))
			SSmove_manager.move_rand(I)

/datum/action/cooldown/spell/essence/cleanse
	name = "Cleanse"
	desc = "Removes dirt and minor stains from objects or surfaces."
	button_icon_state = "cleanse"
	//sound = 'sound/magic/splash.ogg'
	cast_range = 1
	attunements = list(/datum/attunement/blood)

/datum/action/cooldown/spell/essence/cleanse/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE

	owner.visible_message(span_notice("[owner] gestures, creating a cleansing mist around [target]."))
	//playsound(get_turf(target), 'sound/magic/splash.ogg', 50, TRUE)

	target.wash(CLEAN_WASH)

/datum/action/cooldown/spell/essence/spark
	name = "Spark"
	desc = "Creates a small spark that can light candles or torches."
	button_icon_state = "spark"
	sound = 'sound/magic/fireball.ogg'
	cast_range = 1
	attunements = list(/datum/attunement/fire)

/datum/action/cooldown/spell/essence/spark/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	target = get_turf(target)

	owner.visible_message(span_notice("[owner] creates a small spark near [target]."))
	playsound(get_turf(target), 'sound/magic/fireball.ogg', 30, TRUE)

	for(var/obj/item/item in target.contents)
		if(istype(item, /obj/item/candle))
			var/obj/item/candle/C = item
			if(!C.lit)
				C.light()

		else if(istype(item, /obj/item/flashlight/flare/torch))
			var/obj/item/flashlight/flare/torch/T = item
			if(!T.on)
				T.fuel += 5 MINUTES
				T.fire_act()

/datum/action/cooldown/spell/essence/mend
	name = "Minor Mend"
	desc = "Repairs minor damage to simple objects."
	button_icon_state = "mend"
	//sound = 'sound/magic/staff_healing.ogg'
	cast_range = 1
	attunements = list(/datum/attunement/earth)
	point_cost = 3

/datum/action/cooldown/spell/essence/mend/cast(atom/cast_on)
	. = ..()
	var/obj/item/target = cast_on
	if(!isobj(target))
		return FALSE

	owner.visible_message(span_notice("[owner] gestures, mending minor damage to [target]."))
	//playsound(get_turf(target), 'sound/magic/staff_healing.ogg', 50, TRUE)

	// Restore some durability or repair minor damage
	if(target.obj_integrity < target.max_integrity)
		target.obj_integrity = min(target.max_integrity, target.obj_integrity + 10)
		target.update_appearance()

/datum/action/cooldown/spell/essence/chill
	name = "Frost Touch"
	desc = "Creates a small patch of frost that can preserve food or cool drinks."
	button_icon_state = "chill"
	//sound = 'sound/magic/whiff.ogg'
	cast_range = 1
	attunements = list(/datum/attunement/ice)

/datum/action/cooldown/spell/essence/chill/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	target = get_turf(target)

	owner.visible_message(span_notice("[owner] gestures, creating a small patch of frost around [target]."))
	//playsound(get_turf(target), 'sound/magic/whiff.ogg', 50, TRUE)

	// Cool down hot food/drinks and reduce rot buildup on foods
	for(var/obj/item/reagent_containers/item in target.contents)
		item.reagents?.expose_temperature(273) // Set to freezing
		if(istype(item, /obj/item/reagent_containers/food/snacks))
			var/obj/item/reagent_containers/food/snacks/food = item
			food.warming += 5 MINUTES

/datum/action/cooldown/spell/essence/illuminate
	name = "Illuminate"
	desc = "Creates a small, temporary light source."
	button_icon_state = "light"
	//sound = 'sound/magic/staff_healing.ogg'
	cast_range = 0
	attunements = list(/datum/attunement/light)
	point_cost = 1

/datum/action/cooldown/spell/essence/illuminate/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] creates a small orb of light."))
	//playsound(get_turf(owner), 'sound/magic/staff_healing.ogg', 30, TRUE)

	// Create temporary light
	var/obj/effect/temp_visual/light_orb/orb = new(get_turf(owner))
	orb.set_light(3, 1, "#FFFFFF")
	QDEL_IN(orb, 30 SECONDS)

/datum/action/cooldown/spell/essence/haste
	name = "Swift Step"
	desc = "Briefly increases movement speed."
	button_icon_state = "haste"
	//sound = 'sound/magic/whiff.ogg'
	cast_range = 0
	point_cost = 4
	attunements = list(/datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/haste/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] moves with enhanced speed."))
	//playsound(get_turf(owner), 'sound/magic/whiff.ogg', 50, TRUE)

	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/haste, 10 SECONDS)

/datum/action/cooldown/spell/essence/refresh
	name = "Refresh"
	desc = "Removes minor fatigue and restores a small amount of stamina."
	button_icon_state = "refresh"
	//sound = 'sound/magic/staff_healing.ogg'
	cast_range = 1
	point_cost = 3
	attunements = list(/datum/attunement/life)

/datum/action/cooldown/spell/essence/refresh/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] appears refreshed."))
	//playsound(get_turf(owner), 'sound/magic/staff_healing.ogg', 50, TRUE)

	target.adjust_stamina(20)
	target.adjust_energy(20)

// Temporary light effect
/obj/effect/temp_visual/light_orb
	name = "light orb"
	desc = "A small, glowing orb of magical light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "orb"
	duration = 30 SECONDS

// Air Essence Spells
/datum/action/cooldown/spell/essence/air_walk
	name = "Air Walk"
	desc = "Allows brief movement over chasms or gaps by creating temporary air platforms."
	button_icon_state = "air_walk"
	cast_range = 0
	point_cost = 5
	attunements = list(/datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/air_walk/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] steps onto solidified air."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/air_walking, 15 SECONDS)

// Water Essence Spells
/datum/action/cooldown/spell/essence/water_breathing
	name = "Water Breathing"
	desc = "Allows breathing underwater for a short duration."
	button_icon_state = "water_breathing"
	cast_range = 1
	point_cost = 4
	attunements = list(/datum/attunement/blood)

/datum/action/cooldown/spell/essence/water_breathing/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] gains the ability to breathe underwater."))
	target.apply_status_effect(/datum/status_effect/buff/water_breathing, 60 SECONDS)

// Fire Essence Spells
/datum/action/cooldown/spell/essence/warmth
	name = "Warmth"
	desc = "Provides resistance to cold and warms the body."
	button_icon_state = "warmth"
	cast_range = 1
	point_cost = 3
	attunements = list(/datum/attunement/fire)

/datum/action/cooldown/spell/essence/warmth/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] radiates gentle warmth."))
	target.apply_status_effect(/datum/status_effect/buff/warmth, 120 SECONDS)

// Earth Essence Spells
/datum/action/cooldown/spell/essence/stone_shape
	name = "Stone Shape"
	desc = "Slightly reshapes stone surfaces or creates small stone implements."
	button_icon_state = "stone_shape"
	cast_range = 2
	point_cost = 4
	attunements = list(/datum/attunement/earth)

/datum/action/cooldown/spell/essence/stone_shape/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] shapes the stone with magical force."))

	// Create small stone tools or reshape minor features
	if(prob(30))
		new /obj/item/natural/stone(target_turf)

// Frost Essence Spells
/datum/action/cooldown/spell/essence/preserve
	name = "Preserve"
	desc = "Prevents food from spoiling and extends its freshness."
	button_icon_state = "preserve"
	cast_range = 1
	point_cost = 2
	attunements = list(/datum/attunement/ice)

/datum/action/cooldown/spell/essence/preserve/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	owner.visible_message(span_notice("[owner] preserves [target] with frost magic."))

	if(istype(target, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/food = target
		food.warming += 2 HOURS

// Light Essence Spells
/datum/action/cooldown/spell/essence/daylight
	name = "Daylight"
	desc = "Creates a bright light that mimics natural sunlight."
	button_icon_state = "daylight"
	cast_range = 0
	point_cost = 4
	attunements = list(/datum/attunement/light)

/datum/action/cooldown/spell/essence/daylight/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] creates a brilliant daylight orb."))
	var/obj/effect/temp_visual/daylight_orb/orb = new(get_turf(owner))
	orb.set_light(5, 2, "#FFFFAA")
	QDEL_IN(orb, 60 SECONDS)

// Motion Essence Spells
/datum/action/cooldown/spell/essence/phase_step
	name = "Phase Step"
	desc = "Allows brief passage through solid objects."
	button_icon_state = "phase_step"
	cast_range = 0
	point_cost = 6
	attunements = list(/datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/phase_step/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] becomes translucent momentarily."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/phase_walking, 5 SECONDS)

// Life Essence Spells
/datum/action/cooldown/spell/essence/vigor
	name = "Vigor"
	desc = "Increases physical strength and endurance temporarily."
	button_icon_state = "vigor"
	cast_range = 1
	point_cost = 4
	attunements = list(/datum/attunement/life)

/datum/action/cooldown/spell/essence/vigor/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] appears invigorated."))
	target.apply_status_effect(/datum/status_effect/buff/vigor, 60 SECONDS)

/datum/action/cooldown/spell/essence/stabilize
	name = "Stabilize"
	desc = "Prevents objects from moving or falling for a short time."
	button_icon_state = "stabilize"
	cast_range = 2
	point_cost = 4
	attunements = list(/datum/attunement/earth)

/datum/action/cooldown/spell/essence/stabilize/cast(atom/cast_on)
	. = ..()
	var/obj/target = cast_on
	if(!target)
		return FALSE
	if(!istype(target))
		return FALSE
	if(target.anchored)
		return

	owner.visible_message(span_notice("[owner] stabilizes [target] with magical force."))
	target.anchored = TRUE
	addtimer(VARSET_CALLBACK(target, anchored, FALSE), 30 SECONDS)

/datum/action/cooldown/spell/essence/randomize
	name = "Randomize"
	desc = "Causes minor random effects in the area."
	button_icon_state = "randomize"
	cast_range = 2
	point_cost = 3
	attunements = list(/datum/attunement/fire)

/datum/action/cooldown/spell/essence/randomize/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] causes unpredictable magical effects."))

	switch(rand(1, 4))
		if(1)
			for(var/mob/living/M in range(1, target_turf))
				M.adjust_stamina(rand(-10, 10))
		if(2)
			new /obj/effect/temp_visual/cult/sparks(target_turf)
		if(3)
			playsound(target_turf, pick('sound/magic/fireball.ogg'), 30, TRUE)
		if(4)
			target_turf.visible_message(span_notice("The air shimmers with chaotic energy."))

// Void Essence Spells
/datum/action/cooldown/spell/essence/silence
	name = "Silence"
	desc = "Creates a zone of magical silence that muffles all sounds."
	button_icon_state = "silence"
	cast_range = 2
	point_cost = 4
	attunements = list(/datum/attunement/fire)

/datum/action/cooldown/spell/essence/silence/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a zone of absolute silence."))

	var/obj/effect/temp_visual/silence_zone/zone = new(target_turf)
	QDEL_IN(zone, 30 SECONDS)

// Poison Essence Spells
/datum/action/cooldown/spell/essence/neutralize
	name = "Neutralize"
	desc = "Removes harmful toxins and poisons from objects or creatures."
	button_icon_state = "neutralize"
	cast_range = 1
	point_cost = 4
	attunements = list(/datum/attunement/life)

/datum/action/cooldown/spell/essence/neutralize/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	owner.visible_message(span_notice("[owner] neutralizes toxins in [target]."))

	if(istype(target, /mob/living))
		var/mob/living/L = target
		L.reagents?.remove_all_type(/datum/reagent/toxin, 5)

/datum/action/cooldown/spell/essence/detect_poison
	name = "Detect Poison"
	desc = "Reveals the presence of toxins or poisons in nearby objects."
	button_icon_state = "detect_poison"
	cast_range = 2
	point_cost = 2
	attunements = list(/datum/attunement/life)

/datum/action/cooldown/spell/essence/detect_poison/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] scans for toxins in the area."))

	var/found_poison = FALSE
	for(var/obj/item/I in range(1, target_turf))
		if(I.reagents && I.reagents.has_reagent(/datum/reagent/toxin))
			I.visible_message(span_warning("[I] glows with a sickly light!"))
			found_poison = TRUE

	if(!found_poison)
		to_chat(owner, span_notice("No toxins detected in the area."))

/datum/action/cooldown/spell/essence/gem_detect
	name = "Gem Detect"
	desc = "Reveals the location of precious stones and crystals nearby."
	button_icon_state = "gem_detect"
	cast_range = 3
	point_cost = 4
	attunements = list(/datum/attunement/earth)

/datum/action/cooldown/spell/essence/gem_detect/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] searches for precious stones."))

	var/found_gems = FALSE
	for(var/obj/item/gem/G in range(2, target_turf))
		G.visible_message(span_notice("[G] sparkles briefly!"))
		found_gems = TRUE

	for(var/atom/movable/movable in range(2, target_turf))
		for(var/obj/item/gem/G in movable.contents)
			G.visible_message(span_notice("[G] sparkles briefly!"))
			found_gems = TRUE
		if(isliving(movable))
			for(var/obj/item/gem/G in movable:get_contents())
				G.visible_message(span_notice("[G] sparkles briefly!"))
				found_gems = TRUE

	if(!found_gems)
		to_chat(owner, span_notice("No gems detected in the area."))

/datum/action/cooldown/spell/essence/arcane_mark
	name = "Arcane Mark"
	desc = "Places an invisible magical mark on an object for identification."
	button_icon_state = "arcane_mark"
	cast_range = 1
	point_cost = 2
	attunements = list(/datum/attunement/light)

/datum/action/cooldown/spell/essence/arcane_mark/cast(atom/cast_on)
	. = ..()
	var/obj/item/target = cast_on
	if(!isobj(target))
		return FALSE
	owner.visible_message(span_notice("[owner] places an arcane mark on [target]."))
	target.desc += " <i>It bears a faint magical mark.</i>"

// Energia Essence Spells
/datum/action/cooldown/spell/essence/energize
	name = "Energize"
	desc = "Restores energy to magical devices or provides a burst of vitality."
	button_icon_state = "energize"
	cast_range = 1
	point_cost = 4
	attunements = list(/datum/attunement/light)

/datum/action/cooldown/spell/essence/energize/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	owner.visible_message(span_notice("[owner] channels energy into [target]."))

	if(istype(target, /mob/living))
		var/mob/living/L = target
		L.adjust_stamina(30)
		L.adjust_energy(30)

	if(istype(target, /obj/structure/mana_pylon))
		var/obj/structure/mana_pylon/pylon = target
		pylon.mana_pool.adjust_mana(30)

/datum/action/cooldown/spell/essence/power_surge
	name = "Power Surge"
	desc = "Creates a brief surge of magical energy that can power devices."
	button_icon_state = "power_surge"
	cast_range = 2
	point_cost = 5
	attunements = list(/datum/attunement/light)

/datum/action/cooldown/spell/essence/power_surge/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a surge of magical power."))

	var/obj/effect/temp_visual/power_surge/surge = new(target_turf)
	QDEL_IN(surge, 10 SECONDS)

// Cycle Essence Spells
/datum/action/cooldown/spell/essence/seasonal_attune
	name = "Seasonal Attune"
	desc = "Attunes the caster to natural cycles, providing minor benefits."
	button_icon_state = "seasonal_attune"
	cast_range = 0
	point_cost = 3
	attunements = list(/datum/attunement/light)

/datum/action/cooldown/spell/essence/seasonal_attune/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] harmonizes with the natural cycles."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/seasonal_attunement, 600 SECONDS)

// Temporary visual effects for spells
/obj/effect/temp_visual/daylight_orb
	name = "daylight orb"
	desc = "A brilliant orb of magical daylight."
	icon = 'icons/effects/effects.dmi'
	icon_state = "orb"
	duration = 60 SECONDS

/obj/effect/temp_visual/silence_zone
	name = "silence zone"
	desc = "An area of magical silence."
	icon = 'icons/effects/effects.dmi'
	icon_state = "bhole3"
	duration = 30 SECONDS

/obj/effect/temp_visual/power_surge
	name = "power surge"
	desc = "Crackling magical energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity"
	duration = 10 SECONDS

// COMBO SPELLS - Two Essence Combinations

// Fire + Air Combo
/datum/action/cooldown/spell/essence/flame_jet
	name = "Flame Jet"
	desc = "Creates a controlled jet of flame for precise heating or light welding."
	button_icon_state = "flame_jet"
	cast_range = 2
	point_cost = 6
	attunements = list(/datum/attunement/fire, /datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/flame_jet/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a precise jet of flame."))

	var/obj/effect/temp_visual/flame_jet/jet = new(target_turf)
	QDEL_IN(jet, 15 SECONDS)

/obj/effect/temp_visual/flame_jet
	name = "flame jet"
	desc = "A concentrated jet of magical flame."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	duration = 15 SECONDS

/obj/effect/temp_visual/flame_jet/Initialize()
	. = ..()
	propagate_temp_change(40, 12, 0.8, 1) // High heat, high weight, low falloff, very short cast_range (focused)

/obj/effect/temp_visual/flame_jet/Destroy()
	remove_temp_effect()
	return ..()

// Water + Earth Combo
/datum/action/cooldown/spell/essence/mud_shape
	name = "Mud Shape"
	desc = "Combines water and earth to create moldable mud for construction."
	button_icon_state = "mud_shape"
	cast_range = 2
	point_cost = 5
	attunements = list(/datum/attunement/blood, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/mud_shape/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates moldable mud from earth and water."))
	new /obj/item/natural/clay(target_turf)

/datum/action/cooldown/spell/essence/fertile_soil
	name = "Fertile Soil"
	desc = "Enriches soil to promote plant growth."
	button_icon_state = "fertile_soil"
	cast_range = 2
	point_cost = 4
	attunements = list(/datum/attunement/blood, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/fertile_soil/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] enriches the soil with life-giving properties."))

	for(var/obj/structure/soil/plant in range(1, target_turf))
		plant.bless_soil()

// Fire + Earth Combo
/datum/action/cooldown/spell/essence/forge_heat
	name = "Forge Heat"
	desc = "Generates intense heat suitable for metalworking."
	button_icon_state = "forge_heat"
	cast_range = 1
	point_cost = 6
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/forge_heat/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] generates forge-level heat."))

	var/obj/effect/temp_visual/forge_heat/heat = new(target_turf)
	heat.set_light(3, 2, "#FF4400")
	QDEL_IN(heat, 60 SECONDS)

// Frost + Water Combo
/datum/action/cooldown/spell/essence/ice_bridge
	name = "Ice Bridge"
	desc = "Creates a temporary bridge of solid ice over gaps or water."
	button_icon_state = "ice_bridge"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/ice, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/ice_bridge/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a bridge of solid ice."))

	var/obj/structure/ice_bridge/bridge = new(target_turf)
	QDEL_IN(bridge, 300 SECONDS)

/datum/action/cooldown/spell/essence/frozen_storage
	name = "Frozen Storage"
	desc = "Creates a magical ice chest that preserves items indefinitely."
	button_icon_state = "frozen_storage"
	cast_range = 1
	point_cost = 6
	attunements = list(/datum/attunement/ice, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/frozen_storage/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a chest of magical ice."))

	var/obj/structure/closet/crate/chest/magical/chest = new(target_turf)
	QDEL_IN(chest, 5 MINUTES)

// Light + Fire Combo Spells
/datum/action/cooldown/spell/essence/brilliant_flame
	name = "Brilliant Flame"
	desc = "Creates an intensely bright flame that provides both light and heat."
	button_icon_state = "brilliant_flame"
	cast_range = 2
	point_cost = 6
	attunements = list(/datum/attunement/light, /datum/attunement/fire)

/datum/action/cooldown/spell/essence/brilliant_flame/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a brilliant flame that illuminates the area."))

	var/obj/effect/temp_visual/brilliant_flame/flame = new(target_turf)
	flame.set_light(6, 3, "#FFFFDD")
	QDEL_IN(flame, 120 SECONDS)

/datum/action/cooldown/spell/essence/solar_focus
	name = "Solar Focus"
	desc = "Concentrates light and heat into a precise beam for cutting or heating."
	button_icon_state = "solar_focus"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/fire)

/datum/action/cooldown/spell/essence/solar_focus/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] focuses solar energy into a concentrated beam."))

	var/obj/effect/temp_visual/solar_beam/beam = new(target_turf)
	QDEL_IN(beam, 20 SECONDS)

// Life + Water Combo Spells
/datum/action/cooldown/spell/essence/healing_spring
	name = "Healing Spring"
	desc = "Creates a small spring of healing water that slowly restores health."
	button_icon_state = "healing_spring"
	cast_range = 2
	point_cost = 8
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/healing_spring/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] causes a healing spring to bubble forth from the ground."))

	var/obj/structure/healing_spring/spring = new(target_turf)
	QDEL_IN(spring, 600 SECONDS)

/datum/action/cooldown/spell/essence/purify_water
	name = "Purify Water"
	desc = "Removes all impurities and toxins from water, making it pure and safe."
	button_icon_state = "purify_water"
	cast_range = 1
	point_cost = 5
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/purify_water/cast(atom/cast_on)
	. = ..()
	var/obj/item/target = cast_on
	if(!isobj(target))
		return FALSE
	owner.visible_message(span_notice("[owner] purifies [target] with life-giving energy."))

	if(target.reagents)
		target.reagents.remove_all_type(/datum/reagent/toxin)
		target.reagents.remove_reagent(/datum/reagent/water/gross, 999)
		target.reagents.add_reagent(/datum/reagent/water, 20)

// Earth + Crystal Combo Spells
/datum/action/cooldown/spell/essence/gem_growth
	name = "Gem Growth"
	desc = "Encourages the natural formation of gems within suitable stone."
	button_icon_state = "gem_growth"
	cast_range = 2
	point_cost = 8
	attunements = list(/datum/attunement/earth, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/gem_growth/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] encourages gem formation in the surrounding stone."))

	if(prob(40))
		new /obj/item/gem(target_turf)
		owner.visible_message(span_notice("A gem crystallizes from the stone!"))

/datum/action/cooldown/spell/essence/mineral_sense
	name = "Mineral Sense"
	desc = "Detects valuable minerals and ores hidden within stone."
	button_icon_state = "mineral_sense"
	cast_range = 4
	point_cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/mineral_sense/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] senses for valuable minerals in the area."))

	var/found_minerals = FALSE
	for(var/obj/item/natural/stone/S in range(3, target_turf))
		S.visible_message(span_notice("[S] resonates with mineral energy!"))
		found_minerals = TRUE

	if(!found_minerals)
		to_chat(owner, span_notice("No valuable minerals detected nearby."))

// Motion + Air Combo Spells
/datum/action/cooldown/spell/essence/wind_step
	name = "Wind Step"
	desc = "Allows rapid movement by riding currents of air."
	button_icon_state = "wind_step"
	cast_range = 0
	point_cost = 6
	attunements = list(/datum/attunement/aeromancy, /datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/wind_step/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] steps upon the wind itself."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/wind_walking, 30 SECONDS)

/datum/action/cooldown/spell/essence/aerial_dash
	name = "Aerial Dash"
	desc = "Provides a burst of speed through magical air currents."
	button_icon_state = "aerial_dash"
	cast_range = 0
	point_cost = 5
	attunements = list(/datum/attunement/aeromancy, /datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/aerial_dash/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] is propelled by rushing air currents."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/aerial_speed, 15 SECONDS)

// Order + Light Combo Spells
/datum/action/cooldown/spell/essence/divine_order
	name = "Divine Order"
	desc = "Brings perfect organization to an area through divine light."
	button_icon_state = "divine_order"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/earth, /datum/attunement/light)

/datum/action/cooldown/spell/essence/divine_order/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] calls upon divine light to bring perfect order."))

	for(var/obj/item/I in range(2, target_turf))
		I.pixel_x = I.base_pixel_x
		I.pixel_y = I.base_pixel_y
		I.transform = matrix()

	var/obj/effect/temp_visual/divine_light/light = new(target_turf)
	light.set_light(4, 2, "#FFFFFF")
	QDEL_IN(light, 60 SECONDS)

/datum/action/cooldown/spell/essence/sacred_geometry
	name = "Sacred Geometry"
	desc = "Creates perfect geometric patterns that provide structural stability."
	button_icon_state = "sacred_geometry"
	cast_range = 2
	point_cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/light)

/datum/action/cooldown/spell/essence/sacred_geometry/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] inscribes sacred geometric patterns."))

	var/obj/effect/temp_visual/sacred_pattern/pattern = new(target_turf)
	QDEL_IN(pattern, 300 SECONDS)

// Chaos + Void Combo Spells
/datum/action/cooldown/spell/essence/reality_shift
	name = "Reality Shift"
	desc = "Temporarily alters local reality in unpredictable ways."
	button_icon_state = "reality_shift"
	cast_range = 2
	point_cost = 8
	attunements = list(/datum/attunement/fire, /datum/attunement/fire)

/datum/action/cooldown/spell/essence/reality_shift/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] causes reality to shift and warp."))

	switch(rand(1, 6))
		if(1)
			target_turf.visible_message(span_warning("Gravity briefly reverses!"))
		if(2)
			target_turf.visible_message(span_notice("Colors shift and change!"))
		if(3)
			target_turf.visible_message(span_warning("Time seems to skip a beat!"))
		if(4)
			new /obj/effect/temp_visual/reality_crack(target_turf)
		if(5)
			playsound(target_turf, 'sound/magic/ethereal_exit.ogg', 50, TRUE)
		if(6)
			target_turf.visible_message(span_danger("Reality tears briefly!"))

/datum/action/cooldown/spell/essence/probability_warp
	name = "Probability Warp"
	desc = "Alters the likelihood of minor events occurring."
	button_icon_state = "probability_warp"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/fire, /datum/attunement/fire)

/datum/action/cooldown/spell/essence/probability_warp/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] warps probability in the local area."))

	for(var/mob/living/M in range(2, target_turf))
		M.apply_status_effect(/datum/status_effect/buff/probability_flux, 60 SECONDS)

/datum/action/cooldown/spell/essence/toxic_cleanse
	name = "Toxic Cleanse"
	desc = "Completely purges an area of all toxic substances and poisons."
	button_icon_state = "toxic_cleanse"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/life, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/toxic_cleanse/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] cleanses all toxins from the area."))

	for(var/mob/living/M in range(2, target_turf))
		M.reagents?.remove_all_type(/datum/reagent/toxin)
		M.apply_status_effect(/datum/status_effect/buff/toxin_immunity, 300 SECONDS)

// Magic + Crystal Combo Spells
/datum/action/cooldown/spell/essence/spell_crystal
	name = "Spell Crystal"
	desc = "Creates a crystal that can store and later release a spell."
	button_icon_state = "spell_crystal"
	cast_range = 1
	point_cost = 9
	attunements = list(/datum/attunement/light, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/spell_crystal/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a crystal capable of storing magical energy."))

	new /obj/item/spell_crystal(target_turf)

/datum/action/cooldown/spell/essence/arcane_focus
	name = "Arcane Focus"
	desc = "Creates a crystal focus that enhances magical abilities."
	button_icon_state = "arcane_focus"
	cast_range = 0
	point_cost = 8
	attunements = list(/datum/attunement/light, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/arcane_focus/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] creates an arcane focusing crystal."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/arcane_focus, 600 SECONDS)

// Energia + Motion Combo Spells
/datum/action/cooldown/spell/essence/kinetic_burst
	name = "Kinetic Burst"
	desc = "Releases stored energy as a burst of kinetic force."
	button_icon_state = "kinetic_burst"
	cast_range = 3
	point_cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/kinetic_burst/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] releases a burst of kinetic energy."))

	for(var/obj/item/I in range(1, target_turf))
		if(I.w_class <= WEIGHT_CLASS_NORMAL)
			var/distfromcaster = get_dist(owner, I)
			var/throwtarget = get_edge_target_turf(owner, get_dir(owner, get_step_away(I, owner)))
			I.safe_throw_at(throwtarget, ((CLAMP((5 - (CLAMP(distfromcaster - 2, 0, distfromcaster))), 3, 5))), 1,owner, force = 5)


	var/obj/effect/temp_visual/kinetic_burst/burst = new(target_turf)
	QDEL_IN(burst, 5 SECONDS)

/datum/action/cooldown/spell/essence/momentum_transfer
	name = "Momentum Transfer"
	desc = "Transfers kinetic energy between objects or creatures."
	button_icon_state = "momentum_transfer"
	cast_range = 2
	point_cost = 6
	attunements = list(/datum/attunement/light, /datum/attunement/aeromancy)

/datum/action/cooldown/spell/essence/momentum_transfer/cast(atom/cast_on)
	. = ..()
	var/atom/target = cast_on
	if(!target)
		return FALSE
	owner.visible_message(span_notice("[owner] transfers momentum to [target]."))

	if(ismob(target))
		var/mob/living/M = target
		M.apply_status_effect(/datum/status_effect/buff/momentum_boost, 30 SECONDS)

// Cycle + Life Combo Spells
/datum/action/cooldown/spell/essence/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Establishes a cycle of continuous healing over time."
	button_icon_state = "regeneration_cycle"
	cast_range = 1
	point_cost = 8
	attunements = list(/datum/attunement/light, /datum/attunement/life)

/datum/action/cooldown/spell/essence/regeneration_cycle/cast(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(!istype(target))
		target = owner
	owner.visible_message(span_notice("[target] begins a cycle of natural regeneration."))
	target.apply_status_effect(/datum/status_effect/buff/regeneration_cycle, 300 SECONDS)

/datum/action/cooldown/spell/essence/growth_acceleration
	name = "Growth Acceleration"
	desc = "Dramatically speeds up natural growth processes."
	button_icon_state = "growth_acceleration"
	cast_range = 2
	point_cost = 7
	attunements = list(/datum/attunement/light, /datum/attunement/life)

/datum/action/cooldown/spell/essence/growth_acceleration/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] accelerates natural growth in the area."))

	for(var/obj/structure/soil/plant in range(1, target_turf))
		plant.accellerated_growth = world.time + 600 SECONDS

// RACIAL COMBO SPELLS

// Dwarf Racial Spells
/datum/action/cooldown/spell/essence/create_beer
	name = "Create Beer"
	desc = "A dwarven secret - transforms water and grain into fine ale."
	button_icon_state = "create_beer"
	cast_range = 1
	point_cost = 4
	attunements = list(/datum/attunement/earth, /datum/attunement/blood)

/datum/action/cooldown/spell/essence/create_beer/cast(atom/cast_on)
	. = ..()
	var/atom/movable/target = cast_on
	owner.visible_message(span_notice("[owner] works dwarven brewing magic."))

	if(isopenturf(target))
		var/turf/open/open = target
		if(open.liquids)
			var/water_amount = open.liquids.liquid_group.reagents.get_reagent_amount(/datum/reagent/water)
			if(water_amount)
				open.liquids.liquid_group.remove_specific(open.liquids, water_amount, /datum/reagent/water)
				open.liquids.liquid_group.add_reagent(open.liquids, /datum/reagent/consumable/ethanol/beer, water_amount)
			else
				open.liquids.liquid_group.add_reagent(open.liquids, /datum/reagent/consumable/ethanol/beer, 20)
		else
			open.add_liquid(/datum/reagent/consumable/ethanol/beer, 20)
	else if(istype(target, /obj/item/reagent_containers/glass))
		var/obj/item/reagent_containers/glass/glass = target
		glass.reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, 20)

/datum/action/cooldown/spell/essence/master_forge
	name = "Master Forge"
	desc = "Creates a temporary forge of legendary dwarven quality."
	button_icon_state = "master_forge"
	cast_range = 2
	point_cost = 8
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/master_forge/cast(atom/cast_on)
	. = ..()
	var/turf/target_turf = get_turf(cast_on)
	if(!target_turf)
		return FALSE
	owner.visible_message(span_notice("[owner] creates a forge worthy of the greatest dwarven smiths."))

	var/obj/machinery/light/fueled/forge/arcane/forge = new(target_turf)
	QDEL_IN(forge, 1800 SECONDS)

/datum/action/cooldown/spell/essence/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "Channels the spirits of ancient dwarven smiths to guide crafting."
	button_icon_state = "ancestral_smithing"
	cast_range = 0
	point_cost = 7
	attunements = list(/datum/attunement/fire, /datum/attunement/earth)

/datum/action/cooldown/spell/essence/ancestral_smithing/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] calls upon the wisdom of ancient dwarven smiths."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/ancestral_smithing, 600 SECONDS)

// Elf Racial Spells
/datum/action/cooldown/spell/essence/elven_grace
	name = "Elven Grace"
	desc = "Grants the ethereal grace and agility of the ancient elves."
	button_icon_state = "elven_grace"
	cast_range = 0
	point_cost = 6
	attunements = list(/datum/attunement/life, /datum/attunement/light)

/datum/action/cooldown/spell/essence/elven_grace/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] moves with the grace of the ancient elves."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/elven_grace, 300 SECONDS)

// Human Racial Spells
/datum/action/cooldown/spell/essence/balanced_mind
	name = "Balanced Mind"
	desc = "Achieves perfect mental balance between order and chaos."
	button_icon_state = "balanced_mind"
	cast_range = 0
	point_cost = 6
	attunements = list(/datum/attunement/earth, /datum/attunement/fire)

/datum/action/cooldown/spell/essence/balanced_mind/cast(atom/cast_on)
	. = ..()
	owner.visible_message(span_notice("[owner] achieves perfect mental equilibrium."))
	var/mob/living/L = owner
	L.apply_status_effect(/datum/status_effect/buff/balanced_mind, 450 SECONDS)

// Supporting structures and items for the new spells
/obj/effect/temp_visual/brilliant_flame
	name = "brilliant flame"
	desc = "A flame that burns with intense light and heat."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	duration = 120 SECONDS

/obj/effect/temp_visual/brilliant_flame/Initialize()
	. = ..()
	propagate_temp_change(30, 8, 0.6, 3) // Moderate heat, good cast_range

/obj/effect/temp_visual/brilliant_flame/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/solar_beam
	name = "solar beam"
	desc = "A concentrated beam of solar energy."
	icon = 'icons/effects/beam.dmi'
	icon_state = "solar"
	duration = 20 SECONDS

/obj/effect/temp_visual/solar_beam/Initialize()
	. = ..()
	propagate_temp_change(60, 15, 0.9, 1) // Very high heat, very focused

/obj/effect/temp_visual/solar_beam/Destroy()
	remove_temp_effect()
	return ..()

/obj/structure/healing_spring
	name = "healing spring"
	desc = "A mystical spring that bubbles with healing waters."
	icon = 'icons/obj/watercloset.dmi'
	icon_state = "well"
	density = FALSE
	anchored = TRUE

/obj/structure/ice_bridge
	name = "ice bridge"
	desc = "A solid bridge made of magical ice."
	icon = 'icons/turf/floors.dmi'
	icon_state = "ice"
	density = FALSE
	anchored = TRUE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP

/obj/structure/ice_bridge/Initialize()
	. = ..()
	propagate_temp_change(-20, 8, 0.5, 2) // Cooling effect

/obj/structure/ice_bridge/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/forge_heat
	name = "forge heat"
	desc = "Intense heat suitable for metalworking."
	icon = 'icons/effects/fire.dmi'
	icon_state = "fire"
	color = COLOR_RED
	duration = 60 SECONDS

/obj/effect/temp_visual/forge_heat/Initialize()
	. = ..()
	// Start heat propagation when created
	propagate_temp_change(50, 10, 0.7, 2) // High heat, medium weight, decent falloff, short cast_range

/obj/effect/temp_visual/forge_heat/Destroy()
	remove_temp_effect()
	return ..()

/obj/effect/temp_visual/mist_veil
	name = "concealing mist"
	desc = "A veil of mist that provides concealment."
	icon = 'icons/effects/effects.dmi'
	icon_state = "mist"
	duration = 60 SECONDS

/obj/effect/temp_visual/divine_light
	name = "divine light"
	desc = "Pure, organizing divine light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "holy_light"
	duration = 60 SECONDS

/obj/effect/temp_visual/sacred_pattern
	name = "sacred geometric pattern"
	desc = "A perfect geometric pattern inscribed with divine light."
	icon = 'icons/effects/effects.dmi'
	icon_state = "rune_holy"
	duration = 300 SECONDS

/obj/effect/temp_visual/reality_crack
	name = "reality crack"
	desc = "A brief tear in the fabric of reality."
	icon = 'icons/effects/effects.dmi'
	icon_state = "reality_crack"
	duration = 10 SECONDS

/obj/effect/temp_visual/kinetic_burst
	name = "kinetic burst"
	desc = "A burst of pure kinetic energy."
	icon = 'icons/effects/effects.dmi'
	icon_state = "kinetic_wave"
	duration = 5 SECONDS

// Additional supporting items and structures
/obj/item/reagent_containers/glass/bottle/antidote
	name = "universal antidote"
	desc = "A potent brew that counters multiple types of poison."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bottle_green"

/obj/item/reagent_containers/glass/bottle/antidote/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/medicine/antidote, 50)

/obj/item/spell_crystal
	name = "spell storage crystal"
	desc = "A crystal capable of storing magical energy for later use."
	icon_state = "crystal_blue"
	w_class = WEIGHT_CLASS_SMALL
	var/stored_spell = null
	var/stored_charges = 0

// Status effects for the spell buffs
/datum/status_effect/buff/wind_walking
	id = "wind_walking"
	alert_type = /atom/movable/screen/alert/status_effect/wind_walking
	duration = 30 SECONDS

/datum/status_effect/buff/wind_walking/on_apply()
	. = ..()
	owner.add_movespeed_modifier("wind_walking", multiplicative_slowdown = -0.3)
	to_chat(owner, span_notice("You step upon the wind itself!"))

/datum/status_effect/buff/wind_walking/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("wind_walking")

/datum/status_effect/buff/aerial_speed
	id = "aerial_speed"
	alert_type = /atom/movable/screen/alert/status_effect/aerial_speed
	duration = 15 SECONDS

/datum/status_effect/buff/aerial_speed/on_apply()
	. = ..()
	owner.add_movespeed_modifier("aerial_speed", multiplicative_slowdown = -0.5)
	to_chat(owner, span_notice("Air currents propel you forward!"))

/datum/status_effect/buff/aerial_speed/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("aerial_speed")

/datum/status_effect/buff/probability_flux
	id = "probability_flux"
	alert_type = /atom/movable/screen/alert/status_effect/probability_flux
	duration = 60 SECONDS
	effectedstats = list(STATKEY_LCK = 2)

/datum/status_effect/buff/toxin_immunity
	id = "toxin_immunity"
	alert_type = /atom/movable/screen/alert/status_effect/toxin_immunity
	duration = 300 SECONDS

/datum/status_effect/buff/toxin_immunity/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_TOXINLOVER, MAGIC_TRAIT)
	to_chat(owner, span_notice("Toxins cannot harm you!"))

/datum/status_effect/buff/toxin_immunity/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_TOXINLOVER, MAGIC_TRAIT)

/datum/status_effect/buff/arcane_focus
	id = "arcane_focus"
	alert_type = /atom/movable/screen/alert/status_effect/arcane_focus
	duration = 600 SECONDS

/datum/status_effect/buff/arcane_focus/on_apply()
	. = ..()
	if(isliving(owner))
		var/mob/living/L = owner
		for(var/datum/action/cooldown/spell/spell in L.actions)
			spell.charge_required = FALSE
		to_chat(owner, span_notice("Your magical focus intensifies!"))

/datum/status_effect/buff/arcane_focus/on_remove()
	. = ..()
	if(isliving(owner))
		var/mob/living/L = owner
		for(var/datum/action/cooldown/spell/spell in L.actions)
			spell.charge_required = initial(spell.charge_required)
		to_chat(owner, span_notice("Your magical focus returns to normal!"))

/datum/status_effect/buff/momentum_boost
	id = "momentum_boost"
	alert_type = /atom/movable/screen/alert/status_effect/momentum_boost
	duration = 30 SECONDS

/datum/status_effect/buff/momentum_boost/on_apply()
	. = ..()
	owner.add_movespeed_modifier("momentum", multiplicative_slowdown = -0.4)
	ADD_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)
	to_chat(owner, span_notice("Kinetic energy surges through you!"))

/datum/status_effect/buff/momentum_boost/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("momentum")
	REMOVE_TRAIT(owner, TRAIT_PUSHIMMUNE, MAGIC_TRAIT)

/datum/status_effect/buff/regeneration_cycle
	id = "regeneration_cycle"
	alert_type = /atom/movable/screen/alert/status_effect/regeneration_cycle
	duration = 300 SECONDS
	tick_interval = 10 SECONDS

/datum/status_effect/buff/regeneration_cycle/tick()
	if(owner.health < owner.maxHealth)
		owner.adjustBruteLoss(-1)
		owner.adjustFireLoss(-1)

/datum/status_effect/buff/ancestral_smithing
	id = "ancestral_smithing"
	alert_type = /atom/movable/screen/alert/status_effect/ancestral_smithing
	duration = 600 SECONDS

/datum/status_effect/buff/elven_grace
	id = "elven_grace"
	alert_type = /atom/movable/screen/alert/status_effect/elven_grace
	duration = 300 SECONDS

/datum/status_effect/buff/elven_grace/on_apply()
	. = ..()
	owner.add_movespeed_modifier("elven_grace", multiplicative_slowdown = -0.2)

/datum/status_effect/buff/elven_grace/on_remove()
	. = ..()
	owner.remove_movespeed_modifier("elven_grace")

/datum/status_effect/buff/balanced_mind
	id = "balanced_mind"
	alert_type = /atom/movable/screen/alert/status_effect/balanced_mind
	duration = 450 SECONDS
	var/balance_value = 10 // What value to balance all stats to
	var/source_key

/datum/status_effect/buff/balanced_mind/on_apply()
	. = ..()
	if(!owner)
		return
	source_key = "balanced_mind_[ref(src)]"
	owner.set_stat_modifier(source_key, STATKEY_STR, balance_value - owner.STASTR)
	owner.set_stat_modifier(source_key, STATKEY_PER, balance_value - owner.STAPER)
	owner.set_stat_modifier(source_key, STATKEY_END, balance_value - owner.STAEND)
	owner.set_stat_modifier(source_key, STATKEY_CON, balance_value - owner.STACON)
	owner.set_stat_modifier(source_key, STATKEY_INT, balance_value - owner.STAINT)
	owner.set_stat_modifier(source_key, STATKEY_SPD, balance_value - owner.STASPD)
	owner.set_stat_modifier(source_key, STATKEY_LCK, balance_value - owner.STALUC)

/datum/status_effect/buff/balanced_mind/on_remove()
	. = ..()
	if(!owner || !source_key)
		return
	owner.set_stat_modifier(source_key, STATKEY_STR, 0)
	owner.set_stat_modifier(source_key, STATKEY_PER, 0)
	owner.set_stat_modifier(source_key, STATKEY_END, 0)
	owner.set_stat_modifier(source_key, STATKEY_CON, 0)
	owner.set_stat_modifier(source_key, STATKEY_INT, 0)
	owner.set_stat_modifier(source_key, STATKEY_SPD, 0)
	owner.set_stat_modifier(source_key, STATKEY_LCK, 0)

/atom/movable/screen/alert/status_effect/wind_walking
	name = "Wind Walking"
	desc = "You step upon the wind itself, moving with supernatural grace."
	icon_state = "wind_walking"

/atom/movable/screen/alert/status_effect/aerial_speed
	name = "Aerial Speed"
	desc = "Air currents propel you forward with incredible speed."
	icon_state = "aerial_speed"

/atom/movable/screen/alert/status_effect/probability_flux
	name = "Probability Flux"
	desc = "The odds seem to be in your favor... or against you."
	icon_state = "probability_flux"

/atom/movable/screen/alert/status_effect/toxin_immunity
	name = "Toxin Immunity"
	desc = "You are completely immune to all toxins and poisons."
	icon_state = "toxin_immunity"

/atom/movable/screen/alert/status_effect/arcane_focus
	name = "Arcane Focus"
	desc = "Your magical abilities are enhanced by arcane focus."
	icon_state = "arcane_focus"

/atom/movable/screen/alert/status_effect/momentum_boost
	name = "Momentum Boost"
	desc = "Kinetic energy flows through you, enhancing your movement."
	icon_state = "momentum_boost"

/atom/movable/screen/alert/status_effect/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Your body continuously heals itself through natural cycles."
	icon_state = "regeneration_cycle"

/atom/movable/screen/alert/status_effect/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "The spirits of ancient dwarven smiths guide your craft."
	icon_state = "ancestral_smithing"

/atom/movable/screen/alert/status_effect/elven_grace
	name = "Elven Grace"
	desc = "You move with the ethereal grace of the ancient elves."
	icon_state = "elven_grace"

/atom/movable/screen/alert/status_effect/balanced_mind
	name = "Balanced Mind"
	desc = "Perfect mental equilibrium between order and chaos."
	icon_state = "balanced_mind"

/datum/status_effect/buff/air_walking
	id = "air_walking"
	alert_type = /atom/movable/screen/alert/status_effect/air_walking
	duration = 15 SECONDS

/datum/status_effect/buff/air_walking/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_HOLLOWBONES, MAGIC_TRAIT)
	owner.movement_type |= FLYING
	to_chat(owner, span_notice("You feel light as air, able to step over gaps and chasms."))

/datum/status_effect/buff/air_walking/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_HOLLOWBONES, MAGIC_TRAIT)
	owner.movement_type &= ~FLYING
	to_chat(owner, span_notice("Your feet return to solid ground."))

/datum/status_effect/buff/water_breathing
	id = "water_breathing"
	alert_type = /atom/movable/screen/alert/status_effect/water_breathing
	duration = 60 SECONDS

/datum/status_effect/buff/water_breathing/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_WATER_BREATHING, MAGIC_TRAIT)
	to_chat(owner, span_notice("You can now breathe underwater."))

/datum/status_effect/buff/water_breathing/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_WATER_BREATHING, MAGIC_TRAIT)
	to_chat(owner, span_notice("Your ability to breathe underwater fades."))

/datum/status_effect/buff/warmth
	id = "warmth"
	alert_type = /atom/movable/screen/alert/status_effect/warmth
	duration = 120 SECONDS

/datum/status_effect/buff/warmth/on_apply()
	. = ..()
	ADD_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	owner.bodytemperature = max(owner.bodytemperature, BODYTEMP_NORMAL)
	to_chat(owner, span_notice("A gentle warmth spreads through your body."))

/datum/status_effect/buff/warmth/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	to_chat(owner, span_notice("The magical warmth fades away."))

/datum/status_effect/buff/phase_walking
	id = "phase_walking"
	alert_type = /atom/movable/screen/alert/status_effect/phase_walking
	duration = 5 SECONDS

/datum/status_effect/buff/phase_walking/on_apply()
	. = ..()
	owner.pass_flags |= PASSMOB | PASSBLOB | PASSTABLE | PASSGLASS
	owner.alpha = 128
	to_chat(owner, span_notice("You become translucent and can pass through objects."))

/datum/status_effect/buff/phase_walking/on_remove()
	. = ..()
	owner.pass_flags &= ~(PASSMOB | PASSBLOB | PASSTABLE | PASSGLASS)
	owner.alpha = 255
	to_chat(owner, span_notice("You return to solid form."))

/datum/status_effect/buff/vigor
	id = "vigor"
	alert_type = /atom/movable/screen/alert/status_effect/vigor
	duration = 60 SECONDS
	effectedstats = list("strength" = 1, "endurance" = 1)

/datum/status_effect/buff/vigor/on_apply()
	. = ..()
	if(isliving(owner))
		var/mob/living/L = owner
		L.adjust_stamina(50)
		ADD_TRAIT(owner, TRAIT_STRONG_GRABBER, MAGIC_TRAIT)
		to_chat(owner, span_notice("You feel invigorated with supernatural strength."))

/datum/status_effect/buff/vigor/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_STRONG_GRABBER, MAGIC_TRAIT)
	to_chat(owner, span_notice("The supernatural vigor fades."))

/datum/status_effect/buff/seasonal_attunement
	id = "seasonal_attunement"
	alert_type = /atom/movable/screen/alert/status_effect/seasonal_attunement
	duration = 600 SECONDS

/datum/status_effect/buff/seasonal_attunement/on_apply()
	. = ..()
	// Minor resistances based on current season/time
	ADD_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	ADD_TRAIT(owner, TRAIT_RESISTHEAT, MAGIC_TRAIT)
	to_chat(owner, span_notice("You harmonize with the natural cycles."))

/datum/status_effect/buff/seasonal_attunement/on_remove()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_RESISTCOLD, MAGIC_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_RESISTHEAT, MAGIC_TRAIT)
	to_chat(owner, span_notice("Your connection to natural cycles fades."))

// Alert types for status effects
/atom/movable/screen/alert/status_effect/air_walking
	name = "Air Walking"
	desc = "You can step on solidified air over gaps."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/water_breathing
	name = "Water Breathing"
	desc = "You can breathe underwater."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/warmth
	name = "Warmth"
	desc = "Magical warmth protects you from cold."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/phase_walking
	name = "Phase Walking"
	desc = "You can pass through solid objects."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/vigor
	name = "Vigor"
	desc = "You feel supernaturally strong and energetic."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/seasonal_attunement
	name = "Seasonal Attunement"
	desc = "You are harmonized with natural cycles."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/wind_walking
	name = "Wind Walking"
	desc = "You move with supernatural speed on air currents."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/aerial_speed
	name = "Aerial Speed"
	desc = "Air currents propel you forward rapidly."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/probability_flux
	name = "Probability Flux"
	desc = "Reality bends around you in unpredictable ways."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/toxin_immunity
	name = "Toxin Immunity"
	desc = "You are protected from all toxins and poisons."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/arcane_focus
	name = "Arcane Focus"
	desc = "Your magical abilities are enhanced."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/momentum_boost
	name = "Momentum Boost"
	desc = "Kinetic energy surges through you."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/regeneration_cycle
	name = "Regeneration Cycle"
	desc = "Your body heals itself continuously."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/accelerated_growth
	name = "Accelerated Growth"
	desc = "Growth processes are dramatically sped up."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/ancestral_smithing
	name = "Ancestral Smithing"
	desc = "The spirits of ancient smiths guide your hands."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/elven_grace
	name = "Elven Grace"
	desc = "You move with ethereal grace and agility."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/nature_communion
	name = "Nature Communion"
	desc = "You are deeply connected to the natural world."
	icon_state = "buff"

/atom/movable/screen/alert/status_effect/balanced_mind
	name = "Balanced Mind"
	desc = "Your mind is in perfect equilibrium."
	icon_state = "buff"


/obj/structure/closet/crate/chest/magical
	name = "magical ice chest"
	desc = "A chest made of supernatural ice that preserves items indefinitely."
	icon_state = "freezer"
	color = LIGHT_COLOR_LIGHT_CYAN

/obj/structure/closet/crate/chest/magical/Initialize()
	. = ..()
	propagate_temp_change(-15, 6, 0.4, 2)

/obj/structure/closet/crate/chest/magical/Destroy()
	remove_temp_effect()
	return ..()
