/// Global changelog singleton
/datum/changelog
	var/static/built_html
	var/static/list/key_to_text = list(
		"rscadd" = "ADDITION",
		"rscdel" = "REMOVAL",
		"image" = "ICONS",
		"imageadd" = "ADDED ICONS",
		"imagedel" = "REMOVED ICONS",
		"sound" = "SOUNDS",
		"soundadd" = "ADDED SOUNDS",
		"sounddel" = "REMOVED SOUNDS",
		"map" = "MAPPING",
		"bugfix" = "BUGFIX",
		"wip" = "WORK IN PROGRESS",
		"qol" = "QUALITY OF LIFE",
		"spellcheck" = "SPELLING",
		"experiment" = "EXPERIMENTAL",
		"balance" = "BALANCE",
		"code_imp" = "CODE IMPROVEMENT",
		"refactor" = "REFACTOR",
		"config" = "CONFIG",
		"admin" = "ADMIN",
		"server" = "SERVER",
	)

/datum/changelog/New()
	. = ..()

	built_html = {"
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<title>Vanderlin Changelog</title>
		<link rel="stylesheet" type="text/css" href="[SSassets.transport.get_asset_url("changelog.css")]">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</head>

	<body>
	<table align='center' width='650'><tr><td>
	<table align='center' class="top">
		<tr>
			<td valign='top'>
				<div align='center'><font size='3'><b>Vanderlin</b></font></div>

				<p><div align='center'><a href="https://mediawiki.monkestation.com">Wiki</a> | <a href="https://github.com/monkestation/vanderlin">Source Code</a></font></div></p>
				<font size='2'><b>Join our <a href="https://discord.gg/monkestation">Discord channel</a></b></font>
				</td>
		</tr>
	</table>

	<table align='center' class="top">
		<tr>
			<td valign='top'>
				<font size='2'><b>Thanks to:</b> Baystation 12, /vg/station, NTstation, CDK Station devs, FacepunchStation, GoonStation devs, the original Space Station 13 developers, Invisty for the title image and the countless others who have contributed to the game, issue tracker or wiki over the years.</font>
				<font size='2' color='red'><b><br>Have a bug to report?</b> Visit our <a href="https://github.com/Monkestation/Vanderlin/issues">Issue Tracker</a>.<br></font>
				<font size='2'>Please search first to ensure that the bug has not already been reported.</font>
			</td>
		</tr>
	</table>

	<table align='center' class="top">
		<tr>
			<td valign='top'>
				[format_logs()]
			</td>
		</tr>
	</table>

	<b>GoonStation 13 Development Team</b>
	<div class = "top">
		<b>Coders:</b> Stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob, Justicefries, 0staf, sniperchance, AngriestIBM, BrianOBlivion<br>
		<b>Spriters:</b> Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said No<br>
	</div>

	<table align='center' class="top">
		<tr>
			<td valign='top'>
				<p class="lic">
					Except where otherwise noted, Goon Station 13 is licensed under a <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-Noncommercial-Share Alike 3.0 License</a>.
					Rights are currently extended to \
					<a href="http://forums.somethingawful.com/">SomethingAwful Goons</a> only.
					<b><p>
						All code after \
						<a href="https://github.com/tgstation/tgstation/commit/333c566b88108de218d882840e61928a9b759d8">TG station commit 333c566b88108de218d882840e61928a9b759d8f on 2014/31/12 at 4:38 PM PST</a> \
						is licenced under <a href="https://www.gnu.org/licenses/agpl-3.0.html>GNU AGPL v3</a>. \
						All code after that commit is licensed under <a href="https://www.gnu.org/licenses/gpl-3.0.html">GNU GPL v3</a>, \
						including tools unless their readme specifies otherwise, see <a href="https://github.com/Monkestation/Vanderlin/blob/main/LICENSE">LICENSE</a>.
					</p>
					<p>
						Rogue Town was orginally forked from \
						<a href="https://github.com/tgstation/tgstation/commit/c28b351807bad950d2b323ada048190844bbda32">TG station commit c28b351807bad950d2b323ada048190844bbda32 on 2019/17/11</a>
					</p>
					<p>
						All assets including icons and sound are under a \
						<a href="https://creativecommons.org/licenses/by-sa/3.0/">Creative Commons 3.0 BY-SA license</a> unless otherwise indicated.
					</p></b>
				</p>
			</td>
		</tr>
	</table>

	</td></tr></table>
	</body>
	</html>
"}

/datum/changelog/proc/format_logs()
	var/list/logs = setup_logs()
	if(!length(logs))
		return

	return format_months(logs)

/datum/changelog/proc/format_months(list/months)
	var/list/months_data = list()
	for(var/month in months)
		months_data += {"
		<h1>[month]</h1>
			<div>
				[format_days(months[month])]
			</div>
		"}

	return months_data.Join()

/datum/changelog/proc/format_days(list/dates)
	var/list/days_data = list()
	for(var/date in dates)
		days_data += {"
		<h2>[date]</h2>
			<div class="commit sansserif">
				[format_authors(dates[date])]
			</div>
		"}

	return days_data.Join()

/datum/changelog/proc/format_authors(list/authors)
	var/list/authors_data = list()
	for(var/author in authors)
		var/data = authors[author]
		var/list/changes = list()
		for(var/change in data)
			var/ammend = ""
			var/tag = change[1]
			if(key_to_text[tag])
				ammend = "[key_to_text[tag]] - "
			var/description = change[tag]
			changes += {"
				<li class='[tag]'>[ammend][description]</li>
			"}

		authors_data += {"
			<h3 class="author">[author] updated:</h3>
			<ul class="changes bgimages16">
				[changes.Join()]
			</ul>
		"}

	return authors_data.Join()

/datum/changelog/proc/setup_logs()
	var/list/archive_data = list()
	var/regex/jsonRegex = regex(@"\.json", "g")

	var/archive_path = "html/changelogs/archive/"

	for(var/archive_file in sortList(flist(archive_path), GLOBAL_PROC_REF(cmp_text_dsc)))
		var/archive_date = jsonRegex.Replace(archive_file, "")
		archive_data += list(
			"[archive_date]" = reverseRange(json_decode(file2text(archive_path + archive_file)))
		)

	return archive_data
