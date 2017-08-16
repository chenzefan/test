
AddRoom("BGNoisyFungus", {
					colour={r=0.3,g=0.2,b=0.1,a=0.3},
					value = GROUND.FUNGUS_NOISE, 
					--tags = {"ForceConnected"},
					contents =  {
					                distributepercent = .1,
					                distributeprefabs=
					                {
					                    spiderhole= 0.1,
					                    mushtree_tall = 1.5,
										--mushroomtree_normal = 0.5,
										--mushroomtree_short = 0.5,
					                    slurtlehole = 0.001,
					                }
					            }
					})
AddRoom("BGFungusRoom", {
					colour={r=.36,g=.32,b=.38,a=.50},
					value = GROUND.FUNGUS,
					--tags = {"ForceConnected"},
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
										spiderhole=0.001,
										fireflies=0.01,
										flower_cave=0.01,
										tentacle=0.001,
					                    blue_mushroom = .01,
					                    slurtlehole = 0.003,
					                    mushtree_tall =0.02,	
					                },
					            }
					})
