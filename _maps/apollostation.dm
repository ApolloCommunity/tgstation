#if !defined(MAP_FILE)

		#define TITLESCREEN "title" //Add an image in misc/fullscreen.dmi, and set this define to the icon_state, to set a custom titlescreen for your map

		#define MINETYPE "lavaland"

		#include "map_files\ApolloStation/apollo_areas.dm"

        #include "map_files\ApolloStation/apollo-1.dmm"
        #include "map_files\generic\z2.dmm"
        #include "map_files\generic\z3.dmm"
        #include "map_files\generic\z4.dmm"
        #include "map_files\generic\lavaland.dmm"
        #include "map_files\generic\z6.dmm"
        #include "map_files\generic\z7.dmm"
        #include "map_files\generic\z8.dmm"
		#include "map_files\generic\z9.dmm"
		#include "map_files\generic\z10.dmm"
		#include "map_files\generic\z11.dmm"

		#define MAP_PATH "map_files/ApolloStation"
        #define MAP_FILE "apollo-1.dmm"
        #define MAP_NAME "Apollo Station"

		#define MAP_TRANSITION_CONFIG DEFAULT_MAP_TRANSITION_CONFIG

#elif !defined(MAP_OVERRIDE)

	#warn a map has already been included, ignoring appollo station.

#endif