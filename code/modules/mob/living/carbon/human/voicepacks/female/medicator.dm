/datum/voicepack/female/medicator/get_sound(soundin, modifiers)
	var/used
	switch(modifiers)
		if("old")
			used = getfold(soundin)
		if("silenced")
			used = getfsilenced(soundin)
	if(!used)
		switch(soundin)
			if("choke")
				used = 'sound/vo/medicator/choke.ogg'
			if("clearthroat")
				used = 'sound/vo/medicator/clearthroat.ogg'
			if("cough")
				used = pick(
					'sound/vo/medicator/cough1.ogg',
					'sound/vo/medicator/cough2.ogg',
					'sound/vo/medicator/cough3.ogg',
					'sound/vo/medicator/cough4.ogg',
					'sound/vo/medicator/cough5.ogg',
					'sound/vo/medicator/cough6.ogg',
					'sound/vo/medicator/cough7.ogg',
					'sound/vo/medicator/cough8.ogg',
				)
			if("cry")
				used = pick('sound/vo/medicator/cry1.ogg', 'sound/vo/medicator/cry2.ogg')
			if("deathgurgle")
				used = 'sound/vo/medicator/deathgurgle.ogg'
			if("firescream")
				used = 'sound/vo/medicator/firescream.ogg'
			if("laugh")
				used = pick('sound/vo/medicator/laugh1.ogg', 'sound/vo/medicator/laugh2.ogg', 'sound/vo/medicator/laugh3.ogg')
			if("painscream")
				used = pick('sound/vo/medicator/painscream1.ogg', 'sound/vo/medicator/painscream2.ogg', 'sound/vo/medicator/painscream3.ogg')
			if("scream")
				used = pick('sound/vo/medicator/scream1.ogg', 'sound/vo/medicator/scream2.ogg')
			if("sigh")
				used = 'sound/vo/medicator/sigh.ogg'
			if("whimper")
				used ='sound/vo/medicator/whimper.ogg'

	if(!used)
		used = ..(soundin, modifiers)

	return used
