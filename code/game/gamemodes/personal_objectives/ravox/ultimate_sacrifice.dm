/datum/objective/ultimate_sacrifice
	name = "Ultimate Sacrifice"
	triumph_count = 3

/datum/objective/ultimate_sacrifice/on_creation()
	. = ..()
	owner.current.add_spell(/datum/action/cooldown/spell/undirected/list_target/ultimate_sacrifice, source = src)
	update_explanation_text()

/datum/objective/ultimate_sacrifice/update_explanation_text()
	explanation_text = "Make the highest sacrifice by giving your own life to save truly innocent and worthy soul in the name of Ravox."
