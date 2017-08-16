	
local TERRAIN = 
	{ 



	-- Lots of Trees, rarely haunted
		["BurntForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=3,
					colour={r=.090,g=.10,b=.010,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									distributepercent = 0.4,
									distributeprefabs= {
										evergreen = 3 + math.random(4),
									},
									prefabdata={
										evergreen = {burnt=true},
									}
								}
						   },
		["CrappyDeepForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 4 + math.random(3) end,
					colour={r=0,g=.9,b=0,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .8,
					                distributeprefabs=
					                {
                                        fireflies = 0.1,
					                    evergreen_sparse = 6,
										spiderden = 0.01,
					                    grass = .05,
					                    sapling=.5,
					                    berrybush=.02,
					                    blue_mushroom = 0.02,
					                },
					            }
					
					},
		["DeepForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 4 + math.random(3) end,
					colour={r=0,g=.9,b=0,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .8,
					                distributeprefabs=
					                {
                                        fireflies = 0.1,
					                    evergreen = 6,
					                    grass = .05,
					                    sapling=.5,
					                    berrybush=.02,
					                    blue_mushroom = 0.02,
					                },
					            }
					
					},
	-- Trees, very few rocks, very few rabbit holes
		["Forest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(3) end,
					colour={r=.5,g=0.6,b=.080,a=.10},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
                                        fireflies = 0.2,
					                    evergreen = 6,
					                    rock1 = 0.05,
					                    grass = .05,
					                    sapling=.8,
					                    rabbithole=.05,
					                    berrybush=.03,
					                    red_mushroom = .03,
					                    green_mushroom = .02,
					                },
					            }
					},
		["CrappyForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(3) end,
					colour={r=.5,g=0.6,b=.080,a=.10},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
                                        fireflies = 0.2,
					                    evergreen_sparse = 6,
					                    rock1 = 0.05,
					                    grass = .05,
					                    sapling=.8,
					                    rabbithole=.05,
					                    berrybush=.03,
					                    red_mushroom = .03,
					                    green_mushroom = .02,
					                },
					            }
					},
		["SpiderForest"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size= function () return 3 + math.random(3) end,
					colour={r=.80,g=0.34,b=.80,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    evergreen_sparse = 6,
					                    rock1 = 0.05,
					                    sapling = .05,
										spiderden = 1,
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
		["BurntClearing"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return 2 + math.random(2) end,
					colour={r=.8,g=0.5,b=.7,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    evergreen = 0.15,
					                    grass = .1,
					                    sapling=.2,
					                },
									prefabdata={
										evergreen = {burnt=true},
									}
					            }
					},
	-- Trees on the outside, empty in the middle
		["Clearing"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return 2 + math.random(2) end,
					colour={r=.8,g=0.5,b=.6,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs={["MushroomRingLarge"]=function()  
																				if math.random(0,1000) > 985 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .1,
					                distributeprefabs=
					                {
                                        fireflies = 1,
					                    evergreen = 1.5,
					                    grass = .1,
					                    sapling=.8,
					                    berrybush=.1,
					                    beehive=.05,
					                    red_mushroom = .01,
					                    green_mushroom = .02,
					                },
					            }
					},
	-- Trees on the outside, flowers in the middle
		["FlowerPatch"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return 1 + math.random(2) end,
					colour={r=.5, g=1,b=.8,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
                                        fireflies = 1,
					                    flower=2,
					                    beehive=1,
					                },
					            }
					},
		["EvilFlowerPatch"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return 1 + math.random(2) end,
					colour={r=.8,g=1,b=.4,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
                                        fireflies = 1,
					                    flower_evil=2,
					                    wasphive=0.5,
					                },
					            }
					},
	-- Very few Trees, very few rocks, rabbit holes, some beefalow, some grass
		["Plain"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return 4 + math.random(4) end,
					colour={r=.8,g=.4,b=.4,a=.50},
					value = GROUND_VALUES[GROUND.SAVANNA],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    rock1 = 0.05,
					                    grass = .5,
					                    rabbithole=.25, 
					                    green_mushroom = .005,
					                },
					            }
					},
	-- Rabbit holes, Beefalow hurds if bigger
		["BarePlain"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size= function () return  1 end,--4 + math.random(5) end,
					colour={r=.5,g=.5,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.SAVANNA],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    grass = .8,
					                    rabbithole=.4,
--					                    beefalo=0.2
					                },
					            }
					},
	-- No trees, lots of rocks, rare tallbird nest, very rare spiderden
		["Rocky"] = {
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
					                    tallbirdnest=.1,
					                    spiderden=.01,
					                    blue_mushroom = .002,
					                },
					            }
					},
	-- No trees, no rocks, very rare spiderden
		["Marsh"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs={["MushroomRingMedium"]=function()  
																				if math.random(0,1000) > 985 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    evergreen = 1.0,
					                    tentacle = 3,
					                    pond_mos = 1,
					                    reeds =  4,--function () return 3 + math.random(4) end,
					                    mandrake=0.0001,
					                    spiderden=.01,
					                    blue_mushroom = 0.01,
					                    green_mushroom = 2.02,
					                },
					            }
					},
		["SpiderMarsh"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    evergreen = 1.0,
					                    tentacle = 2,
					                    pond_mos = 0.1,
					                    blue_mushroom = 0.1,
					                    reeds =  4,--function () return 3 + math.random(4) end,
					                    mandrake=0.0001,
					                    spiderden=3.15,
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
		["SlightlyMermySwamp"] = {
					shape = function () return SHAPES.CIRCLE end, 
					position = {x=0,y=0},
					size=5,
					colour={r=0.5,g=.18,b=.35,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					contents =  {

									distributepercent = .1,
									distributeprefabs= {
					                    --merm = 0.1,
					                    mermhouse = 0.1,
										pighead = 0.01,
					                    tentacle =  1,
					                    marsh_tree =  2,
					                    marsh_bush= 1.5,
									},
					            }
					 },
		["Nothing"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.45,g=.45,b=.35,a=.50},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents =  {
					            }
					},
--[[ This is the "Default" background terrain, which was previously
     encoded in forest_map.lua for each ground type. 
	 --]]
		["BGBadlands"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.76,g=.66,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
										rock1=1,
										rock2=1,
										rocks=0.1,
										marsh_bush=1,
										marsh_tree=0.3,
										houndbone=0.5,
										houndmound=0.08,
					                },
					            }
					},
		["BGRocky"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.66,g=.66,b=.66,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
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
		["BGNoise"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.66,g=.66,b=.66,a=.50},
					value = nil, --causes perlin noise
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .15,
									-- A bit of everything, and let terrain filters handle the rest.
					                distributeprefabs=
					                {
										flint=0.4,
										rocks=0.4,
										rock1=0.1,
										rock2=0.1,
										grass=0.09,
										rabbithole=0.025,
										flower=0.003,
										spiderden=0.001,
										beehive=0.003,
										berrybush=0.05,
										sapling=0.2,
										pond=.001,
					                    blue_mushroom = .001,
					                    green_mushroom = .001,
					                    red_mushroom = .001,
										evergreen=1.5,
					                },
					            }
					},
		["BGChessRocky"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.66,g=.66,b=.66,a=.50},
					value = GROUND_VALUES[GROUND.ROCKY],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs = {
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
		["BGDirt"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=1.0,g=.8,b=.66,a=.50},
					value = GROUND_VALUES[GROUND.DIRT],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
										rock1=1,
										rock2=1,
					                },
					            }
					},
		["BGSavanna"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.8,g=.8,b=.2,a=.50},
					value = GROUND_VALUES[GROUND.SAVANNA],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
										spiderden=0.001,
										grass=0.09,
										rabbithole=0.025,
										flower=0.003,
					                },
					            }
					},
		["BGGrassBurnt"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.5,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .275,
					                distributeprefabs=
					                {
										rock1=0.01,
										rock2=0.01,
										spiderden=0.001,
										beehive=0.003,
										flower=0.112,
										grass=0.2,
										rabbithole=0.02,
										flint=0.05,
										sapling=0.2,
										evergreen=0.3,
					                },
									prefabdata={
										evergreen = {burnt=true},
									}
					            }
					},
		["BGGrass"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.5,g=.8,b=.5,a=.50},
					value = GROUND_VALUES[GROUND.GRASS],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .275,
					                distributeprefabs=
					                {
										spiderden=0.001,
										beehive=0.003,
										flower=0.112,
										grass=0.2,
										rabbithole=0.02,
										carrot_planted=0.05,
										flint=0.05,
										berrybush=0.05,
										sapling=0.2,
										evergreen=0.3,
										pond=.001,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
					                },
					            }
					},
		["BGCrappyForest"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.1,g=.8,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
					                distributepercent = .6,
					                distributeprefabs=
					                {
										gravestone=0.01,
										pighouse=0.015,
										spiderden=0.04,
										grass=0.0025,
										sapling=0.15,
										rock1=0.008,
										rock2=0.008,
										evergreen_sparse=1.5,
										flower=0.05,
										pond=.001,
					                    green_mushroom = .025,
					                    red_mushroom = .025,
					                },
					            }
					},
		["BGForest"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.1,g=.8,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
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
					                    green_mushroom = .025,
					                    red_mushroom = .025,
					                },
					            }
					},
		["BGDeepForest"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.1,g=.8,b=.1,a=.50},
					value = GROUND_VALUES[GROUND.FOREST],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs={["MushroomRingSmall"]=function() 
																				if math.random(0,1000) > 985 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .8,
					                distributeprefabs=
					                {
										spiderden=0.05,
										rock1=0.004,
										rock2=0.004,
										evergreen=4.5,
										fireflies=0.1,
					                    blue_mushroom = .025,
					                    green_mushroom = .005,
					                    red_mushroom = .005,
					                },
									prefabdata = {
										spiderden = function() if math.random() < 0.1 then
																	return { growable={stage=2}}
																else
																	return { growable={stage=1}}
																end
															end,
									},
					            }
					},
		["BGMarsh"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.6,g=.2,b=.8,a=.50},
					value = GROUND_VALUES[GROUND.MARSH],
					tags = {"ExitPiece", "Chester_Eyebone"},
					contents =  {
									countspecialprefabs={["MushroomRingMedium"] = function()  
																				if math.random(0,1000) > 985 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .25,
					                distributeprefabs=
					                {
										spiderden=0.003,
										sapling=0.0001,
										pond_mos=0.005,
										reeds=0.005,
										tentacle=0.095,
										marsh_bush=0.05,
										marsh_tree=0.1,
					                    blue_mushroom = .01,
					                    mermhouse=0.004,
					                },
					            }
					},
		["BGImpassable"] = {
					shape =  function () return SHAPES.CIRCLE end, 
					position={x=0,y=0},
					size=  function () return 3 + math.random(1) end,
					colour={r=.6,g=.35,b=.8,a=.50},
					value = GROUND_VALUES[GROUND.IMPASSABLE],
					contents =  { }
					},
	}

return {TERRAIN=TERRAIN}
