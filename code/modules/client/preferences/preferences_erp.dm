/datum/preferences/proc/show_erp_preferences(mob/user)
	var/list/dat = list()
	dat += "<style>span.color_holder_box{display: inline-block; width: 20px; height: 8px; border:1px solid #000; padding: 0px;}</style>"
	dat += "<style>"
	dat += ".tab-container { margin-bottom: 20px; }"
	dat += ".tab-button { display: inline-block; padding: 10px 20px; margin-right: 2px; background: #333; color: #fff; border: none; cursor: pointer; font-weight: bold; }"
	dat += ".tab-button:hover { background: #555; }"
	dat += ".tab-button.active { background: #8B0000; }" // Dark red to match your character sheet
	dat += ".tab-content { display: none; }"
	dat += ".tab-content.active { display: block; }"
	dat += ".search-container { margin-bottom: 15px; text-align: center; }"
	dat += ".search-box { width: 300px; padding: 8px; font-size: 14px; border: 2px solid #333; border-radius: 4px; }"
	dat += ".hidden { display: none !important; }"
	dat += "</style>"

	// Tab buttons
	dat += "<div class='tab-container'>"
	dat += "<button class='tab-button' id='general-tab' onclick='showTab(\"general\")'>General ERP</button>"
	dat += "<button class='tab-button' id='kinks-tab' onclick='showTab(\"kinks\")'>Kinks</button>"
	dat += "</div>"

	// Search bar
	dat += "<div class='search-container'>"
	dat += "<input type='text' class='search-box' id='searchBox' placeholder='Search preferences...' onkeyup='searchPreferences()'>"
	dat += "</div>"

	// Tab contents
	dat += "<div id='general' class='tab-content'>"
	dat += print_erp_preferences_page()
	dat += "</div>"

	dat += "<div id='kinks' class='tab-content'>"
	dat += print_kinks_preferences_page()
	dat += "</div>"

	dat += "<script>"
	// Cookie functions
	dat += "function setCookie(name, value, days) {"
	dat += "  var expires = '';"
	dat += "  if (days) {"
	dat += "    var date = new Date();"
	dat += "    date.setTime(date.getTime() + (days*24*60*60*1000));"
	dat += "    expires = '; expires=' + date.toUTCString();"
	dat += "  }"
	dat += "  document.cookie = name + '=' + (value || '') + expires + '; path=/';"
	dat += "}"
	dat += "function getCookie(name) {"
	dat += "  var nameEQ = name + '=';"
	dat += "  var ca = document.cookie.split(';');"
	dat += "  for(var i=0;i < ca.length;i++) {"
	dat += "    var c = ca\[i\];"
	dat += "    while (c.charAt(0)==' ') c = c.substring(1,c.length);"
	dat += "    if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);"
	dat += "  }"
	dat += "  return null;"
	dat += "}"
	// Tab switching
	dat += "function showTab(tabName) {"
	dat += "  var tabs = document.querySelectorAll('.tab-content');"
	dat += "  tabs.forEach(function(tab) { tab.classList.remove('active'); });"
	dat += "  var buttons = document.querySelectorAll('.tab-button');"
	dat += "  buttons.forEach(function(btn) { btn.classList.remove('active'); });"
	dat += "  document.getElementById(tabName).classList.add('active');"
	dat += "  document.getElementById(tabName + '-tab').classList.add('active');"
	dat += "  setCookie('erp_active_tab', tabName, 30);"
	dat += "}"
	// Search functionality
	dat += "function searchPreferences() {"
	dat += "  var input = document.getElementById('searchBox');"
	dat += "  var filter = input.value.toLowerCase();"
	dat += "  var tables = document.querySelectorAll('.tab-content table');"
	dat += "  tables.forEach(function(table) {"
	dat += "    var rows = table.querySelectorAll('tr');"
	dat += "    rows.forEach(function(row) {"
	dat += "      if (row.querySelector('h3')) return;" // Skip category headers
	dat += "      var nameCell = row.cells\[0\];"
	dat += "      if (nameCell) {"
	dat += "        var text = nameCell.textContent || nameCell.innerText;"
	dat += "        if (text.toLowerCase().indexOf(filter) > -1) {"
	dat += "          row.style.display = '';"
	dat += "        } else {"
	dat += "          row.style.display = 'none';"
	dat += "        }"
	dat += "      }"
	dat += "    });"
	dat += "  });"
	dat += "}"
	// Load saved tab on page load
	dat += "window.onload = function() {"
	dat += "  var savedTab = getCookie('erp_active_tab');"
	dat += "  if (savedTab && (savedTab === 'general' || savedTab === 'kinks')) {"
	dat += "    showTab(savedTab);"
	dat += "  } else {"
	dat += "    showTab('general');"
	dat += "  }"
	dat += "};"
	dat += "</script>"

	var/datum/browser/popup = new(user, "erp_preferences", "<div align='center'>ERP Preferences</div>", 630, 730)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/print_erp_preferences_page()
	var/list/dat = list()
	var/list/categories = list()

	for(var/datum/erp_preference/pref_type as anything in subtypesof(/datum/erp_preference))
		if(is_abstract(pref_type))
			continue
		var/datum/erp_preference/pref = new pref_type()
		if(pref.abstract_type == pref_type)
			continue
		if(!categories[pref.category])
			categories[pref.category] = list()
		categories[pref.category] += pref_type

	if(!length(categories))
		dat += "<div style='text-align: center; padding: 20px;'>No general ERP preferences available.</div>"
		return dat

	dat += "<table width='100%'>"
	for(var/category in categories)
		dat += "<tr><td colspan='2'><h3>[category]</h3></td></tr>"
		for(var/pref_type in categories[category])
			var/datum/erp_preference/pref = new pref_type()
			dat += "<tr><td width='50%'><b>[pref.name]:</b><br><i>[pref.description]</i></td>"
			dat += "<td width='50%'>[pref.show_pref_ui(src)]</td></tr>"
	dat += "</table>"
	return dat

/datum/preferences/proc/print_kinks_preferences_page()
	var/list/dat = list()
	var/list/categories = list()

	for(var/kink_name in GLOB.available_kinks)
		var/datum/kink/kink = GLOB.available_kinks[kink_name]
		if(!categories[kink.category])
			categories[kink.category] = list()
		categories[kink.category] += kink

	if(!length(categories))
		dat += "<div style='text-align: center; padding: 20px;'>No kinks available.</div>"
		return dat

	dat += "<table width='100%'>"
	for(var/category in categories)
		dat += "<tr><td colspan='2'><h3>[category]</h3></td></tr>"
		for(var/datum/kink/kink in categories[category])
			dat += "<tr><td width='50%'><b>[kink.name]:</b><br><i>[kink.description]</i></td>"
			dat += "<td width='50%'>[show_kink_ui(kink)]</td></tr>"
	dat += "</table>"
	return dat

/datum/preferences/proc/show_kink_ui(datum/kink/kink)
	var/list/kink_prefs = erp_preferences["kinks"]
	if(!kink_prefs)
		kink_prefs = list()
		erp_preferences["kinks"] = kink_prefs

	var/list/kink_data = kink_prefs[kink.name]
	if(!kink_data)
		kink_data = list("enabled" = TRUE, "intensity" = 3, "notes" = "")
		kink_prefs[kink.name] = kink_data

	var/enabled = kink_data["enabled"]
	var/intensity = kink_data["intensity"]
	var/notes = kink_data["notes"]

	var/list/dat = list()
	dat += "<b>Enabled:</b> "
	dat += "<a href='?_src_=prefs;task=erp_pref;preference=kink;kink_name=[url_encode(kink.name)];action=toggle_enabled'>"
	dat += enabled ? "Yes" : "No"
	dat += "</a><br>"

	if(enabled)
		dat += "<b>Intensity:</b> "
		for(var/i = 1 to 5)
			if(i == intensity)
				dat += "<b>[i]</b> "
			else
				dat += "<a href='?_src_=prefs;task=erp_pref;preference=kink;kink_name=[url_encode(kink.name)];action=set_intensity;intensity=[i]'>[i]</a> "
		dat += "<br>"

		dat += "<b>Notes:</b> "
		dat += "<a href='?_src_=prefs;task=erp_pref;preference=kink;kink_name=[url_encode(kink.name)];action=set_notes'>"
		dat += length(notes) ? "[copytext(notes, 1, 20)]..." : "None"
		dat += "</a>"

	return dat.Join()

/datum/preferences/proc/handle_erp_pref_topic(mob/user, list/href_list)
	if(href_list["preference"] == "kink")
		handle_kink_topic(user, href_list)
		return

	var/pref_type = text2path(href_list["pref_type"])
	if(!pref_type)
		return
	var/datum/erp_preference/pref = new pref_type()
	pref.handle_topic(user, href_list, src)

/datum/preferences/proc/handle_kink_topic(mob/user, list/href_list)
	var/kink_name = href_list["kink_name"]
	if(!kink_name || !GLOB.available_kinks[kink_name])
		return

	var/list/kink_prefs = erp_preferences["kinks"]
	if(!kink_prefs)
		kink_prefs = list()
		erp_preferences["kinks"] = kink_prefs

	var/list/kink_data = kink_prefs[kink_name]
	if(!kink_data)
		kink_data = list("enabled" = TRUE, "intensity" = 3, "notes" = "")
		kink_prefs[kink_name] = kink_data

	switch(href_list["action"])
		if("toggle_enabled")
			kink_data["enabled"] = !kink_data["enabled"]
		if("set_intensity")
			var/new_intensity = text2num(href_list["intensity"])
			if(new_intensity >= 1 && new_intensity <= 5)
				kink_data["intensity"] = new_intensity
		if("set_notes")
			var/new_notes = input(user, "Enter notes for [kink_name]:", "Kink Notes", kink_data["notes"]) as text|null
			if(new_notes != null)
				kink_data["notes"] = new_notes

	show_erp_preferences(user) // Refresh the UI

/datum/preferences/proc/apply_character_kinks(mob/living/carbon/human/character)
	if(!length(erp_preferences))
		validate_erp_preferences()

	var/list/kink_prefs = erp_preferences["kinks"]
	if(!kink_prefs)
		return

	for(var/kink_name in kink_prefs)
		var/list/kink_data = kink_prefs[kink_name]
		if(!kink_data["enabled"])
			continue

		var/datum/kink/kink = GLOB.available_kinks[kink_name]
		if(!kink)
			continue

		// Create a copy of the kink for this character
		var/datum/kink/character_kink = new kink.type()
		character_kink.enabled = kink_data["enabled"]
		character_kink.intensity = kink_data["intensity"]
		character_kink.notes = kink_data["notes"]

		LAZYADD(character_kink.tracked_mobs, character) //this kinda makes tracked_mobs redundant since its no longer singletons but w/e this allows notes
		character_kink.apply_kink(character)

/datum/preferences/proc/save_erp_preferences(savefile/S)
	WRITE_FILE(S["erp_preferences"], erp_preferences)

/datum/preferences/proc/load_erp_preferences(savefile/S)
	S["erp_preferences"] >> erp_preferences
	erp_preferences = SANITIZE_LIST(erp_preferences)
	validate_erp_preferences()

/datum/preferences/proc/validate_erp_preferences()
	if(!erp_preferences)
		erp_preferences = list()

	// Clean up any invalid preference types that might have been loaded
	var/list/valid_types = list()
	for(var/datum/erp_preference/pref_type as anything in subtypesof(/datum/erp_preference))
		if(is_abstract(pref_type))
			continue
		var/datum/erp_preference/pref = new pref_type()
		if(pref.abstract_type != pref_type)
			valid_types += pref_type

	// Remove any preferences that are no longer valid
	for(var/pref_type in erp_preferences)
		if(pref_type == "kinks") // Keep kinks
			continue
		if(!(pref_type in valid_types))
			erp_preferences -= pref_type

	// Validate kinks
	var/list/kink_prefs = erp_preferences["kinks"]
	if(kink_prefs)
		for(var/kink_name in kink_prefs)
			if(!GLOB.available_kinks[kink_name])
				kink_prefs -= kink_name

/datum/preferences/proc/setup_default_erp_preferences()
	if(!erp_preferences)
		erp_preferences = list()

	// Set up default values for any missing ERP preferences
	for(var/pref_type in subtypesof(/datum/erp_preference))
		var/datum/erp_preference/pref = new pref_type()
		if(pref.abstract_type == pref_type)
			continue
		if(!(pref_type in erp_preferences))
			if(istype(pref, /datum/erp_preference/boolean))
				erp_preferences[pref_type] = pref.default_value
			else if(istype(pref, /datum/erp_preference/list_choice))
				var/datum/erp_preference/list_choice/choice_pref = pref
				erp_preferences[pref_type] = choice_pref.default_choice
			else if(istype(pref, /datum/erp_preference/numeric))
				var/datum/erp_preference/numeric/num_pref = pref
				erp_preferences[pref_type] = num_pref.default_numeric

	// Set up default kink preferences
	if(!erp_preferences["kinks"])
		erp_preferences["kinks"] = list()

	var/list/kink_prefs = erp_preferences["kinks"]
	for(var/kink_name in GLOB.available_kinks)
		if(!kink_prefs[kink_name])
			kink_prefs[kink_name] = list("enabled" = FALSE, "intensity" = 1, "notes" = "")
