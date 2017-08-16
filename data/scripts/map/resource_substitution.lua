local substitution_list = {
	["rock1"] = 		{"basalt"},--, "plainrock"},
	["rock2"] = 		{"basalt"},--, "plainrock"},
	["evergreen"] = 	{ "evergreen_stump", "evergreen_sparse", "marsh_tree"}, --, "leif"
	["evergreen_normal"] = 	{"evergreen_burnt", "evergreen_stump", "evergreen_sparse", "marsh_tree"},-- "leif"}, 
	["evergreen_short"] = 	{"evergreen_burnt", "evergreen_stump", "evergreen_sparse", "marsh_tree"},-- "leif"}, 
	["evergreen_tall"] = 	{"evergreen_burnt", "evergreen_stump", "evergreen_sparse", "marsh_tree"},-- "leif"}, 
	["grass"] 	= 		{"depleted_grass"},
	["sapling"] = 		{"marsh_bush"}, --  "depleted_sapling"},
--	["berrybush"] = 	{"berrybush", "depleted_berrybush"},
	["beefalo"] = 		{"rabbithole"},
	["rabbithole"] = 	{"beefalo"},
	["spiderden"] =		{"spiderden_2", "spiderden_3"},
}

local function GetSubstitute(item)
	if substitution_list[item] == nil then
		--print ("GetSubstitute", item, "not found in list")
		return item
	end

	-- TODO: Weighted list --  weighted_random_choice(choices)
	return GetRandomItem(substitution_list[item])
end

return {GetSubstitute = GetSubstitute}
