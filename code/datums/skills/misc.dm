/datum/skill/misc
	abstract_type = /datum/skill/misc
	name = "Misc"
	desc = ""

/datum/skill/misc/athletics
	name = "Athletics"
	desc = "Athletics is a general skill that represents your character's physical fitness. The higher your skill in Athletics, the higher your stamina and energy."
	dreams = list(
		"...you look behind you, and you can see their faces lessen, their silhouettes shrink - until they're only a spec on the horizon...",
		"...your arms move tirelessly... the tool in your hands, it creaks and breaks at the shaft... you sigh and reach for another..."
	)

/datum/skill/misc/climbing
	name = "Climbing"
	desc = "Climbing is a skill that represents your character's ability to scale walls and trees. The higher your skill in Climbing, the faster you can climb and the less damage you'll take while falling."
	dreams = list(
		"...you can feel the blood rush through your body in the freezing rain, scaling the tree rapidly - the figures behind you bicker to one-another... you lost them...",
		"...your right hand slips, and rocks tumble past as the other clinges with all its might. You look down, into the abyss. The bloody heads of your friends fall down the wall, then disappear..."
	)

/datum/skill/misc/reading
	name = "Reading"
	desc = "Reading is a skill that represents your character's ability to read and write. The higher your skill in Reading, better you can read." //Placeholder description, no clue what it does besides minimum reading for signs
	randomable_dream_xp = FALSE

/datum/skill/misc/swimming
	name = "Swimming"
	desc = "Swimming is a skill that represents your character's ability to swim. The higher your skill in Swimming, the faster you can swim and the less energy you'll use while swimming." //Placeholder description, no clue what it does.
	dreams = list(
		"...you fight the current, struggling - the lungs in your body crawling for breath... you go limp, and you let the current guide you..."
	)

/datum/skill/misc/stealing
	name = "Pickpocketing"
	desc = "Pickpocketing is a skill that represents your character's ability to steal from others. The higher your skill in Pickpocketing, the less likely you are to be caught."
	dreams = list(
		"...you sneak past a well-dressed man, stealing an elaborate dagger from his waist... when you get home and unsheathe it, you stare at his reflection on the blade...",
		"",
		""
	)

/datum/skill/misc/sneaking
	name = "Sneaking"
	desc = "Sneaking is a skill that represents your character's ability to move quietly and unseen. The higher your skill in Sneaking, the better you can hide in shadows."
	dreams = list(
		"...you're running as fast as you can, hearing the clatter of armor rapidly approaching... you round the corner, hug the wall, and close your eyes...",
		"...you lower your left foot, slowly, carefuly... the undergrowth crackles, you look up to the side... the beast grumbles and raises its head...",
		""
	)

/datum/skill/misc/lockpicking
	name = "Lockpicking"
	desc = "Lockpicking is a skill that represents your character's ability to pick locks. The higher your skill in Lockpicking, the faster you can pick locks and the less likely you are to break your tools." //Actually no idea if you can pick faster or not. Placeholder
	dreams = list(
		"...clatter, click-... click... clack! the door opens, the glint of the iron lock is replaced with a green eye staring down a crossbow... clatter, click... click... clack...!",
		""
	)

/datum/skill/misc/riding
	name = "Riding"
	desc = "Riding is a skill that represents your character's ability to ride animals. The higher your skill in Riding, the less likely you are to be thrown off your mount."
	dreams = list(
		"...you give the heels to your Saiga... it hurries further, it jumps, it crosses the obstacle... your arm jolts back, the lance struck its target...",
		"...the rhythmic clacking of hooves on pavement lull you into a dreamless sleep... you startle awake to the sound of crumbling bones... you raise your head and stare upon the hill of skulls...",
		"...your saiga hurries along the path... the fugitive stumbles and falls... you smile, and spur your steed..."
	)
/*
⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠗⣪⣵⣶⠞⣃⣄⡻⠇⣿⣿⣿⣿⣿⣶⣿⡇⣿⣿
⢸⣿⣿⣿⣿⣿⣿⣿⣿⡿⢡⣾⣿⣿⠁⠚⠧⠿⠛⠜⢸⣿⣿⣿⣿⡏⣿⡇⣿⣿
⢸⣿⣿⣿⣿⣿⣿⣿⣿⡇⣿⡿⣛⣋⢅⣤⣷⡯⣥⣒⠎⣙⡛⠿⠿⠿⢋⡇⣿⣿
⢨⣭⣭⣭⣭⣭⣭⣭⣭⢡⣴⣾⠏⣴⣯⣍⠻⣿⣮⠻⢷⣌⢻⣧⢰⣶⡟⡅⣿⣿
⢸⣿⣿⣿⣿⣿⣿⡿⣥⣾⣿⠇⣾⢿⣧⣤⣤⣌⡟⢳⠿⠛⠀⣿⠸⢋⣼⣧⣛⣻
⢈⣉⣉⣉⣉⣉⢉⠁⣿⣿⠏⣾⢟⣨⣛⠻⣛⣻⡻⣿⣶⣮⢐⢡⣾⡈⣿⣿⣿⣿
⢀⣠⣤⣶⣶⡶⢒⠀⠿⡿⢸⡏⠼⢢⡩⣅⠈⢹⣿⢿⡛⢗⢸⢘⣟⣣⣛⣛⣛⣛
⢸⣿⣿⣿⡿⣣⣿⢿⡷⣭⠘⡀⠐⣻⣷⠪⣛⠦⣤⣤⣬⡤⢠⡈⢼⣇⣿⣿⣿⣿
⢸⣿⣿⡟⣰⣿⣿⣦⡛⢷⣾⣿⠡⣿⣿⣿⣶⣿⣷⣶⠶⣶⣆⢩⢸⣿⣿⣿⣿⣿
⢸⣿⣿⢱⣿⣿⣿⣿⣿⡦⠙⣿⣟⠹⣿⣿⣿⣿⣯⣷⣿⣿⢣⣿⡇⢿⣿⣿⣿⣿
⢸⣿⡏⣿⣿⣿⣿⣿⠟⣵⣷⠹⣿⣷⣤⣉⣥⣛⠘⣋⠛⢣⣿⣿⡇⣠⡹⣿⣿⣿
⢸⣿⣧⠻⣿⣿⡿⢋⣾⣿⣿⣧⠹⠿⡿⠿⢿⣿⠿⢋⣔⣻⠿⣫⣾⣿⣿⡌⢿⣿
*/

/datum/skill/misc/music
	name = "Music"
	desc = "Music is a skill that represents your character's ability to play musical instruments. The higher your skill in Music, the better you can play. Bards can use higher skills for better effects!"
	dreams = list(
		"...you bang your open palm against the top of the drum, the sound of warfare clattering all about you... you march forward, screaming to your brethren to continue... you feel a bolt bite your chest, and yet your heart still beats...",
		"...you get up on the stage. Your fingers play with the strings, then they glide through your palm... the smell of roses still clings to her hair...",
		"...the campfire cackles and taunts you with its dance... your clench your fists around the guitar's neck. Blood runs down the strings... the instrument hits the firewood, and the flames embrace it with an intimate hug..."
	)

/datum/skill/misc/medicine
	name = "Medicine"
	desc = "Medicine is a skill that represents your character's ability to perform medicine on others. The higher your skill in Medicine, the better you can treat your patients and the faster you can perform surgery on them."
	dream_cost_base = 3
	dreams = list(
		"...your hands move with practiced precision, needle and thread dancing through torn flesh like a tailor at their loom... the scent of blood and old herbs clings to you as you whisper a prayer to stave off infection... the battle rages on, but your patient will not fall today...",
		"...the stench of rot and death is overwhelming... You press the searing cautery on the wound. The aroma of burning flesh first joins the mix, then overtakes entirely as the corpse bursts into flames...",
		"...the arrow pierced the chest, but only hit a bone... the wound is not fatal... you cut out the flesh, cut out the shaft, cut out the heart..."
	)

/datum/skill/misc/sewing
	name = "Sewing"
	desc = "Sewing is a skill that represents your character's ability to sew. The higher your skill in Sewing, the faster you can sew and the better your creations will be." //Placeholder description.
	dreams = list(
		"...the needle goes through the cloth, in-and-out... then it's hide... then it's a man's flesh... you blink, the dress is done... the queen will love it...",
		"...your fingers trace over the shirt's intricate patterns... silvery-silk, gilded threads, red blood... with a heavy sigh, you grab your needle, and you get to mending the jagged hole...",
		"...your hands tirelessly work the loom... your thread runs out, you grab your scissors. You cut open your belly, and pull out your entrails..."
	)
