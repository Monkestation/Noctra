/datum/erp_preference/bitflag
	abstract_type = /datum/erp_preference/bitflag
	var/list/flags = list() // List of flag names and their bit values
	var/list/flag_descriptions = list() // Optional descriptions for each flag

/datum/erp_preference/bitflag/New()
	..()
	if(!length(flags))
		CRASH("Bitflag preference [type] must define flags list")


/datum/erp_preference/bitflag/New()
	..()
	if(!length(flags))
		CRASH("Bitflag preference [type] must define flags list")

/datum/erp_preference/bitflag/show_pref_ui(datum/preferences/prefs)
	var/current_value = get_value(prefs)
	var/list/output = list()

	output += "<div class='bitflag-pref'>"
	output += "<b>[name]:</b><br>"

	for(var/flag_name in flags)
		var/flag_bit = flags[flag_name]
		var/is_enabled = (current_value & flag_bit)
		var/status_text = is_enabled ? "On" : "Off"
		var/link_class = is_enabled ? "linkOn" : "linkOff"
		var/description = flag_descriptions[flag_name] || ""
		var/title_attr = description ? " title='[description]'" : ""

		output += "<div class='bitflag-option'>"
		output += "<span[title_attr]>[flag_name]</span>: "
		output += "<a href='?_src_=prefs;task=erp_pref;pref_type=[type];action=toggle_flag;flag=[flag_bit]' class='[link_class]'>[status_text]</a>"
		output += "</div>"

	output += "</div>"
	return jointext(output, "")

/datum/erp_preference/bitflag/handle_topic(mob/user, list/href_list, datum/preferences/prefs)
	if(href_list["action"] == "toggle_flag")
		var/flag_bit = text2num(href_list["flag"])
		if(!flag_bit)
			return FALSE

		var/current_value = get_value(prefs)
		current_value ^= flag_bit // XOR to toggle the specific bit
		set_value(prefs, current_value)
		return TRUE
	return FALSE

/datum/erp_preference/bitflag/show_session_ui(datum/preferences/prefs, editable = FALSE, datum/sex_session/session)
	var/current_value = get_value(prefs)
	var/list/output = list()

	output += "<div class='bitflag-session-pref'>"
	output += "<b>[name]:</b><br>"

	for(var/flag_name in flags)
		var/flag_bit = flags[flag_name]
		var/is_enabled = (current_value & flag_bit)
		var/toggle_class = "pref-toggle bitflag-toggle"
		var/toggle_text = is_enabled ? "ON" : "OFF"
		var/description = flag_descriptions[flag_name] || ""
		var/title_attr = description ? " title='[description]'" : ""

		if(is_enabled)
			toggle_class += " enabled"

		output += "<div class='bitflag-session-option'>"
		output += "<span class='bitflag-label'[title_attr]>[flag_name]:</span> "

		if(editable)
			output += "<button class='[toggle_class]' onclick=\"window.location.href='?src=[REF(session)];task=handle_pref;pref_type=[type];action=toggle_flag;flag=[flag_bit];tab=preferences'\">[toggle_text]</button>"
		else
			toggle_class += " disabled"
			output += "<button class='[toggle_class]'>[toggle_text]</button>"

		output += "</div>"

	output += "</div>"
	return jointext(output, "")

/datum/erp_preference/bitflag/handle_session_topic(mob/user, list/href_list, datum/preferences/prefs, datum/sex_session/session)
	if(href_list["action"] != "toggle_flag")
		return FALSE

	var/flag_bit = text2num(href_list["flag"])
	if(!flag_bit)
		return FALSE

	var/current_value = get_value(prefs)
	var/was_enabled = (current_value & flag_bit)
	current_value ^= flag_bit // XOR to toggle the specific bit
	set_value(prefs, current_value)
	prefs.save_preferences()

	// Find the flag name for the message
	var/flag_name = "Unknown"
	for(var/fname in flags)
		if(flags[fname] == flag_bit)
			flag_name = fname
			break

	var/status_text = was_enabled ? "disabled" : "enabled"
	to_chat(user, "<span class='notice'>[flag_name] [status_text] for [name].</span>")
	return TRUE

// Helper procs for checking flags
/datum/erp_preference/bitflag/proc/has_flag(datum/preferences/prefs, flag_bit)
	var/current_value = get_value(prefs)
	return (current_value & flag_bit)

/datum/erp_preference/bitflag/proc/has_any_flags(datum/preferences/prefs, list/check_flags)
	var/current_value = get_value(prefs)
	for(var/flag in check_flags)
		if(current_value & flag)
			return TRUE
	return FALSE

/datum/erp_preference/bitflag/proc/has_all_flags(datum/preferences/prefs, list/check_flags)
	var/current_value = get_value(prefs)
	for(var/flag in check_flags)
		if(!(current_value & flag))
			return FALSE
	return TRUE
