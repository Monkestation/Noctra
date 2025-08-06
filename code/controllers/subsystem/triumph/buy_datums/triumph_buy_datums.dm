/*
	TO NOTE THERE WILL BE A LOT OF SNOWFLAKE BEHAVIOR
*/

/datum/triumph_buy
 	/// This serves no purpose rn other than to stop duplicates in certain places
	var/triumph_buy_id = "ERROR"
	/// Key of the person who bought it.
	var/key_of_buyer = null
	/// Ckey of the person who bought it. I don't feel like dealing with the fact zeth used key for triumphs
	var/ckey_of_buyer = null
    /// Desc shown for it on the menu
	var/desc = "ERROR"
	/// Cost in triumphs for something
	var/triumph_cost = 500
	/// Category we sort something into
	var/category = TRIUMPH_CAT_ACTIVE_DATUMS
	/// Whether we are visible on active menu
	var/visible_on_active_menu = FALSE
	/// Whether its pre-round only
	var/pre_round_only = FALSE
	/// Whatever the triumph buy effect must be manually activated somewhere else than on its buy
	var/manual_activation = FALSE
	/// Whatever the triumph buy effect was activated and therefore cannot be refunded
	var/activated = FALSE
	/// List of things it can conflict with
	var/list/conflicts_with = list()

/// We call this when someone buys it in the triumph shop
/datum/triumph_buy/proc/on_buy()
	if(!manual_activation)
		on_activate()

/// We call this when someone is trying to remove it aka on refund or otherwise
/datum/triumph_buy/proc/on_removal()
	return

/// We call this on when the triumph buy effect is active
/datum/triumph_buy/proc/on_activate(mob/living/carbon/human/H)
	activated = TRUE

/// Called upon job post equip if the triumph buy is in post_equip_calls
/datum/triumph_buy/proc/on_post_equip(mob/living/carbon/human/H)
	return
