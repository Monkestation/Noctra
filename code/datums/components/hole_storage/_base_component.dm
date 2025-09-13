/datum/component/storage/concrete/grid/hole
	screen_max_rows = 4
	screen_max_columns = 1
	max_w_class = WEIGHT_CLASS_NORMAL
	not_while_equipped = FALSE

	var/target_zone = BODY_ZONE_CHEST
	var/facing_direction

/datum/component/hole_storage
	/// Array of holes going by ID = storage holder
	var/list/hole_array = list()

/datum/component/hole_storage/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_HOLE_TRY_FIT, PROC_REF(try_fit_in_hole))
	RegisterSignal(parent, COMSIG_HOLE_RETURN_INVENTORY, PROC_REF(return_inventory))
	RegisterSignal(parent, COMSIG_HOLE_RETURN_ITEM_LIST, PROC_REF(return_list))
	RegisterSignal(parent, COMSIG_HOLE_ADD_HOLE, PROC_REF(add_hole))
	RegisterSignal(parent, COMSIG_HOLE_REMOVE_HOLE, PROC_REF(remove_hole))
	RegisterSignal(parent, COMSIG_HOLE_MODIFY_HOLE, PROC_REF(modify_hole))
	RegisterSignal(parent, COMSIG_HOLE_GET_FULLNESS, PROC_REF(get_hole_fullness))
	RegisterSignal(parent, COMSIG_HOLE_REMOVE_ITEM, PROC_REF(remove_item_from_hole))

/**
 * Add a new hole with storage capability
 *
 * @param source - The source object calling this
 * @param hole_id - Unique identifier for the hole
 * @param hole_name - Display name for the hole (optional)
 * @param storage_size - Custom storage size (optional)
 */
/datum/component/hole_storage/proc/add_hole(datum/source, hole_id, hole_name = null, datum/component/storage/concrete/grid/hole/storage_type = /datum/component/storage/concrete/grid/hole)
	if(!hole_id)
		return FALSE

	// Check if hole already exists
	if(hole_array[hole_id])
		var/datum/component/storage/existing_storage = hole_array[hole_id]
		if(existing_storage && !QDELETED(existing_storage.parent))
			return existing_storage

	var/obj/item/storage/backpack/hole_storage/new_storage = new()
	new_storage.name = hole_name || "Hole [hole_id] Storage"
	new_storage.desc = "A mysterious storage space within hole [hole_id]. Items placed here seem to exist in a pocket dimension."

	var/datum/component/storage/concrete/grid/hole/storage_comp = new_storage.GetComponent(/datum/component/storage)
	if(!storage_comp)
		storage_comp = new_storage.AddComponent(storage_type)
	else
		// a very crude patchwork fix, for some reason the component is not being added correctly
		storage_comp.RemoveComponent()
		storage_comp = new_storage.AddComponent(storage_type)

	hole_array[hole_id] = storage_comp
	return storage_comp

/**
 * Remove a hole and its storage
 */
/datum/component/hole_storage/proc/remove_hole(datum/source, hole_id)
	if(!hole_id || !hole_array[hole_id])
		return FALSE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(storage_comp && !QDELETED(storage_comp.parent))
		qdel(storage_comp.parent)

	hole_array -= hole_id
	return TRUE

/**
 * Modify existing hole storage properties
 */
/datum/component/hole_storage/proc/modify_hole(datum/source, hole_id, new_size_row, new_size_column)
	if(!hole_id || !hole_array[hole_id])
		return FALSE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		return FALSE

	if(new_size_row)
		storage_comp.screen_max_rows = new_size_row

	if(new_size_column)
		storage_comp.screen_max_columns = new_size_column

	return TRUE


/**
 * Get fullness information for a specific hole using grid-based calculation
 *
 * @param source - The source object calling this
 * @param hole_id - Unique identifier for the hole
 * @return list with keys via the data param: "is_full" (boolean), "percent_full" (0-100), "used_capacity" (grid units), "max_capacity" (grid units), "redstone_level" (0-15)
 */
/datum/component/hole_storage/proc/get_hole_fullness(datum/source, hole_id, list/data)
	if(!hole_id || !hole_array[hole_id])
		data += list("is_full" = FALSE, "percent_full" = 0, "used_capacity" = 0, "max_capacity" = 0, "redstone_level" = 0)
		return NONE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		data += list("is_full" = FALSE, "percent_full" = 0, "used_capacity" = 0, "max_capacity" = 0, "redstone_level" = 0)
		return NONE

	var/obj/storage_parent = storage_comp.parent
	var/used_capacity = calculate_grid_storage_fullness(storage_comp, storage_parent)
	var/max_capacity = storage_comp.screen_max_rows * storage_comp.screen_max_columns

	if(max_capacity <= 0)
		data +=  list("is_full" = FALSE, "percent_full" = 0, "used_capacity" = 0, "max_capacity" = 0, "redstone_level" = 0)
		return NONE

	var/fullness_ratio = used_capacity / max_capacity
	var/percent_full = round(fullness_ratio * 100)
	var/is_full = (fullness_ratio >= 1.0)
	var/redstone_level = round(fullness_ratio * 15)

	data += list(
		"is_full" = is_full,
		"percent_full" = percent_full,
		"used_capacity" = used_capacity,
		"max_capacity" = max_capacity,
		"redstone_level" = redstone_level
	)
	return NONE

/**
 * Calculate grid-based storage fullness
 *
 * @param storage_comp - The storage component to check
 * @param storage_obj - The storage object containing items
 * @return The total grid capacity used by all items
 */
/datum/component/hole_storage/proc/calculate_grid_storage_fullness(datum/component/storage/storage_comp, obj/storage_obj)
	if(!storage_comp || !storage_obj)
		return 0

	var/total_capacity = 0
	for(var/obj/item/item as anything in storage_obj.contents)
		total_capacity += (item.grid_width / 32) * (item.grid_height / 32)

	return total_capacity

/**
 * Quick check if a hole is completely full
 *
 * @param source - The source object calling this
 * @param hole_id - Unique identifier for the hole
 * @return TRUE if full, FALSE if not full or hole doesn't exist
 */
/datum/component/hole_storage/proc/is_hole_full(datum/source, hole_id)
	var/list/fullness_info = list()
	get_hole_fullness(source, hole_id, fullness_info)
	return fullness_info["is_full"]

/**
 * Get fullness percentage for a hole (0-100)
 *
 * @param source - The source object calling this
 * @param hole_id - Unique identifier for the hole
 * @return Number from 0-100 representing how full the hole is
 */
/datum/component/hole_storage/proc/get_hole_percent_full(datum/source, hole_id)
	var/list/fullness_info = list()
	get_hole_fullness(source, hole_id, fullness_info)
	return fullness_info["percent_full"]

/**
 * Remove a specific item from a specific hole
 *
 * @param source - The source object calling this
 * @param item - The item to remove
 * @param hole_id - Unique identifier for the hole
 * @param mob/user - User performing the removal (optional)
 * @return TRUE if successfully removed, FALSE otherwise
 */
/datum/component/hole_storage/proc/remove_item_from_hole(datum/source, obj/item/item, hole_id, mob/user)
	if(!hole_id || !hole_array[hole_id] || !item)
		return FALSE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		return FALSE

	// Check if the item is actually in this hole's storage
	var/obj/storage_parent = storage_comp.parent
	if(!storage_parent || !(item in storage_parent.contents))
		return FALSE

	// Remove the item from storage
	storage_comp.remove_from_storage(item, user)

	if(user)
		to_chat(user, span_notice("You remove [item] from [hole_id]."))

	return TRUE

/**
 * Remove all items of a specific type from a specific hole
 *
 * @param source - The source object calling this
 * @param item_type - The type of item to remove
 * @param hole_id - Unique identifier for the hole
 * @param mob/user - User performing the removal (optional)
 * @param max_count - Maximum number to remove (0 = all)
 * @return Number of items actually removed
 */
/datum/component/hole_storage/proc/remove_items_by_type(datum/source, item_type, hole_id, mob/user, max_count = 0)
	if(!hole_id || !hole_array[hole_id] || !item_type)
		return 0

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		return 0

	var/obj/storage_parent = storage_comp.parent
	if(!storage_parent)
		return 0

	var/removed_count = 0
	var/list/items_to_remove = list()

	// Find matching items
	for(var/obj/item/stored_item in storage_parent.contents)
		if(istype(stored_item, item_type))
			items_to_remove += stored_item
			removed_count++
			if(max_count > 0 && removed_count >= max_count)
				break

	// Remove the items
	for(var/obj/item/item_to_remove in items_to_remove)
		storage_comp.remove_from_storage(item_to_remove, user)

	if(user && removed_count > 0)
		to_chat(user, span_notice("You remove [removed_count] item(s) from [hole_id]."))

	return removed_count

/**
 * Remove items by name from a specific hole
 *
 * @param source - The source object calling this
 * @param item_name - The name of items to remove
 * @param hole_id - Unique identifier for the hole
 * @param mob/user - User performing the removal (optional)
 * @param max_count - Maximum number to remove (0 = all)
 * @return Number of items actually removed
 */
/datum/component/hole_storage/proc/remove_items_by_name(datum/source, item_name, hole_id, mob/user, max_count = 0)
	if(!hole_id || !hole_array[hole_id] || !item_name)
		return 0

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		return 0

	var/obj/storage_parent = storage_comp.parent
	if(!storage_parent)
		return 0

	var/removed_count = 0
	var/list/items_to_remove = list()

	// Find matching items
	for(var/obj/item/stored_item in storage_parent.contents)
		if(stored_item.name == item_name)
			items_to_remove += stored_item
			removed_count++
			if(max_count > 0 && removed_count >= max_count)
				break

	// Remove the items
	for(var/obj/item/item_to_remove in items_to_remove)
		storage_comp.remove_from_storage(item_to_remove, user)

	if(user && removed_count > 0)
		to_chat(user, span_notice("You remove [removed_count] item(s) named '[item_name]' from [hole_id]."))

	return removed_count

/**
 * Try to fit an item into a specific hole
 */
/datum/component/hole_storage/proc/try_fit_in_hole(datum/source, obj/item/item, hole_id, mob/user, silent = TRUE)
	if(!hole_id || !hole_array[hole_id] || !item)
		return FALSE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp || QDELETED(storage_comp.parent))
		return FALSE

	// Check if item can fit
	if(!storage_comp.can_be_inserted(item, user))
		if(user && !silent)
			to_chat(user, span_warning("[item] won't fit in [hole_id]."))
		return FALSE

	// Insert the item
	storage_comp.handle_item_insertion(item, user)
	if(user && !silent)
		to_chat(user, span_notice("You place [item] into [hole_id]."))
	return TRUE

/**
 * Open/show the inventory of a specific hole to a user
 */
/datum/component/hole_storage/proc/return_inventory(datum/source, hole_id, mob/user)
	if(!hole_id || !user)
		return FALSE

	var/datum/component/storage/storage_comp = hole_array[hole_id]
	if(!storage_comp)
		// Create hole if it doesn't exist
		storage_comp = add_hole(src, hole_id)

	if(!storage_comp || QDELETED(storage_comp.parent))
		to_chat(user, span_warning("Unable to access hole [hole_id] storage."))
		return FALSE

	to_chat(user, span_notice("Opening storage for hole [hole_id]."))
	storage_comp.show_to(user)
	return TRUE

/**
 * Return a simple list of all items across all holes
 */
/datum/component/hole_storage/proc/return_list(datum/source)
	var/list/all_items = list()

	for(var/hole_id in hole_array)
		var/datum/component/storage/storage_comp = hole_array[hole_id]
		if(!storage_comp || QDELETED(storage_comp.parent))
			continue

		all_items += storage_comp.contents()

	return all_items

// Storage container object for holes
/obj/item/storage/backpack/hole_storage
	name = "hole storage"
	desc = "God I feel dirty."
	icon_state = "backpack"

/mob/living/proc/add_hole(hole_id, datum/component/storage/concrete/grid/hole/hole_type)
	var/datum/component/hole_storage/hole = GetComponent(/datum/component/hole_storage)
	if(!hole)
		AddComponent(/datum/component/hole_storage)
	if(!hole_id)
		return
	SEND_SIGNAL(src, COMSIG_HOLE_ADD_HOLE, hole_id, hole_id, hole_type)
