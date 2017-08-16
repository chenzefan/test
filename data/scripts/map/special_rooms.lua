
local function MakeSetpieceBlockerRoom(blocker_name)
	return	{
				colour={r=0.2,g=0.0,b=0.2,a=0.3},
				value = GROUND_VALUES[GROUND.IMPASSABLE],
				tags = {"ForceConnected", "RoadPoison"},
				contents =  {
								countstaticlayouts= {
									[blocker_name]=1,
								}, 
							}
			}
end



local SpecialRooms = 
	{
------------------------------------------------------------------------------------
-- TEST ROOMS -----------------------------------------------------------------------
------------------------------------------------------------------------------------
		["MaxPuzzle1"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countstaticlayouts={
										["MaxPuzzle1"]=1,
									},
					                distributepercent = 0.2,
									distributeprefabs = {
										spider_nest=0.02,
										spider=0.5,
										spider_warrior=0.2,
										--TODO: Right now the warrior wanders off from his starting location; not good enough.
										marsh_tree=6,
										marsh_bush=4,
					                }
					            }
					       },
		["MaxPuzzle2"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countstaticlayouts={
										["MaxPuzzle2"]=1,
									},
					                distributepercent = 0.5,
									distributeprefabs = {
										trap_teeth_maxwell = 20,
										spider_nest=0.02,
										--TODO: Right now the warrior wanders off from his starting location; not good enough.
										marsh_tree=6,
										marsh_bush=4,
					                }
					            }
					       },
		["MaxPuzzle3"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countstaticlayouts={
										["MaxPuzzle3"]=1,
									},
					                distributepercent = 0.3,
									distributeprefabs = {
										beemine_maxwell = 12,
										spider_nest=0.02,
										--TODO: Right now the warrior wanders off from his starting location; not good enough.
										marsh_tree=6,
										marsh_bush=4,
					                }
					            }
					       },
		["SymmetryRoom"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
									countstaticlayouts={
										["SymmetryTest"]=2,
										["SymmetryTest2"]=2,
									},
					            }
					       },
		["TEST_ROOM"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FUNGUS], --GetRandomItem(GROUND_VALUES),
					contents =  {
									countstaticlayouts={
										["test"]=1,
									},
					                countprefabs= {
					                    flower = function () return 4 + math.random(4) end,
					                    adventure_portal = 1,
					                },
									distributepercent=0.01,
									distributeprefabs={
										grass=1,
									},
					            }
					},
		["MaxHome"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents =  {
									countstaticlayouts={
										["MaxwellHome"]=1,
									},
					            }
					       },
		["TestMixedForest"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									distributepercent=0.8,
									distributeprefabs={
										evergreen=1,
										evergreen_sparse=1,
									}
					            }
					       },
		["TestSparseForest"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									distributepercent=0.8,
									distributeprefabs={
										evergreen_sparse=1,
									}
					            }
					       },
		["TestPineForest"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									distributepercent=0.8,
									distributeprefabs={
										evergreen=1,
									}
					            }
					       },

--------------------------------------------------------------------------------
-- Merms 
--------------------------------------------------------------------------------
		["MermTown"] = {
					colour={r=0.5,g=.18,b=.35,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countprefabs={
										pighead=function() return math.random(6) end,
									},
									distributepercent = .1,
									distributeprefabs= {
					                    --merm = 0.1,
					                    mermhouse = 1,
					                    tentacle =  1,
					                    reeds =  2,
					                    pond_mos=0.5,
									},
					            }
					 },
--------------------------------------------------------------------------------
-- Pigs 
--------------------------------------------------------------------------------
		["PigTown"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countstaticlayouts={
										["PigTown"]=1, 
									},
									distributepercent = .1,
									distributeprefabs= {
					                    grass = .05,
					                    berrybush=.05,
									},
					            }
					 },
		["PigVillage"] = {
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countstaticlayouts={
										["Farmplot"]=function() return math.random(2,5) end,
										["VillageSquare"]= function()	
																		if math.random() > 0.97 then 
																			return 1 
																	  	end 
																	  	return 0 
															end,
									},
					                countprefabs= {
					                    --bonfire = 1,
					                    pighouse = function () return 3 + math.random(4) end,
										mermhead = function () return math.random(3) end,
					                },
									distributepercent = .1,
									distributeprefabs= {
					                    grass = .05,
					                    berrybush=.05,
									},
					            }
					       },
		["PigKingdom"] = {
					colour={r=0.8,g=.8,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countstaticlayouts=
									{
										["DefaultPigking"]=1,
										["CropCircle"]=function() return math.random(0,1) end,
										["TreeFarm"]= 	function()
																		if math.random() > 0.97 then 
																			return math.random(1,2) 
																	  	end 
																	  	return 0 
										 				end,
									},
					                countprefabs= {
					                    pighouse = function () return 5 + math.random(4) end,
					                }
					            }
					       },
		["PigCity"] = {
					colour={r=0.9,g=.9,b=.2,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"Town"},
					contents =  {
									countstaticlayouts=
									{
										["PigTown"]=function () return 1 + math.random(2) end,
										["TorchPigking"]=1,
									},
									countprefabs={
										mermhead = function () return math.random(3) end,
									},
					            }
					       },
		["PigCamp"] = {
					colour={r=1,g=.8,b=.8,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
					                countprefabs= {
					                    pighouse = function () return 4 + math.random(4) end,
										mermhead = function () return math.random(3) end,
					                },
									distributepercent = 0.1,
									distributeprefabs = {
										poop = 0.01,
										wall_hay = 0.01,
					                    grass = .15,
					                    berrybush=.05,
									},
					                }
					       },
		["PigShrine"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST], 
					contents =  {
									countstaticlayouts={
										["MaxPigShrine"]=1,
									},
					                countprefabs= {
					                    flower = function () return 8 + math.random(4) end,
					                },
									distributepercent=0.4,
									distributeprefabs={
					                    evergreen_normal = 1,
										evergreen_tall=1,
									},
					            }
					},
		["Pondopolis"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
					                countprefabs= {
					                    pond = function () return 5 + math.random(3) end
					                },
									distributepercent = 0.1,
									distributeprefabs = {
					                    grass = 8,
					                    flower = 6,
					                    sapling = 1,
									},
					            }
					       },
--------------------------------------------------------------------------------
-- Spider 
--------------------------------------------------------------------------------
		["SpiderCity"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
					                countprefabs= {
                                        goldnugget = function() return 3 + math.random(3) end,
					                },
									distributepercent = 0.3,
					                distributeprefabs = {
					                    evergreen_sparse = 3,
					                    spiderden = 0.3,
					                },
									prefabdata = {
										spiderden = function() if math.random() < 0.2 then
																	return { growable={stage=3}}
																else
																	return { growable={stage=2}}
																end
															end,
									},
					            }
					       },

		["SpiderVillage"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					contents =  {
					                countprefabs= {
                                        goldnugget = function() return 3 + math.random(3) end,
					                    spiderden = function () return 5 + math.random(3) end
					                },
									distributepercent = 0.1,
									distributeprefabs = {
					                    rock1 = 1,
					                    rock2 = 1,
					                    rocks = 1,
									},
									prefabdata = {
										spiderden = function() if math.random() < 0.2 then
																	return { growable={stage=2}}
																else
																	return { growable={stage=1}}
																end
															end,
									},
					            }
					       },
		["SpiderVillageSwamp"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
					                countprefabs= {
                                        goldnugget = function() return 3 + math.random(3) end,
					                    spiderden = function () return 5 + math.random(3) end
					                },
									distributepercent = 0.1,
									distributeprefabs = {
					                    marsh_tree = 1,
					                    marsh_bush = 1,
									},
									prefabdata = {
										spiderden = function() if math.random() < 0.2 then
																	return { growable={stage=2}}
																else
																	return { growable={stage=1}}
																end
															end,
									},
					            }
					       },
--------------------------------------------------------------------------------
-- Walrus 
--------------------------------------------------------------------------------
		["WalrusHut_Plains"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.SAVANNA],
					contents =  {
					                countprefabs= {
										walrus_camp = 1
					                },
					                distributepercent = .1,
					                distributeprefabs=
					                {
										grass=0.09,
										flower=0.003,
					                },
					            }
					       },
		["WalrusHut_Grassy"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
					                countprefabs= {
										walrus_camp = 1
					                },
					                distributepercent = .275,
					                distributeprefabs=
					                {
										flower=0.112,
										grass=0.2,
										carrot_planted=0.05,
										flint=0.05,
										sapling=0.2,
										evergreen=0.3,
										pond=.005,
					                },
					            }
					       },
		["WalrusHut_Rocky"] = {
					colour={r=.30,g=.20,b=.50,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					contents =  {
					                countprefabs= {
										walrus_camp = 1
					                },
					                distributepercent = .1,
					                distributeprefabs=
					                {
										flint=0.5,
										rock1=1,
										rock2=1,
										tallbirdnest=0.3,
					                },
					            }
					       },
		["BeeClearing"] = {
					colour={r=.8,g=1,b=.8,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
					                countprefabs= {
                                        fireflies= 1,
					                    flower=6,
					                    beehive=1,
					                }
					            }
					       },
		["Graveyard"] =    {
					colour={r=.010,g=.010,b=.10,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"Town"},
					contents =  {
					                countprefabs= {
					                    evergreen = 3,
                                        goldnugget = function() return math.random(5) end,
					                    gravestone = function () return 4 + math.random(4) end,
					                    mound = function () return 4 + math.random(4) end
					                }
					            }
					       },
		["BurntForestStart"] = {
					colour={r=.010,g=.010,b=.010,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countprefabs= {
										firepit=1,
									},	
									distributepercent = 0.6,
									distributeprefabs= {
										evergreen = 3 + math.random(4),
										charcoal = 0.2,
									},
									prefabdata={
										evergreen = {burnt=true},
									}
								}
						   },
		["BeefalowPlain"] =    {
					colour={r=.45,g=.5,b=.85,a=.50},
					value = GROUND_VALUES[GROUND.SAVANNA],
					contents =  {
					                distributepercent = .05,
					                distributeprefabs= {
					                    grass = .01,
					                    beefalo = 0.02,
					                } 
					            }
					       },
		["MandrakeHome"] = {
					colour={r=0.3,g=0.4,b=0.8,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
									countstaticlayouts=
									{
										["InsanePighouse"]=function() if math.random(1000)> 995 then 
																		return 1 
																	  else 
																	  	return 0 
																	  end 
															end,
									},
					                countprefabs= {
					                    mandrake = 1,
					                },
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    flower = 4,
                                        fireflies = 0.3,
					                    evergreen = 6,
					                    grass = .05,
					                    sapling=.5,
					                    berrybush=.05,
					                },
					            }
					       },

		["TallbirdNests"] = {
					colour={r=.55,g=.75,b=.75,a=.50},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    rock1 = 2,
					                    rock2 = 2,
					                    tallbirdnest=1.8,
					                    spiderden=.01,
					                    blue_mushroom = .02,
					                },
					            }
					},
		["Rockpile"] =    {
					colour={r=0.6,g=0.1,b=0.8,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents =  {
					                distributepercent = 0.5,
									distributeprefabs = {
										sapling=1,
										rocks=4,
										--TODO: Rocks should be in a pile in the middle of the room
					                }
					            }
					},
		["Woodpile"] =    {
					colour={r=0.6,g=0.8,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countprefabs = {
										pighouse=1,
									},
					                distributepercent = 0.5,
									distributeprefabs = {
										grass=1,
										log=4,
										evergreen=1.5,
										--TODO: Logs should be in a pile in the middle of the room
					                },
									prefabdata={
										evergreen = {stump=true},
									}
					            }
					},
		["SafeSwamp"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.SWAMP],
					contents =  {
					                countprefabs= {
					                    mandrake = math.random(1,2),
					                },
					                distributepercent = 0.2,
									distributeprefabs = {
										marsh_tree=1,
										marsh_bush=1,
										--TODO: Traps need to be not "owned" by player
					                }
					            }
					},

------------------------------------------------------------------------------------
-- WORMHOLE ------------------------------------------------------------------------
------------------------------------------------------------------------------------

		["Wormhole_Swamp"] = {
					colour={r=1,g=0,b=0,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countprefabs = {
										wormhole_MARKER = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
										marsh_tree = 2,
										marsh_bush = 4,
										rocks = 2,
									},
					            }
					},
		["Wormhole_Plains"] = {
					colour={r=1,g=0,b=0,a=0.3},
					value = GROUND_VALUES[GROUND.SAVANNA],
					contents =  {
									countprefabs = {
										wormhole_MARKER = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    grass = 3,
										rocks = 2,
										rock1 = 0.5,
										rock2 = 0.5,
									},
					            }
					},
		["Wormhole_Burnt"] = {
					colour={r=1,g=0,b=0,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countprefabs = {
										wormhole_MARKER = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    grass = 0.5,
										sapling = 0.5,
										rocks = 3,
										evergreen = 7,
									},
									prefabdata={
										evergreen = {burnt=true},
					                }
					            }
					},
		["Wormhole"] = {
					colour={r=1,g=0,b=0,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countprefabs = {
										wormhole_MARKER = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    grass = 1,
										sapling = 1,
										rocks = 3,
										evergreen_normal = 1,
										evergreen_short = 5,
										evergreen_tall = 1,
					                }
					            }
					},
		["Sinkhole"] = { -- This room is used to tag for the caves - it will be removed later
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countprefabs = {
										cave_entrance = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    grass = 1,
										sapling = 1,
										rocks = 3,
										evergreen_normal = 1,
										evergreen_short = 5,
										evergreen_tall = 1,
					                }
					            }
					},
------------------------------------------------------------------------------------
-- CHESS CORRUPTION ----------------------------------------------------------------
------------------------------------------------------------------------------------
		["ChessArea"] =    {
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.CHECKER],
					contents =  {
									countstaticlayouts={
										["Maxwell1"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell2"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell3"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell4"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell6"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell7"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["ChessSpot1"] = function() return math.random(0,3) end,
										["ChessSpot2"] = function() return math.random(0,3) end,
										["ChessSpot3"] = function() return math.random(0,3) end,
									},
					                distributepercent = 0.25,
									distributeprefabs = {
										marbletree = 1,
										flower_evil = 1,
										marblepillar = 0.1,
										knight = 0.1,
										bishop = 0.05,
					                }
					            }
					},
		["MarbleForest"] =    {
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.CHECKER],
					contents =  {
									countstaticlayouts={
										["Maxwell1"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell2"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell3"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell4"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell6"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell7"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["ChessSpot1"] = function() return math.random(0,3) end,
										["ChessSpot2"] = function() return math.random(0,3) end,
										["ChessSpot3"] = function() return math.random(0,3) end,
									},
					                distributepercent = 0.75,
									distributeprefabs = {
										marbletree = 5,
										flower_evil = 1,
										marblepillar = 0.1,
										knight = 0.1,
										bishop = 0.15,
					                }
					            }
					},

		["ChessMarsh"] =    {
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countstaticlayouts={
										["Maxwell1"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell2"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell3"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["ChessSpot1"] = function() return math.random(0,3) end,
										["ChessSpot2"] = function() return math.random(0,3) end,
										["ChessSpot3"] = function() return math.random(0,3) end,
									},
					                distributepercent = 0.2,
									distributeprefabs = {
										marsh_tree=6,
										marsh_bush=4,
										pond_mos=0.3,
										tentacle=1,
					                }
					            }
					},
		["ChessForest"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countstaticlayouts = {
										["Maxwell2"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell3"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell5"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["ChessSpot1"] = function() return math.random(0,3) end,
										["ChessSpot2"] = function() return math.random(0,3) end,
										["ChessSpot3"] = function() return math.random(0,3) end,
									},
					                distributepercent = .3,
					                distributeprefabs=
					                {
										gravestone=0.01,
										pighouse=0.015,
										spiderden=0.02,
										grass=0.0025,
										sapling=0.15,
										berrybush=0.005,
										rock1=0.004,
										rock2=0.004,
										evergreen_sparse=1.5,
										flower=0.05,
										pond=.001,
					                    blue_mushroom = .02,
					                    green_mushroom = .02,
					                    red_mushroom = .02,
					                },
					            }
					},
		["ChessBarrens"] = {
					colour={r=.66,g=.66,b=.66,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countstaticlayouts = {
										["Maxwell1"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell3"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["Maxwell5"] = function() return math.random(0,3) < 1 and 1 or 0 end,
										["ChessSpot1"] = function() return math.random(0,3) end,
										["ChessSpot2"] = function() return math.random(0,3) end,
										["ChessSpot3"] = function() return math.random(0,3) end,
									},
					                distributepercent = .1,
					                distributeprefabs=
					                {
										flint=0.5,
										rock1=1,
										rock2=1,
										tallbirdnest=0.008,
					                },
					            }
					},

------------------------------------------------------------------------------------
-- BLOCKERS ------------------------------------------------------------------------
------------------------------------------------------------------------------------
		["Deerclopsfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
					                countprefabs= {
										deerclops = 1,
					                },
					                distributepercent = .6,
					                distributeprefabs=
					                {
										gravestone=0.01,
										pighouse=0.015,
										spiderden=0.02,
										grass=0.0025,
										sapling=0.15,
										berrybush=0.005,
										rock1=0.004,
										rock2=0.004,
										evergreen=1.5,
										flower=0.05,
										pond=.001,
					                    blue_mushroom = .02,
					                    green_mushroom = .02,
					                    red_mushroom = .02,
					                },
					            }
					},
		["Walrusfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
					                countprefabs= {
										walrus_camp = 6,
					                },
					                distributepercent = .275,
					                distributeprefabs=
					                {
										flower=0.112,
										grass=0.2,
										carrot_planted=0.05,
										flint=0.05,
										sapling=0.2,
										evergreen=0.3,
										pond=.005,
					                },
					            }
					},
		["Chessfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.CHECKER],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countstaticlayouts = {
										["ChessSpot1"] = function() return math.random(2,3) end,
										["ChessSpot2"] = function() return math.random(2,3) end,
									},
					                distributepercent = 0.4,
									distributeprefabs = {
					                    marblepillar=1,
					                    knight=0.8,
										bishop=0.5,
										marbletree=2,
										flower_evil=2,
					                }
					            }
					},
		["ChessfieldA"] = MakeSetpieceBlockerRoom("ChessBlocker"),
		["ChessfieldB"] = MakeSetpieceBlockerRoom("ChessBlockerB"),
		["ChessfieldC"] = MakeSetpieceBlockerRoom("ChessBlockerC"),
		["Tallbirdfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countprefabs={
										tallbirdnest=1,
									},
					                distributepercent = 0.1,
									distributeprefabs = {
					                    rock1=1,
					                    rock2=1,
										tallbirdnest=1,
					                }
					            }
					},
		["TallbirdfieldSmallA"] = MakeSetpieceBlockerRoom("TallbirdBlockerSmall"),
		["TallbirdfieldA"] = MakeSetpieceBlockerRoom("TallbirdBlocker"),
		["TallbirdfieldB"] = MakeSetpieceBlockerRoom("TallbirdBlockerB"),
		["Mermfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countprefabs={
										pighead=function() return math.random(6) end,
									},
					                distributepercent = 0.3,
									distributeprefabs = {
					                    mermhouse = 1,
					                    reeds =  2,
					                    pond_mos=0.5,
										marsh_bush = 2,
					                }
					            }
					},
		["Moundfield"] =    {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countprefabs = {
										houndmound=1, -- sometimes zero spawn, so lets have at least one
									},
					                distributepercent = 0.2,
									distributeprefabs = {
										houndmound=0.4,
										houndbone=3,
										marsh_bush=1,
										marsh_tree=0.3,
										rock1=0.5,
										rock2=0.5,
										rocks=0.05,
					                }
					            }
					},
		["Minefield"] =    {
			-- DO NOT USE -- it destroys performance, so many mosquitos!!
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.SWAMP],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
					                distributepercent = 0.5,
									distributeprefabs = {
										marsh_tree=1,
										beemine_maxwell=4,
					                }
					            }
					},
		["Trapfield"] =    {
					colour={r=0.0,g=0.4,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countprefabs = {
										homesign = 2,
									},
					                distributepercent = .4,
									distributeprefabs = {
										houndbone=1,
										trap_teeth_maxwell=1,
					                }
					            }
					},
		["TrappedForest"] =    {
					colour={r=0.0,g=0.4,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
--									countstaticlayouts={
--										["FisherPig"]=1--function() return math.random(0,1) end,
--										},
					                distributepercent = 1.0,
									distributeprefabs = {
										evergreen_sparse=1,
										trap_teeth_maxwell=1,
					                }
					            }
					},
		["SpiderfieldEasy"] =    {
					colour={r=0.0,g=0.4,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
--									countstaticlayouts={
--										["FisherPig"]=1--function() return math.random(0,1) end,
--										},
					                distributepercent = .4,
									distributeprefabs = {
										evergreen_sparse=1,
										spiderden=0.1,
					                },
									prefabdata={
										spiderden={growable={stage=2}},
									},
					            }
					},
		["Spiderfield"] =    {
					colour={r=0.0,g=0.4,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
--									countstaticlayouts={
--										["FisherPig"]=1--function() return math.random(0,1) end,
--										},
					                distributepercent = .4,
									distributeprefabs = {
										evergreen_sparse=1,
										spiderden=0.15,
					                },
									prefabdata={
										spiderden={growable={stage=3}},
									},
					            }
					},
		["SpiderfieldEasyA"] = MakeSetpieceBlockerRoom("SpiderBlockerEasy"),
		["SpiderfieldEasyB"] = MakeSetpieceBlockerRoom("SpiderBlockerEasyB"),
		["SpiderfieldA"] = MakeSetpieceBlockerRoom("SpiderBlocker"),
		["SpiderfieldB"] = MakeSetpieceBlockerRoom("SpiderBlockerB"),
		["SpiderfieldC"] = MakeSetpieceBlockerRoom("SpiderBlockerC"),
		["DenseForest"] = MakeSetpieceBlockerRoom("TreeBlocker"), -- DO NOT USE! The trees right now don't block...
		["DenseRocks"] = MakeSetpieceBlockerRoom("RockBlocker"),
		["InsanityWall"] = MakeSetpieceBlockerRoom("InsanityBlocker"),
		["SanityWall"] = MakeSetpieceBlockerRoom("SanityBlocker"),
		["PigGuardpostEasy"] = MakeSetpieceBlockerRoom("PigGuardsEasy"),
		["PigGuardpost"] = MakeSetpieceBlockerRoom("PigGuards"),
		["PigGuardpostB"] = MakeSetpieceBlockerRoom("PigGuardsB"),
		["SpiderCon"] =    {
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
									countstaticlayouts={["StoneHenge"]=function() return math.random(0,1) end},
					                distributepercent = 0.2,
									distributeprefabs = {
										spider=0.5,
										spider_warrior=0.2,
										--TODO: Right now the warrior wanders off from his starting location; not good enough.
										marsh_tree=6,
										marsh_bush=4,
					                }
					            }
					},
		["Waspnests"] =    {
					colour={r=0.9,g=0.1,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
					                distributepercent = 0.5,
									distributeprefabs = {
										flower=6,
										beehive=1,
										grass=2,
										wasphive=1,
					                }
					            }
					},

		["Tentacleland"] = {
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected", "RoadPoison"},
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    tentacle = 14,
					                    pond_mos = 0.1,
					                    reeds =  0.2,--function () return 3 + math.random(4) end,
					                    mandrake=0.0001,
										marsh_bush=1.5,
										marsh_tree=1.1,
					                },
					            }
					},
		["TentaclelandA"] = MakeSetpieceBlockerRoom("TentacleBlocker"),
		["TentaclelandSmallA"] = MakeSetpieceBlockerRoom("TentacleBlockerSmall"),

		["SanityWormholeBlocker"] = {
					colour={r=.45,g=.75,b=.45,a=.50},
					type = "blank",
					tags = {"OneshotWormhole", "ForceDisconnected"},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents = {},
					},
		["ForceDisconnectedRoom"] = {
					colour={r=.45,g=.75,b=.45,a=.50},
					type = "blank",
					tags = {"ForceDisconnected"},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents = {},
					},


------------------------------------------------------------------------------------
-- Caves -----------------------------------------------------------------------
------------------------------------------------------------------------------------
		["FungusRoom"] = {
					colour={r=.36,g=.32,b=.38,a=.50},
					value = GROUND_VALUES[GROUND.FUNGUS],
					contents =  {
									countstaticlayouts={["MushroomRingMedium"] = function()  
																				if math.random(0,200) > 185 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .25,
					                distributeprefabs=
					                {
					                    mushtree_tall = 1.5,
										--mushroomtree_normal = 0.5,
										--mushroomtree_short = 0.5,
					                    spiderhole=.025,
										fireflies=0.01,
										flower_cave=0.05,
										tentacle=0.001,
										rabbithouse=0.01,
					                    blue_mushroom = .01,
					                },
					            }
					},
		["CaveRoom"] = {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND_VALUES[GROUND.CAVE],
					contents =  {
					                distributepercent = .275,
					                distributeprefabs=
					                {
					                    spiderhole= .025,
										flint=0.05,
										fireflies=0.01,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
					                    slurtlehole = 0.001,
					                },
					            }
					},
		["SinkholeRoom"] = {
					colour={r=.15,g=.18,b=.15,a=.50},
					value = GROUND_VALUES[GROUND.SINKHOLE],
					contents =  {
					                distributepercent = .275,
					                distributeprefabs=
					                {
										grass=0.0025,
										cavelight=0.25,
										sapling=0.15,
										evergreen=0.0025,
										berrybush=0.005,
										spiderden=0.001,
					                    slurtlehole = 0.001,
										fireflies=0.01,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
										rabbithouse=0.01,
					                },
									prefabdata = {
										spiderden = function() if math.random() < 0.1 then
																	return { growable={stage=3}}
																else
																	return { growable={stage=2}}
																end
															end,
									},
					            }
					},
		["TentacleCaveRoom"] = {
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    tentacle = 2,
					                    --tentaclepillar = 2,
					                    flower_cave= 0.5,
					                    spiderhole= .125,
					                },
					            }
					},
		["RabitFungusRoom"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FUNGUS], 
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                	mushtree_tall = 1.5,
					                	flower_cave=0.75,
					                	carrot_planted = 1,
					                    --mushroomtree_tall = 0.5,
										--mushroomtree_normal = 0.5,
										--mushroomtree_short = 0.5,
					                    rabbithouse = 0.51,
					                }
					            }
					},
		["NoisyFungus"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FUNGUS_NOISE], 
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    spiderhole= .125,
					                    mushtree_tall = 1.5,
					                    flower_cave=2,
					                    --mushroomtree_tall = 0.5,
										--mushroomtree_normal = 0.5,
										--mushroomtree_short = 0.5,
					                    slurtlehole = 0.001,
					                    goldnugget=.05,
					                }
					            }
					},
		["NoisyCave"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.CAVE_NOISE], 
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                	stalagmite = 1,
					                	--stalagmite_gold = 0.05,
					                    spiderhole= .125,
					                    slurtlehole = 0.01,
					                }
					            }
					},
		["BatCaveRoom"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.CAVE], 
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    bat = 0.25,
					                    spiderhole= 0.05,
										goldnugget=.05,
										flint=0.05,
					                    slurtlehole = 0.0001,
					                	stalagmite = 0.25,
					                }
					            }
					},
		["PitRoom"] = {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					},
		["Stairs"] = { -- This room is used to tag for the next level of caves - it will be removed later
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND_VALUES[GROUND.CAVE],
					contents =  {
									countprefabs = {
										cave_stairs = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    bat = 0.25,
					                    spiderhole= 0.25,
					                	stalagmite = 0.25,
					                }
					            }
					},

------------------------------------------------------------------------------------
-- EXIT ROOM -----------------------------------------------------------------------
------------------------------------------------------------------------------------
		["Exit"] =    {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST], --GetRandomItem(GROUND_VALUES),
					contents =  {
					                countprefabs= {
					                	teleportato_base = 1,
					                    spiderden = function () return 5 + math.random(3) end,
					                    gravestone = function () return 4 + math.random(4) end,
					                    mound = function () return 4 + math.random(4) end
					                }
					            }
					},

	}

return {SpecialRooms=SpecialRooms}
