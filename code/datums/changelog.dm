/datum/changelog
	var/static/list/changelog_items = list()
	var/built_html
	var/static/list/key_to_text = list(
		"rscadd" = "ADDITION"
	)

/datum/changelog/New()
	. = ..()

	built_html = {"
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
	<html>
	<head>
		<title>Vanderlin Changelog</title>
		<link rel="stylesheet" type="text/css" href="changelog.css">
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

	<div>
		[format_logs()]
	<div>

	<b>GoonStation 13 Development Team</b>
		<div class = "top">
		<b>Coders:</b> Stuntwaffle, Showtime, Pantaloons, Nannek, Keelin, Exadv1, hobnob, Justicefries, 0staf, sniperchance, AngriestIBM, BrianOBlivion<br>
		<b>Spriters:</b> Supernorn, Haruhi, Stuntwaffle, Pantaloons, Rho, SynthOrange, I Said No<br>
		</div>
	<br>
	<p class="lic"><a name="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/"><img src="88x31.png" alt="Creative Commons License" /></a><br><i>Except where otherwise noted, Goon Station 13 is licensed under a <a href="http://creativecommons.org/licenses/by-nc-sa/3.0/">Creative Commons Attribution-Noncommercial-Share Alike 3.0 License</a>.<br>Rights are currently extended to <a href="http://forums.somethingawful.com/">SomethingAwful Goons</a> only.</i></p>
	<p class="lic">Some icons by <a href="http://p.yusukekamiyamane.com/">Yusuke Kamiyamane</a>. All rights reserved. Licensed under a <a href="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution 3.0 License</a>.</p>
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
				<li>[ammend][description]</li>
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

	for(var/archive_file in sortList(flist(archive_path)))
		var/archive_date = jsonRegex.Replace(archive_file, "")
		archive_data += list(
			"[archive_date]" = json_decode(file2text(archive_path + archive_file))
		)

	return archive_data
