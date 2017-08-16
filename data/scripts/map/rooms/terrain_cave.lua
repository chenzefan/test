
AddRoom("BGNoisyCave", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.CAVE_NOISE, 
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
AddRoom("BGCaveRoom", {
					colour={r=.25,g=.28,b=.25,a=.50},
					value = GROUND.CAVE,
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .175,
					                distributeprefabs=
					                {
										spiderhole=0.001,
										flint=0.05,
										fireflies=0.001,
										stalagmite=0.03,
										stalagmite_tall=0.03,
										--stalagmite_gold=0.02,
					                    blue_mushroom = .005,
					                    slurtlehole = 0.001,
					                },
					            }
					})
