/datum/job/roguetown/longshoreman
	title = "Longshoreman"
	flag = LONGSHOREMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	selection_color = JCOLOR_SOLDIER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(/datum/species/akula)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	allowed_patrons =  list(/datum/patron/divine/abyssor)
	tutorial = "YARR HARR."
	display_order = JDO_TOWNGUARD
	whitelist_req = TRUE

	outfit = /datum/outfit/job/roguetown/longshoreman
	give_bank_account = 12
	min_pq = 2
	max_pq = null
	cmode_music = 'sound/music/combat_guard.ogg'

/datum/outfit/job/roguetown/longshoreman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/cutlass
	beltl = /obj/item/rogueweapon/huntingknife/idagger/steel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/maces, pick(3,4), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE) 
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2) 
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

