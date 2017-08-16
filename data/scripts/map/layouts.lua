require("constants")

local StaticLayout = require("map/static_layout")
local ExampleLayout = 
	{
		["Farmplot"] = 
						{
							-- Choose layout type
							type = LAYOUT.STATIC,
							
							-- Add any arguments for the layout function
							args = nil,
							
							-- Define a choice list for substitution below
							defs = 
								{
								 	unknown_plant = { "carrot_planted","flower", "grass", "berrybush2" },
								},
							
							-- Lay the objects in whatever pattern
							layout = 
								{
									unknown_plant = {
													 {x=-1,y=-1}, {x=0,y=-1}, {x=1,y=-1},
													 {x=-1, y=0}, {x=0, y=0}, {x=1, y=0},
													 {x=-1, y=1}, {x=0, y=1}, {x=1, y=1}
													},
								},
								
							-- Either choose to specify the objects positions or a number of objects
							count = nil,
								
							-- Choose a scale on which to place everything
							scale = 0.3
						},
		["StoneHenge"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							defs = 
								{
								 	unknown_plant = { "rock2", "rock1", "evergreen_tall", "evergreen_normal", "evergreen_short", "sapling"},
								},
							count = 
								{
									unknown_plant = 9,
								},
							scale = 1.2
						},						 
		["CropCircle"] = 
						{
							type = LAYOUT.CIRCLE_RANDOM,
							defs = 
								{
								 	unknown_plant = { "carrot_planted", "grass", "flower", "berrybush2"},
								},
							count = 
								{
									unknown_plant = 15,
								},
							scale = 1.5
						},
		["TreeFarm"] = 
						{
							type = LAYOUT.GRID,
							count = 
								{
									evergreen_short = 16,
								},
							scale = 0.9
						},
		["MushroomRingSmall"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							defs = 
								{
								 	unknown_plant = { "red_mushroom", "green_mushroom", "blue_mushroom"},
								},
							count = 
								{
									unknown_plant = 7,
								},
							scale = 1
						},
		["MushroomRingMedium"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							defs = 
								{
								 	unknown_plant = { "red_mushroom", "green_mushroom", "blue_mushroom"},
								},
							count = 
								{
									unknown_plant = 10,
								},
							scale = 1.2
						},
		["MushroomRingLarge"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							defs = 
								{
								 	unknown_plant = { "red_mushroom", "green_mushroom", "blue_mushroom"},
								},
							count = 
								{
									unknown_plant = 15,
								},
							scale = 1.5
						},
		["SimpleBase"] = StaticLayout.Get("map/static_layouts/simple_base", {
							areas = {
								construction_area = function() return PickSome(2, { "birdcage", "cookpot", "firepit", "homesign", "beebox", "meatrack", "icebox", "tent" }) end,
							},
						}),
		["RuinedBase"] = StaticLayout.Get("map/static_layouts/ruined_base", {
							areas = {
								construction_area = function() return PickSome(2, { "birdcage", "cookpot", "firepit", "homesign", "beebox", "meatrack", "icebox", "tent" }) end,
							},
						}),
		["Grotto"] = StaticLayout.Get("map/static_layouts/grotto"),


		["ResurrectionStone"] = StaticLayout.Get("map/static_layouts/resurrectionstone"),
		-- Need to have a separate import of the same object so that we can reference it twice
		-- from levels.lua -> set_pieces. This needs to be fixed.
		["ResurrectionStone_2"] = StaticLayout.Get("map/static_layouts/resurrectionstone"),

		["WesUnlock"] = StaticLayout.Get("map/static_layouts/wes_unlock", {
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN,
						}),

		
--------------------------------------------------------------------------------
-- MacTusk 
--------------------------------------------------------------------------------
		["MacTuskTown"] = StaticLayout.Get("map/static_layouts/mactusk_village"),
		["MacTuskCity"] = StaticLayout.Get("map/static_layouts/mactusk_city", {
							start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER
						}),

--------------------------------------------------------------------------------
-- Pigs 
--------------------------------------------------------------------------------
		["MaxMermShrine"] = StaticLayout.Get("map/static_layouts/maxwell_merm_shrine"),

		["MaxPigShrine"] = StaticLayout.Get("map/static_layouts/maxwell_pig_shrine"),
		["VillageSquare"] = 
						{
							type = LAYOUT.RECTANGLE_EDGE,
							count = 
								{
									pighouse = 8,
								},
							scale = 0.5
						},
		["PigTown"] = StaticLayout.Get("map/static_layouts/pigtown"),
		["InsanePighouse"] = StaticLayout.Get("map/static_layouts/insane_pig"),
		["DefaultPigking"] = StaticLayout.Get("map/static_layouts/default_pigking"),
		["TorchPigking"] = StaticLayout.Get("map/static_layouts/torch_pigking"),
		["FisherPig"] = 
						{
							type = LAYOUT.STATIC,
							defs = 
								{
								 	unknown_hanging = { "drumstick", "smallmeat", "monstermeat", "meat"},
								 	unknown_fruit = { "pumpkin", "eggplant", "durian", "pomegranate", "dragonfruit"},
								},
							ground_types = {GROUND.IMPASSABLE, GROUND.WOODFLOOR},
							ground =
								{
									{0, 0, 1, 1, 1, 1, 1, 0},
									{0, 1, 1, 1, 1, 1, 1, 1},
									{0, 1, 1, 1, 1, 1, 1, 1},
									{0, 1, 1, 2, 2, 2, 1, 1},
									{0, 1, 1, 2, 2, 2, 1, 1},
									{0, 1, 1, 2, 2, 2, 1, 1},
									{0, 1, 1, 1, 2, 1, 1, 1},
									{0, 0, 1, 1, 2, 1, 1, 0},
								},
							layout = 
								{
									unknown_fruit = 	{ {x=-0.3, y=   0} },
									pighouse = 			{ {x=   0, y=   0} },
									unknown_hanging =  	{ {x= 0.8, y=-0.5} },
									firepit =  			{ {x=   1, y=   1} },
									wall_wood = {
													 {x=-1.5,y=1.5},{x=-1.25,y=1.5}, {x=-1,y=1.5}, {x=-0.75,y=1.5},       {x=0.75,y=1.5}, {x=1,y=1.5}, {x=1.25,y=1.5}, {x=1.5,y=1.5},
																		 		  {x=-0.5,y=1.75}, {x=0.5,y=1.75},
																		 		  {x=-0.5,y=   2}, {x=0.5,y=   2}, 
																		 		  {x=-0.5,y=2.25}, {x=0.5,y=2.25},
																		 		  {x=-0.5,y= 2.5}, {x=0.5,y= 2.5}, 
																		 		  {x=-0.5,y=2.75}, {x=0.5,y=2.75}, 
																		 		  {x=-0.5,y=   3}, {x=0.5,y=   3}, 
																		 		  {x=-0.5,y=3.25}, {x=0.5,y=3.25}, 
																		 		  {x=-0.5,y= 3.5}, {x=0.5,y= 3.5}, 
												},
								},
							scale = 1 -- scale must be 1 if we set grount tiles
						},
		["SwampPig"] = 
						{
							type = LAYOUT.STATIC,
							defs = 
								{
								 	unknown_bird = { "crow", "robin"},
								 	unknown_fruit = { "pumpkin", "eggplant", "durian", "pomegranate", "dragonfruit"},
								 	unknown_bird = { "carrot_planted","flower", "grass"},
								},
							layout = 
								{
									unknown_plant = {
													 {x=-1,y=-1}, {x=0,y=-1}, {x=1,y=-1},
													 {x=-1,y= 0}, {x=0,y= 0}, {x=1,y= 0},
													 {x=-1,y= 1}, {x=0,y= 1}, {x=1,y= 1}
													},
								},
							scale = 0.3
						},
						
--------------------------------------------------------------------------------
-- Start Nodes 
--------------------------------------------------------------------------------
		["DefaultStart"] = StaticLayout.Get("map/static_layouts/default_start"),
		["NightmareStart"] = StaticLayout.Get("map/static_layouts/nightmare"),
		["BargainStart"] = StaticLayout.Get("map/static_layouts/bargain_start"),
		["ThisMeansWarStart"] = StaticLayout.Get("map/static_layouts/thismeanswar_start"),
		["WinterStartEasy"] = StaticLayout.Get("map/static_layouts/winter_start_easy"),
		["WinterStartMedium"] = StaticLayout.Get("map/static_layouts/winter_start_medium"),
		["WinterStartHard"] = StaticLayout.Get("map/static_layouts/winter_start_hard"),
		["PreSummerStart"] = StaticLayout.Get("map/static_layouts/presummer_start"),
		
--------------------------------------------------------------------------------
-- Chess bits
--------------------------------------------------------------------------------
		
		["ChessSpot1"] = StaticLayout.Get("map/static_layouts/chess_spot", {
								defs={
									evil_thing={"marblepillar","flower_evil","marbletree"},
								},
							}),
		["ChessSpot2"] = StaticLayout.Get("map/static_layouts/chess_spot2", {
								defs={
									evil_thing={"marblepillar","flower_evil","marbletree"},
								},
							}),
		["ChessSpot3"] = StaticLayout.Get("map/static_layouts/chess_spot3", {
								defs={
									evil_thing={"marblepillar","flower_evil","marbletree"},
								},
							}),
		["Maxwell1"] = StaticLayout.Get("map/static_layouts/maxwell_1"),
		["Maxwell2"] = StaticLayout.Get("map/static_layouts/maxwell_2"),
		["Maxwell3"] = StaticLayout.Get("map/static_layouts/maxwell_3"),
		["Maxwell4"] = StaticLayout.Get("map/static_layouts/maxwell_4"),
		["Maxwell5"] = StaticLayout.Get("map/static_layouts/maxwell_5"),
		["Maxwell6"] = StaticLayout.Get("map/static_layouts/maxwell_6"),
		["Maxwell7"] = StaticLayout.Get("map/static_layouts/maxwell_7"),

--------------------------------------------------------------------------------
-- Blockers 
--------------------------------------------------------------------------------
		["TreeBlocker"] = 
						{
							type = LAYOUT.CIRCLE_RANDOM,
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							ground_types = {GROUND.FOREST},
							ground =
								{
									{1,1},{1,1},
									--{0, 0, 1, 1, 0, 0},
									--{0, 1, 1, 1, 1, 0},
									--{1, 1, 1, 1, 1, 1},
									--{1, 1, 1, 1, 1, 1},
									--{0, 1, 1, 1, 1, 0},
									--{0, 0, 1, 1, 0, 0},
								},
							defs = 
								{
								 	trees = { "evergreen_short", "evergreen_normal", "evergreen_tall"},
								},
							count = 
								{
									trees = 185,
								},
							scale = 0.9,
						},
		["RockBlocker"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							ground_types = {GROUND.ROCKY},
							defs = 
								{
								 	rocks = { "rock1", "rock2"},
								},
							count = 
								{
									rocks = 35,
								},
							scale = 1.9,
						},
		["InsanityBlocker"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							ground_types = {GROUND.ROCKY},
							defs = 
								{
								 	rocks = { "insanityrock"},
								},
							count = 
								{
									rocks = 55,
								},
							scale = 4.0,
						},
		["SanityBlocker"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							ground_types = {GROUND.ROCKY},
							defs = 
								{
								 	rocks = { "sanityrock"},
								},
							count = 
								{
									rocks = 55,
								},
							scale = 4.0,
						},
		["InsaneFlint"] = StaticLayout.Get("map/static_layouts/insane_flint"),
		["PigGuards"] = StaticLayout.Get("map/static_layouts/pigguards", {
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER
						}),
		["TallbirdBlocker"] = StaticLayout.Get("map/static_layouts/tallbird_blocker", {
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
						}),
		["SpiderBlocker"] = StaticLayout.Get("map/static_layouts/spider_blocker", {
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
						}),
		["ChessBlocker"] = StaticLayout.Get("map/static_layouts/chess_blocker", {
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
						}),
				
		["MaxwellHome"] = StaticLayout.Get("map/static_layouts/maxwellhome", {
							areas = 
							{
								sav_area = function() return PickSome(2, {"grass","poop"}) end,							
								rock_area = function() return PickSome(3, {"rock1", "rock2", "rocks", "flint"}) end,
								forest_area = function() return PickSome(3, {"evergreen_sparse_normal", "evergreen_sparse_short", "evergreen_stump"}) end,
								swamp_area = function() return PickSome(2, {"marsh_tree", "marsh_bush", "reeds"}) end,
							},
							start_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							disable_transform = true
						}),
				
--------------------------------------------------------------------------------
-- Wormhole 
--------------------------------------------------------------------------------
		-- "Generic" wormholes
		["WormholeGrass"] = StaticLayout.Get("map/static_layouts/wormhole_grass"),

		-- "Fancy" wormholes
		["InsaneEnclosedWormhole"] = StaticLayout.Get("map/static_layouts/insane_wormhole"),
		["InsaneWormhole"] = StaticLayout.Get("map/static_layouts/insanity_wormhole_1"),
		["SaneWormhole"] = StaticLayout.Get("map/static_layouts/sanity_wormhole_1"),
		["SaneWormholeOneShot"] = StaticLayout.Get("map/static_layouts/sanity_wormhole_oneshot"),
		
--------------------------------------------------------------------------------
-- Eyebone 
--------------------------------------------------------------------------------
		["InsaneEyebone"] = StaticLayout.Get("map/static_layouts/insane_eyebone"),

--------------------------------------------------------------------------------
-- TELEPORTATO 
--------------------------------------------------------------------------------
		["TeleportatoBoxLayout"] = StaticLayout.Get("map/static_layouts/teleportato_box_layout"),
		["TeleportatoRingLayout"] = 
						{
							type = LAYOUT.CIRCLE_EDGE,
							start_mask = PLACE_MASK.NORMAL,
							fill_mask = PLACE_MASK.IGNORE_IMPASSABLE_BARREN_RESERVED,
							layout_position = LAYOUT_POSITION.CENTER,
							ground_types = {GROUND.GRASS},
							ground = {
									{0, 1, 1, 1, 0},
									{1, 1, 1, 1, 1},
									{1, 1, 1, 1, 1},
									{1, 1, 1, 1, 1},
									{0, 1, 1, 1, 0},
								},
							count = {
									flower_evil = 15,
								},
							layout = {
									teleportato_ring = { {x=0,y=0} },
								},

							scale = 1,
						},
		["TeleportatoPotatoLayout"] = StaticLayout.Get("map/static_layouts/teleportato_potato_layout"),
		["TeleportatoCrankLayout"] = StaticLayout.Get("map/static_layouts/teleportato_crank_layout"),
		["TeleportatoBaseLayout"] = StaticLayout.Get("map/static_layouts/teleportato_base_layout"),
		["AdventurePortalLayout"] = StaticLayout.Get("map/static_layouts/adventure_portal_layout"),

--------------------------------------------------------------------------------
-- MAX PUZZLE 
--------------------------------------------------------------------------------
		--["SymmetryTest"] = StaticLayout.Get("map/static_layouts/symmetry_test"),
		--["SymmetryTest2"] = StaticLayout.Get("map/static_layouts/symmetry_test2"),
		["test"] = StaticLayout.Get("map/static_layouts/test", {
			areas = {
				area_1 = {"rocks","log"},
				area_2 = {"grass","berrybush"},
			},
		}),
		["MaxPuzzle1"] = StaticLayout.Get("map/static_layouts/MAX_puzzle1"),
		["MaxPuzzle2"] = StaticLayout.Get("map/static_layouts/MAX_puzzle2"),
		["MaxPuzzle3"] = StaticLayout.Get("map/static_layouts/MAX_puzzle3"),
	}

	return {Layouts = ExampleLayout}