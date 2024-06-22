/datum/plant_def
	abstract_type = /datum/plant_def
	/// Name of the plant
	var/name = "Some plant"
	/// Description of the plant
	var/desc = "Sure is a plant."
	var/icon
	var/icon_state
	/// Loot the plant will yield for uprooting it
	var/list/uproot_loot
	/// Time in ticks the plant will require to mature, before starting to make produce
	var/maturation_time = 6 MINUTES
	/// Time in ticks the plant will require to make produce
	var/produce_time = 3 MINUTES
	/// Typepath of produce to make on harvest
	var/produce_type
	/// Amount of produce to make on harvest
	var/produce_amount = 2
	/// How much nutrition will the plant require to mature fully
	var/maturation_nutrition = 30
	/// How much nutrition will the plant require to make produce
	var/produce_nutrition = 20
	/// If not perennial, the plant will uproot itself upon harvesting first produce
	var/perennial = FALSE
	/// Whether the plant is immune to weeds and will naturally deal with them
	var/weed_immune = FALSE
	/// The rate at which the plant drains water, if zero then it'll be able to live without water
	var/water_drain_rate = 3 / (1 MINUTES)

/datum/plant_def/wheat
	name = "wheat stalks"
	icon = 'icons/obj/hydroponics/growing.dmi'
	icon_state = "wheat"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/wheat

/datum/plant_def/oat
	name = "oat stalks"
	icon = 'icons/obj/hydroponics/growing.dmi'
	icon_state = "oat"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/oat

/datum/plant_def/apple
	name = "apple tree"
	icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_state = "apple"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/apple
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE

/datum/plant_def/pipeweed
	name = "westleach leaf"
	icon = 'icons/obj/hydroponics/growing.dmi'
	icon_state = "tobacco"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/pipeweed

/datum/plant_def/sweetleaf
	name = "swampweed"
	icon = 'icons/obj/hydroponics/growing.dmi'
	icon_state = "teaaspera"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/rogue/sweetleaf

/datum/plant_def/berry
	name = "berry bush"
	icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/berries/rogue
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE

/datum/plant_def/berry_poison
	name = "berry bush"
	icon = 'icons/obj/hydroponics/growing_fruits.dmi'
	icon_state = "berry"
	produce_type = /obj/item/reagent_containers/food/snacks/grown/berries/rogue/poison
	uproot_loot = list(/obj/item/grown/log/tree/small)
	perennial = TRUE
