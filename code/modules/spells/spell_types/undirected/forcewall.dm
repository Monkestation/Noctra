/datum/action/cooldown/spell/undirected/forcewall
	name = "Forcewall"
	desc = "Conjure a wall of arcyne force, preventing anyone and anything other than you from moving through it."
	button_icon_state = "forcewall"

	point_cost = 3
	attunements = list(
		/datum/attunement/illusion = 0.3,
	)
	school = SCHOOL_TRANSMUTATION

	charge_time = 2 SECONDS
	charge_drain = 1
	charge_slowdown = 1.3
	cooldown_time = 35 SECONDS
	spell_cost = 30
	spell_flags = SPELL_RITUOS
	var/wall_type = /obj/effect/forcefield/wizard

/datum/action/cooldown/spell/undirected/forcewall/cast(atom/cast_on)
	. = ..()
	var/turf/ahead = get_step(owner, owner.dir)
	new wall_type(ahead, owner, antimagic_flags)
	if(owner.dir == SOUTH || owner.dir == NORTH)
		new wall_type(get_step(ahead, EAST), owner, antimagic_flags)
		new wall_type(get_step(ahead, WEST), owner, antimagic_flags)
	else
		new wall_type(get_step(ahead, NORTH), owner, antimagic_flags)
		new wall_type(get_step(ahead, SOUTH), owner, antimagic_flags)

/datum/action/cooldown/spell/undirected/forcewall/breakable
	name = "Lesser Forcewall"
	wall_type = /obj/structure/forcefield/casted
