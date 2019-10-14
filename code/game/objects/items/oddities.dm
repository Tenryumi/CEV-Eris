//This is set of item created to work with Eris stat and perk systems
//The idea here is simple, you find oddities in random spawners, you use them, and they grant you stats, or even perks.
//After use, the object is claimed, and cannot be used by someone else
//If rebalancing is needed, keep in mind spawning rate of those items, it might be good idea to change that as well
//Clockrigger 2019

#define MINIMUM_ODDITY_STAT 2

/obj/item/weapon/oddity
	name = "Oddity"
	desc = "Strange item of uncertain origin."
	icon = 'icons/obj/oddities.dmi'
	icon_state = "gift3"
	item_state = "electronic"
	w_class = ITEM_SIZE_SMALL
	var/claimed = FALSE

//You choose what stat can be increased, and a maximum value that will be added to this stat
//The minimum is defined above. The value of change will be decided by random
//As for perks, the second number in associated list will be a chance to get it
	var/list/oddity_stats
	var/list/oddity_perks


/obj/item/weapon/oddity/attack_self(mob/user as mob)

	if(claimed)
		to_chat(user, SPAN_NOTICE("This item is already someone's inspiration."))
		return FALSE

	if(!ishuman(user))
		to_chat(user, SPAN_NOTICE("There is no value in this item for you"))
		return FALSE

	if(oddity_stats)
		var/chosen_stat = pick(oddity_stats)
		var/stat_change = rand (2, oddity_stats[chosen_stat])
		user.stats.changeStat(chosen_stat, stat_change)
		claim(user)
		to_chat(user, SPAN_NOTICE("Something sparks in your mind as you examine the [initial(name)]. A brief moment of understanding to this item's past granting you insight to a bigger picture. \
									Your [chosen_stat] skill is increased by [stat_change]"))

	if(oddity_perks)
		var/chosen_perk = pick(oddity_perks)
		if(prob (oddity_perks[chosen_perk]))
			var/datum/perk/P = new chosen_perk
			P.teach(user.stats)
			claim(user)
			to_chat(user, SPAN_NOTICE("You are now something more. The abillity [P.name] is avalible for you."))

	return TRUE


/obj/item/weapon/oddity/proc/claim(mob/user as mob)
	if(!claimed)
		claimed = TRUE
		name = "[user.name] [name]"
		return TRUE
	else
		return FALSE


//Oddities are separated into categories depending on their origin. They are meant to be used both in maints and derelicts, so this is important
//This is done by subtypes, because this way even densiest code monkey will not able to misuse them
//They are meant to be put in appropriate random spawners

//Common - you can find those everywhere
/obj/item/weapon/oddity/common/blueprint
	name = "strange blueprint"
	desc = "Whoever made this blueprint clearly had no idea what they were doing. The design is impossible to follow and completely impractical. Even an amateur could tell that the machine it details would never work in practice."
	icon_state = "blueprint"
	oddity_stats = list(
		STAT_COG = 5,
		STAT_MEC = 7,
	)

/obj/item/weapon/oddity/common/coin
	name = "strange coin"
	desc = "It appears to be more of a collectible than any sort of actual currency. Strangely enough, it's made from an unidentifiable metal."
	icon_state = "coin"
	oddity_stats = list(
		STAT_ROB = 5,
		STAT_TGH = 5,
	)

/obj/item/weapon/oddity/common/photo_landscape
	name = "alien landscape photo"
	desc = "The arid landscape in this photo seems hostile and dangerous."
	icon_state = "photo_landscape"
	oddity_stats = list(
		STAT_COG = 5,
		STAT_TGH = 5,
	)

/obj/item/weapon/oddity/common/photo_coridor
	name = "surreal maint photo"
	desc = "The corridor in this photograph looks familiar, though something seems wrong about it; as if everything in it was replaced with an exact replica of itself."
	icon_state = "photo_corridor"
	oddity_stats = list(
		STAT_MEC = 5,
		STAT_TGH = 5,
	)

/obj/item/weapon/oddity/common/photo_eyes
	name = "observer photo"
	desc = "Looking at this photo fills you with anxiety..."
	icon_state = "photo_corridor"
	oddity_stats = list(
		STAT_ROB = 6,
		STAT_TGH = 6,
		STAT_VIG = 6,
	)

/obj/item/weapon/oddity/common/old_newspaper
	name = "old newspaper"
	desc = "It contains a report on some old and strange phenomena. Was this just rumormilling, or corporate experiments gone horribly wrong?"
	icon_state = "old_newspaper"
	oddity_stats = list(
		STAT_MEC = 4,
		STAT_COG = 4,
		STAT_BIO = 4,
	)

/obj/item/weapon/oddity/common/paper_crumpled
	name = "turn-out page"
	desc = "The text in this page is ALMOST legible through the folds and crumples."
	icon_state = "paper_crumpled"
	oddity_stats = list(
		STAT_MEC = 6,
		STAT_COG = 6,
		STAT_BIO = 6,
	)

/obj/item/weapon/oddity/common/paper_omega
	name = "collection of obscure reports"
	desc = "Filling these pages is a collection of strange reports by different authors, most of them skeptical about thier findings. Despite this each of their reports are similar in nature, and their findings line up closely with each other..."
	icon_state = "paper_omega"
	oddity_stats = list(
		STAT_MEC = 8,
		STAT_COG = 8,
		STAT_BIO = 8,
	)

/obj/item/weapon/oddity/common/book_eyes
	name = "observer book"
	desc = "This book is structured like an encyclopedia, giving details about artificial creatures created with cybernetic technology. The level of scientific detail put into the writing about them is staggering, almost as if these creatures were real..."
	icon_state = "book_eyes"
	oddity_stats = list(
		STAT_ROB = 9,
		STAT_TGH = 9,
		STAT_VIG = 9,
	)

/obj/item/weapon/oddity/common/book_omega
	name = "occult book"
	desc = "Written into the pages of this tome is absolute madness manifested as vaguely cohesive words, telling stories about worlds and events beyond the comprehension of our simple minds. It's certainly an interesting read at least."
	icon_state = "book_omega"
	oddity_stats = list(
		STAT_BIO = 6,
		STAT_ROB = 6,
		STAT_VIG = 6,
	)

/obj/item/weapon/oddity/common/book_bible
	name = "old bible"
	desc = "Oh, how quickly we forgot."
	icon_state = "book_bible"
	oddity_stats = list(
		STAT_ROB = 5,
		STAT_VIG = 5,
	)

/obj/item/weapon/oddity/common/old_money
	name = "old money"
	desc = "Deprecated currency. Would any organization even accept these any more?"
	icon_state = "old_money"
	oddity_stats = list(
		STAT_ROB = 4,
		STAT_TGH = 4,
	)

/obj/item/weapon/oddity/common/healthscanner
	name = "odd healthscanner"
	desc = "It's fractured and worn away from neglect and time. Its display is stuck showing some incredibly bizarre readings. What did it scan? Was it even human...?"
	icon_state = "healthscanner"
	item_state = "electronic"
	oddity_stats = list(
		STAT_COG = 8,
		STAT_BIO = 8,
	)

/obj/item/weapon/oddity/common/old_pda
	name = "broken pda"
	desc = "An old Nanotrasen-era PDA. In older times, these were standard issue for all NT employees throughout the galaxy."
	icon_state = "old_pda"
	item_state = "electronic"
	oddity_stats = list(
		STAT_COG = 6,
		STAT_MEC = 6,
	)

/obj/item/weapon/oddity/common/towel
	name = "trustworthy towel"
	desc = "Always have it with you."
	icon_state = "towel"
	oddity_stats = list(
		STAT_ROB = 6,
		STAT_TGH = 6,
	)

/obj/item/weapon/oddity/common/teddy
	name = "teddy bear"
	desc = "So long as you hold him tight and keep him close, he will give you comfort and security."
	icon_state = "teddy"
	oddity_stats = list(
		STAT_ROB = 7,
		STAT_TGH = 7,
		STAT_VIG = 7,
	)

/obj/item/weapon/oddity/common/old_knife
	name = "old knife"
	desc = "The dried blood on the dulled edge of this knife almost seems older than the bladde itself. How old is it? You will probably never know the answer."
	icon_state = "old_knife"
	structure_damage_factor = STRUCTURE_DAMAGE_BLADE
	tool_qualities = list(QUALITY_CUTTING = 20,  QUALITY_WIRE_CUTTING = 10, QUALITY_SCREW_DRIVING = 5)
	force = WEAPON_FORCE_DANGEROUS
	attack_verb = list("slashed", "stabbed", "sliced", "torn", "ripped", "diced", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	slot_flags = SLOT_BELT
	sharp = 1
	edge = 1

	oddity_stats = list(
		STAT_ROB = 5,
		STAT_TGH = 5,
		STAT_VIG = 5,
	)

/obj/item/weapon/oddity/common/old_id
	name = "old id"
	desc = "There is a story behind this name. One that will likely remain untold for all time, but given its condition and location it's easy to tell that this story didn't have a happy ending."
	icon_state = "old_id"
	oddity_stats = list(
		STAT_VIG = 9,
	)

/obj/item/weapon/oddity/common/old_radio
	name = "old radio"
	desc = "Close your eyes, bring it closer and listen. You can almost hear it, in the edge of your consciousness. The world is ticking."
	icon_state = "old_radio"
	oddity_stats = list(
		STAT_COG = 9,
		STAT_VIG = 9,
	)

/obj/item/weapon/oddity/common/paper_bundle
	name = "paper bundle"
	desc = "Somewhere beneath all of these scraps, there is truth."
	icon_state = "paper_bundle"
	oddity_stats = list(
		STAT_BIO = 6,
		STAT_ROB = 6,
		STAT_VIG = 6,
	)


#undef MINIMUM_ODDITY_STAT
