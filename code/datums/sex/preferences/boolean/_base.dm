/datum/erp_preference/boolean
	abstract_type = /datum/erp_preference/boolean

/datum/erp_preference/boolean/show_pref_ui(datum/preferences/prefs)
	var/current_value = get_value(prefs)
	var/status_text = current_value ? "Enabled" : "Disabled"
	var/link_class = current_value ? "linkOn" : "linkOff"
	return "<a href='?_src_=prefs;task=erp_pref;pref_type=[type];action=toggle' class='[link_class]'>[status_text]</a>"

/datum/erp_preference/boolean/handle_topic(mob/user, list/href_list, datum/preferences/prefs)
	if(href_list["action"] == "toggle")
		var/current_value = get_value(prefs)
		set_value(prefs, !current_value)

/datum/erp_preference/boolean/show_session_ui(datum/preferences/prefs, editable = FALSE, datum/sex_session/session)
	var/current_value = get_value(prefs)
	var/toggle_class = "pref-toggle"
	var/toggle_text = current_value ? "ENABLED" : "DISABLED"

	if(current_value)
		toggle_class += " enabled"

	if(editable)
		return "<button class='[toggle_class]' onclick=\"window.location.href='?src=[REF(session)];task=handle_pref;pref_type=[type];action=toggle;tab=preferences'\">[toggle_text]</button>"
	else
		toggle_class += " disabled"
		return "<button class='[toggle_class]'>[toggle_text]</button>"

/datum/erp_preference/boolean/handle_session_topic(mob/user, list/href_list, datum/preferences/prefs, datum/sex_session/session)
	if(href_list["action"] != "toggle")
		return FALSE

	var/current_value = get_value(prefs)
	set_value(prefs, !current_value)
	prefs.save_preferences()

	var/status_text = current_value ? "disabled" : "enabled"
	to_chat(user, "<span class='notice'>[name] [status_text].</span>")
	return TRUE
