///from base of atom/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum)
#define COMSIG_ATOM_HITBY "atom_hitby"

#define COMSIG_LOCKPICK_ONMOUSEDOWN "lockpick_onmousedown"
	#define COMPONENT_LOCKPICK_ONMOUSEDOWN_BYPASS (1<<0)

#define COMPONENT_PICKED "picked"

#define COMSIG_ATOM_PROXY_STEAM_USE "proxy_steam_usage"

#define COMSIG_ATOM_STEAM_USE "steam_usage"

#define COMSIG_ATOM_STEAM_INCREASE "steam_increase"

///from base of atom/attackby(): (/obj/item, /mob/living, params)
#define COMSIG_ATOM_ATTACKBY "atom_attackby"
/// From base of [atom/proc/attacby_secondary()]: (/obj/item/weapon, /mob/user, params)
#define COMSIG_ATOM_ATTACKBY_SECONDARY "atom_attackby_secondary"
	/// Return this in response if you don't want afterattack to be called
	#define COMPONENT_NO_AFTERATTACK 1

/// From base of atom/attack_hand(): (mob/user)
#define COMSIG_ATOM_ATTACK_HAND "atom_attack_hand"
/// From base of atom/attack_right(): (mob/user)
#define COMSIG_ATOM_ATTACK_HAND_SECONDARY "atom_attack_hand_secondary"

/// From base of atom/attack_ghost(): (mob/dead/observer/ghost)
#define COMSIG_ATOM_ATTACK_GHOST "atom_attack_ghost"
/// From base of atom/attack_paw(): (mob/user)
#define COMSIG_ATOM_ATTACK_PAW "atom_attack_paw"
/// From base of atom/animal_attack(): (/mob/user)
#define COMSIG_ATOM_ATTACK_ANIMAL "attack_animal"
/// From relay_attackers element: (atom/attacker, attack_flags)
#define COMSIG_ATOM_WAS_ATTACKED "atom_was_attacked"

/* Attack signals. They should share the returned flags, to standardize the attack chain. */
/// tool_act -> pre_attack -> target.attackby (item.attack) -> afterattack
	///Ends the attack chain. If sent early might cause posterior attacks not to happen.
	#define COMPONENT_CANCEL_ATTACK_CHAIN (1<<0)
	///Skips the specific attack step, continuing for the next one to happen.
	#define COMPONENT_SKIP_ATTACK (1<<1)


#define COMSIG_ATOM_GET_RESISTANCE "atom_get_resistance"
#define COMSIG_ATOM_GET_MAX_RESISTANCE "atom_get_max_resistance"
#define COMSIG_ATOM_GET_STATUS_MOD "atom_get_status_mod"
