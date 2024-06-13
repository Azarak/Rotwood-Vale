/datum/mutation/human/telepathy
	name = "Telepathy"
	desc = ""
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>I can hear my own voice echoing in my mind!</span>"
	text_lose_indication = "<span class='notice'>I don't hear my mind echo anymore.</span>"
	difficulty = 12
	power = /obj/effect/proc_holder/spell/targeted/telepathy
	instability = 10
	energy_coeff = 1

/datum/mutation/human/firebreath
	name = "Fire Breath"
	desc = ""
	quality = POSITIVE
	difficulty = 12
	locked = TRUE
	text_gain_indication = "<span class='notice'>My throat is burning!</span>"
	text_lose_indication = "<span class='notice'>My throat is cooling down.</span>"
	power = /obj/effect/proc_holder/spell/aimed/firebreath
	instability = 30
	energy_coeff = 1
	power_coeff = 1

/datum/mutation/human/firebreath/modify()
	if(power)
		var/obj/effect/proc_holder/spell/aimed/firebreath/S = power
		S.strength = GET_MUTATION_POWER(src)

/obj/effect/proc_holder/spell/aimed/firebreath
	name = "Fire Breath"
	desc = ""
	school = "evocation"
	charge_max = 600
	clothes_req = FALSE
	range = 20
	projectile_type = /obj/projectile/magic/aoe/fireball/firebreath
	base_icon_state = "fireball"
	action_icon_state = "fireball0"
	sound = 'sound/blank.ogg' //horrifying lizard noises
	active_msg = "You built up heat in my mouth."
	deactive_msg = "You swallow the flame."
	var/strength = 1

/obj/effect/proc_holder/spell/aimed/firebreath/before_cast(list/targets)
	. = ..()
	if(iscarbon(usr))
		var/mob/living/carbon/C = usr
		if(C.is_mouth_covered())
			C.adjust_fire_stacks(2)
			C.IgniteMob()
			to_chat(C,"<span class='warning'>Something in front of my mouth caught fire!</span>")
			return FALSE

/obj/effect/proc_holder/spell/aimed/firebreath/ready_projectile(obj/projectile/P, atom/target, mob/user, iteration)
	if(!istype(P, /obj/projectile/magic/aoe/fireball))
		return
	var/obj/projectile/magic/aoe/fireball/F = P
	switch(strength)
		if(1 to 3)
			F.exp_light = strength-1
		if(4 to INFINITY)
			F.exp_heavy = strength-3
	F.exp_fire += strength

/obj/projectile/magic/aoe/fireball/firebreath
	name = "fire breath"
	exp_heavy = 0
	exp_light = 0
	exp_flash = 0
	exp_fire= 4

/datum/mutation/human/void
	name = "Void Magnet"
	desc = ""
	quality = MINOR_NEGATIVE //upsides and downsides
	text_gain_indication = "<span class='notice'>I feel a heavy, dull force just beyond the walls watching you.</span>"
	instability = 30
	power = /obj/effect/proc_holder/spell/self/void
	energy_coeff = 1
	synchronizer_coeff = 1

/datum/mutation/human/void/on_life()
	if(!isturf(owner.loc))
		return
	if(prob((0.5+((100-dna.stability)/20))) * GET_MUTATION_SYNCHRONIZER(src)) //very rare, but enough to annoy you hopefully. +0.5 probability for every 10 points lost in stability
		new /obj/effect/immortality_talisman/void(get_turf(owner), owner)

/obj/effect/proc_holder/spell/self/void
	name = "Convoke Void" //magic the gathering joke here
	desc = ""
	school = "evocation"
	clothes_req = FALSE
	charge_max = 600
	invocation = "DOOOOOOOOOOOOOOOOOOOOM!!!"
	invocation_type = "shout"
	action_icon_state = "void_magnet"

/obj/effect/proc_holder/spell/self/void/can_cast(mob/user = usr)
	. = ..()
	if(!isturf(user.loc))
		return FALSE

/obj/effect/proc_holder/spell/self/void/cast(mob/user = usr)
	. = ..()
	new /obj/effect/immortality_talisman/void(get_turf(user), user)

/datum/mutation/human/self_amputation
	name = "Autotomy"
	desc = ""
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>My joints feel loose.</span>"
	instability = 30
	power = /obj/effect/proc_holder/spell/self/self_amputation

	energy_coeff = 1
	synchronizer_coeff = 1

/obj/effect/proc_holder/spell/self/self_amputation
	name = "Drop a limb"
	desc = ""
	clothes_req = FALSE
	human_req = FALSE
	charge_max = 100
	action_icon_state = "autotomy"

/obj/effect/proc_holder/spell/self/self_amputation/cast(mob/user = usr)
	if(!iscarbon(user))
		return

	var/mob/living/carbon/C = user
	if(HAS_TRAIT(C, TRAIT_NODISMEMBER))
		return

	var/list/parts = list()
	for(var/X in C.bodyparts)
		var/obj/item/bodypart/BP = X
		if(BP.body_part != HEAD && BP.body_part != CHEST)
			if(BP.dismemberable)
				parts += BP
	if(!parts.len)
		to_chat(usr, "<span class='notice'>I can't shed any more limbs!</span>")
		return

	var/obj/item/bodypart/BP = pick(parts)
	BP.dismember()
