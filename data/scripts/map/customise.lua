local freqency_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDENEVER, data = "never" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDERARE, data = "rare" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEDEFAULT, data = "default" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEOFTEN, data = "often" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALWAYS, data = "always" },
}

local speed_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEVERYSLOW, data = "veryslow" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESLOW, data = "slow" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEDEFAULT, data = "default" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEFAST, data = "fast" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEVERYFAST, data = "veryfast" },
}

local day_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALL.." "..STRINGS.UI.SANDBOXMENU.DAY, data = "onlyday" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALL.." "..STRINGS.UI.SANDBOXMENU.DUSK, data = "onlydusk" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALL.." "..STRINGS.UI.SANDBOXMENU.NIGHT, data = "onlynight" },
	
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEDEFAULT, data = "default" },

	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.DAY, data = "longday" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.DUSK, data = "longdusk" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.NIGHT, data = "longnight" },
}

local season_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALL.." "..STRINGS.UI.SANDBOXMENU.SUMMER, data = "onlysummer" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEALL.." "..STRINGS.UI.SANDBOXMENU.WINTER, data = "onlywinter" },
	
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEDEFAULT, data = "default" },

	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.SUMMER, data = "longsummer" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.WINTER, data = "longwinter" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDELONG.." "..STRINGS.UI.SANDBOXMENU.BOTH, data = "longboth" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESHORT.." "..STRINGS.UI.SANDBOXMENU.BOTH, data = "shortboth" },
}

local season_start_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SUMMER, data = "summer"},-- 	image = "data/images/customisation/season_start_summer.tex" },
	{ text = STRINGS.UI.SANDBOXMENU.WINTER, data = "winter"},-- 	image = "data/images/customisation/season_start_winter.tex" },
}

local size_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESMALL, data = "default"},-- 	image = "data/images/customisation/world_size_small.tex"}, 	--350x350
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESMEDIUM, data = "medium"},-- 	image = "data/images/customisation/world_size_medium.tex"},	--450x450
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESLARGE, data = "large"},-- 	image = "data/images/customisation/world_size_large.tex"},	--550x550
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESHUGE, data = "huge"},-- 		image = "data/images/customisation/world_size_huge.tex"},	--800x800
}

local branching_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.BRANCHINGNEVER, data = "never" },
	{ text = STRINGS.UI.SANDBOXMENU.BRANCHINGLEAST, data = "least" },
	{ text = STRINGS.UI.SANDBOXMENU.BRANCHINGANY, data = "default" },
	{ text = STRINGS.UI.SANDBOXMENU.BRANCHINGMOST, data = "most" },
}

local loop_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.LOOPNEVER, data = "never" },
	{ text = STRINGS.UI.SANDBOXMENU.LOOPRANDOM, data = "default" },
	{ text = STRINGS.UI.SANDBOXMENU.LOOPALWAYS, data = "always" },
}

local complexity_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEVERYSIMPLE, data = "verysimple" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDESIMPLE, data = "simple" },
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEDEFAULT, data = "default" },	
	{ text = STRINGS.UI.SANDBOXMENU.SLIDECOMPLEX, data = "complex" },	
	{ text = STRINGS.UI.SANDBOXMENU.SLIDEVERYCOMPLEX, data = "verycomplex" },	
}

-- Read this from the levels.lua
local preset_descriptions = {
}

-- TODO: Read this from the tasks.lua
local yesno_descriptions = {
	{ text = STRINGS.UI.SANDBOXMENU.NO, data = "no" },
	{ text = STRINGS.UI.SANDBOXMENU.YES, data = "yes" },
}

local GROUP = {
	["monsters"] = 	{	-- These guys come after you	
						text = STRINGS.UI.SANDBOXMENU.CHOICEMONSTERS, 
						desc = freqency_descriptions,
						enable = false,
						items={
							["spiders"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/spiders.tex"}, 
							["tentacles"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/tentacles.tex"}, 
							["hounds"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/hounds.tex"}, 
							["liefs"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/liefs.tex"}, 
							["deerclops"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/deerclops.tex"}, 
							--["mactusk"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/mactusk.tex"}, 
							--["merm"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/merm.tex"}, 
						}
					},
	["animals"] =  	{	-- These guys live and let live
						text = STRINGS.UI.SANDBOXMENU.CHOICEANIMALS, 
						desc = freqency_descriptions,
						enable = false,
						items={
							["pigs"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/pigs.tex"}, 
							["tallbirds"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/tallbirds.tex"}, 
							["rabbits"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/rabbits.tex"}, 
							["beefalo"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/beefalo.tex"}, 
							["beefaloheat"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/beefaloheat.tex"}, 
							["frogs"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/frogs.tex"}, 
							["bees"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/bees.tex"}, 
							["perd"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/perd.tex"}, 
						}
					},
	["resources"] = {
						text = STRINGS.UI.SANDBOXMENU.CHOICERESOURCES, 
						desc = freqency_descriptions,
						enable = false,
						items={
							["grass"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/grass.tex"}, 
							["rock"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/rock.tex"}, 
							["sapling"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/sapling.tex"}, 
							["reeds"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/reeds.tex"}, 
							["trees"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/trees.tex"}, 
						}
					},
	["unprepared"] ={
						text = STRINGS.UI.SANDBOXMENU.CHOICEFOOD, 
						desc = freqency_descriptions,
						enable = true,
						items={
							["carrot"] = {value = "default", enable = true, spinner = nil, image = "data/images/customisation/carrot.tex",
--											images ={
--												"data/images/customisation/carrot_never.tex",
--												"data/images/customisation/carrot_rare.tex",
--												"data/images/customisation/carrot_default.tex",
--												"data/images/customisation/carrot_often.tex",
--												"data/images/customisation/carrot_always.tex",
--											}
										}, 
							["berrybush"] = {value = "default", enable = true, spinner = nil, image = "data/images/customisation/berrybush.tex"}, 
							--["flowers"] = {value = "default", enable = true, spinner = nil, image = "data/images/customisation/flowers.tex"}, 
						}
					},
	["misc"] =		{
						text = STRINGS.UI.SANDBOXMENU.CHOICEMISC, 
						desc = nil,
						enable = true,
						items={
							["day"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/day.tex", desc = day_descriptions}, 
							["season"] = {value = "default", enable = true, spinner = nil, image = "data/images/customisation/season.tex", desc = season_descriptions}, 
							["season_start"] = {value = "summer", enable = false, spinner = nil, image = "data/images/customisation/season_start.tex", desc = season_start_descriptions}, 
							["weather"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/rain.tex", desc = freqency_descriptions}, 
							["lightning"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/lightning.tex", desc = freqency_descriptions}, 
							["world_size"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/world_size.tex", desc = size_descriptions}, 
							["branching"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/world_branching.tex", desc = branching_descriptions}, 
							["loop"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/world_loop.tex", desc = loop_descriptions}, 
--							["world_complexity"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/world_complexity.tex", desc = complexity_descriptions}, 
							["boons"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/skeletons.tex", desc = freqency_descriptions}, 
							["touchstone"] = {value = "default", enable = false, spinner = nil, image = "data/images/customisation/resurrection.tex", desc = freqency_descriptions}, 
						}
					},
}

local function GetGroupForItem(target)
	for area,items in pairs(GROUP) do
		for name,item in pairs(items.items) do
			if name == target then
				return area
			end
		end
	end
	return "misc"
end

return {GetGroupForItem=GetGroupForItem, GROUP=GROUP, preset_descriptions=preset_descriptions}
