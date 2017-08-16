
------------------------------------------------------------------------------------
-- Ruins ---------------------------------------------------------------------------
------------------------------------------------------------------------------------
AddRoom("Labyrinth", {-- Not a real Labyrinth.. more of a maze really.
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.CAVE,
					tags = {"Labyrinth"},
					internal_type = NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
				})
AddRoom("LabyrinthEntrance", {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND.CAVE,
					tags = {"ForceConnected",  "LabyrinthEntrance"},--"Labyrinth",
					contents =  {
					                distributepercent = .6,
					                distributeprefabs=
					                {
					                    blue_mushroom = .02,
					                    green_mushroom = .02,
					                    red_mushroom = .02,
					                },
					            }
					})

AddRoom("RuinedCity", {-- Maze used to define room connectivity
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.CAVE,
					tags = {"Maze"},
					internal_type = NODE_INTERNAL_CONNECTION_TYPE.EdgeCentroid,
				})
AddRoom("RuinedCityEntrance", {
					colour={r=0.2,g=0.0,b=0.2,a=0.3},
					value = GROUND.CAVE,
					tags = {"ForceConnected",   "MazeEntrance"},--"Maze",
					contents =  {
					                distributepercent = .6,
					                distributeprefabs=
					                {
					                    blue_mushroom = .02,
					                    green_mushroom = .02,
					                    red_mushroom = .02,
					                },
					            }
					})
AddRoom("RuinedGuarden", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.FUNGUS, 
					contents =  {
					                countprefabs= {
					                	mushtree = function () return 3 + math.random(3) end,
					                    flower_cave = function () return 5 + math.random(3) end,
					                    gravestone = function () return 4 + math.random(4) end,
					                    mound = function () return 4 + math.random(4) end
					                }
					            }
					})
