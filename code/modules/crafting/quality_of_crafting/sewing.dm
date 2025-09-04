/datum/repeatable_crafting_recipe/sewing
	abstract_type = /datum/repeatable_crafting_recipe/sewing
	requirements = list(
		/obj/item/natural/cloth = 1
	)
	tool_usage = list(
		/obj/item/needle = list("starts to sew", "start to sew")
	)

	starting_atom = /obj/item/needle
	attacked_atom = /obj/item/natural/cloth
	skillcraft = /datum/skill/misc/sewing
	craftdiff = 0
	subtypes_allowed = TRUE // so you can use any subtype of fur
	category = "Shirt"

/// Stuff made from hides
/datum/repeatable_crafting_recipe/sewing/hide
	abstract_type = /datum/repeatable_crafting_recipe/sewing/hide
	category = "Sewn Hides"
	attacked_atom = /obj/item/natural/hide
	blacklisted_paths = list(/obj/item/natural/hide/cured)

/datum/repeatable_crafting_recipe/sewing/hide/tribalrags
	name = "tribal rags"
	output = /obj/item/clothing/shirt/tribalrag
	requirements = list(/obj/item/natural/hide = 1,
				/obj/item/natural/fibers = 1)
	sellprice = 6
	craftdiff = 0

/datum/repeatable_crafting_recipe/sewing/hide/tribal_cloak
	name = "tribal pelt"
	requirements = list(
		/obj/item/natural/hide = 2,
	)
	output = /obj/item/clothing/cloak/tribal

/datum/repeatable_crafting_recipe/sewing/hide/tribal_shoes
	name = "tribal shoes"
	requirements = list(
		/obj/item/natural/hide = 1,
	)
	output = /obj/item/clothing/shoes/tribal

/datum/repeatable_crafting_recipe/sewing/hide/volfhelm
	name = "volf helm"
	requirements = list(
		/obj/item/natural/hide = 3,
		/obj/item/natural/fur = 2,
	)
	output = /obj/item/clothing/head/helmet/leather/volfhelm
	sellprice = 20

/datum/repeatable_crafting_recipe/sewing/hide/volfmantle
	name = "volf mantle"
	attacked_atom = /obj/item/natural/fur/volf
	requirements = list(
		/obj/item/natural/hide = 1,
		/obj/item/natural/fur/volf = 2,
		/obj/item/natural/head/volf = 1,
	)
	output = /obj/item/clothing/cloak/volfmantle
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/hide/papakha
	name = "papakha hat"
	requirements = list(
		/obj/item/natural/hide = 1,
		/obj/item/natural/fur = 1,
		/obj/item/natural/fibers = 2,
	)
	output = /obj/item/clothing/head/papakha
	craftdiff = 1

/// Cloth
/datum/repeatable_crafting_recipe/sewing/rags
	name = "rags"
	requirements = list(
		/obj/item/natural/cloth = 2,
	)
	output = /obj/item/clothing/shirt/rags

/datum/repeatable_crafting_recipe/sewing/winding_sheet
	name = "winding sheet"
	requirements = list(
		/obj/item/natural/cloth = 2,
	)
	output = /obj/item/burial_shroud
	craftdiff = 1
	category = "Misc Sewing"

/datum/repeatable_crafting_recipe/sewing/loincloth
	name = "loincloth"
	requirements = list(
		/obj/item/natural/cloth = 1,
	)
	output = /obj/item/clothing/pants/loincloth
	category = "Pants"

/datum/repeatable_crafting_recipe/sewing/apron
	name = "cloth apron"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/cloak/apron
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/clothgloves
	name = "cloth gloves"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/gloves/fingerless
	category = "Gloves"

/datum/repeatable_crafting_recipe/sewing/shortshirt
	name = "cloth short shirt"
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/shirt/shortshirt

/datum/repeatable_crafting_recipe/sewing/clothshirt
	name = "cloth shirt"
	requirements = list(
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/shirt/undershirt

/datum/repeatable_crafting_recipe/sewing/tunic
	name = "tunic"
	output = /obj/item/clothing/shirt/tunic
	requirements = list(/obj/item/natural/cloth = 2)

/datum/repeatable_crafting_recipe/sewing/lowcut_shirt
	name = "low cut tunic"
	requirements = list(
		/obj/item/natural/cloth = 2,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/shirt/undershirt/lowcut
	category = "Undershirt"

/datum/repeatable_crafting_recipe/sewing/stripedtunic
	name = "striped tunic"
	output = /obj/item/clothing/armor/gambeson/light/striped
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	category = "Armor"

/datum/repeatable_crafting_recipe/sewing/clothtights
	name = "cloth tights"
	output = /obj/item/clothing/pants/tights
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	category = "Pants"

/datum/repeatable_crafting_recipe/sewing/headband
	name = "headband"
	output = /obj/item/clothing/head/headband
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/strawhat
	name = "crude straw hat"
	output = /obj/item/clothing/head/strawhat
	requirements = list(/obj/item/natural/fibers = 3)
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/knitcap
	name = "knit cap"
	output = /obj/item/clothing/head/knitcap
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/cmask
	name = "cloth mask"
	output = /obj/item/clothing/face/shepherd/clothmask
	requirements = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 1)
	category = "Mask"

/datum/repeatable_crafting_recipe/sewing/cmask_rag
	name = "rag mask"
	output = /obj/item/clothing/face/shepherd/rag
	requirements = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 1)
	category = "Mask"

/datum/repeatable_crafting_recipe/sewing/linedanklet
	name = "cloth anklet"
	output = /obj/item/clothing/shoes/boots/clothlinedanklets
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	category = "Shoes"

/datum/repeatable_crafting_recipe/sewing/zigbox
	name = "zigbox"
	output = /obj/item/storage/fancy/cigarettes/zig/empty
	requirements = list(/obj/item/paper = 1,
				/obj/item/natural/fibers = 1)
	blacklisted_paths = list(/obj/item/paper/scroll, /obj/item/paper/confession)
	category = "Storage"
/*.............. recipes requiring skill 1 ..............*/

/datum/repeatable_crafting_recipe/sewing/stripedtunic
	name = "striped tunic"
	output = /obj/item/clothing/armor/gambeson/light/striped
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Armor"

/datum/repeatable_crafting_recipe/sewing/Reyepatch
	name = "right eye patch"
	output = /obj/item/clothing/face/eyepatch
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Face"

/datum/repeatable_crafting_recipe/sewing/Leyepatch
	name = "left eye patch"
	output = /obj/item/clothing/face/eyepatch/left
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Face"

/datum/repeatable_crafting_recipe/sewing/fakeeyepatch
	name = "see through eyepatch"
	output = /obj/item/clothing/face/eyepatch/fake
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Face"

/datum/repeatable_crafting_recipe/sewing/fisherhat
	name = "straw fisher hat"
	output = /obj/item/clothing/head/fisherhat
	requirements = list(/obj/item/natural/fibers = 3)
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/fisherhat
	name = "shawl"
	output = /obj/item/clothing/head/shawl
	requirements = list(/obj/item/natural/fibers = 3)
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/sack
	name = "sack hood"
	output = /obj/item/clothing/head/menacing
	requirements = list(/obj/item/natural/cloth = 3)
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/clothknapsack
	name = "cloth knapsack"
	output = /obj/item/storage/backpack/satchel/cloth
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 2)
	craftdiff = 1
	category = "Storage"

/datum/repeatable_crafting_recipe/sewing/pcoif
	name = "cloth coif"
	output = /obj/item/clothing/neck/coif/cloth
	requirements = list(/obj/item/natural/fibers = 1, /obj/item/natural/cloth = 2)
	craftdiff = 1
	category = "Neck"

/datum/repeatable_crafting_recipe/sewing/keffiyeh
	name = "keffiyeh"
	requirements = list(/obj/item/natural/cloth = 2, /obj/item/natural/fibers = 1,)
	output = /obj/item/clothing/neck/keffiyeh
	craftdiff = 1
	category = "Neck"

/datum/repeatable_crafting_recipe/sewing/feld_collar
	name = "feldsher's collar"
	requirements = list(/obj/item/natural/cloth = 2, /obj/item/natural/fibers = 2,)
	output = /obj/item/clothing/neck/feld
	craftdiff = 1
	category = "Neck"

/datum/repeatable_crafting_recipe/sewing/phys_collar
	name = "physicker's collar"
	requirements = list(/obj/item/natural/cloth = 1, /obj/item/natural/fibers = 2,)
	output = /obj/item/clothing/neck/phys
	craftdiff = 1
	category = "Neck"

/datum/repeatable_crafting_recipe/sewing/courtphys_collar
	name = "court physician's collar"
	requirements = list(/obj/item/natural/cloth = 3, /obj/item/natural/fibers = 2,)
	output = /obj/item/clothing/neck/courtphysician
	craftdiff = 1
	category = "Neck"

/datum/repeatable_crafting_recipe/sewing/roguehood
	name = "cloth hood"
	requirements = list(/obj/item/natural/cloth = 1, /obj/item/natural/fibers = 1,)
	output = /obj/item/clothing/head/roguehood
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/articap
	name = "artificer cap"
	requirements = list(/obj/item/natural/cloth = 1, /obj/item/natural/fibers = 1,)
	output = /obj/item/clothing/head/articap
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/cookhat
	name = "cook hat"
	requirements = list(/obj/item/natural/cloth = 1, /obj/item/natural/fibers = 1,)
	output = /obj/item/clothing/head/cookhat
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/chefhat
	name = "chef hat"
	requirements = list(/obj/item/natural/cloth = 1, /obj/item/natural/fibers = 1,)
	output = /obj/item/clothing/head/cookhat/chef
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/clothpouch
	name = "cloth pouch"
	output = /obj/item/storage/belt/pouch/cloth
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Storage"

/datum/repeatable_crafting_recipe/sewing/clothtrou
	name = "cloth trousers"
	output = /obj/item/clothing/pants/trou
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Pants"

/datum/repeatable_crafting_recipe/sewing/lgambeson
	name = "light gambeson"
	output = /obj/item/clothing/armor/gambeson/light
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Armor"

/datum/repeatable_crafting_recipe/sewing/sleepingbag
	name = "bedroll"
	output = /obj/item/sleepingbag
	requirements =  list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Misc Sewing"

/datum/repeatable_crafting_recipe/sewing/armingcap
	name = "arming cap"
	output = /obj/item/clothing/head/armingcap
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/flowercrown
	abstract_type = /datum/repeatable_crafting_recipe/sewing/flowercrown
	attacked_atom = /obj/item/rope
	craftdiff = 1
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/flowercrown/rosa
	name = "rosa crown"
	requirements = list(/obj/item/rope = 1,\
					/obj/item/alch/herb/rosa = 2)
	output = /obj/item/clothing/head/flowercrown/rosa

/datum/repeatable_crafting_recipe/sewing/flowercrown/rosa/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/sewing/flowercrown/salvia
	name = "salvia crown"
	requirements = list(/obj/item/rope = 1,\
					/obj/item/alch/herb/salvia = 2)
	output = /obj/item/clothing/head/flowercrown/salvia

/datum/repeatable_crafting_recipe/sewing/flowercrown/salvia/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/*.............. recipes requiring skill 2 ..............*/
/datum/repeatable_crafting_recipe/sewing/gambeson
	name = "gambeson"
	output = /obj/item/clothing/armor/gambeson
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Armor"

/datum/repeatable_crafting_recipe/sewing/tabard
	name = "tabard"
	output = /obj/item/clothing/cloak/tabard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/tabard
	name = "tabard (crusader)"
	output = /obj/item/clothing/cloak/tabard/crusader
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/stabard
	name = "surcoat"
	output = /obj/item/clothing/cloak/stabard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/jupon_cloak
	name = "jupon"
	output = /obj/item/clothing/cloak/stabard/jupon
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/bedsheet
	name = "bedsheet"
	output = /obj/item/bedsheet/cloth
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Misc Sewing"

/datum/repeatable_crafting_recipe/sewing/undervestments
	name = "undervestments"
	requirements = list(
		/obj/item/natural/cloth = 3,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/shirt/undershirt/priest
	craftdiff = 2
	category = "Undershirt"

/datum/repeatable_crafting_recipe/sewing/wrappings
	name = "solar wrappings"
	requirements = list(
		/obj/item/natural/cloth = 2
	)
	output = /obj/item/clothing/wrists/wrappings
	craftdiff = 2
	category = "Wrists"

/datum/repeatable_crafting_recipe/sewing/nocwrappings
	name = "moon wrappings"
	requirements = list(
		/obj/item/natural/cloth = 2
	)
	output = /obj/item/clothing/wrists/nocwrappings
	craftdiff = 2
	category = "Wrists"


/datum/repeatable_crafting_recipe/sewing/skirt
	name = "skirt"
	output = /obj/item/clothing/pants/skirt
	requirements = list(/obj/item/natural/cloth = 2,
			/obj/item/natural/fibers = 1)
	craftdiff = 2
	category = "Pants"
/*.............. recipes requiring skill 3 ..............*/

/datum/repeatable_crafting_recipe/sewing/armingjacket
	name = "arming jacket"
	output = /obj/item/clothing/armor/gambeson/arming
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Armor"

/datum/repeatable_crafting_recipe/sewing/wizhat
	name = "wizard hat"
	output = /obj/item/clothing/head/wizhat
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/witchhat
	name = "witch hat"
	output = /obj/item/clothing/head/wizhat/witch
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/wizardrobes
	name = "wizard robes"
	output = /obj/item/clothing/shirt/robe/wizard
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/magusrobes
	name = "magus robe"
	output = /obj/item/clothing/shirt/robe/magus
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/hide/cured = 4,
				/obj/item/natural/fibers = 1)
	craftdiff = 6

/datum/repeatable_crafting_recipe/sewing/adept_robes
	name = "adept robes"
	output = /obj/item/clothing/shirt/robe/newmage/adept
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/sorcerer_robes
	name = "sorcerer robes"
	output = /obj/item/clothing/shirt/robe/newmage/sorcerer
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/warlock_robes
	name = "warlock robes"
	output = /obj/item/clothing/shirt/robe/newmage/warlock
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 4

/datum/repeatable_crafting_recipe/sewing/normal_robes
	name = "robes"
	output = /obj/item/clothing/shirt/robe
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 1

/datum/repeatable_crafting_recipe/sewing/feld_robe
	name = "feldsher robes"
	output = /obj/item/clothing/shirt/robe/feld
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/phys_robes
	name = "physicker robes"
	output = /obj/item/clothing/shirt/robe/phys
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/courtphysician_robes
	name = "court physician robes"
	output = /obj/item/clothing/shirt/robe/courtphysician
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 3)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/robe
	name = "robes"
	output = /obj/item/clothing/shirt/robe/colored/plain
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3

/datum/repeatable_crafting_recipe/sewing/apron_waist
	name = "apron"
	output = /obj/item/clothing/cloak/apron/waist
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/apron_cook
	name = "cook apron"
	output = /obj/item/clothing/cloak/apron/cook
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/fisher_hat
	name = "fisher hat"
	output = /obj/item/clothing/head/fisherhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 2

/datum/repeatable_crafting_recipe/sewing/cape
	name = "cape"
	output = /obj/item/clothing/cloak/cape
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/guard_cape
	name = "guard cape"
	output = /obj/item/clothing/cloak/cape/guard
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/puritan_cape
	name = "puritan cape"
	output = /obj/item/clothing/cloak/cape/archivist
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/inquisitor_cloak
	name = "inquisitor's cloak"
	output = /obj/item/clothing/cloak/cape/inquisitor
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/guard_half_cloak
	name = "guard half cloak"
	output = /obj/item/clothing/cloak/half/guard
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"


/datum/repeatable_crafting_recipe/sewing/guard_half_cloak_alt
	name = "guard half cloak (alt)"
	output = /obj/item/clothing/cloak/half/guardsecond
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/town_watch_cloak
	name = "town watch cloak"
	output = /obj/item/clothing/cloak/half/vet
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/duel_cape
	name = "duelist cape"
	output = /obj/item/clothing/cloak/half/duelcape
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/knight_tabard
	name = "knight's tabbard"
	output = /obj/item/clothing/cloak/tabard/knight
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/guard_tabard
	name = "garrison tabbard"
	output = /obj/item/clothing/cloak/tabard/knight/guard
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/crusader_tabard_alt
	name = "crusader tabbard (alt)"
	output = /obj/item/clothing/cloak/tabard/crusader/tief
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/psydon_tabbard
	name = "psydonic tababrd"
	output = /obj/item/clothing/cloak/tabard/adept
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/guard_surcoat
	name = "garrison surcoat"
	output = /obj/item/clothing/cloak/stabard/guard
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/mercenary_surcoat
	name = "mercenary surcoat"
	output = /obj/item/clothing/cloak/stabard/mercenary
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/gallowglass_surcoat
	name = "gallowglass surcoat"
	output = /obj/item/clothing/cloak/stabard/kaledon
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"




/datum/repeatable_crafting_recipe/sewing/desertcape
	name = "desert cape"
	output = /obj/item/clothing/cloak/cape/crusader
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/halfcloak
	name = "half cloak"
	requirements = list(
		/obj/item/natural/cloth = 3,
		/obj/item/natural/fibers = 1,
	)
	output = /obj/item/clothing/cloak/half
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/templar
	name = "templar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/astratatemplar
	name = "solar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/astrata
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/astratatemplar/alt
	name = "solar surcoat (alt)"
	output =  /obj/item/clothing/cloak/stabard/templar/astrata/alt
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/golden_order
	name = "golden order surcoat"
	output =  /obj/item/clothing/cloak/stabard/crusader
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/silver_order
	name = "silver order surcoat"
	output =  /obj/item/clothing/cloak/stabard/crusader/t
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/necratemplar
	name = "necran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/necra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/necratemplar/alt
	name = "necran surcoat (alt)"
	output = /obj/item/clothing/cloak/stabard/templar/necra/alt
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"



/datum/repeatable_crafting_recipe/sewing/dendortemplar
	name = "dendorian surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/dendor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/noctemplar
	name = "lunar surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/noc
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/noctemplar/alt
	name = "lunar surcoat (alt)"
	output = /obj/item/clothing/cloak/stabard/templar/noc/alt
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/ravoxtemplar
	name = "ravox surcoat (alt)"
	output = /obj/item/clothing/cloak/stabard/templar/ravox
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"


/datum/repeatable_crafting_recipe/sewing/abyssortemplar
	name = "abyssal surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/abyssor
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/malumtemplar
	name = "malumite surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/malum
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/eoratemplar
	name = "eoran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/eora
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/pestratemplar
	name = "pestran surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/pestra
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/xylixtemplar
	name = "xylixian surcoat"
	output = /obj/item/clothing/cloak/stabard/templar/xylix
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Cloak"

/datum/repeatable_crafting_recipe/sewing/dress
	name = "bar dress"
	output = /obj/item/clothing/shirt/dress
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/stockdress
	name = "stock dress"
	output = /obj/item/clothing/shirt/dress/gen
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/Bladress
	name = "black dress"
	output = /obj/item/clothing/shirt/dress/gen/colored/black
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/Bludress
	name = "blue dress"
	output = /obj/item/clothing/shirt/dress/gen/colored/blue
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/Purdress
	name = "purple dress"
	output = /obj/item/clothing/shirt/dress/gen/colored/purple
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 1)
	craftdiff = 3
	category = "Dress"

/* .............. recipes requiring skill 4 ..............*/

/datum/repeatable_crafting_recipe/sewing/camisole
	name = "Camisole"
	output = /obj/item/clothing/shirt/dress/gen/sexy
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/fancyhat
	name = "fancy hat"
	output = /obj/item/clothing/head/fancyhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/courtierhat
	name = "courtier hat"
	output = /obj/item/clothing/head/courtierhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/bardhat
	name = "bard hat"
	output = /obj/item/clothing/head/bardhat
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/natural/feather = 1)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/battlenun_helm
	name = "iron coif battlenun helm"
	output = /obj/item/clothing/head/helmet/battlenun
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/clothing/neck/chaincoif/iron)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/battlenun_helm_steel
	name = "steel coif battlenun helm"
	output = /obj/item/clothing/head/helmet/battlenun/steel
	requirements = list(/obj/item/natural/cloth = 1,
				/obj/item/natural/fibers = 1,
				/obj/item/clothing/neck/chaincoif)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/chaperonhat
	name = "chaperon hat"
	output = /obj/item/clothing/head/chaperon/colored/greyscale
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	category = "Hat"

/datum/repeatable_crafting_recipe/sewing/jupon_guard
	name = "guard's jupon"
	output = /obj/item/clothing/cloak/stabard/jupon/guard
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 4
	category = "Cloak"

/*.............. recipes requiring skill 5 ..............*/

/datum/repeatable_crafting_recipe/sewing/grenzel_shirt
	name = "Grenzelhoftian hip shirt"
	output = /obj/item/clothing/shirt/grenzelhoft
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 2,
				/obj/item/natural/fibers = 1)
	craftdiff = 5
	category = "Shirt"

/datum/repeatable_crafting_recipe/sewing/grenzel_pants
	name = "Grenzelhoftian paumpers"
	output = /obj/item/clothing/pants/grenzelpants
	requirements = list(/obj/item/natural/cloth = 2,
				/obj/item/natural/silk = 1,
				/obj/item/natural/fibers = 1)
	craftdiff = 5
	category = "Pants"

/*.............. recipes requiring skill 6 ..............*/

/datum/repeatable_crafting_recipe/sewing/silkydress
	name = "silky dress of legendary sewists"
	output = /obj/item/clothing/shirt/dress/silkydress
	requirements = list(/obj/item/natural/cloth = 6,
				/obj/item/natural/fibers = 3)
	craftdiff = 6
	category = "Dress"

/datum/repeatable_crafting_recipe/sewing/carpet
	name = "brown carpet"
	output = /obj/item/natural/carpet_fibers
	requirements = list(/obj/item/natural/cloth = 3,
				/obj/item/natural/fibers = 2,
				/obj/item/dye_pack/cheap = 1)
	craftdiff = 0
	category = "Carpets"

/datum/repeatable_crafting_recipe/sewing/carpet/blue
	name = "blue carpet"
	output = /obj/item/natural/carpet_fibers/blue

/datum/repeatable_crafting_recipe/sewing/carpet/cyan
	name = "cyan carpet"
	output = /obj/item/natural/carpet_fibers/cyan

/datum/repeatable_crafting_recipe/sewing/carpet/green
	name = "green carpet"
	output = /obj/item/natural/carpet_fibers/green

/datum/repeatable_crafting_recipe/sewing/carpet/purple
	name = "purple carpet"
	output = /obj/item/natural/carpet_fibers/purple

/datum/repeatable_crafting_recipe/sewing/carpet/red
	name = "red carpet"
	output = /obj/item/natural/carpet_fibers/red

/datum/repeatable_crafting_recipe/sewing/beehood
	name = "beehood"
	output = /obj/item/clothing/head/beekeeper
	requirements = list(/obj/item/natural/cloth = 4,
				/obj/item/natural/fibers = 2)
	craftdiff = 2
	category = "Hat"
