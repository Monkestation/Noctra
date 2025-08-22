
/datum/talent_node/debug
	talent_tree_id = "debug"

// Tier 1 - Starting nodes (no prerequisites)
/datum/talent_node/debug/basic_power
	name = "Basic Power"
	desc = "Increases your basic power by 10%"
	icon_state = "spell_fireball"
	talent_cost = 1

/datum/talent_node/debug/quick_reflexes
	name = "Quick Reflexes"
	desc = "Increases your reaction time"
	icon_state = "spell_haste"
	talent_cost = 1

/datum/talent_node/debug/sturdy_build
	name = "Sturdy Build"
	desc = "Increases your durability"
	icon_state = "spell_armor"
	talent_cost = 1

// Tier 2 - Depends on Tier 1
/datum/talent_node/debug/enhanced_power
	name = "Enhanced Power"
	desc = "Further increases your power by 15%"
	icon_state = "spell_forcewall"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/basic_power)

/datum/talent_node/debug/combat_training
	name = "Combat Training"
	desc = "Improves combat effectiveness"
	icon_state = "spell_summon"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/quick_reflexes)

/datum/talent_node/debug/defensive_stance
	name = "Defensive Stance"
	desc = "Reduces incoming damage"
	icon_state = "spell_shield"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/sturdy_build)

/datum/talent_node/debug/agility_boost
	name = "Agility Boost"
	desc = "Increases movement and dodge"
	icon_state = "spell_teleport"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/quick_reflexes)

// Tier 3 - Cross-dependencies
/datum/talent_node/debug/berserker_rage
	name = "Berserker Rage"
	desc = "Increases damage but reduces defense"
	icon_state = "spell_blind"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/enhanced_power, /datum/talent_node/debug/combat_training)

/datum/talent_node/debug/tactical_mind
	name = "Tactical Mind"
	desc = "Improves strategic thinking and planning"
	icon_state = "spell_mindswap"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/combat_training)

/datum/talent_node/debug/fortified_defense
	name = "Fortified Defense"
	desc = "Greatly increases defensive capabilities"
	icon_state = "spell_forcewall"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/defensive_stance, /datum/talent_node/debug/sturdy_build)

/datum/talent_node/debug/evasive_maneuvers
	name = "Evasive Maneuvers"
	desc = "Master of evasion and mobility"
	icon_state = "spell_smoke"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/agility_boost)

// Tier 4 - Advanced combinations
/datum/talent_node/debug/unstoppable_force
	name = "Unstoppable Force"
	desc = "Cannot be stopped when charging"
	icon_state = "spell_summon"
	talent_cost = 4
	prerequisites = list(/datum/talent_node/debug/berserker_rage, /datum/talent_node/debug/enhanced_power)

/datum/talent_node/debug/master_strategist
	name = "Master Strategist"
	desc = "Ultimate tactical awareness"
	icon_state = "spell_mindswap"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/tactical_mind, /datum/talent_node/debug/evasive_maneuvers)

/datum/talent_node/debug/immovable_object
	name = "Immovable Object"
	desc = "Nearly invulnerable to physical damage"
	icon_state = "spell_armor"
	talent_cost = 4
	prerequisites = list(/datum/talent_node/debug/fortified_defense)

// Tier 5 - Ultimate abilities
/datum/talent_node/debug/perfect_balance
	name = "Perfect Balance"
	desc = "Master of both offense and defense"
	icon_state = "spell_teleport"
	talent_cost = 5
	prerequisites = list(/datum/talent_node/debug/unstoppable_force, /datum/talent_node/debug/immovable_object)

/datum/talent_node/debug/omniscient_warrior
	name = "Omniscient Warrior"
	desc = "Knows all, sees all, defeats all"
	icon_state = "spell_blind"
	talent_cost = 5
	prerequisites = list(/datum/talent_node/debug/master_strategist, /datum/talent_node/debug/perfect_balance)

// Side branches - Utility skills
/datum/talent_node/debug/resource_management
	name = "Resource Management"
	desc = "Better use of consumables and energy"
	icon_state = "spell_heal"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/tactical_mind)

/datum/talent_node/debug/efficiency_expert
	name = "Efficiency Expert"
	desc = "All actions cost less energy"
	icon_state = "spell_haste"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/resource_management, /datum/talent_node/debug/evasive_maneuvers)

// Special nodes with alternative prerequisites
/datum/talent_node/debug/adaptive_fighter
	name = "Adaptive Fighter"
	desc = "Adapts fighting style to opponents"
	icon_state = "spell_summon"
	talent_cost = 3
	prerequisites = list(/datum/talent_node/debug/combat_training)

/datum/talent_node/debug/survival_instinct
	name = "Survival Instinct"
	desc = "Enhanced survival capabilities"
	icon_state = "spell_heal"
	talent_cost = 2
	prerequisites = list(/datum/talent_node/debug/defensive_stance)
	singular_requirement = TRUE // Can be unlocked if any defensive node is learned

/datum/talent_tree/debug
	name = "Debug Talent Tree"
	desc = "A comprehensive debug tree for testing talent systems"
	tree_identifier = "debug"
	max_talent_points = 75
	tree_nodes = list(
		// Tier 1
		/datum/talent_node/debug/basic_power,
		/datum/talent_node/debug/quick_reflexes,
		/datum/talent_node/debug/sturdy_build,
		// Tier 2
		/datum/talent_node/debug/enhanced_power,
		/datum/talent_node/debug/combat_training,
		/datum/talent_node/debug/defensive_stance,
		/datum/talent_node/debug/agility_boost,
		// Tier 3
		/datum/talent_node/debug/berserker_rage,
		/datum/talent_node/debug/tactical_mind,
		/datum/talent_node/debug/fortified_defense,
		/datum/talent_node/debug/evasive_maneuvers,
		// Tier 4
		/datum/talent_node/debug/unstoppable_force,
		/datum/talent_node/debug/master_strategist,
		/datum/talent_node/debug/immovable_object,
		// Tier 5
		/datum/talent_node/debug/perfect_balance,
		/datum/talent_node/debug/omniscient_warrior,
		// Utility
		/datum/talent_node/debug/resource_management,
		/datum/talent_node/debug/efficiency_expert,
		// Special
		/datum/talent_node/debug/adaptive_fighter,
		/datum/talent_node/debug/survival_instinct
	)
