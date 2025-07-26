/datum/action/cooldown/spell/transfrom_tree
	name = "Transform Tree"
	button_icon_state = "entangle"
	has_visual_effects = FALSE
	self_cast_possible = FALSE

	cast_range = 1
	cooldown_time = 20 SECONDS

	var/uses = 3

/datum/action/cooldown/spell/transfrom_tree/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return
	if(!ishuman(owner))
		return FALSE

/datum/action/cooldown/spell/transfrom_tree/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/obj/structure/flora/target

	if(istype(cast_on, /obj/structure/flora/tree) && !istype(cast_on, /obj/structure/flora/tree/wise) && !istype(cast_on, /obj/structure/flora/tree/stump))
		target = cast_on
	else if(istype(cast_on, /obj/structure/flora/newtree))
		target = cast_on
	else if(cast_on.loc && (get_dist(owner, cast_on.loc) <= 1))
		for(var/obj/structure/flora/tree/T in cast_on.loc)
			if(!istype(T, /obj/structure/flora/tree/wise) && !istype(T, /obj/structure/flora/tree/stump))
				target = T
				break
		if(!target)
			for(var/obj/structure/flora/newtree/NT in cast_on.loc)
				if(!NT.burnt)
					target = NT
					break

	if(!target)
		to_chat(H, span_warning("You must target a normal, living tree adjacent to you!"))
		return

	var/turf/below = get_step_multiz(target, DOWN)
	if(below && istype(below, /turf/open/transparent/openspace))
		to_chat(H, span_warning("You must target the base of the tree!"))
		return

	if(uses <= 0)
		to_chat(H, span_warning("Your blessing has been exhausted!"))
		H.remove_spell(src)
		return

	H.visible_message(span_notice("[H] begins chanting to transform the tree."), \
					span_notice("You begin the transformation ritual..."))

	if(!do_after(H, 10 SECONDS, target = target))
		to_chat(H, span_warning("The ritual was interrupted!"))
		return

	var/turf/T = get_turf(target)
	if(istype(target, /obj/structure/flora/newtree))
		for(var/DIR in GLOB.cardinals)
			var/turf/B = get_step(T, DIR)
			for(var/obj/structure/flora/newbranch/BRANCH in B)
				if(BRANCH.dir == DIR)
					var/turf/BI = get_step(B, DIR)
					for(var/obj/structure/flora/newbranch/bi in BI)
						if(bi.dir == DIR)
							qdel(bi)
					for(var/obj/structure/flora/newleaf/bil in BI)
						qdel(bil)
					qdel(BRANCH)
		for(var/turf/DIA in block(get_step(T, SOUTHWEST), get_step(T, NORTHEAST)))
			for(var/obj/structure/flora/newleaf/LEAF in DIA)
				qdel(LEAF)
		var/turf/above = get_step_multiz(T, UP)
		if(istype(above, /turf/open/transparent/openspace))
			for(var/obj/structure/flora/newtree/upper_tree in above)
				qdel(upper_tree)

	var/obj/structure/flora/tree/wise/new_wise_tree = new(T)
	new_wise_tree.activated = TRUE
	new_wise_tree.set_light(2, 2, 2, l_color = "#66FF99")

	qdel(target)

	uses--
	SEND_SIGNAL(owner, COMSIG_TREE_TRANSFORMED)
	if(uses > 0)
		to_chat(H, span_notice("You transform the tree into a wise tree. [uses] use\s remaining."))
	else
		to_chat(H, span_notice("You transform the tree into a wise tree."))
	playsound(T, 'sound/ambience/noises/mystical (4).ogg', 50, TRUE)

	if(uses <= 0)
		to_chat(H, span_warning("Dendor's blessing fades from you."))
		H.remove_spell(src)
