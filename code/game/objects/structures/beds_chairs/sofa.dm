/obj/structure/chair/sofa
	name = "old ratty sofa"
	icon_state = "sofamiddle"
	icon = 'icons/obj/sofa.dmi'
	buildstackamount = 1
	item_chair = null

/obj/structure/chair/sofa/left
	icon_state = "sofaend_left"

/obj/structure/chair/sofa/right
	icon_state = "sofaend_right"

/obj/structure/chair/sofa/corner
	icon_state = "sofacorner"

// -------- CannibalHunter's Le' Fancy Couch --------
/obj/structure/chair/bench/couch
	name = "fancy couch"
	desc = "It's quite an elegant couch of the finest quality and color. Crumbs and strands of various hair color- stuffed in the cracks."
	icon = 'icons/roguetown/misc/couch.dmi'
	icon_state = null
	color = null
	dir = 6

/obj/structure/chair/bench/couch/Initialize()
	. = ..()
	if(color==CLOTHING_ROYAL_BLACK | color==CLOTHING_ROYAL_RED)
		if(GLOB.lordprimary)
			lordcolor(GLOB.lordprimary,GLOB.lordprimary)
		else
			GLOB.lordcolor += src

/obj/structure/chair/bench/couch/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/structure/chair/bench/couch/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	if(color==CLOTHING_ROYAL_RED)
		color = primary
		GLOB.lordcolor -= src
		return
	if(color==CLOTHING_ROYAL_BLACK)
		color = secondary
		GLOB.lordcolor -= src
		return

/obj/structure/chair/bench/couch/normal
	icon_state = "couch-1"
	color = CLOTHING_ROYAL_RED

/obj/structure/chair/bench/couch/normal/long_or_corner
	icon_state = "couch-2"

/obj/structure/chair/bench/couch/normal/alt
	color = CLOTHING_ROYAL_BLACK

/obj/structure/chair/bench/couch/normal/long_or_corner/alt
	color = CLOTHING_ROYAL_BLACK

/obj/structure/chair/bench/couch/normal/mapper_dont_use_this
	dir = 2

/obj/structure/chair/bench/couch/normal/alt/mapper_dont_use_this
	dir = 2
