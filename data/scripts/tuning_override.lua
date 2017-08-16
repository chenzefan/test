
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
										local Hounded = require("components/hounded")
										if difficulty == "never" then
											GetPlayer().components.hounded:SpawnModeNever()
										elseif difficulty == "always" then
											GetPlayer().components.hounded:SpawnModeHeavy()
										elseif difficulty == "often" then
											GetPlayer().components.hounded:SpawnModeMed()
										elseif difficulty == "rare" then
											GetPlayer().components.hounded:SpawnModeLight()
										end
									end,
				},
	["deerclops"] = 	{
							doit = 	function(difficulty)
										local BaseHassler = require("components/basehassler")
										if difficulty == "never" then
											GetPlayer().components.basehassler:SetAttacksPerWinter(0)
											GetPlayer().components.basehassler:SetAttackDuringSummer(false)
										elseif difficulty == "rare" then
											GetPlayer().components.basehassler:SetAttacksPerWinter(1)
											GetPlayer().components.basehassler:SetAttackDuringSummer(false)
										elseif difficulty == "often" then
											GetPlayer().components.basehassler:SetAttacksPerWinter(2)
											GetPlayer().components.basehassler:SetAttackDuringSummer(false)
										elseif difficulty == "always" then
											GetPlayer().components.basehassler:SetAttacksPerWinter(3)
											GetPlayer().components.basehassler:SetAttackDuringSummer(true)
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
	["day"] = {
							doit =  function(data)
										local lookup = { 
											["onlyday"]={
													summer={day=16,dusk=0,night=0},
												},
											["onlydusk"]={
													summer={day=0,dusk=16,night=0},
												},
											["onlynight"]={
													summer={day=0,dusk=0,night=16},
												},
											["default"]={
													summer={day=10,dusk=2,night=4},
													winter={day=6,dusk=4,night=5},
												},
											["longday"]={
													summer={day=14,dusk=1,night=1},
													winter={day=13,dusk=1,night=2},
												},
											["longdusk"]={
													summer={day=7,dusk=6,night=3},
													winter={day=3,dusk=8,night=5},
												},
											["longnight"]={
													summer={day=5,dusk=2,night=9},
													winter={day=2,dusk=2,night=12},
												}
										}
										
										
										local summersegs = lookup[data].summer
										local wintersegs = lookup[data].winter or summersegs
										GetSeasonManager():SetSegs(summersegs, wintersegs)
										GetClock():SetSegs(summersegs.day, summersegs.dusk, summersegs.night)
										
--										if lookup[data].winter ~= nil then
--											GetClock():SetSegs(lookup[data].winter.day, lookup[data].winter.dusk, lookup[data].winter.night)
--										end
										--print("SET DAY ["..data.."]")
									end

					},
	["season"] = 	{
					doit = 	function(difficulty)
							if difficulty == "preonlywinter" then
								GetSeasonManager():EndlessWinter(10,10)
							elseif difficulty == "preonlysummer" then
								GetSeasonManager():EndlessSummer(10,10)
							elseif difficulty == "onlysummer" then
								GetSeasonManager():AlwaysSummer()
							elseif difficulty == "onlywinter" then
								GetSeasonManager():AlwaysWinter()
							else
								local tuning_vars = {												
									
									["longsummer"] = {summer= 50 , winter= 10, start=50},
									["longwinter"] = {summer= 10, winter= 50, start=10},
									
									["longboth"] = 	 {summer= 50 , winter= 50, start=50},
									["shortboth"] =  {summer= 10 , winter= 10, start=10},

									["autumn"] = 	{summer= 5, winter= 3, start=5},
									["spring"] = 	{summer= 3, winter= 5, start=3},
								}
								GetSeasonManager():SetSeasonLengths(tuning_vars[difficulty].summer, tuning_vars[difficulty].winter)
							end
							--print("SET SEASON ["..difficulty.."]")
						end
					},
	["season_start"] = 	{
					doit = 	function(data)
							if data == "summer" then
								GetSeasonManager():StartSummer() -- TEMP to make sure its working
								GetSeasonManager().ground_snow_level = 0
							else
								GetSeasonManager():StartWinter()
								GetSeasonManager().ground_snow_level = 1
							end
							GetSeasonManager().percent_season = 0.5
						end
					},
	["weather"] = 	{
					doit = 	function(data)
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
	["lightning"] = 	{
					doit = 	function(data)
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

}

return {OVERRIDES = TUNING_OVERRIDES}
