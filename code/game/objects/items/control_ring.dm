GLOBAL_LIST_EMPTY(submission_collars)

// Returns associative list from real name to collar ref
/proc/get_all_control_ring_subjects(submission_id)
	var/list/subjects = list()
	for(var/obj/item/clothing/neck/roguetown/gorget/submission_collar/collar as anything in GLOB.submission_collars)
		if(!collar.collar_locked)
			continue
		if(collar.submission_id != submission_id)
			continue
		var/atom/location = collar.loc
		if(!ishuman(location))
			continue
		var/mob/living/carbon/human/subject = location
		subjects[subject.real_name] = collar
	return subjects

/obj/item/clothing/ring/control_ring
	name = "control ring"
	desc = "Point to those whom you control, and they will feel your will with great pain"
	icon_state = "ring_s"
	var/submission_id = null
	var/next_shock = 0
	var/next_remote = 0
	var/static/next_random_id = 0

/obj/item/clothing/ring/control_ring/Initialize()
	. = ..()
	if(!submission_id)
		next_random_id++
		submission_id = "random[next_random_id]"

/obj/item/clothing/ring/control_ring/attack(mob/M, mob/user, def_zone)
	if(ishuman(M) && ishuman(user))
		var/mob/living/carbon/human/attacked = M
		var/mob/living/carbon/human/ringbearer = user
		var/obj/item/clothing/neck/roguetown/gorget/submission_collar/collar = locate(/obj/item/clothing/neck/roguetown/gorget/submission_collar) in attacked
		if(!collar)
			return
		if(!collar.collar_locked)
			return
		if(collar.submission_id != submission_id)
			return
		var/arcane_skill = ringbearer.mind.get_skill_level(/datum/skill/magic/arcane)
		if(arcane_skill < 5)
			to_chat(ringbearer, span_warning("I don't know such advanced arcane magic"))
			return
		attacked.visible_message(span_warning("[attacked]'s collar unlocks!"))
		collar.set_lock_state(FALSE)
		collar.submission_id = null
		return
	. = ..()

/obj/item/clothing/ring/control_ring/attack_self(mob/user)
	. = ..()
	if(next_remote > world.time)
		to_chat(user, span_info("The [name] is not ready yet"))
		return
	var/list/subjects = get_all_control_ring_subjects(submission_id)
	if(!length(subjects))
		return
	var/chosen_name = input(user, "Punish them", "Control Ring") as null|anything in subjects
	if(!chosen_name)
		return
	var/obj/item/clothing/neck/roguetown/gorget/submission_collar/collar = subjects[chosen_name]
	if(collar.try_shocking_wearer(null, user, src, 5 SECONDS, TRUE))
		next_remote = world.time + 5 MINUTES

/obj/item/clothing/neck/roguetown/gorget/submission_collar
	name = "submission collar"
	desc = "Magically enchanted collar. Non-obedient wearers may feel a painful shock."
	var/submission_id = null
	var/any_ring_shocks = FALSE
	var/collar_locked = FALSE
	var/last_shock = 0
	var/starts_locked = FALSE

/obj/item/clothing/neck/roguetown/gorget/submission_collar/Initialize()
	. = ..()
	GLOB.submission_collars += src
	if(starts_locked)
		set_lock_state(TRUE)

/obj/item/clothing/neck/roguetown/gorget/submission_collar/Destroy()
	GLOB.submission_collars -= src
	. = ..()

/obj/item/clothing/neck/roguetown/gorget/submission_collar/equipped(mob/user, slot)
	. = ..()
	if(slot == SLOT_NECK)
		RegisterSignal(user, COMSIG_ATOM_POINTED_AT, PROC_REF(on_pointed))

/obj/item/clothing/neck/roguetown/gorget/submission_collar/dropped(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(H.get_item_by_slot(SLOT_NECK) == src)
		UnregisterSignal(user, COMSIG_ATOM_POINTED_AT)
	set_lock_state(FALSE)
	submission_id = null

/obj/item/clothing/neck/roguetown/gorget/submission_collar/proc/on_pointed(atom/movable/source, mob/pointer)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/wearer = source
	var/obj/item/clothing/ring/control_ring/ring = locate(/obj/item/clothing/ring/control_ring) in pointer
	if(!ring)
		return
	// If it's an unbound collar, bind it with the first point
	if(!submission_id)
		submission_id = ring.submission_id
	if(!any_ring_shocks && (submission_id != ring.submission_id))
		return
	if(!collar_locked)
		// Lock if not locked
		log_combat(pointer, wearer, "locked collar with control ring")
		wearer.visible_message(span_warning("[wearer]'s collar locks itself tight!"))
		set_lock_state(TRUE)
	else
		// Else try shocking!!!
		try_shocking_wearer(wearer, pointer, ring, 5 SECONDS, FALSE)

/obj/item/clothing/neck/roguetown/gorget/submission_collar/proc/try_shocking_wearer(mob/living/carbon/human/wearer, mob/living/carbon/human/pointer, obj/item/clothing/ring/control_ring/ring, shock_cooldown, remote)
	if(!collar_locked)
		return
	if(!wearer)
		wearer = loc
	if(ring.next_shock > world.time)
		to_chat(pointer, span_info("The [ring.name] is recharging"))
		return FALSE
	if(last_shock + 20 SECONDS > world.time)
		to_chat(pointer, span_info("The [name] is not responding"))
		return FALSE
	do_sparks(1, TRUE, wearer)
	to_chat(wearer, span_warning("You feel a sharp shock from the collar!"))
	//wearer.Knockdown(20)
	//wearer.Stun(30)
	wearer.electrocute_act(5, src)
	last_shock = world.time
	ring.next_shock = world.time + shock_cooldown
	if(remote)
		log_combat(pointer, wearer, "shocked with control ring remotely")
	else
		log_combat(pointer, wearer, "shocked with control ring")
	return TRUE

/obj/item/clothing/neck/roguetown/gorget/submission_collar/proc/set_lock_state(new_state)
	if(collar_locked == new_state)
		return
	collar_locked = new_state
	if(collar_locked)
		ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
	else
		REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)
