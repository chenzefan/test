
local tuning_backups = {}

local function OverrideTuningVariables(tuning)
	for k,v in pairs(tuning) do
		tuning_backups[k] = TUNING[k] 
		TUNING[k] = v
	end
end

local function ResetTuningVariables()
	for k,v in pairs(tuning_backups) do
		TUNING[k] = v
	end
end

local TUNING_OVERRIDES = 
{
	["hounds"] = 	{
						doit = 	function(difficulty)
							--local Hounded = require("components/hounded")

							local hounded = GetWorld().components.hounded
							if hounded then
								if difficulty == "never" then
									hounded:SpawnModeNever()
								elseif difficulty == "always" then
									hounded:SpawnModeHeavy()
								elseif difficulty == "often" then
									hounded:SpawnModeMed()
								elseif difficulty == "rare" then
									hounded:SpawnModeLight()
								end
							end
						end,
					},
	["deerclops"] = 	{
							doit = 	function(difficulty)									
								local basehassler = GetWorld().components.basehassler
								if basehassler then
									if difficulty == "never" then
										basehassler:OverrideAttacksPerSeason("DEERCLOPS", 0)
										basehassler:OverrideAttackDuringOffSeason("DEERCLOPS", false)
										basehassler:OverrideAttackChance("DEERCLOPS", 0)
									elseif difficulty == "rare" then
										basehassler:OverrideAttacksPerSeason("DEERCLOPS", 1)
										basehassler:OverrideAttackDuringOffSeason("DEERCLOPS", false)
										basehassler:OverrideAttackChance("DEERCLOPS", .33)
									elseif difficulty == "often" then
										basehassler:OverrideAttacksPerSeason("DEERCLOPS", 1)
										basehassler:OverrideAttackDuringOffSeason("DEERCLOPS", false)
										basehassler:OverrideAttackChance("DEERCLOPS", 1.1)
										basehassler:OverrideMinSpawnDay("DEERCLOPS", nil)
									elseif difficulty == "always" then
										basehassler:OverrideAttacksPerSeason("DEERCLOPS", 1)
										basehassler:OverrideAttackDuringOffSeason("DEERCLOPS", true)
										basehassler:OverrideAttackChance("DEERCLOPS", 1.1)
										basehassler:OverrideMinSpawnDay("DEERCLOPS", nil)
									end
								end
							end,
						},
	["bearger"] = 	{
							doit = 	function(difficulty)									
								local basehassler = GetWorld().components.basehassler
								if basehassler then
									if difficulty == "never" then
										basehassler:OverrideAttacksPerSeason("BEARGER", 0)
										basehassler:OverrideAttackDuringOffSeason("BEARGER", false)
										basehassler:OverrideAttackChance("BEARGER", 0)
									elseif difficulty == "rare" then
										basehassler:OverrideAttacksPerSeason("BEARGER", 1)
										basehassler:OverrideAttackDuringOffSeason("BEARGER", false)
										basehassler:OverrideAttackChance("BEARGER", .33)
									elseif difficulty == "often" then
										basehassler:OverrideAttacksPerSeason("BEARGER", 1)
										basehassler:OverrideAttackDuringOffSeason("BEARGER", false)
										basehassler:OverrideAttackChance("BEARGER", 1.1)
										basehassler:OverrideMinSpawnDay("BEARGER", nil)
									elseif difficulty == "always" then
										basehassler:OverrideAttacksPerSeason("BEARGER", 1)
										basehassler:OverrideAttackDuringOffSeason("BEARGER", true)
										basehassler:OverrideAttackChance("BEARGER", 1.1)
										basehassler:OverrideMinSpawnDay("BEARGER", nil)
									end
								end
							end,
						},
	["goosemoose"] = 	{
							doit = 	function(difficulty)									
								local basehassler = GetWorld().components.basehassler
								if basehassler then
									if difficulty == "never" then
										basehassler:OverrideAttacksPerSeason("GOOSEMOOSE", 0)
										basehassler:OverrideAttackDuringOffSeason("GOOSEMOOSE", false)
										basehassler:OverrideAttackChance("GOOSEMOOSE", 0)
									elseif difficulty == "rare" then
										basehassler:OverrideAttacksPerSeason("GOOSEMOOSE", 1)
										basehassler:OverrideAttackDuringOffSeason("GOOSEMOOSE", false)
										basehassler:OverrideAttackChance("GOOSEMOOSE", .33)
									elseif difficulty == "often" then
										basehassler:OverrideAttacksPerSeason("GOOSEMOOSE", 1)
										basehassler:OverrideAttackDuringOffSeason("GOOSEMOOSE", false)
										basehassler:OverrideAttackChance("GOOSEMOOSE", 1.1)
										basehassler:OverrideMinSpawnDay("GOOSEMOOSE", nil)
									elseif difficulty == "always" then
										basehassler:OverrideAttacksPerSeason("GOOSEMOOSE", 1)
										basehassler:OverrideAttackDuringOffSeason("GOOSEMOOSE", true)
										basehassler:OverrideAttackChance("GOOSEMOOSE", 1.1)
										basehassler:OverrideMinSpawnDay("GOOSEMOOSE", nil)
									end
								end
							end,
						},
	["dragonfly"] = 	{
							doit = 	function(difficulty)									
								local basehassler = GetWorld().components.basehassler
								if basehassler then
									if difficulty == "never" then
										basehassler:OverrideAttacksPerSeason("DRAGONFLY", 0)
										basehassler:OverrideAttackDuringOffSeason("DRAGONFLY", false)
										basehassler:OverrideAttackChance("DRAGONFLY", 0)
									elseif difficulty == "rare" then
										basehassler:OverrideAttacksPerSeason("DRAGONFLY", 1)
										basehassler:OverrideAttackDuringOffSeason("DRAGONFLY", false)
										basehassler:OverrideAttackChance("DRAGONFLY", .33)
									elseif difficulty == "often" then
										basehassler:OverrideAttacksPerSeason("DRAGONFLY", 1)
										basehassler:OverrideAttackDuringOffSeason("DRAGONFLY", false)
										basehassler:OverrideAttackChance("DRAGONFLY", 1.1)
										basehassler:OverrideMinSpawnDay("DRAGONFLY", nil)
									elseif difficulty == "always" then
										basehassler:OverrideAttacksPerSeason("DRAGONFLY", 1)
										basehassler:OverrideAttackDuringOffSeason("DRAGONFLY", true)
										basehassler:OverrideAttackChance("DRAGONFLY", 1.1)
										basehassler:OverrideMinSpawnDay("DRAGONFLY", nil)
									end
								end
							end,
						},
	["perd"] = 	{
					doit = 	function(difficulty)
						local tuning_vars = {
								["never"] =  {PERD_SPAWNCHANCE = 0, 	PERD_ATTACK_PERIOD = 1},
								["rare"] = 	 {PERD_SPAWNCHANCE = 0.1, 	PERD_ATTACK_PERIOD = 1},
								["often"] =  {PERD_SPAWNCHANCE = 0.2,	PERD_ATTACK_PERIOD = 1},
								["always"] = {PERD_SPAWNCHANCE = 0.4, 	PERD_ATTACK_PERIOD = 1},
							}
						OverrideTuningVariables(tuning_vars[difficulty])
					end,
				},
	["deciduousmonster"] = 	{
					doit = 	function(difficulty)
						local tuning_vars = {
								["never"] =  {DECID_TREE_MONSTER_CHANCE = -1},
								["rare"] = 	 {DECID_TREE_MONSTER_CHANCE = .125},
								["often"] =  {DECID_TREE_MONSTER_CHANCE = .5},
								["always"] = {DECID_TREE_MONSTER_CHANCE = 1},
							}
						OverrideTuningVariables(tuning_vars[difficulty])
					end,
				},
	["hunt"] = 	{
					doit = 	function(difficulty)
						local tuning_vars = {
								["never"] =  {HUNT_COOLDOWN = -1, HUNT_COOLDOWNDEVIATION = 0, HUNT_RESET_TIME = 0, HUNT_SPRING_RESET_TIME = -1},
								["rare"] = 	 {HUNT_COOLDOWN = TUNING.TOTAL_DAY_TIME*2.4, HUNT_COOLDOWNDEVIATION = TUNING.TOTAL_DAY_TIME*.3, HUNT_RESET_TIME = 5, HUNT_SPRING_RESET_TIME = TUNING.TOTAL_DAY_TIME*5},
								["often"] =  {HUNT_COOLDOWN = TUNING.TOTAL_DAY_TIME*.6, HUNT_COOLDOWNDEVIATION = TUNING.TOTAL_DAY_TIME*.3, HUNT_RESET_TIME = 5, HUNT_SPRING_RESET_TIME = TUNING.TOTAL_DAY_TIME*2},
								["always"] = {HUNT_COOLDOWN = TUNING.TOTAL_DAY_TIME*.3, HUNT_COOLDOWNDEVIATION = TUNING.TOTAL_DAY_TIME*.2, HUNT_RESET_TIME = 5, HUNT_SPRING_RESET_TIME = TUNING.TOTAL_DAY_TIME*1},
							}
						OverrideTuningVariables(tuning_vars[difficulty])
					end,
				},				
	["krampus"] = 	{
					doit = 	function(difficulty)
						local tuning_vars = {
								["never"] =  {KRAMPUS_THRESHOLD = -1, KRAMPUS_THRESHOLD_VARIANCE = 0, KRAMPUS_INCREASE_LVL1 = -1, KRAMPUS_INCREASE_LVL2 = -1, KRAMPUS_INCREASE_RAMP = -1, KRAMPUS_NAUGHTINESS_DECAY_PERIOD = 1},
								["rare"] = 	 {KRAMPUS_THRESHOLD = 45, KRAMPUS_THRESHOLD_VARIANCE = 30, KRAMPUS_INCREASE_LVL1 = 75, KRAMPUS_INCREASE_LVL2 = 125, KRAMPUS_INCREASE_RAMP = 1, KRAMPUS_NAUGHTINESS_DECAY_PERIOD = 30},
								["often"] =  {KRAMPUS_THRESHOLD = 20, KRAMPUS_THRESHOLD_VARIANCE = 15, KRAMPUS_INCREASE_LVL1 = 37, KRAMPUS_INCREASE_LVL2 = 75, KRAMPUS_INCREASE_RAMP = 3, KRAMPUS_NAUGHTINESS_DECAY_PERIOD = 90},
								["always"] = {KRAMPUS_THRESHOLD = 10, KRAMPUS_THRESHOLD_VARIANCE = 5, KRAMPUS_INCREASE_LVL1 = 25, KRAMPUS_INCREASE_LVL2 = 50, KRAMPUS_INCREASE_RAMP = 4, KRAMPUS_NAUGHTINESS_DECAY_PERIOD = 120},
							}
						OverrideTuningVariables(tuning_vars[difficulty])
					end,
				},								
	["butterfly"] = {
						doit = 	function(difficulty)
							local butterflies = GetWorld().components.butterflyspawner
							if butterflies then
								if difficulty == "never" then
									butterflies:SpawnModeNever()
								elseif difficulty == "always" then
									butterflies:SpawnModeHeavy()
								elseif difficulty == "often" then
									butterflies:SpawnModeMed()
								elseif difficulty == "rare" then
									butterflies:SpawnModeLight()
								end
							end								
						end,
					},
	["flowers"] = 	{
						doit = 	function(difficulty)
							local flowers = GetWorld().components.flowerspawner
							if flowers then
								if difficulty == "never" then
									flowers:SpawnModeNever()
								elseif difficulty == "always" then
									flowers:SpawnModeHeavy()
								elseif difficulty == "often" then
									flowers:SpawnModeMed()
								elseif difficulty == "rare" then
									flowers:SpawnModeLight()
								end
							end								
						end,
					},
	["birds"] = 	{
						doit = 	function(difficulty)
							local birds = GetWorld().components.birdspawner
							if birds then
								if difficulty == "never" then
									birds:SpawnModeNever()
								elseif difficulty == "always" then
									birds:SpawnModeHeavy()
								elseif difficulty == "often" then
									birds:SpawnModeMed()
								elseif difficulty == "rare" then
									birds:SpawnModeLight()
								end
							end								
						end,
					},
	["penguins"] = 	{
						doit = 	function(difficulty)
							local penguins = GetWorld().components.penguinspawner
							if penguins then
								if difficulty == "never" then
									penguins:SpawnModeNever()
								elseif difficulty == "always" then
									penguins:SpawnModeHeavy()
								elseif difficulty == "often" then
									penguins:SpawnModeMed()
								elseif difficulty == "rare" then
									penguins:SpawnModeLight()
								end
							end								
						end,
					},					
	["lureplants"] = 	{
							doit = 	function(difficulty)
								local lureplants = GetWorld().components.lureplantspawner
								if lureplants then
									if difficulty == "never" then
										lureplants:SpawnModeNever()
									elseif difficulty == "always" then
										lureplants:SpawnModeHeavy()
									elseif difficulty == "often" then
										lureplants:SpawnModeMed()
									elseif difficulty == "rare" then
										lureplants:SpawnModeLight()
									end
								end
							end,
						},
	["beefaloheat"] = 	{
							doit = 	function(difficulty)
								local tuning_vars = {
										["never"] =  {BEEFALO_MATING_SEASON_LENGTH = 0, 	BEEFALO_MATING_SEASON_WAIT = -1},
										["rare"] = 	 {BEEFALO_MATING_SEASON_LENGTH = 2, 	BEEFALO_MATING_SEASON_WAIT = 18},
										["often"] =  {BEEFALO_MATING_SEASON_LENGTH = 4,     BEEFALO_MATING_SEASON_WAIT = 6},
										["always"] = {BEEFALO_MATING_SEASON_LENGTH = -1, 	BEEFALO_MATING_SEASON_WAIT = 0},
									}
								OverrideTuningVariables(tuning_vars[difficulty])
							end,
						},
	["liefs"] = 	{
						doit = 	function(difficulty)
							local tuning_vars = {												
									["never"] =  {LEIF_MIN_DAY = 9999, LEIF_PERCENT_CHANCE = 0},
									["rare"] = 	 {LEIF_MIN_DAY = 5, LEIF_PERCENT_CHANCE = 1/100},
									["often"] =  {LEIF_MIN_DAY = 2, LEIF_PERCENT_CHANCE = 1/70},
									["always"] = {LEIF_MIN_DAY = 1, LEIF_PERCENT_CHANCE = 1/55},
								}
							OverrideTuningVariables(tuning_vars[difficulty])
						end
					},
	["day"] = 	{
					doit =  function(data)
						local lookup = { 
							["onlyday"]={
									autumn={day=16,  dusk=0, night=0},
								},
							["onlydusk"]={
									autumn={day=0,  dusk=16, night=0},
								},
							["onlynight"]={
									autumn={day=0,  dusk=0,  night=16},
								},
							["default"]={
									autumn={day=8,  dusk=4,  night=4},
									winter={day=5,  dusk=5,  night=6},
									spring={day=4,  dusk=8,  night=4},
									summer={day=10, dusk=3,  night=3},
								},
							["longday"]={
									autumn={day=12, dusk=2,  night=2},
									winter={day=9,  dusk=3,  night=4},
									spring={day=8,  dusk=6,  night=2},
									summer={day=14, dusk=1,  night=1},
								},
							["longdusk"]={
									autumn={day=6,  dusk=8,  night=2},
									winter={day=3,  dusk=9,  night=4},
									spring={day=2,  dusk=12, night=2},
									summer={day=8,  dusk=7,  night=1},
								},
							["longnight"]={
									autumn={day=6,  dusk=2,  night=8},
									winter={day=3,  dusk=3,  night=10},
									spring={day=2,  dusk=6,  night=8},
									summer={day=8,  dusk=1,  night=7},
								}
						}
						
						local autumnsegs = lookup[data].autumn
						local wintersegs = lookup[data].winter or autumnsegs
						local springsegs = lookup[data].spring or autumnsegs
						local summersegs = lookup[data].summer or autumnsegs
						if GetSeasonManager() then
							GetSeasonManager():SetSegs(autumnsegs, wintersegs, springsegs, summersegs)
						end
						GetClock():SetSegs(autumnsegs.day, autumnsegs.dusk, autumnsegs.night)
					end
				},
	["season_mode"] = 	{
					doit = 	function(difficulty)
					
							if not GetSeasonManager() then
								return
							end
							
							if difficulty == "preonlywinter" then
								GetSeasonManager():EndlessWinter(10,10)
							elseif difficulty == "preonlyautumn" then
								GetSeasonManager():EndlessAutumn(10,10)
							elseif difficulty == "onlysummer" then
								GetSeasonManager():AlwaysSummer()
							elseif difficulty == "onlywinter" then
								GetSeasonManager():AlwaysWinter()
							elseif difficulty == "onlyspring" then
								GetSeasonManager():AlwaysSpring()
							elseif difficulty == "onlyautumn" then
								GetSeasonManager():AlwaysAutumn()
							else
								local tuning_vars = {		 										
									["default"] = {autumn=true, winter=true, spring=true, summer=true},

									["classic"] = {autumn=true, winter=true, spring=false, summer=false},
									["dlc"] = 	 {autumn=false, winter=false, spring=true, summer=true},
									["extreme"] =  {autumn=false, winter=true, spring=false, summer=true},
									["static"] = 	{autumn=true, winter=false, spring=true, summer=false},

									["noautumn"] = 	{autumn=false, winter=true, spring=true, summer=true},
									["nowinter"] = 	{autumn=true, winter=false, spring=true, summer=true},
									["nospring"] = 	{autumn=true, winter=true, spring=false, summer=true},
									["nosummer"] = 	{autumn=true, winter=true, spring=true, summer=false},
								}
								GetSeasonManager():SetSeasonsEnabled(tuning_vars[difficulty].autumn, tuning_vars[difficulty].winter, tuning_vars[difficulty].spring, tuning_vars[difficulty].summer)
							end
							--print("SET SEASON ["..difficulty.."]")
						end
					},
	["season"] = 	{ --#srosen this is only called by the RAINY (A Cold Reception) adventure level. I left everything intact but changed code refs to summer to ref to autumn
					doit = 	function(difficulty)
					
							if not GetSeasonManager() then
								return
							end
							
							if difficulty == "preonlywinter" then
								GetSeasonManager():EndlessWinter(10,10)
							elseif difficulty == "preonlysummer" then
								GetSeasonManager():EndlessAutumn(10,10)
							elseif difficulty == "onlysummer" then
								GetSeasonManager():AlwaysAutumn()
							elseif difficulty == "onlywinter" then
								GetSeasonManager():AlwaysWinter()
							else
								local tuning_vars = {												
									
									["longsummer"] = {autumn= 50 , winter= 10, start=50},
									["longwinter"] = {autumn= 10, winter= 50, start=10},
									
									["longboth"] = 	 {autumn= 50 , winter= 50, start=50},
									["shortboth"] =  {autumn= 10 , winter= 10, start=10},

									["autumn"] = 	{autumn= 5, winter= 3, start=5},
									["spring"] = 	{autumn= 3, winter= 5, start=3},
								}
								GetSeasonManager():SetSeasonLengths(tuning_vars[difficulty].autumn, tuning_vars[difficulty].winter)
							end
							--print("SET SEASON ["..difficulty.."]")
						end
					},
	["season_length"] = 	{
					doit = 	function(difficulty)
					
							if not GetSeasonManager() then
								return
							end
							
							local tuning_vars = {			
								["shortseasons"] = {autumn=15, winter=10, spring=15, summer=10}, 
								["default"] = {autumn=TUNING.AUTUMN_LENGTH, winter=TUNING.WINTER_LENGTH, spring=TUNING.SPRING_LENGTH, summer=TUNING.SUMMER_LENGTH}, 
								["longseasons"] = {autumn=25, winter= 20, spring=25, summer=20}, 
							}
							GetSeasonManager():SetSeasonLengths(tuning_vars[difficulty].autumn, tuning_vars[difficulty].winter, tuning_vars[difficulty].spring, tuning_vars[difficulty].summer)
							--print("SET SEASON ["..difficulty.."]")
						end
					},
	["season_start"] = 	{
					doit = 	function(data)

							if not GetSeasonManager() then
								return 
							end
							if data == "autumn" then
								GetSeasonManager():StartAutumn()
								GetSeasonManager().ground_snow_level = 0
							elseif data == "summer" then
								GetSeasonManager():StartSummer()
								GetSeasonManager().ground_snow_level = 0
							elseif data == "winter" then
								GetSeasonManager():StartWinter()
								GetSeasonManager().ground_snow_level = 1
							elseif data == "spring" then
								GetSeasonManager():StartSpring(true)
								GetSeasonManager().ground_snow_level = 0
							end
						end
					},
	["weather"] = 	{
					doit = 	function(data)
							if not GetSeasonManager() then
								return
							end
					
							local tuning_vars = {	
												["default"] = function() end,											
												["never"] =  function() 
																		GetSeasonManager():AlwaysDry()
																		GetSeasonManager():StopPrecip()
																	 end,
												["rare"] = 	 function() 
																		GetSeasonManager():SetMoiustureMult(0.5)
																	 end,
												["often"] =  function() 
																		GetSeasonManager():SetMoiustureMult(2)
																	 end,
												["squall"] =  function() 
																		GetSeasonManager():SetMoiustureMult(30)
																	 end,
												["always"] = function() 
																		GetSeasonManager():AlwaysWet()
																	 end,
											}
							tuning_vars[data]()

						end
					},
	["frograin"] = {
					doit = 	function(difficulty)
						local tuning_vars = {
							["default"] =  {FROG_RAIN_CHANCE=.16},
							["never"] = {FROG_RAIN_CHANCE= -1},
							["rare"] =  {FROG_RAIN_CHANCE=.08},
							["sometimes"] =  {FROG_RAIN_CHANCE=.33},
							["often"] =  {FROG_RAIN_CHANCE=.5},
							["always"] =  {FROG_RAIN_CHANCE=1},
							["force"] =  {FROG_RAIN_CHANCE=1},
						}
						OverrideTuningVariables(tuning_vars[difficulty])
					end
					},
	["smoke"] = {
					doit = 	function(difficulty)
						local tuning_vars = {
							["never"] = {WILDFIRE_CHANCE = -1},
							["rare"] =  {WILDFIRE_CHANCE = .1},
							["default"] =  {WILDFIRE_CHANCE = .2},
							["often"] =  {WILDFIRE_CHANCE = .4},
							["always"] =  {WILDFIRE_CHANCE = .75},
						}
						OverrideTuningVariables(tuning_vars[difficulty])
					end
					},
	["lightning"] = 	{
					doit = 	function(data)
							if not GetSeasonManager() then return end
							
							local tuning_vars = {	
												["default"] = function() end,											
												["never"] =  function() 
																		GetSeasonManager():LightningNever()
																	 end,
												["rare"] = 	 function() 
	                                                                    GetSeasonManager():OverrideLightningDelays(60, 90)
																	 end,
												["often"] =  function() 
																		GetSeasonManager():LightningWhenPrecipitating()
	                                                                    GetSeasonManager():OverrideLightningDelays(10, 20)
																	 end,
												["always"] = function() 
	                                                                    GetSeasonManager():OverrideLightningDelays(10, 30)
																		GetSeasonManager():LightningAlways()
																	 end,
											}
							tuning_vars[data]()

						end
					},
	["creepyeyes"] = 	{
							doit = 	function(difficulty)
										local tuning_vars = {
												["always"] =
												{
		                                            CREEPY_EYES = 
		                                            {
		                                                {maxsanity=1, maxeyes=6},
		                                            },
												},
											}
										OverrideTuningVariables(tuning_vars[difficulty])
									end,
							},
	["areaambient"] = 	{
							doit = 	function(data)
										local ambient = GetWorld()
										-- HACK HACK HACK
										ambient.components.ambientsoundmixer:SetOverride(GROUND.ROAD, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.ROCKY, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.DIRT, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.WOODFLOOR, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.GRASS, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.SAVANNA, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.FOREST, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.MARSH, data)
										ambient.components.ambientsoundmixer:SetOverride(GROUND.IMPASSABLE, data)
										ambient.components.ambientsoundmixer:UpdateAmbientGeoMix()
									end,
						}, 
	["areaambientdefault"] = 	{
							doit = 	function(data)
										local ambient = GetWorld()

										if data== "cave" then
											-- Clear out the above ground (forest) sounds
											ambient.components.ambientsoundmixer:SetOverride(GROUND.ROAD, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.ROCKY, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.DIRT, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.WOODFLOOR, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.SAVANNA, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.GRASS, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.FOREST, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.CHECKER, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.MARSH, "SINKHOLE")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.IMPASSABLE, "ABYSS")
										else
											-- Clear out the cave sounds
											ambient.components.ambientsoundmixer:SetOverride(GROUND.CAVE, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.FUNGUSRED, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.FUNGUSGREEN, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.FUNGUS, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.SINKHOLE, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.UNDERROCK, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.MUD, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.UNDERGROUND, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.BRICK, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.BRICK_GLOW, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.TILES, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.TILES_GLOW, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.TRIM, "ROCKY")
											ambient.components.ambientsoundmixer:SetOverride(GROUND.TRIM_GLOW, "ROCKY")
										end

										ambient.components.ambientsoundmixer:UpdateAmbientGeoMix()
									end,
						}, 
	["waves"] = 	{
							doit = 	function(data)
										
										if data == "off" then
											local ground = GetWorld()
											if ground.WaveComponent then
												ground.WaveComponent:SetRegionNumWaves( 0 )
											end
										end
									end,
						}, 
	["ColourCube"] = 	{
							doit = 	function(data)
										local COLOURCUBE = "images/colour_cubes/"..data..".tex"
										GetWorld().components.colourcubemanager:SetOverrideColourCube(COLOURCUBE)
									end,
						}, 
}

return {OVERRIDES = TUNING_OVERRIDES}
