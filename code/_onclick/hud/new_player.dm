#define SHUTTER_MOVEMENT_DURATION 1 SECONDS
#define SHUTTER_WAIT_DURATION 1 SECONDS

/datum/hud/new_player/New(mob/owner)
	..()

/datum/hud/new_player
	///Whether the menu is currently on the client's screen or not
	var/menu_hud_status = TRUE
	var/list/shown_station_trait_buttons

/datum/hud/new_player/New(mob/owner)
	. = ..()

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

	if (!owner?.client)
		return

	var/list/buttons = subtypesof(/atom/movable/screen/lobby)
	for (var/atom/movable/screen/lobby/lobbyscreen as anything in buttons)
		if (!initial(lobbyscreen.always_available))
			continue
		lobbyscreen = new lobbyscreen(our_hud = src)
		static_inventory += lobbyscreen
		if (!lobbyscreen.always_shown)
			lobbyscreen.RegisterSignal(src, COMSIG_HUD_LOBBY_COLLAPSED, TYPE_PROC_REF(/atom/movable/screen/lobby, collapse_button))
			lobbyscreen.RegisterSignal(src, COMSIG_HUD_LOBBY_EXPANDED, TYPE_PROC_REF(/atom/movable/screen/lobby, expand_button))

//copypaste begin

/atom/movable/screen/lobby
	plane = SPLASHSCREEN_PLANE
	layer = LOBBY_MENU_LAYER
	screen_loc = "TOP,CENTER"
	/// Whether this HUD element can be hidden from the client's "screen" (moved off-screen) or not
	var/always_shown = FALSE
	/// If true we will create this button every time the HUD is generated
	var/always_available = TRUE

///Set the HUD in New, as lobby screens are made before Atoms are Initialized.
/atom/movable/screen/lobby/New(loc, datum/hud/our_hud, ...)
	set_new_hud(our_hud)
	return ..()

///Run sleeping actions after initialize
/atom/movable/screen/lobby/proc/SlowInit()
	return

///Animates moving the button off-screen
/atom/movable/screen/lobby/proc/collapse_button()
	SIGNAL_HANDLER
	//wait for the shutter to come down
	animate(src, transform = transform, time = SHUTTER_MOVEMENT_DURATION + SHUTTER_WAIT_DURATION)
	//then pull the buttons up with the shutter
	animate(transform = transform.Translate(x = 0, y = 146), time = SHUTTER_MOVEMENT_DURATION, easing = CUBIC_EASING|EASE_IN)

///Animates moving the button back into place
/atom/movable/screen/lobby/proc/expand_button()
	SIGNAL_HANDLER
	//the buttons are off-screen, so we sync them up to come down with the shutter
	animate(src, transform = matrix(), time = SHUTTER_MOVEMENT_DURATION, easing = CUBIC_EASING|EASE_OUT)

/atom/movable/screen/lobby/background
	icon = 'icons/hud/lobby/background.dmi'
	icon_state = "background"
	plane = LOBBY_MENU_PLANE
	layer = LOBBY_BACKGROUND_LAYER
	screen_loc = "TOP,CENTER:-61"

/atom/movable/screen/lobby/button
	mouse_over_pointer = MOUSE_HAND_POINTER
	///Is the button currently enabled?
	VAR_PROTECTED/enabled = TRUE
	///Is the button currently being hovered over with the mouse?
	var/highlighted = FALSE
	///Should this button play the select sound?
	var/select_sound_play = TRUE

/atom/movable/screen/lobby/button/Click(location, control, params)
	if(!usr.client)
		return

	. = ..()

	if(!enabled)
		return
	flick("[base_icon_state]_pressed", src)
	update_appearance(UPDATE_ICON)
	return TRUE

/atom/movable/screen/lobby/button/MouseEntered(location,control,params)
	if(!usr.client)
		return

	. = ..()
	highlighted = TRUE
	update_appearance(UPDATE_ICON)

/atom/movable/screen/lobby/button/MouseExited()
	if(!usr.client)
		return

	. = ..()
	highlighted = FALSE
	update_appearance(UPDATE_ICON)

/atom/movable/screen/lobby/button/update_icon(updates)
	. = ..()
	if(!enabled)
		icon_state = "[base_icon_state]_disabled"
		return
	else if(highlighted)
		icon_state = "[base_icon_state]_highlighted"
		return
	icon_state = base_icon_state

///Updates the button's status: TRUE to enable interaction with the button, FALSE to disable
/atom/movable/screen/lobby/button/proc/set_button_status(status)
	if(status == enabled)
		return FALSE
	enabled = status
	update_appearance(UPDATE_ICON)
	mouse_over_pointer = enabled ? MOUSE_HAND_POINTER : MOUSE_INACTIVE_POINTER
	return TRUE

///Prefs menu
/atom/movable/screen/lobby/button/character_setup
	name = "View Character Setup"
	screen_loc = "TOP:-70,CENTER:-54"
	icon = 'icons/hud/lobby/character_setup.dmi'
	icon_state = "character_setup_disabled"
	base_icon_state = "character_setup"
	enabled = FALSE

/atom/movable/screen/lobby/button/character_setup/Initialize(mapload, datum/hud/hud_owner)
	. = ..()

/atom/movable/screen/lobby/button/character_setup/Click(location, control, params)
	. = ..()
	if(!.)
		return

	var/datum/preferences/preferences = hud.mymob.client.prefs
	preferences.update_static_data(usr)
	preferences.ui_interact(usr)

/atom/movable/screen/lobby/button/character_setup/proc/enable_character_setup()
	SIGNAL_HANDLER
	flick("[base_icon_state]_enabled", src)
	set_button_status(TRUE)

///Button that appears before the game has started
/atom/movable/screen/lobby/button/ready
	name = "Toggle Readiness"
	screen_loc = "TOP:-8,CENTER:-65"
	icon = 'icons/hud/lobby/ready.dmi'
	icon_state = "not_ready"
	base_icon_state = "not_ready"
	///Whether we are readied up for the round or not
	var/ready = FALSE

/atom/movable/screen/lobby/button/ready/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	switch(SSticker.current_state)
		if(GAME_STATE_PREGAME, GAME_STATE_STARTUP)
			RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, PROC_REF(hide_ready_button))
		if(GAME_STATE_SETTING_UP)
			set_button_status(FALSE)
			RegisterSignal(SSticker, COMSIG_TICKER_ERROR_SETTING_UP, PROC_REF(show_ready_button))
		else
			set_button_status(FALSE)

/atom/movable/screen/lobby/button/ready/proc/hide_ready_button()
	SIGNAL_HANDLER
	set_button_status(FALSE)

/atom/movable/screen/lobby/button/ready/proc/show_ready_button()
	SIGNAL_HANDLER
	set_button_status(TRUE)

/atom/movable/screen/lobby/button/ready/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	ready = !ready
	if(ready)
		new_player.ready = PLAYER_READY_TO_PLAY
		base_icon_state = "ready"
	else
		new_player.ready = PLAYER_NOT_READY
		base_icon_state = "not_ready"
	update_appearance(UPDATE_ICON)
	SEND_SIGNAL(hud, COMSIG_HUD_PLAYER_READY_TOGGLE)

///Shown when the game has started
/atom/movable/screen/lobby/button/join
	name = "Join Game"
	screen_loc = "TOP:-13,CENTER:-58"
	icon = 'icons/hud/lobby/join.dmi'
	icon_state = "" //Default to not visible
	base_icon_state = "join_game"
	enabled = null // set in init

/atom/movable/screen/lobby/button/join/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	switch(SSticker.current_state)
		if(GAME_STATE_PREGAME, GAME_STATE_STARTUP)
			set_button_status(FALSE)
			RegisterSignal(SSticker, COMSIG_TICKER_ENTER_SETTING_UP, PROC_REF(show_join_button))
		if(GAME_STATE_SETTING_UP)
			set_button_status(TRUE)
			RegisterSignal(SSticker, COMSIG_TICKER_ERROR_SETTING_UP, PROC_REF(hide_join_button))
		else
			set_button_status(TRUE)

/atom/movable/screen/lobby/button/join/Click(location, control, params)
	. = ..()
	if(!.)
		return

	if(!SSticker?.IsRoundInProgress())
		to_chat(hud.mymob, span_boldwarning("The round is either not ready, or has already finished..."))
		return

	//Determines Relevent Population Cap
	var/relevant_cap
	var/hard_popcap = CONFIG_GET(number/hard_popcap)
	var/extreme_popcap = CONFIG_GET(number/extreme_popcap)
	if(hard_popcap && extreme_popcap)
		relevant_cap = min(hard_popcap, extreme_popcap)
	else
		relevant_cap = max(hard_popcap, extreme_popcap)

	var/mob/dead/new_player/new_player = hud.mymob

	if(SSticker.queued_players.len || (relevant_cap && living_player_count() >= relevant_cap && !(ckey(new_player.key) in GLOB.admin_datums)))
		to_chat(new_player, span_danger("[CONFIG_GET(string/hard_popcap_message)]"))

		var/queue_position = SSticker.queued_players.Find(new_player)
		if(queue_position == 1)
			to_chat(new_player, span_notice("You are next in line to join the game. You will be notified when a slot opens up."))
		else if(queue_position)
			to_chat(new_player, span_notice("There are [queue_position-1] players in front of you in the queue to join the game."))
		else
			SSticker.queued_players += new_player
			to_chat(new_player, span_notice("You have been added to the queue to join the game. Your position in queue is [SSticker.queued_players.len]."))
		return

	new_player.auto_deadmin_on_ready_or_latejoin()

	if(!LAZYACCESS(params2list(params), CTRL_CLICK))
		GLOB.latejoin_menu.ui_interact(new_player)
	else
		to_chat(new_player, span_warning("Opening emergency fallback late join menu! If THIS doesn't show, ahelp immediately!"))
		GLOB.latejoin_menu.fallback_ui(new_player)


/atom/movable/screen/lobby/button/join/proc/show_join_button()
	SIGNAL_HANDLER
	set_button_status(TRUE)

/atom/movable/screen/lobby/button/join/proc/hide_join_button()
	SIGNAL_HANDLER
	set_button_status(FALSE)

/atom/movable/screen/lobby/button/observe
	name = "Observe"
	screen_loc = "TOP:-40,CENTER:-54"
	icon = 'icons/hud/lobby/observe.dmi'
	icon_state = "observe_disabled"
	base_icon_state = "observe"
	enabled = null // set in init

/atom/movable/screen/lobby/button/observe/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	set_button_status(TRUE)

/atom/movable/screen/lobby/button/observe/Click(location, control, params)
	. = ..()
	if(!.)
		return
	var/mob/dead/new_player/new_player = hud.mymob
	new_player.make_me_an_observer()
