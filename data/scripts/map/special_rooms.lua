
local SpecialRooms = 
	{
------------------------------------------------------------------------------------
-- TEST ROOMS -----------------------------------------------------------------------
------------------------------------------------------------------------------------
		["MaxPuzzle1"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
									countspecialprefabs={
										["SymmetryTest"]=2,
										["SymmetryTest2"]=2,
									},
					            }
					       },
		["TEST_ROOM"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(1) end,
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS], --GetRandomItem(GROUND_VALUES),
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents =  {
									countspecialprefabs={
										["MaxwellHome"]=1,
									},
					            }
					       },
		["TestMixedForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.3,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.8,g=.8,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"Town"},
					contents =  {
									countspecialprefabs=
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.9,g=.9,b=.2,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"Town"},
					contents =  {
									countspecialprefabs=
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(1) end,
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST], 
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=3,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=3,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 7 + math.random(4) end,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=1,
					colour={r=0.3,g=0.4,b=0.8,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					contents =  {
									countspecialprefabs=
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
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.SWAMP],
					contents =  {
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=1,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=1,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=1,
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=1,
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
		["ChessArea"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 8,
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.CHECKER],
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 8,
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.CHECKER],
					contents =  {
									countspecialprefabs={
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

------------------------------------------------------------------------------------
-- CHESS CORRUPTION ----------------------------------------------------------------
------------------------------------------------------------------------------------
		["ChessMarsh"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 8,
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {
									countspecialprefabs={
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					contents =  {
									countspecialprefabs = {
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
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.66,g=.66,b=.66,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs = {
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected"},
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ForceConnected"},
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs=
									{
										["ChessBlocker"] = 1,
									},
					            }
					},
		["Tallbirdfield"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs=
									{
										["TallbirdBlocker"] = 1,
									},
					            }
					},
		["Mermfield"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected"},
					contents =  {
									countprefabs={
										pighead=function() return math.random(6) end,
									},
					                distributepercent = 0.3,
									distributeprefabs = {
					                    mermhouse = 1,
					                    reeds =  2,
					                    pond_mos=0.5,
										swampbush = 2,
					                }
					            }
					},
		["Moundfield"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ForceConnected"},
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.SWAMP],
					tags = {"ForceConnected"},
					contents =  {
					                distributepercent = 0.5,
									distributeprefabs = {
										marsh_tree=1,
										beemine_maxwell=4,
					                }
					            }
					},
		["Trapfield"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 3,
					colour={r=0.0,g=0.4,b=0.2,a=0.3},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ForceConnected"},
					contents =  {
--									countspecialprefabs={
--										["FisherPig"]=1--function() return math.random(0,1) end,
--										},
					                distributepercent = 1.0,
									distributeprefabs = {
										evergreen_sparse=1,
										trap_teeth_maxwell=1,
					                }
					            }
					},
		["SpiderField"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["SpiderBlocker"]=1,
									},
					            }
					},
		["DenseForest"] =    {
			-- DO NOT USE! The trees right now don't block...
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["TreeBlocker"]=1,
									},
					            }
					},
		["DenseRocks"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["RockBlocker"]=1,
									},
					            }
					},
		["InsanityWall"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["InsanityBlocker"]=1,
									},
					            }
					},
		["SanityWall"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["SanityBlocker"]=1,
									},
					            }
					},
		["PigGuardpost"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 5,
					colour={r=0.7,g=0.7,b=0.7,a=0.3},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={
										["PigGuards"]=1,
									},
									countprefabs={
										["mermhead"]=2,
									},
					            }
					},
		["SpiderCon"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 8,
					colour={r=0.5,g=0.7,b=0.5,a=0.3},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected"},
					contents =  {
									countspecialprefabs={["StoneHenge"]=function() return math.random(0,1) end},
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
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size = 8,
					colour={r=0.9,g=0.1,b=0.1,a=0.3},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ForceConnected"},
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
		["TentacleLand"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ForceConnected"},
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

		["SanityWormholeBlocker"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.45,g=.75,b=.45,a=.50},
					type = "blank",
					tags = {"InsanityWormhole", "RoadPoison"},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents = {},
					},


------------------------------------------------------------------------------------
-- EXIT ROOM -----------------------------------------------------------------------
------------------------------------------------------------------------------------
		["Exit"] =    {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(1) end,
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
