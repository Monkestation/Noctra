/datum/action/cooldown/spell/gravemark
	name = "Gravemark"
	desc = "Adds or removes a target from the list of allies exempt from your undead's aggression."
	button_icon_state = "raiseskele"
	cooldown_time = 25 SECONDS
	spell_cost = 25
	cast_range = 4
	charge_required = FALSE

/datum/action/cooldown/spell/gravemark/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	return isliving(cast_on)

/datum/action/cooldown/spell/gravemark/cast(mob/living/cast_on)
	. = ..()
	var/faction_tag = FACTION_CABAL
	if(cast_on == owner)
		to_chat(owner, span_warning("It would be unwise to make an enemy of your own skeletons."))
		return FALSE
	if(cast_on.mind && cast_on.mind.current)
		if(faction_tag in cast_on.mind.current.faction)
			cast_on.mind.current.faction -= faction_tag
			owner.say("Hostis declaratus es.")
		else
			cast_on.mind.current.faction += faction_tag
			owner.say("Amicus declaratus es.")
	else if(istype(cast_on, /mob/living/simple_animal))
		if(faction_tag in cast_on.faction)
			cast_on.faction -= faction_tag
			owner.say("Hostis declaratus es.")
		else
			cast_on.faction |= faction_tag
			owner.say("Amicus declaratus es.")
