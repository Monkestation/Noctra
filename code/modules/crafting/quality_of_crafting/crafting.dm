/datum/repeatable_crafting_recipe/crafting
	abstract_type = /datum/repeatable_crafting_recipe/crafting
	skillcraft = /datum/skill/craft/crafting
	category = "Misc Crafting"
	allow_inverse_start = TRUE
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/mantrap
	name = "mantrap"
	requirements = list(
		/obj/item/grown/log/tree/stake = 1,
		/obj/item/rope = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stake
	starting_atom  = /obj/item/rope
	output = /obj/item/restraints/legcuffs/beartrap
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/mantrap/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/earnecklace
	name = "ear necklace"
	requirements = list(
		/obj/item/organ/ears= 4,
		/obj/item/rope = 1,
	)
	attacked_atom = /obj/item/rope
	starting_atom= /obj/item/organ/ears
	output = /obj/item/clothing/neck/menears
	subtypes_allowed = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/earnecklace/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/earnecklace/elf
	name = "elf ear necklace"
	requirements = list(
		/obj/item/organ/ears/elf = 4,
		/obj/item/rope = 1,
	)
	starting_atom= /obj/item/organ/ears/elf
	output = /obj/item/clothing/neck/elfears

/datum/repeatable_crafting_recipe/crafting/earnecklace/elfw
	hides_from_books = TRUE
	name = "elf ear necklace"
	requirements = list(
		/obj/item/organ/ears/elfw = 4,
		/obj/item/rope = 1,
	)
	starting_atom= /obj/item/organ/ears/elfw
	output = /obj/item/clothing/neck/elfears

/datum/repeatable_crafting_recipe/crafting/wickercloak
	name = "wicker cloak"
	requirements = list(
		/obj/item/natural/dirtclod = 2,
		/obj/item/grown/log/tree/stick= 4,
		/obj/item/natural/fibers = 3,
	)
	attacked_atom = /obj/item/natural/dirtclod
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/clothing/cloak/wickercloak
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/bog_cowl
	name = "bog cowl"
	requirements = list(
		/obj/item/natural/dirtclod= 1,
		/obj/item/grown/log/tree/stick= 3,
		/obj/item/natural/fibers = 2,
	)
	attacked_atom = /obj/item/natural/dirtclod
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/clothing/neck/bogcowl
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/skull_mask
	name = "skull mask"
	requirements = list(
		/obj/item/alch/bone= 3,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/natural/fibers
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/face/skullmask
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/antlerhood
	name = "antler hood"
	requirements = list(
		/obj/item/alch/bone= 2,
		/obj/item/natural/hide = 1,
	)
	attacked_atom = /obj/item/natural/hide
	starting_atom= /obj/item/alch/bone
	output = /obj/item/clothing/head/antlerhood
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/antlerhood/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/natural/hide)

/datum/repeatable_crafting_recipe/crafting/short_bow
	name = "short bow"
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/natural/fibers = 3,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/natural/fibers
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/short
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/bow
	name = "wooden bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 5,
	)

	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/natural/wood/plank
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/long_bow
	name = "long bow"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/natural/fibers = 7,
		/obj/item/reagent_containers/food/snacks/fat = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom  = /obj/item/natural/fibers
	allow_inverse_start = FALSE
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/wsword
	name = "wooden sword"
	requirements = list(
		/obj/item/natural/wood/plank = 1,
		/obj/item/grown/log/tree/stick = 1,
	)

	starting_atom = /obj/item/grown/log/tree/stick
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/mace/woodclub/train_sword
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/wshield
	name = "wooden shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
	)

	starting_atom = /obj/item/natural/wood/plank
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/wood/crafted
	allow_inverse_start = FALSE // so we can typecheck less

/obj/item/weapon/shield/wood/crafted
	sellprice = 6

/datum/repeatable_crafting_recipe/crafting/heatershield
	name = "heater shield"
	requirements = list(
		/obj/item/natural/wood/plank = 2,
		/obj/item/natural/hide/cured = 1,
	)

	starting_atom = /obj/item/natural/hide/cured
	attacked_atom = /obj/item/natural/wood/plank
	output = /obj/item/weapon/shield/heater/crafted
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/drum
	name = "drum"
	starting_atom = /obj/item/natural/hide/cured
	attacked_atom = /obj/item/grown/log/tree/small
	requirements = list(
		/obj/item/natural/hide/cured = 1,
		/obj/item/grown/log/tree/small = 1,
	)
	output = /obj/item/instrument/drum

/datum/repeatable_crafting_recipe/crafting/dart
	name = "dart"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/thorn = 1,
	)

	starting_atom = /obj/item/natural/thorn
	attacked_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/ammo_casing/caseless/dart
	craftdiff = 0
	output_amount = 3

/datum/repeatable_crafting_recipe/crafting/blowgun
	name = "blowgun"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	output = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/candle
	name = "candle"
	requirements = list(
		/obj/item/reagent_containers/food/snacks/fat= 1,
		/obj/item/natural/fibers= 1,
	)
	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/reagent_containers/food/snacks/fat
	output = /obj/item/candle/yellow
	output_amount = 2

/datum/repeatable_crafting_recipe/crafting/imp_saw
	name = "improvised saw"
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/stone = 1,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/saw/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/imp_clamp
	name = "improvised clamp"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/hemostat/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/imp_retractor
	name = "improvised retractor"
	requirements = list(
		/obj/item/grown/log/tree/stick = 2,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/weapon/surgery/retractor/improv
	craftdiff = 1

/datum/repeatable_crafting_recipe/crafting/stone_mortar
	name = "stone mortar"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/reagent_containers/glass/mortar
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/pestle
	name = "pestle"
	requirements = list(
		/obj/item/natural/stone = 1,
	)

	starting_atom = /obj/item/weapon/knife
	attacked_atom = /obj/item/natural/stone
	output = /obj/item/pestle
	craftdiff = 0
	skillcraft = /datum/skill/craft/masonry
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/stone_tongs
	name = "stone tongs"
	requirements = list(
		/obj/item/natural/stone = 1,
		/obj/item/grown/log/tree/stick = 2,
	)

	attacked_atom = /obj/item/natural/stone
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/tongs/stone
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/quarterstaff
	name = "wooden quarterstaff"
	requirements = list(
		/obj/item/grown/log/tree= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff
	required_intent = /datum/intent/dagger/cut
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/iron_quarterstaff
	name = "iron quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/iron = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/iron
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/iron
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/repeatable_crafting_recipe/crafting/steel_quarterstaff
	name = "steel quarterstaff"
	requirements = list(
		/obj/item/weapon/polearm/woodstaff/quarterstaff = 1,
		/obj/item/ingot/steel = 1,
	)
	attacked_atom = /obj/item/weapon/polearm/woodstaff/quarterstaff
	starting_atom  = /obj/item/ingot/steel
	allow_inverse_start = FALSE
	output = /obj/item/weapon/polearm/woodstaff/quarterstaff/steel
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/caningstick
	name = "caning stick"
	requirements = list(
		/obj/item/grown/log/tree/stick= 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE
	allow_inverse_start = FALSE
	output = /obj/item/weapon/whip/cane
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/spoon
	name = "wooden spoon"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/spoon
	craft_time = 3 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/fork
	name = "wooden fork"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to whittle", "start whittling", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/fork
	craft_time = 3 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/rollingpin
	name = "wooden rollingpin"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/kitchen/rollingpin
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodbowl
	name = "wooden bowl"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/reagent_containers/glass/bowl
	output_amount = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodcup
	name = "wooden cup"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/reagent_containers/glass/cup/wooden/crafted
	output_amount = 3
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodtray
	name = "wooden tray"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/plate/tray
	output_amount = 2
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodplatter
	name = "wooden platter"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/plate
	output_amount = 2
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/woodspade
	name = "wooden spade"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/grown/log/tree/stick
	output = /obj/item/weapon/shovel/small
	craft_time = 2 SECONDS

/datum/repeatable_crafting_recipe/crafting/pipe
	name = "wooden pipe"
	requirements = list(
		/obj/item/grown/log/tree/stick= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/clothing/face/cigarette/pipe/crafted
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/broom
	name = "broom"
	requirements = list(
		/obj/item/grown/log/tree/stick= 4,
		/obj/item/natural/fibers = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	starting_atom  = /obj/item/natural/fibers
	output = /obj/item/broom

/datum/repeatable_crafting_recipe/crafting/wpsycross
	name = "wooden psycross"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/knife
	allow_inverse_start = FALSE
	output = /obj/item/clothing/neck/psycross
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/bottle_kit
	name = "bottle kit"
	requirements = list(
		/obj/item/reagent_containers/glass/bottle = 2,
		/obj/item/paper = 2,
	)
	attacked_atom = /obj/item/paper
	starting_atom = /obj/item/reagent_containers/glass/bottle
	allow_inverse_start = FALSE
	output = /obj/item/bottle_kit
	craft_time = 5 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/bottle_kit/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/paper)

/datum/repeatable_crafting_recipe/crafting/woodflail
	name = "wooden flail"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope/chain = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/flail/towner
	output_amount = 2
	craftdiff = 2
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/militia_flail
	name = "militia flail"
	requirements = list(
		/obj/item/weapon/flail/towner= 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/weapon/flail/towner
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/flail/militia
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodthresher
	name = "wooden thresher"
	requirements = list(
		/obj/item/grown/log/tree/small= 1,
		/obj/item/rope = 1,
		/obj/item/grown/log/tree/stick = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/thresher
	craftdiff = 1
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/woodthresher/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/rope)

/datum/repeatable_crafting_recipe/crafting/bigflail
	name = "great militia flail"
	requirements = list(
		/obj/item/weapon/thresher= 1,
		/obj/item/rope/chain = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom =/obj/item/weapon/thresher
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/thresher/military
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/ironcudgel
	name = "peasant cudgel"
	requirements = list(
		/obj/item/weapon/mace/woodclub = 1,
		/obj/item/ingot/iron = 1,
	)
	tool_usage = list(
		/obj/item/weapon/hammer = list("starts to hammer", "start hammering", 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/weapon/mace/woodclub
	starting_atom = /obj/item/weapon/hammer
	allow_inverse_start = FALSE
	subtypes_allowed = TRUE
	output = /obj/item/weapon/mace/cudgel/carpenter
	subtypes_allowed = TRUE
	craftdiff = 3
	craft_time = 5 SECONDS

/datum/repeatable_crafting_recipe/crafting/scroll
	name = "parchment scroll"
	requirements = list(
		/obj/item/paper = 2,
		/obj/item/natural/fibers = 1,
	)
	starting_atom = /obj/item/natural/fibers
	attacked_atom = /obj/item/paper
	output = /obj/item/paper/scroll
	subtypes_allowed = TRUE
	craftdiff = 0

/datum/repeatable_crafting_recipe/crafting/scroll/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/paper)

/datum/repeatable_crafting_recipe/crafting/cart_upgrade
	name = "cart upgrade"
	requirements = list(
		/obj/item/natural/wood/plank= 2,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list(span_notice("starts to whittle"), span_notice("start to whittle"), 'sound/items/wood_sharpen.ogg'),
	)
	attacked_atom = /obj/item/natural/wood/plank
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE
	allow_inverse_start = FALSE
	output = /obj/item/gear/wood/basic
	craftdiff = 3
	skillcraft = /datum/skill/labor/lumberjacking

/datum/repeatable_crafting_recipe/crafting/wheatlbait
	name = "bait (wheat)"
	output = /obj/item/bait
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/grain/wheat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/grain/wheat
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/oatbait
	name = "bait (oat)"
	output = /obj/item/bait
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/grain/oat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/grain/oat
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/sweetbait
	name = "sweet bait (apple)"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fruit/apple = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/apple
	attacked_atom = /obj/item/natural/cloth

/datum/repeatable_crafting_recipe/crafting/berrybait
	name = "sweet bait (berry)"
	output = /obj/item/bait/sweet
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/fruit/jacksberry
	attacked_atom = /obj/item/natural/cloth
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/bloodbait
	name = "blood bait"
	output = /obj/item/bait/bloody
	requirements = list(
		/obj/item/natural/cloth = 1,
		/obj/item/reagent_containers/food/snacks/meat = 2,
	)
	starting_atom = /obj/item/reagent_containers/food/snacks/meat
	attacked_atom = /obj/item/natural/cloth
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/crafting/alchemical_vial
	name = "Alchemical Vial"
	output = /obj/item/reagent_containers/glass/alchemical
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 3
	craftdiff = 3

/datum/repeatable_crafting_recipe/crafting/alchemical_bottle
	name = "Alchemical Bottle"
	output = /obj/item/reagent_containers/glass/bottle
	requirements = list(
		/obj/item/natural/glass = 1,
	)
	tool_usage = list(
		/obj/item/weapon/knife = list("starts to carve out a rune", "start to carve a rune")
	)

	attacked_atom = /obj/item/natural/glass
	starting_atom = /obj/item/weapon/knife
	subtypes_allowed = TRUE // so you can use any subtype of knife
	output_amount = 1
	craftdiff = 3
