//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("You now can easily see in the dark.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_LESSER_NV_TRAIT
	eyes.Insert(character)

/datum/special_trait/thickskin
	name = "Tough"
	greet_text = span_notice("You feel it. Thick Skin. Dense Flesh. Durable Bones. You are a punch-taking machine.")
	weight = 100

/datum/special_trait/thickskin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BREADY, "[type]")
	character.change_stat("constitution", 2)

/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("You feel like you don't need to eat anymore, and your veins feel empty... Is this normal?")
	weight = 25

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")

/datum/special_trait/value
	name = "Coin Counter"
	greet_text = span_notice("You now know how to estimate a item's value.")
	weight = 100
	restricted_traits = list(TRAIT_SEEPRICES)

/datum/special_trait/value/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")

/datum/special_trait/lightstep
	name = "Light Step"
	greet_text = span_notice("I am quiet, nobody can hear my steps.")
	weight = 100

/datum/special_trait/lightstep/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")

//positive
/datum/special_trait/duelist
	name = "Swordmaster Apprentice"
	greet_text = span_notice("You were the student of a legendary sword master, your skill is rivalled by few!")
	weight = 100

/datum/special_trait/duelist/on_apply(mob/living/carbon/human/character, silent)
	character.cmode_music = 'sound/music/combat_duelist.ogg'
	character.change_stat("speed", 2)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE) //will make a unique trait later on
	var/obj/item/rapier = new /obj/item/rogueweapon/sword/rapier(get_turf(character))
	if(!character.equip_to_appropriate_slot(rapier))
		character.put_in_hands(rapier, TRUE)

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("You have always picked up on languages easily, even those that are forbidden to mortals.")
	weight = 100

/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/beast)

/datum/special_trait/civilizedbarbarian
	name = "Tavern Brawler"
	greet_text = span_notice("You are skilled at using Improvised Weapons and your fists feel heavier!")

/datum/special_trait/civilizedbarbarian/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CIVILIZEDBARBARIAN, TRAIT_GENERIC) //Need to make trait improve hitting people with chairs, mugs, goblets.

/datum/special_trait/mastercraftsmen
	name = "Master Crasftman"
	greet_text = "In your youth, you decided you'd get a grasp on every trade, and pursued the 10 arts of the craft."
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/masonry, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)

/datum/special_trait/bleublood
	name = "Noble Lineage"
	greet_text = span_notice("You come are of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)

/datum/special_trait/bleublood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")

/datum/special_trait/innocent
	name = "Remorseful"
	//no greet text, silent.

/datum/special_trait/innocent/on_apply(mob/living/carbon/human/character, silent)


//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("You've always been called a giant. You are valued for your stature, but, this world made for smaller folk has forced you to move cautiously.")
	restricted_races = list(/datum/species/anthromorphsmall, /datum/species/dwarf/mountain, /datum/species/kobold)

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat("strength", 2)
	character.change_stat("constitution", 1)
	character.change_stat("speed", -2)
	character.transform = character.transform.Scale(1.15, 1.15)
	character.update_transform()

//negative
/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_notice("You've been denounced by the church for either reasons legitimate or not! A strange sympathetic noble from a nearby mountain manor has given you some coin to aid you in these times.")

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name
	var/obj/item/pouch = new /obj/item/storage/belt/rogue/pouch/coins/rich(get_turf(character))
	if(!character.equip_to_appropriate_slot(pouch))
		character.put_in_hands(pouch, TRUE)

/datum/special_trait/sillyvoice
	name = "Annoying"
	greet_text = span_sans("People really hate your voice for some reason.")

/datum/special_trait/sillyvoice/on_apply((mob/living/carbon/human/character))
	ADD_TRAIT(character, TRAIT_COMICSANS, "[type]")
	character.dna.add_mutation(WACKY)

/datum/special_trait/debtevasion
	name = "Loanshark"
	greet_text = span_warning("You took out a massive loan from the Keep. But, that was awhile ago, and you have most of the money still, just not the amount they might be hoping for.")

/datum/special_trait/bathcarrier
	name = "Lover's Itch"
	greet_text = span_love("Baotha has made you a carrier of Lover's Itch. For every person you spread it to, you will have triumphed against the world.")

/datum/special_trait/bathcarrier/on_apply(mob/living/carbon/human/character)

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("You are quite rebellous for princess. Screw Noble Customs!")
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/roguetown/prince)

/datum/special_trait/punkprincess/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.head)
	character.equip_to_slot_or_del(new /obj/item/clothing/under/roguetown/tights/random(character), SLOT_PANTS)
	character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/shirt/undershirt/guard(character), SLOT_SHIRT)
	character.equip_to_slot_or_del(new /obj/item/clothing/suit/roguetown/armor/chainmail(character), SLOT_ARMOR)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/leather(character), SLOT_BELT)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/rogue/pouch/coins/rich(character), SLOT_BELT_R)
	character.equip_to_slot_or_del(new /obj/item/storage/backpack/rogue/satchel(character), SLOT_BACK_R)
	character.mind.adjust_skillrank(/datum/skill/combat/maces, 1, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/reading, -2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/sneaking, -2, TRUE)
	character.mind.adjust_skillrank(/datum/skill/misc/stealing, -2, TRUE)