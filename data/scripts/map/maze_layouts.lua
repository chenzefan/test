require("constants")

local StaticLayout = require("map/static_layout")
local RoomLayouts = 
	{
		["SINGLE_NORTH"] = 	StaticLayout.Get("map/static_layouts/rooms/room/one",	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_EAST"] = 	StaticLayout.Get("map/static_layouts/rooms/room/one",	{force_rotation = LAYOUT_ROTATION.EAST}),
		["L_NORTH"] = 		StaticLayout.Get("map/static_layouts/rooms/room/two", 		{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_SOUTH"] = 	StaticLayout.Get("map/static_layouts/rooms/room/one",	{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["TUNNEL_NS"] = 	StaticLayout.Get("map/static_layouts/rooms/room/long", 		{force_rotation = LAYOUT_ROTATION.NORTH}),
		["L_EAST"] = 		StaticLayout.Get("map/static_layouts/rooms/room/two",		{force_rotation = LAYOUT_ROTATION.EAST}),
		["THREE_WAY_N"] = 	StaticLayout.Get("map/static_layouts/rooms/room/three", 	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_WEST"] = 	StaticLayout.Get("map/static_layouts/rooms/room/one",	{force_rotation = LAYOUT_ROTATION.WEST}),
		["L_WEST"] = 		StaticLayout.Get("map/static_layouts/rooms/room/two",		{force_rotation = LAYOUT_ROTATION.WEST}),
		["TUNNEL_EW"] = 	StaticLayout.Get("map/static_layouts/rooms/room/long",		{force_rotation = LAYOUT_ROTATION.EAST}),
		["THREE_WAY_W"] = 	StaticLayout.Get("map/static_layouts/rooms/room/three",		{force_rotation = LAYOUT_ROTATION.WEST}),
		["L_SOUTH"] = 		StaticLayout.Get("map/static_layouts/rooms/room/two",		{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["THREE_WAY_S"] = 	StaticLayout.Get("map/static_layouts/rooms/room/three",		{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["THREE_WAY_E"] = 	StaticLayout.Get("map/static_layouts/rooms/room/three",		{force_rotation = LAYOUT_ROTATION.EAST}),
		["FOUR_WAY"] = 		StaticLayout.Get("map/static_layouts/rooms/room/four", 		{force_rotation = LAYOUT_ROTATION.NORTH}),
	}
local HallwayLayouts = 
	{
		["SINGLE_NORTH"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/one",	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_EAST"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/one",	{force_rotation = LAYOUT_ROTATION.EAST}),
		["L_NORTH"] = 		StaticLayout.Get("map/static_layouts/rooms/hallway/two", 	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_SOUTH"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/one",	{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["TUNNEL_NS"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/long", 	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["L_EAST"] = 		StaticLayout.Get("map/static_layouts/rooms/hallway/two",	{force_rotation = LAYOUT_ROTATION.EAST}),
		["THREE_WAY_N"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/three", 	{force_rotation = LAYOUT_ROTATION.NORTH}),
		["SINGLE_WEST"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/one",	{force_rotation = LAYOUT_ROTATION.WEST}),
		["L_WEST"] = 		StaticLayout.Get("map/static_layouts/rooms/hallway/two",	{force_rotation = LAYOUT_ROTATION.WEST}),
		["TUNNEL_EW"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/long",	{force_rotation = LAYOUT_ROTATION.EAST}),
		["THREE_WAY_W"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/three",	{force_rotation = LAYOUT_ROTATION.WEST}),
		["L_SOUTH"] = 		StaticLayout.Get("map/static_layouts/rooms/hallway/two",	{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["THREE_WAY_S"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/three",	{force_rotation = LAYOUT_ROTATION.SOUTH}),
		["THREE_WAY_E"] = 	StaticLayout.Get("map/static_layouts/rooms/hallway/three",	{force_rotation = LAYOUT_ROTATION.EAST}),
		["FOUR_WAY"] = 		StaticLayout.Get("map/static_layouts/rooms/hallway/four", 	{force_rotation = LAYOUT_ROTATION.NORTH}),
	}

return {Layouts = RoomLayouts, Alternate0 = HallwayLayouts}
