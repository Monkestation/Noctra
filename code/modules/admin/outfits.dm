GLOBAL_LIST_EMPTY(custom_outfits) //Admin created outfits

/client/proc/outfit_manager()
	set category = "Debug"
	set name = "Outfit Manager"

	if(!check_rights(R_DEBUG))
		return
	holder.outfit_manager(usr)

/datum/admins/proc/outfit_manager(mob/admin)
	var/list/dat = list("<ul>")
	for(var/datum/outfit/O in GLOB.custom_outfits)
		var/vv = FALSE
		var/datum/outfit/varedit/VO = O
		if(istype(VO))
			vv = length(VO.vv_values)
		dat += "<li>[O.name][vv ? "(VV)" : ""]</li> <a href='?_src_=holder;[HrefToken()];save_outfit=1;chosen_outfit=[REF(O)]'>Save</a> <a href='?_src_=holder;[HrefToken()];delete_outfit=1;chosen_outfit=[REF(O)]'>Delete</a>"
	dat += "</ul>"
	dat += "<a href='?_src_=holder;[HrefToken()];create_outfit_menu=1'>Create</a><br>"
	dat += "<a href='?_src_=holder;[HrefToken()];load_outfit=1'>Load from file</a>"
	var/datum/browser/popup = new(admin, "outfitmanager", "Outfit Manager", 670, 650)
	popup.set_content(dat.Join())
	popup.open()

/datum/admins/proc/save_outfit(mob/admin,datum/outfit/O)
	O.save_to_file(admin)
	outfit_manager(admin)

/datum/admins/proc/delete_outfit(mob/admin,datum/outfit/O)
	GLOB.custom_outfits -= O
	qdel(O)
	to_chat(admin,"<span class='notice'>Outfit deleted.</span>")
	outfit_manager(admin)

/datum/admins/proc/load_outfit(mob/admin)
	var/outfit_file = input("Pick outfit json file:", "File") as null|file
	if(!outfit_file)
		return
	var/filedata = file2text(outfit_file)
	var/json = json_decode(filedata)
	if(!json)
		to_chat(admin,"<span class='warning'>JSON decode error.</span>")
		return
	var/otype = text2path(json["outfit_type"])
	if(!ispath(otype,/datum/outfit))
		to_chat(admin,"<span class='warning'>Malformed/Outdated file.</span>")
		return
	var/datum/outfit/O = new otype
	if(!O.load_from(json))
		to_chat(admin,"<span class='warning'>Malformed/Outdated file.</span>")
		return
	GLOB.custom_outfits += O
	message_admins("[key_name(usr)] loaded an outfit! Name: \"[O.name]\"")
	outfit_manager(admin)

/datum/admins/proc/create_outfit(mob/admin)

	var/heads_select = "<input type=\"text\" name=\"outfit_head\""

	var/masks_select = "<input type=\"text\" name=\"outfit_mask\""

	var/necks_select = "<input type=\"text\" name=\"outfit_neck\""

	var/cloaks_select = "<input type=\"text\" name=\"outfit_cloak\""

	var/backsr_select = "<input type=\"text\" name=\"outfit_backr\""

	var/backsl_select = "<input type=\"text\" name=\"outfit_backl\""

	var/rings_select = "<input type=\"text\" name=\"outfit_ring\""

	var/wrists_select = "<input type=\"text\" name=\"outfit_wrists\""

	var/gloves_select = "<input type=\"text\" name=\"outfit_gloves\""

	var/shirts_select = "<input type=\"text\" name=\"outfit_shirt\""

	var/armors_select = "<input type=\"text\" name=\"outfit_armor\""

	var/pants_select = "<input type=\"text\" name=\"outfit_pants\""

	var/belts_select = "<input type=\"text\" name=\"outfit_belt\""

	var/shoes_select = "<input type=\"text\" name=\"outfit_shoes\""

	var/scabbard1 = "<input type=\"text\" name=\"outfit_scabbard1\""

	var/scabbard2 = "<input type=\"text\" name=\"outfit_scabbard2\""

	var/dat = {"
	<html><head><title>Create Outfit</title></head><body>
	<form name="outfit" action="byond://?src=[REF(src)];[HrefToken()]" method="get">
	<input type="hidden" name="src" value="[REF(src)]">
	[HrefTokenFormField()]
	<input type="hidden" name="create_outfit_finalize" value="1">
	<table>
		<tr>
			<th>Name:</th>
			<td>
				<input type="text" name="outfit_name" value="Custom Outfit">
			</td>
		</tr>
		<tr>
			<th>Head:</th>
			<td>
				[heads_select]
			</td>
		</tr>
		<tr>
			<th>Mask:</th>
			<td>
				[masks_select]
			</td>
		</tr>
		<tr>
			<th>Neck:</th>
			<td>
				[necks_select]
			</td>
		</tr>
		<tr>
			<th>Cloak:</th>
			<td>
				[cloaks_select]
			</td>
		</tr>
		<tr>
			<th>BackR:</th>
			<td>
				[backsr_select]
			</td>
		</tr>
		<tr>
			<th>BackL:</th>
			<td>
				[backsl_select]
			</td>
		</tr>
		<tr>
			<th>Ring:</th>
			<td>
				[rings_select]
			</td>
		</tr>
		<tr>
			<th>Wrists:</th>
			<td>
				[wrists_select]
			</td>
		</tr>
		<tr>
			<th>Gloves:</th>
			<td>
				[gloves_select]
			</td>
		</tr>
		<tr>
			<th>Shirt:</th>
			<td>
				[shirts_select]
			</td>
		</tr>
		<tr>
			<th>Armor:</th>
			<td>
				[armors_select]
			</td>
		</tr>
		<tr>
			<th>Pants:</th>
			<td>
				[pants_select]
			</td>
		</tr>
		<tr>
			<th>Belt:</th>
			<td>
				[belts_select]
			</td>
		</tr>
		<tr>
			<th>Shoes:</th>
			<td>
				[shoes_select]
			</td>
		</tr>
		<tr>
			<th>Scabbard 1:</th>
			<td>
				[scabbard1]
			</td>
		</tr>
		<tr>
			<th>Scabbard 2:</th>
			<td>
				[scabbard2]
			</td>
		</tr>
	</table>
	<br>
	<input type="submit" value="Save">
	</form></body></html>
	"}

	var/datum/browser/popup = new (admin, "outfit_manager", "Outfit Manager", 300, 350)
	popup.set_content(dat)

	popup.open()

/datum/admins/proc/create_outfit_finalize(mob/admin, list/href_list)
	var/datum/outfit/O = new

	O.name = href_list["outfit_name"]
	O.head = text2path(href_list["outfit_head"])
	O.mask = text2path(href_list["outfit_mask"])
	O.neck = text2path(href_list["outfit_neck"])
	O.cloak = text2path(href_list["outfit_cloak"])
	O.backl = text2path(href_list["outfit_backl"])
	O.backr = text2path(href_list["outfit_backr"])
	O.ring = text2path(href_list["outfit_ring"])
	O.wrists = text2path(href_list["outfit_wrists"])
	O.gloves = text2path(href_list["outfit_gloves"])
	O.shirt = text2path(href_list["outfit_shirt"])
	O.armor = text2path(href_list["outfit_armor"])
	O.pants = text2path(href_list["outfit_pants"])
	O.belt = text2path(href_list["outfit_belt"])
	O.shoes = text2path(href_list["outfit_shoes"])
	var/loaded_scabbard1 = text2path(href_list["outfit_scabbard1"])
	if(loaded_scabbard1)
		LAZYADD(O.scabbards, loaded_scabbard1)

	var/loaded_scabbard2 = text2path(href_list["outfit_scabbard2"])
	if(loaded_scabbard2)
		LAZYADD(O.scabbards, loaded_scabbard2)

	GLOB.custom_outfits.Add(O)
	message_admins("[key_name(usr)] created \"[O.name]\" outfit!")

	outfit_manager(admin)
