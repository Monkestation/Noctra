/datum/spell_node
	var/name = "Unknown Spell"
	var/desc = "A mysterious magical technique."
	var/icon = 'icons/mob/actions/roguespells.dmi'
	var/icon_state = "rune1"
	var/node_x = 0  // Position on the research tree
	var/node_y = 0
	/// List of spell node types required
	var/list/prerequisites = list()
	/// Description of what this unlocks
	var/list/unlocks = list()
	/// Spell points required
	var/cost = 1
	/// Whether this is a passive ability instead of a spell
	var/is_passive = FALSE
	/// What spell this grants (null for passives)
	var/datum/action/cooldown/spell/spell_type = null

/datum/spell_node/New()
	. = ..()
	if(spell_type)
		cost = spell_type.point_cost
		icon = spell_type.button_icon
		icon_state = spell_type.button_icon_state

/datum/spell_node/proc/on_node_buy(mob/user)
	return
