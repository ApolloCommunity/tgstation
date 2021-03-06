// Seeing as none of these will change throughout a round, and we had a fuckton of defines anyways, I made them into defines. For the blood god.
#define TRANSFORM_DISTANCE_MOD 2 // Size/this is maximum distance from SM during burst for transformation to Nucleation
#define BASE_EXPLOSION_RANGE 15
#define EXPLOSION_RANGE_INC_PER_LEVEL 10

var/global/list/datum/sm_control/sm_levels = list(	  new /datum/sm_control/level_1, \
													  new /datum/sm_control/level_2, \
													  new /datum/sm_control/level_3, \
													  new /datum/sm_control/level_4, \
													  new /datum/sm_control/level_5, \
													  new /datum/sm_control/level_6, \
													  new /datum/sm_control/level_7, \
													  new /datum/sm_control/level_8, \
													  new /datum/sm_control/level_9 )
/proc/setSMVar( var/level, var/variable, var/value)
	//Sanity check
	if( level < MIN_SUPERMATTER_LEVEL )
		level = 0

	if( level > MAX_SUPERMATTER_LEVEL )
		level = MAX_SUPERMATTER_LEVEL

	//If level 0 (or lower) was given edit vars in all levels.
	if(level == 0)
		for(var/datum/sm_control/sm_level in sm_levels)
			for(var/V in sm_level.vars)
				if (V == variable)
					sm_level.vars[V] = value
		return
	//Else only edit the level indicated
	else
		var/datum/sm_control/sm_level = sm_levels[level]
		for( var/V in sm_level.vars )
			if( V == variable )
				sm_level.vars[V] = value
				return

	//log_debug("[variable] doesn't exist in sm_levels!")

/proc/getSMVar( var/level, var/variable )
	if( level < MIN_SUPERMATTER_LEVEL )
		level = MIN_SUPERMATTER_LEVEL

	if( level > MAX_SUPERMATTER_LEVEL )
		level = MAX_SUPERMATTER_LEVEL

	var/datum/sm_control/sm_level = sm_levels[level]
	for( var/V in sm_level.vars )
		if( V == variable )
			return sm_level.vars[V] // Return the request variable

	//log_debug("[variable] doesn't exist in sm_levels!")

proc/supermatter_delamination( var/turf/epicenter, var/size = 25, var/smlevel = 1, var/transform_mobs = 0, var/adminlog = 1 )
	spawn(0)
		var/start = world.timeofday
		size = min(size, 128)
		epicenter = get_turf(epicenter)
		if(!epicenter) return

		if(adminlog)
			message_admins("Supermatter delamination with size ([size]) in area [epicenter.loc.name] ([epicenter.x],[epicenter.y],[epicenter.z] - <A HREF='?_src_=holder;adminplayerobservecoodjump=1;X=[epicenter.x];Y=[epicenter.y];Z=[epicenter.z]'>JMP</a>)", "LOG:")
			log_game("Supermatter delamination with size ([size]) in area [epicenter.loc.name] ")

		playsound(epicenter, 'sound/effects/supermatter.ogg', 100, 1, round(size*3,1) )

		//TODO: VWAVE
		new /obj/cell_spawner/v_wave( epicenter, size, smlevel )

		diary << "## Supermatter delamination with size [size]. Took [(world.timeofday-start)/10] seconds."
	return 1


proc/supermatter_convert( var/turf/T, var/transform_mobs = 0, var/level = 1 )
	for( var/mob/item in T.contents )
		if( istype( item, /mob/living ))
			var/mob/living/mob = item
			//TODO: Human-->Supermatter conversion!
			/*
			if( transform_mobs )
				if( ishuman( mob ))
					var/mob/living/carbon/human/M = mob
					if( istype(M.species, /datum/species/human ))
						if( prob( 33 ))
							M.set_species( "Nucleation", 1 )
							*/

			mob.apply_effect( level*15, IRRADIATE )
			mob.ex_act( 3 )

	//TODO: Generate sharts on vwaved floors
	//if( istype( T, /turf/open/floor/ ) && prob( 10 ))
		//TODO: Generate sharts on vwaved floors
		//new /datum/cell_auto_master/supermatter_crystal( T, 0, level )

	for( var/obj/machinery/light/item in T.contents )
		item.stat = BROKEN
		//item.broken()

/mob/proc/smVaporize()
	if( !smSafeCheck() )
		src.dust()
		return 1
	else
		return 0

/mob/proc/smSafeCheck()
	return 0

/mob/living/carbon/human/smSafeCheck()
	//TODO: NUCLEATIONS!
	if(src.gloves)
		if(istype( src.gloves, /obj/item/clothing/gloves/sm_proof ))
			return 1
	//if( isnucleation( src )) // Nucleation's biology doesn't react to this
	//	return 1
	//
	//return 0