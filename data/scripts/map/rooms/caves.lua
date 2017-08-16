
------------------------------------------------------------------------------------
-- Caves -----------------------------------------------------------------------
------------------------------------------------------------------------------------
AddRoom("FungusRoom", {
					colour={r=.36,g=.32,b=.38,a=.50},
					value = GROUND.FUNGUS,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=6, seed_mode=CA_SEED_MODE.SEED_RANDOM, num_random_points=2,
									translate={	{tile=GROUND.DIRT, items={"rabbithouse"}, 		item_count=3},
												{tile=GROUND.MUD, items={"spiderhole"}, 	item_count=5},
												{tile=GROUND.MUD, items={"flower_cave"}, 	item_count=7},
												{tile=GROUND.MARSH,  items={"mushtree_tall","rabbithouse"},	item_count=6},
												{tile=GROUND.MARSH,  items={"mushtree_tall","rabbithouse"},	item_count=6},
								 	},
						},
					},

					contents =  {
									countstaticlayouts={["MushroomRingMedium"] = function()  
																				if math.random(0,200) > 185 then 
																					return 1 
																				end
																				return 0 
																			   end},
					                distributepercent = .15,
					                distributeprefabs=
					                {
					                    mushtree_tall = 0.5,
										mushtree_medium = 0.5,
										mushtree_small = 0.5,
					                    spiderhole=.025,
										fireflies=0.01,
										flower_cave=0.05,
										rabbithouse=0.01,
					                    blue_mushroom = .01,
					                    cave_fern=0.2,
					                },
					            }
					})
AddRoom("CaveRoom", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.CAVE,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=6, seed_mode=CA_SEED_MODE.SEED_WALLS, num_random_points=1,
									translate={	{tile=GROUND.DIRT, items={"red_mushroom"}, 		item_count=3},
												{tile=GROUND.UNDERROCK, items={"spiderhole"}, 	item_count=5},
												{tile=GROUND.WALL_ROCKY, items={"green_mushroom"}, 	item_count=0},
												{tile=GROUND.CAVE,  items={"slurtlehole","red_mushroom"},	item_count=6},
												{tile=GROUND.CAVE,items={"fireflies"}, 				item_count=6},
											   },
						},
					},
					contents =  {
					                distributepercent = .175,
					                distributeprefabs=
					                {
					                    spiderhole= .025,
										flint=0.05,
										fireflies=0.01,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
					                    slurtlehole = 0.001,
										cave_fern=0.08,					                    
					                },
					            }
					})
AddRoom("SinkholeRoom", {
					colour={r=.15,g=.18,b=.15,a=.50},
					value = GROUND.SINKHOLE,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=3, seed_mode=CA_SEED_MODE.SEED_CENTROID, num_random_points=1,
									translate={	{tile=GROUND.GRASS, items={"grass"}, 		item_count=3},
												{tile=GROUND.GRASS, items={"sapling","berrybush"}, 	item_count=5},
												{tile=GROUND.FOREST, items={"evergreen_short"}, 	item_count=17},
												{tile=GROUND.FOREST,  items={"evergreen_normal"},	item_count=16},
												{tile=GROUND.FOREST,items={"evergreen_tall"}, 		item_count=16},
										},
								centroid= 	{tile=GROUND.FOREST, 	items={"cavelight"},			item_count=1},
						},
					},
					contents =  {
					                distributepercent = .175,
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
										cave_fern=0.2,										
										cave_banana_tree = 0.002,
										monkeybarrel = 0.1, 
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
					})

		-- Rock Lobster Plains
AddRoom("RockLobsterPlains", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE, 
					contents =  {
					                distributepercent = .15,
					                distributeprefabs=
					                {
					                	rocky = .25,
					                    bat = 0.05,
					                    spiderhole= 0.025,
										goldnugget=.05,
										rocks=.1,
										flint=0.05,
					                    slurtlehole = 0.0001,
					                	rock_flintless = 0.2,
										stalagmite_tall=0.12,
										cave_fern=0.2,										
										cave_banana_tree = 0.05,
										monkeybarrel = 0.01,
					                }
					            }
					})
		-- Misty Sinkhole
AddRoom("MistyCavern", {
					colour={r=.15,g=.18,b=.15,a=.50},
					value = GROUND.MUD,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=5, seed_mode=CA_SEED_MODE.SEED_CENTROID, num_random_points=1,
									translate={	{tile=GROUND.GRASS, items={"grass"}, 		item_count=3},
												{tile=GROUND.GRASS, items={"cave_banana_tree","berrybush"}, 	item_count=5},
												{tile=GROUND.FOREST, items={"evergreen_short"}, 	item_count=17},
												{tile=GROUND.FOREST,  items={"evergreen_normal"},	item_count=16},
												{tile=GROUND.FOREST,items={"evergreen_tall"}, 		item_count=16},
											   },
								centroid= 	{tile=GROUND.FOREST, 	items={"cavelight"},			item_count=1},
						},
					},
					contents =  {
					                distributepercent = .175,
					                distributeprefabs=
					                {
										grass=0.0025,
										sapling=0.15,
										evergreen=0.0025,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
										cave_banana_tree = 0.2,
										monkeybarrel = 0.15,
					                    red_mushroom = .004,
					                	cave_fern=0.2,

					                },
					            }
					})
AddRoom("TentacleCave", {
					colour={r=.45,g=.75,b=.45,a=.50},
					value = GROUND.MARSH,
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    tentacle_garden = 0.25,
					                    flower_cave= 1.5,
					                    spiderhole= .125,
					                },
					            }
					})
AddRoom("RabitFungusRoom", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.FUNGUS, 
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                	flower_cave=0.75,
					                	carrot_planted = 1,
					                    mushtree_tall = 0.5,
										mushtree_medium = 0.5,
										mushtree_small = 0.5,
					                    rabbithouse = 0.51,
					                	cave_fern=0.5,
					                }
					            }
					})
AddRoom("NoisyFungus", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.FUNGUS_NOISE, 
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                    spiderhole= .125,
					                    flower_cave=2,
					                    mushtree_tall = 0.5,
										mushtree_medium = 0.5,
										mushtree_small = 0.5,
					                	cave_fern=0.02,
										cave_banana_tree = 0.02,
										monkeybarrel = 0.05,
					                    slurtlehole = 0.001,
					                    goldnugget=.05,
					                }
					            }
					})
AddRoom("NoisyCave", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE_NOISE, 
					contents =  {
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                	stalagmite = 0.5,
										stalagmite_tall=0.5,
					                	--stalagmite_gold = 0.05,
					                    spiderhole= .125,
					                    slurtlehole = 0.01,
					                    slurper = 0.08,
					                }
					            }
					})
AddRoom("BatCaveRoom", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE, 
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    bat = 0.25,
					                    guano = 0.27,
					                    spiderhole= 0.05,
										goldnugget=.05,
										flint=0.05,
					                    slurtlehole = 0.0001,
					                	stalagmite = 0.12,
										stalagmite_tall=0.12,
					                }
					            }
					})
		-- Bat Cave antichamber (warn of impending bats)
AddRoom("BatCaveRoomAntichamber", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE, 
					contents =  {
					                distributepercent = .3,
					                distributeprefabs=
					                {
					                    guano = 1.0,
					                	stalagmite = 0.12,
										stalagmite_tall=0.12,
					                }
					            }
					})
AddRoom("PitRoom", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.IMPASSABLE,
					internal_type = NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
				})
AddRoom("PitEdgeCave", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.IMPASSABLE,
					internal_type = NODE_INTERNAL_CONNECTION_TYPE.EdgeEdgeRight,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=2, seed_mode=CA_SEED_MODE.SEED_WALLS, num_random_points=1, 
								translate={	{tile=GROUND.IMPASSABLE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.IMPASSABLE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.CAVE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.CAVE,  items={"stalagmite"},	item_count=0},
											{tile=GROUND.CAVE,  items={"stalagmite"},	item_count=0},
										},
							},
						},
					})
AddRoom("PitCave", {--
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.CAVE,
					tags = {"ForceConnected"},
					internal_type = NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
					custom_tiles={
						GeneratorFunction = RUNCA.GeneratorFunction,
						data = {iterations=3, seed_mode=CA_SEED_MODE.SEED_CENTROID, num_random_points=1, 
								translate={	{tile=GROUND.IMPASSABLE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.IMPASSABLE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.IMPASSABLE, items={"stalagmite"}, 	item_count=0},
											{tile=GROUND.WALL_CAVE,  items={"stalagmite"},	item_count=0},
											{tile=GROUND.WALL_CAVE,  items={"stalagmite"},	item_count=0},
										},
							},
						},
					})
AddRoom("MistyPitRoom", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.IMPASSABLE,
				})
AddRoom("WaterFilledAbyss", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.IMPASSABLE,
				})


AddRoom("Stairs", { -- This room is used to tag for the next level of caves - it will be removed later
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND.CAVE,
					contents =  {
									countprefabs = {
										cave_stairs = 1,
									},
									distributepercent=0.3,
					                distributeprefabs= {
					                    bat = 0.25,
					                    spiderhole= 0.25,
					                	stalagmite = 0.12,
										stalagmite_tall=0.12,
					                }
					            }
					})

		---------------------------------------------
		--These are temporary rooms to allow for points of interest within caves.
		---------------------------------------------

AddRoom("CaveBase", {
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND.CAVE,
					contents =  {
									countstaticlayouts={
										["CaveBase"]=1,
									},
					                distributepercent = .175,
					                distributeprefabs=
					                {
					                    spiderhole= .025,
										flint=0.05,
										fireflies=0.01,
					                	cave_fern=0.01,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
					                    slurtlehole = 0.001,
					                    monkeybarrel = 0.01,
					                },

					            }
					})

AddRoom("SinkBase", {
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND.SINKHOLE,
					contents =  {
									countstaticlayouts={
										["SinkBase"]=1,
									},
					                distributepercent = .175,
					                distributeprefabs=
					                {
										grass=0.0025,
										cavelight=0.25,
										sapling=0.15,
										evergreen=0.0025,
					                	cave_fern=0.2,
										berrybush=0.005,
										fireflies=0.01,
					                    blue_mushroom = .005,
					                    green_mushroom = .003,
					                    red_mushroom = .004,
					                    monkeybarrel = 0.02,
					                },
					            }
					})

AddRoom("MushBase", {
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND.FUNGUS,
					contents =  {
									countstaticlayouts={
										["MushBase"]=1,
									},
					                distributepercent = .15,
					                distributeprefabs=
					                {
					                    mushtree_tall = 1.5,
										mushtree_medium = 0.5,
										mushtree_small = 0.5,
					                	cave_fern=0.5,
					                    spiderhole=.025,
										fireflies=0.01,
										flower_cave=0.05,
										flower_cave_double = 0.02,
										flower_cave_triple = 0.01,
										tentacle=0.001,
										rabbithouse=0.01,
					                    blue_mushroom = .01,
					                    monkeybarrel = 0.02,

					                },
					            }
					})

AddRoom("RabbitTown", {
					colour={r=0,g=0,b=0,a=0.9},
					value = GROUND.FUNGUS,
					contents =  {
									countstaticlayouts={
										["RabbitTown"]=1,
									},
					                distributepercent = .2,
					                distributeprefabs=
					                {
					                	mushtree_tall = 1.5,
					                	flower_cave=0.75,
					                	carrot_planted = 1,
					                	cave_fern=0.75,
					                    --mushtree_tall = 0.5,
										--mushtree_medium = 0.5,
										--mushtree_small = 0.5,
					                    rabbithouse = 0.51,
					                }
					            }
					})
AddRoom("RabbitCity", {
					colour={r=0.9,g=.9,b=.2,a=.50},
					value = GROUND.UNDERROCK,
					tags = {"Town"},
					contents =  {
									countstaticlayouts=
									{
										["RabbitCity"]=function () return 1 + math.random(2) end,
										["TorchRabbitking"]=function () return 1 + math.random(2) end,
									},
									countprefabs={
										mermhead = function () return math.random(3) end,
									},
					            }
					})

