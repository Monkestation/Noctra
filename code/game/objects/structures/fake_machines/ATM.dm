/obj/structure/fake_machine/atm
	name = "MEISTER"
	desc = "Stores and withdraws currency for accounts managed by the Kingdom."
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "atm"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/fake_machine/atm/attack_hand(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user

	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
		to_chat(H, "<span class='warning'>The idea repulses me!</span>")
		H.cursed_freak_out()
		return

	if(user.real_name in GLOB.outlawed_players)
		say("OUTLAW DETECTED! REFUSING SERVICE!")
		return

	if(H in SStreasury.bank_accounts)
		var/amt = SStreasury.bank_accounts[H]
		if(!amt)
			say("Your balance is nothing.")
			return
		if(amt < 0)
			say("Your balance is NEGATIVE.")
			return
		var/list/choicez = list()
		if(amt >= 10)
			choicez += "GOLD"
		if(amt >= 5)
			choicez += "SILVER"
		if(amt > 1) choicez += "BRONZE"
		var/selection = input(user, "Make a Selection", src) as null|anything in choicez
		if(!selection)
			return
		amt = SStreasury.bank_accounts[H]
		var/mod = 1
		if(selection == "GOLD")
			mod = 10
		if(selection == "SILVER")
			mod = 5
		if(selection == "BRONZE") mod = 1
		var/coin_amt = input(user, "There is [SStreasury.treasury_value] mammon in the treasury. You may withdraw [amt/mod] [selection] COINS from your account.", src) as null|num
		coin_amt = round(coin_amt)
		if(coin_amt < 1)
			return
		amt = SStreasury.bank_accounts[H]
		if(!Adjacent(user))
			return
		if((coin_amt*mod) > amt)
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		if(!SStreasury.withdraw_money_account(coin_amt*mod, H))
			playsound(src, 'sound/misc/machineno.ogg', 100, FALSE, -1)
			return
		budget2change(coin_amt*mod, user, selection)
	else
		to_chat(user, "<span class='warning'>The machine bites my finger.</span>")
		icon_state = "atm-b"
		H.flash_fullscreen("redflash3")
		playsound(H, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
		SStreasury.create_bank_account(H)
		if(H.mind)
			var/datum/job/target_job = SSjob.GetJob(H.mind.assigned_role)
			if(target_job && target_job.noble_income)
				SStreasury.noble_incomes[H] = target_job.noble_income
		spawn(5)
			say("New account created.")
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)

/obj/structure/fake_machine/atm/attackby(obj/item/P, mob/user, params)
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(istype(P, /obj/item/coin))
			if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
				to_chat(H, "<span class='warning'>The idea repulses me!</span>")
				H.cursed_freak_out()
				return

			if(user.real_name in GLOB.outlawed_players)
				say("OUTLAW DETECTED! REFUSING SERVICE!")
				return

			if(H in SStreasury.bank_accounts)
				var/list/deposit_results = SStreasury.generate_money_account(P.get_real_price(), H)
				if(islist(deposit_results))
					if(deposit_results[2] != 0)
						say("Your deposit was taxed [deposit_results[2]] mammon.")
						record_featured_stat(FEATURED_STATS_TAX_PAYERS, H, deposit_results[2])
						record_round_statistic(STATS_TAXES_COLLECTED, deposit_results[2])
				qdel(P)
				playsound(src, 'sound/misc/coininsert.ogg', 100, FALSE, -1)
				return
			else
				say("No account found. Submit your fingers for inspection.")
				return
		if(istype(P, /obj/item/paper/merc_work_onetime))
			var/obj/item/paper/merc_work_onetime/WC = P
			if(!WC.jobsdone)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("This contract is unfinished!")
				return
			if(WC.jobber in SStreasury.bank_accounts)
				var/amt = SStreasury.bank_accounts[WC.jobber]
				if(amt < WC.payment)
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					say("[WC.jobber.real_name] does not have enough funds to pay for this contract.")
					return
				budget2change(WC.payment, user)
				return
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			say("[WC.jobber.real_name] does not have an account.")
			return
		if(istype(P, /obj/item/paper/merc_work_conti/))
			var/obj/item/paper/merc_work_conti/CW = P
			if(!CW.signed)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("This contract is not recognized as legitimate.")
				return
			if(CW.worktime < 1)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("This contract's payment obligations have been fulfilled.")
				return
			if(CW.daycount == GLOB.dayspassed) //if you wait a whole week you won't get your pay, but thats on you.
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("The payment cycle is not in effect.")
				return
			if(CW.jobber in SStreasury.bank_accounts)
				var/amt2 = SStreasury.bank_accounts[CW.jobber]
				if(amt2 < CW.payment)
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					say("[CW.jobber.real_name] does not have enough funds to pay for this contract.")
					return
				budget2change(CW.payment, user)
				return
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			say("[CW.jobber.real_name] does not have an account.")
			return
		if(istype(P, /obj/item/paper/merc_will/adven_will))
			var/obj/item/paper/merc_will/adven_will/AW = P
			if(!AW.yuptheydied || !AW.stewardsigned)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("This... err... 'health insurance' can't be claimed without the proper signatures.")
				return
			H.flash_fullscreen("redflash3")
			playsound(H, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
			if(H != AW.inheretorial)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("You are not the individual in this coverage")
				return
			if(AW.soontodie in SStreasury.bank_accounts)
				var/deadsaccount = SStreasury.bank_accounts[AW.soontodie]
				if(deadsaccount < 0) //generational debt mechanic
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					say("Your acquaintance, [AW.soontodie.real_name] has left you their debt. The crown thanks you, personally, for continuing to pay what is rightfully owned to the crown")
					AW.inheretorial += deadsaccount
					return
				var/list/deposit_results2 = SStreasury.generate_money_account(deadsaccount, H)
				if(islist(deposit_results2))
					if(deposit_results2[2] != 0)
						say("The crown is sorry for your loss... TAX OF [deposit_results2[2]] MAMMONS APPLIED!!")
						record_featured_stat(FEATURED_STATS_TAX_PAYERS, H, deposit_results2[2])
						GLOB.vanderlin_round_stats[STATS_TAXES_COLLECTED] += deposit_results2[2]
				if(AW.yuptheydied in SStreasury.bank_accounts && deadsaccount > 0)
					var/gaffersaccount = SStreasury.bank_accounts[AW.yuptheydied]
					var/gafferscut = deadsaccount * 0.05
					gafferscut = round(gafferscut)
					deadsaccount -= gafferscut
					gaffersaccount += gafferscut
				budget2change(deadsaccount, H)
				qdel(AW)
				return
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			say("[AW.soontodie.real_name] does not have an account to pay out.")
			return
		if(istype(P, /obj/item/paper/merc_will/))
			var/obj/item/paper/merc_will/MW = P
			if(!MW.yuptheydied || !MW.stewardsigned)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("This... err... 'health insurance' can't be claimed without the proper signatures.")
				return
			H.flash_fullscreen("redflash3")
			playsound(H, 'sound/combat/hits/bladed/genstab (1).ogg', 100, FALSE, -1)
			if(H != MW.inheretorial)
				playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
				say("You are not the individual in this coverage")
				return
			if(MW.soontodie in SStreasury.bank_accounts)
				var/deadsaccount = SStreasury.bank_accounts[MW.soontodie]
				if(deadsaccount < 0) //generational debt mechanic
					playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
					say("Your acquaintance, [MW.soontodie.real_name] has left you their debt. The crown thanks you, personally, for continuing to pay what is rightfully owned to the crown")
					MW.inheretorial += deadsaccount
					return
				if(MW.yuptheydied in SStreasury.bank_accounts && deadsaccount > 0)
					var/gaffersaccount = SStreasury.bank_accounts[MW.yuptheydied]
					var/gafferscut = deadsaccount * 0.05
					gafferscut = round(gafferscut)
					deadsaccount -= gafferscut
					gaffersaccount += gafferscut
				budget2change(deadsaccount, H)
				qdel(MW)
				return
			playsound(src, 'sound/misc/machinetalk.ogg', 100, FALSE, -1)
			say("[MW.soontodie.real_name] does not have an account to pay out.")
			return
	return ..()

/obj/structure/fake_machine/atm/examine(mob/user)
	. += ..()
	. += span_info("The current tax rate on deposits is [SStreasury.tax_value * 100] percent. Kingdom nobles exempt.")
