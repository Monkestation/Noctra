/datum/action/cooldown/spell/aoe/on_turf/meteor_storm
	name = "Meteor Storm"
	desc = "Summons forth meteors from the sky."
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC|SPELL_REQUIRES_NO_MOVE
	button_icon_state = "fireball_greater"
	sound = 'sound/magic/meteorstorm.ogg'

	point_cost = 8
	attunements = list(
		/datum/attunement/fire = 1.2
	)

	charge_time = 25 SECONDS
	charge_drain = 2
	charge_slowdown = 1.3
	cooldown_time = 3 MINUTES
	spell_cost = 120

	aoe_radius = 5
	max_targets = 16
	respect_LOS = FALSE

/datum/action/cooldown/spell/aoe/on_turf/meteor_storm/cast(atom/cast_on)
	. = ..()
	cast_on.visible_message(span_boldwarning("Fire is raining from the sky!"))

/datum/action/cooldown/spell/aoe/on_turf/meteor_storm/cast_on_thing_in_aoe(turf/victim, atom/caster)
	if(prob(20 * attuned_strength))
		new /obj/effect/temp_visual/target/meteor(get_turf(victim))
