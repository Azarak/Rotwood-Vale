// Proc taken from yogstation, credit to nichlas0010 for the original
/client/proc/fix_air(turf/open/T in world)
	set name = "Fix Air"
	set category = "Admin"
	set desc = ""
	set hidden = 1

	if(!holder)
		//to_chat(src, "Only administrators may use this command.")
		return
	return
