
AddRoom("LabyrinthGuarden", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.TRIM, 
					tags = {"LabyrinthEntrance"},
					contents =  {
					                distributepercent = .6,
					                distributeprefabs=
					                {
					                	mushtree_tall =0.02,
					                    blue_mushroom = .02,
					                    green_mushroom = .02,
					                    red_mushroom = .02,
					                },
					               	countprefabs= 
					                {
					                	rook = 1,
					                },					            }
					})

AddRoom("BGLabyrinth", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE_NOISE, 
					tags = {"Labyrinth"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                	stalagmite = 0.5,
										stalagmite_tall=0.5,
					                	--stalagmite_gold = 0.05,
					                    spiderhole= 0.1,
					                    slurtlehole = 0.01,
					                }
					            }
					})
AddRoom("BGMaze", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE, 
					tags = {"Maze"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                	stalagmite = 0.5,
										stalagmite_tall=0.5,
					                	--stalagmite_gold = 0.05,
					                    spiderhole= 0.1,
					                    slurtlehole = 0.01,
					                }
					            }
					})
