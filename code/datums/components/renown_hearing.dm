//ported codeword code from TG, this all literally means absolutely nothing to me


GLOBAL_VAR(legendary_name_evil)
GLOBAL_VAR(legendary_name_maybeevil)


GLOBAL_DATUM(legendary_name_evil_regex, /regex)
GLOBAL_DATUM(legendary_name_maybeevil_regex, /regex)



/datum/component/renown_hearing
	dupe_mode = COMPONENT_DUPE_ALLOWED

	/// Regex for matching words or phrases you want highlighted.
	var/regex/replace_regex
	/// The <span class=''> to use for highlighting matches.
	var/span_class
	/// The source of this component. Used to identify the source in delete_if_from_source since this component is COMPONENT_DUPE_ALLOWED.
	var/source

/datum/component/renown_hearing/Initialize(regex/renown_regex, highlight_span_class, component_source)
	if(!ismovable(parent))
		return COMPONENT_INCOMPATIBLE

	replace_regex = renown_regex
	span_class = highlight_span_class
	source = component_source
	return ..()

/datum/component/renown_hearing/RegisterWithParent()
	RegisterSignal(parent, COMSIG_MOVABLE_HEAR, PROC_REF(handle_hearing))

/datum/component/renown_hearing/UnregisterFromParent()
	UnregisterSignal(parent, COMSIG_MOVABLE_HEAR)

/// Callback for COMSIG_MOVABLE_HEAR which highlights syndicate code phrases in chat.
/datum/component/renown_hearing/proc/handle_hearing(datum/source, list/hearing_args)
	SIGNAL_HANDLER

	var/mob/living/owner = parent
	if(!istype(owner))
		return

	// don't skip renown names when owner speaks
	if(!owner.can_hear() || !owner.has_language(hearing_args[HEARING_LANGUAGE]))
		return

	var/message = hearing_args[HEARING_RAW_MESSAGE]
	message = replace_regex.Replace(message, "<span class='[span_class]'>$1</span>")
	hearing_args[HEARING_RAW_MESSAGE] = message

/// Since a parent can have multiple of these components on them simultaneously, this allows a datum to delete components from a specific source.
/datum/component/renown_hearing/proc/delete_if_from_source(component_source)
	if(source == component_source)
		qdel(src)
		return TRUE

	return FALSE
