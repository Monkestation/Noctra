/datum/repeatable_crafting_recipe/sigdry
	name = "westleach zig"
	output = /obj/item/clothing/face/cigarette/rollie/nicotine
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/dry_westleach = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/dry_westleach

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a westleach zig"
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/sigsweet
	name = "swampweed zig"
	output = /obj/item/clothing/face/cigarette/rollie/cannabis
	starting_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried
	requirements = list(
		/obj/item/reagent_containers/food/snacks/produce/swampweed_dried = 2
	)
	attacked_atom = /obj/item/reagent_containers/food/snacks/produce/swampweed_dried

	craft_time = 10 SECONDS
	crafting_message = "starts rolling a swampweed zig"
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/canvas
	name = "canvas"
	output = /obj/item/canvas
	requirements = list(
		/obj/item/paper = 2,
	)
	tool_usage = list(
		/obj/item/needle = list("starts to weave", "start to weave")
	)
	starting_atom = /obj/item/needle
	attacked_atom = /obj/item/paper
	craft_time = 3 SECONDS
	crafting_message = "starts weaving a canvas"
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/canvas/create_blacklisted_paths()
	blacklisted_paths = subtypesof(/obj/item/paper)

/datum/repeatable_crafting_recipe/paintbrush
	name = "paint brush"
	output = /obj/item/paint_brush
	starting_atom = /obj/item/natural/feather
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/feather = 1,
	)
	attacked_atom = /obj/item/grown/log/tree/stick
	allow_inverse_start = TRUE

	craft_time = 3 SECONDS
	crafting_message = "starts tying a paint brush"
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/paint_palette
	name = "paint palette"
	output = /obj/item/paint_palette
	starting_atom = /obj/item/grown/log/tree/stick
	requirements = list(
		/obj/item/grown/log/tree/stick = 1,
		/obj/item/natural/wood/plank = 1,
		/obj/item/alch = 1,
	)
	attacked_atom = /obj/item/natural/wood/plank
	allow_inverse_start = TRUE

	craft_time = 3 SECONDS
	crafting_message = "starts constructing a paint palette"
	craftdiff = 0
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/woodthresher
	name = "thresher"
	output = /obj/item/weapon/thresher
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/rope = 1
	)
	starting_atom = /obj/item/rope
	attacked_atom = /obj/item/grown/log/tree/small

/datum/repeatable_crafting_recipe/militarythresher
	name = "military flail"
	output = /obj/item/weapon/thresher/military
	requirements = list(
		/obj/item/weapon/thresher = 1,
		/obj/item/ingot/iron = 1
	)
	attacked_atom = /obj/item/weapon/thresher
	starting_atom = /obj/item/ingot/iron


/datum/repeatable_crafting_recipe/bee_treatment
	name = "General Bee Treatment"
	output = /obj/item/bee_treatment
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/alch/herb/mentha = 1
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/alch/herb/mentha
	category = "Bees"

/datum/repeatable_crafting_recipe/bee_treatment/antiviral
	name = "Antiviral Bee Treatment"
	output = /obj/item/bee_treatment/antiviral
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/alch/herb/rosa = 1
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/alch/herb/rosa

/datum/repeatable_crafting_recipe/bee_treatment/miticide
	name = "Miticide Bee Treatment"
	output = /obj/item/bee_treatment/miticide
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/alch/herb/salvia = 1
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/alch/herb/salvia

/datum/repeatable_crafting_recipe/bee_treatment/insecticide
	name = "Insecticide Bee Treatment"
	output = /obj/item/bee_treatment/miticide
	requirements = list(
		/obj/item/grown/log/tree/small = 1,
		/obj/item/alch/herb/paris = 1
	)
	attacked_atom = /obj/item/grown/log/tree/small
	starting_atom = /obj/item/alch/herb/paris
