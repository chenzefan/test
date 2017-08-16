require("map/level")

----------------------------------
-- Cave levels
----------------------------------

AddLevel(LEVELTYPE.CAVE, {
		id="CAVE_LEVEL_1",
		name="CAVE_LEVEL_1",
		overrides={
			{"world_size", 		"tiny"},
			{"day", 			"onlynight"}, 
			{"waves", 			"off"},
			{"location",		"cave"},
			{"boons", 			"never"},
			{"poi", 			"never"},
			{"traps", 			"never"},
			{"protected", 		"never"},
			{"start_setpeice", 	"CaveStart"},
			{"start_node",		"BGSinkholeRoom"},
		},
		tasks={
			"CavesStart",
			"CavesAlternateStart",
			"FungalBatCave",
			"BatCaves",
			"TentacledCave",
			"LargeFungalComplex",
			"SingleBatCaveTask",
			"RabbitsAndFungs",
			"FungalPlain",
			"Cavern",
		},
		numoptionaltasks = 1,
		optionaltasks = {
			"CaveBase",
			"MushBase",
			"SinkBase",
			"RabbitTown",
		},
		-- override_triggers = {
		-- 	["CavesStart"] = {	
		-- 		{"ColourCube", "sinkhole_cc"}, 
		-- 	},
		-- 	["CavesAlternateStart"] = {	
		-- 		{"ColourCube", "sinkhole_cc"}, 
		-- 	},
		-- 	["BatCaves"] = {	
		-- 		{"ColourCube", "caves_default"}, 
		-- 	},	
		-- 	["Cavern"] = {	
		-- 		{"ColourCube", "caves_default"}, 
		-- 	},	
		-- 	["SingleBatCaveTask"] = {	
		-- 		{"ColourCube", "caves_default"}, 
		-- 	},	
		-- 	["TentacledCave"] = {	
		-- 		{"ColourCube", "caves_default"}, 
		-- 	},
		-- 	["LargeFungalComplex"] = {	
		-- 		{"ColourCube", "fungus_cc"}, 
		-- 	},
		-- 	["FungalBatCave"] = {	
		-- 		{"ColourCube", "fungus_cc"}, 
		-- 	},
		-- 	["RabbitsAndFungs"] = {	
		-- 		{"ColourCube", "fungus_cc"}, 
		-- 	},
		-- 	["FungalPlain"] = {	
		-- 		{"ColourCube", "fungus_cc"}, 
		-- 	},
		-- },
	})

AddLevel(LEVELTYPE.CAVE, {
		id="CAVE_LEVEL_2",
		name="CAVE_LEVEL_2",
		overrides={
			{"world_size", 		"tiny"},
			{"day", 			"onlynight"}, 
			{"waves", 			"off"},
			{"location",		"cave"},
			{"boons", 			"never"},
			{"poi", 			"never"},
			{"traps", 			"never"},
			{"protected", 		"never"},
			{"start_setpeice", 	"RuinsStart"},
			{"start_node",		"BGWilds"},
		},
		tasks={
			"RuinsStart",
			"TheLabyrinth",
			--"CityInRuins",
			--"AlterAhead",
			--"TownSquare",
			"Residential",
			"Military",
			"Sacred",
		},
		numoptionaltasks = math.random(1,2),
		optionaltasks = {
			"MoreAltars",
			"SacredDanger",
			"FailedCamp",
			"Residential2",
			"Residential3",
			"Military2",
			"Sacred2",
		},
		--override_triggers = {
		-- 	["RuinsStart"] = {	
		-- 		{"ColourCube", "ruins_light_cc"}, 
		-- 		-- {"SeasonColourCube", SEASONS.CAVES}, 
		-- 	},
		-- },
		-- 	["TheLabyrinth"] = {	
		-- 		{"SeasonColourCube", "caves_ruins"}, 
		-- 		-- {"SeasonColourCube", 	{	DAY = "images/colour_cubes/ruins_light_cc.tex",
		-- 		-- 							DUSK = "images/colour_cubes/ruins_dim_cc.tex",
		-- 		-- 							NIGHT = "images/colour_cubes/ruins_dark_cc.tex",
		-- 		-- 						},
		-- 						-- }, 
		-- 	},
		-- 	["CityInRuins"] = {	
		-- 		{"SeasonColourCube", "caves_ruins"}, 
		-- 		-- {"SeasonColourCube", 	{	DAY = "images/colour_cubes/ruins_light_cc.tex",
		-- 		-- 							DUSK = "images/colour_cubes/ruins_dim_cc.tex",
		-- 		-- 							NIGHT = "images/colour_cubes/ruins_dark_cc.tex",
		-- 		-- 						},
		-- 		-- 				},
		-- 	},
		-- },
	})
