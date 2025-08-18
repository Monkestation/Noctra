// Divine
/datum/devotion/astrata
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/sacred_flame,
		CLERIC_T2 = /datum/action/cooldown/spell/healing/greater,
		CLERIC_T3 = /datum/action/cooldown/spell/revive,
	)

/datum/devotion/noc
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/status/invisibility,
		CLERIC_T2 = /datum/action/cooldown/spell/blindness/miracle,
		CLERIC_T3 = /datum/action/cooldown/spell/projectile/moonlit_dagger,
	)

/datum/devotion/dendor
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/undirected/bless_crops,
		CLERIC_T2 = /datum/action/cooldown/spell/undirected/beast_sense,
		CLERIC_T3 = /datum/action/cooldown/spell/beast_tame,
	)

/datum/devotion/abyssor
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/projectile/swordfish,
		CLERIC_T2 = /datum/action/cooldown/spell/undirected/conjure_item/summon_trident,
		CLERIC_T3 = /datum/action/cooldown/spell/ocean_embrace,
	)

/datum/devotion/abyssor
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/sacred_flame,
		CLERIC_T2 = /datum/action/cooldown/spell/healing/greater,
		CLERIC_T3 = /datum/action/cooldown/spell/revive,
	)

/datum/devotion/necra
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/burial_rites,
		CLERIC_T2 = /datum/action/cooldown/spell/undirected/soul_speak,
		CLERIC_T3 = /datum/action/cooldown/spell/aoe/churn_undead,
	)
	traits = list(TRAIT_DEATHSIGHT)

/datum/devotion/necra/make_acolyte()
	. = ..()
	miracles_extra += /datum/action/cooldown/spell/avert

/datum/devotion/necra/make_cleric()
	. = ..()
	miracles_extra += /datum/action/cooldown/spell/avert

/datum/devotion/necra/make_templar()
	. = ..()
	miracles_extra -= /datum/action/cooldown/spell/aoe/abrogation
	miracles_extra += list(/datum/action/cooldown/spell/aoe/churn_undead, /datum/action/cooldown/spell/avert)

/datum/devotion/ravox
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/undirected/call_to_arms,
		CLERIC_T2 = /datum/action/cooldown/spell/undirected/divine_strike,
		CLERIC_T3 = /datum/action/cooldown/spell/persistence,
	)

/datum/devotion/xylix
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/undirected/list_target/vicious_mimicry,
		CLERIC_T2 = /datum/action/cooldown/spell/status/wheel,
	)

/datum/devotion/pestra
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/diagnose/holy,
		CLERIC_T1 = /datum/action/cooldown/spell/healing,
		CLERIC_T2 = /datum/action/cooldown/spell/attach_bodypart,
		CLERIC_T3 = /datum/action/cooldown/spell/cure_rot,
	)

/datum/devotion/malum
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/status/vigorous_craft,
		CLERIC_T2 = /datum/action/cooldown/spell/hammer_fall,
		CLERIC_T3 = /datum/action/cooldown/spell/heat_metal,
	)

/datum/devotion/eora
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/healing,
		CLERIC_T1 = /datum/action/cooldown/spell/instill_perfection,
		CLERIC_T2 = /datum/action/cooldown/spell/projectile/eora_curse,
		CLERIC_T3 = /datum/action/cooldown/spell/eoran_bloom,
	)

// Inhumen
/datum/devotion/zizo
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/undirected/touch/orison,
		CLERIC_T1 = /datum/action/cooldown/spell/projectile/profane,
		CLERIC_T2 = /datum/action/cooldown/spell/conjure/raise_lesser_undead,
		CLERIC_T3 = /datum/action/cooldown/spell/undirected/rituos,
	)
	traits = list(TRAIT_DEATHSIGHT)

/datum/devotion/graggar
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/undirected/bloodrage,
		CLERIC_T1 = /datum/action/cooldown/spell/undirected/call_to_slaughter,
		CLERIC_T2 = /datum/action/cooldown/spell/projectile/blood_net,
		CLERIC_T3 = /datum/action/cooldown/spell/revel_in_slaughter,
	)

/datum/devotion/matthios
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/appraise/holy,
		CLERIC_T1 = /datum/action/cooldown/spell/transact,
		CLERIC_T2 = /datum/action/cooldown/spell/beam/equalize,
		CLERIC_T3 = /datum/action/cooldown/spell/churn_wealthy,
	)

/datum/devotion/baotha
	miracles = list(
		CLERIC_T0 = /datum/action/cooldown/spell/find_flaw,
		CLERIC_T1 = /datum/action/cooldown/spell/baothablessings,
		CLERIC_T2 = /datum/action/cooldown/spell/projectile/blowingdust,
		CLERIC_T3 = /datum/action/cooldown/spell/painkiller,
	)
