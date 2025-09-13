SUBSYSTEM_DEF(librarian)
	name = "Librarian"
	init_order = INIT_ORDER_PATH
	flags = SS_NO_FIRE
	var/list/books = list()

/datum/controller/subsystem/librarian/Initialize(start_timeofday)
	update_books()
	return ..()

/datum/controller/subsystem/librarian/proc/get_book(input)
	if(!input)
		return list()
	if(books.Find(input))
		return books[input]
	books[input] = file2book(input)
	return books[input]

/datum/controller/subsystem/librarian/proc/get_books(search_title, search_author, search_category)
	var/list/return_books = list()

	if(!search_title && !search_author && !search_category)
		return list()

	for(var/filename in books)
		var/list/book_info = books[filename]
		if(!book_info || !book_info["book_title"])
			continue

		var/matches = TRUE
		if(search_title && !findtext(lowertext(book_info["book_title"]), lowertext(search_title)))
			matches = FALSE
		if(search_author && !findtext(lowertext(book_info["author"]), lowertext(search_author)))
			matches = FALSE
		if(search_category && search_category != "Any" && book_info["category"] != search_category)
			matches = FALSE

		if(matches)
			return_books += list(book_info)

	return return_books

/proc/file2book(filename)
	if(!filename)
		return list()
	var/json_file = file("strings/books/[filename]")
	if(fexists(json_file))
		var/list/configuration = json_decode(file2text(json_file))
		var/list/contents = configuration["Contents"]
		if(isnull(contents))
			return list()
		return contents
	return list()

/datum/controller/subsystem/librarian/proc/playerbook2file(input, book_title = "Unknown", author = "Unknown", author_ckey = "Unknown", icon = "basic_book", category = "Myths & Tales")
	if(!input)
		return "There is no text in the book!"
	if(fexists("data/player_generated_books/[url_encode(book_title)].json"))
		return "there is already a book by this title!"
	if(!(istext(input) && istext(book_title) && istext(author) && istext(author_ckey) && istext(icon)))
		return "This book is incorrectly formatted!"

	var/list/contents = list("book_title" = "[book_title]", "author" = "[author]", "author_ckey" = "[author_ckey]", "icon" = "[icon]",  "text" = "[input]", "category" = category)
	//url_encode should escape all the characters that do not belong in a file name. If not, god help us
	var/file_name = "data/player_generated_books/[url_encode(book_title)].json"
	text2file(json_encode(contents), file_name)

	if(fexists("data/player_generated_books/_book_titles.json"))
		var/list/_book_titles_contents = json_decode(file2text("data/player_generated_books/_book_titles.json"))
		_book_titles_contents += "[url_encode(book_title)]"
		fdel("data/player_generated_books/_book_titles.json")
		text2file(json_encode(_book_titles_contents), "data/player_generated_books/_book_titles.json")
		message_admins("Book [book_title] has been saved to the player book database by [author_ckey]([author])")
		return "You have a feeling the newly written book will remain in the archive for a very long time..."
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. making a new one without old books... !!!")
		text2file(json_encode(list(book_title)), "data/player_generated_books/_book_titles.json")
		return "_book_titles.json no longer exists, yell at your server host that some books have been lost!"

/datum/controller/subsystem/librarian/proc/file2playerbook(filename)
	if(!filename)
		return list()
	var/json_file = file("data/player_generated_books/[filename].json")
	if(fexists(json_file))
		var/list/contents = json_decode(file2text(json_file))
		if(isnull(contents))
			return list()
		if(!("category" in contents))
			contents |= "category"
			contents["category"] = "Thesis"
		return contents
	return list()

/datum/controller/subsystem/librarian/proc/player_book_exists(book_title)
	if(!book_title)
		return FALSE
	return fexists("data/player_generated_books/[book_title].json")

/datum/controller/subsystem/librarian/proc/del_player_book(book_title)
	if(!book_title)
		return FALSE

	var/encoded_title = url_encode(book_title)
	var/json_file = file("data/player_generated_books/[encoded_title].json")

	if(!fexists(json_file))
		return FALSE

	if(fexists("data/player_generated_books/_book_titles.json"))
		fdel(json_file)
		var/list/_book_titles_contents = json_decode(file2text("data/player_generated_books/_book_titles.json"))
		_book_titles_contents -= encoded_title
		fdel("data/player_generated_books/_book_titles.json")
		text2file(json_encode(_book_titles_contents), "data/player_generated_books/_book_titles.json")
		update_books()
		return TRUE
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. !!!")
		return FALSE

/datum/controller/subsystem/librarian/proc/pull_player_book_titles()
	if(fexists(file("data/player_generated_books/_book_titles.json")))
		var/json_file = file("data/player_generated_books/_book_titles.json")
		var/json_list = json_decode(file2text(json_file))
		return json_list
	else
		message_admins("!!! _book_titles.json no longer exists, previous book title list has been lost. !!!")

/datum/controller/subsystem/librarian/proc/update_books()
	books = list()
	books = pull_player_book_titles()
	for(var/book in books)
		if(!length(file2playerbook(book)))
			books -= book
			continue
		books[book] = file2playerbook(book)
