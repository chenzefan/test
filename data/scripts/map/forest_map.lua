
local trees = {"evergreen_short", "evergreen_normal", "evergreen_tall"}
local function tree()
    return "evergreen"--trees[math.random(#trees)]
end

require "map/terrain"
local function pickspawnprefab(items_in, ground_type)
--	if ground_type == GROUND.ROAD then
--		return
--	end
	local items = {}
	if ground_type ~= nil then		
		-- Filter the items
	    for item,v in pairs(items_in) do
	    	items[item] = items_in[item]
	        if terrain.filter[item]~= nil then
--	        	if ground_type == GROUND.ROAD then
--	        		print ("Filter", item, terrain.filter.Print(terrain.filter[item]), GROUND_NAMES[ground_type])
--	        	end
	        	
	            for idx,gt in ipairs(terrain.filter[item]) do
        			if gt == ground_type then
        				items[item] = nil
        				--print ("Filtered", item, GROUND_NAMES[ground_type], " (".. terrain.filter.Print(terrain.filter[item])..")")
        			end
   				end        
	        end 
	    end
	end
    local total = 0
    for k,v in pairs(items) do
        total = total + v
    end
    if total > 0 then
        local rnd = math.random()*total
        for k,v in pairs(items) do
            rnd = rnd - v
            if rnd <= 0 then
                return k
            end
        end
    end
end

local function pickspawngroup(groups)
    for k,v in pairs(groups) do
        if math.random() < v.percent then
            return v
        end
    end
end

local MULTIPLY = {
	["never"] = 0,
	["rare"] = 0.5,
	["default"] = 1,
	["often"] = 1.5,
	["always"] = 3,		
	}

	
local TRANSLATE_TO_PREFABS = {
	["spiders"] = 	{"spiderden"},
	["tentacles"] = {"tentacle"},
	["tallbirds"] = {"tallbirdnest"},
	["pigs"] = 		{"pighouse"},
	["rabbits"] = 	{"rabbithole"},
	["beefalo"] = 	{"beefalo"},
	["frogs"] = 	{"pond"},
	["bees"] = 		{"killerbee", "beehive"},
	["grass"] = 	{"grass"},
	["rocks"] = 	{"rocks"}, 
	["sapling"] = 	{"sapling"},
	["reeds"] = 	{"reeds"},	
	["trees"] = 	{"evergreen"},	
	["evergreen"] = {"evergreen"},	
	["carrot"] = 	{"carrot_planted"},
	["berrybush"] = {"berrybush", "berrybush2"},
	}

local customise = require("map/customise")
local function TranslateWorldGenChoices(world_gen_choices)
	if world_gen_choices == nil or GetTableSize(world_gen_choices["tweak"]) == 0 then
		return nil, nil
	end
	
	local translated = {}
	local runtime_overrides = {}
	
	for group, items in pairs(world_gen_choices["tweak"]) do
		for selected, v in pairs(items) do
			if v ~= "default" then
				if TRANSLATE_TO_PREFABS[selected] == nil then
					local area = customise.GetGroupForItem(selected)
					-- Modify world now
					if runtime_overrides[area] == nil then
						runtime_overrides[area] = {}
					end
					table.insert(runtime_overrides[area], {selected, v})
				else
					for i,prefab in ipairs(TRANSLATE_TO_PREFABS[selected]) do
						translated[prefab] = MULTIPLY[v]
					end	
				end	
			end	
		end
	end
	
	if GetTableSize(translated) == 0 then
		translated = nil
	end

	if GetTableSize(runtime_overrides) == 0 then
		runtime_overrides = nil
	end

	return translated, runtime_overrides
end
	
local function UpdatePercentage(distributeprefabs, world_gen_choices)
	for selected, v in pairs(world_gen_choices) do
		if v ~= "default" then		
			for i, prefab in ipairs(TRANSLATE_TO_PREFABS[selected]) do
				if distributeprefabs[prefab] ~= nil then
					distributeprefabs[prefab] = distributeprefabs[prefab] * MULTIPLY[v]
				end
			end
		end
	end
end
	
local function UpdateTerrainValues(world_gen_choices)
	if world_gen_choices == nil or GetTableSize(world_gen_choices) == 0 then
		return
	end

	for name,val in pairs(terrain.base) do
		if val.contents.distributeprefabs ~= nil then
			UpdatePercentage(val.contents.distributeprefabs, world_gen_choices)
		end
	end
	
	for name,val in pairs(terrain.special) do
		if val.contents.distributeprefabs ~= nil then
			UpdatePercentage(val.contents.distributeprefabs, world_gen_choices)
		end
	end
end


local function GenerateVoro(prefab, map_width, map_height, tasks, world_gen_choices, level_type)
	--print("Generate",prefab, map_width, map_height, tasks, world_gen_choices, level_type)
	local start_time = GetTimeReal()

    local SpawnFunctions = {
        pickspawnprefab = pickspawnprefab, 
        pickspawngroup = pickspawngroup, 
    }

    local check_col = {}
    
	require "map/storygen"	
	require "prefabs/forest"
	
  	local current_gen_params = deepcopy(world_gen_choices)
	
	local start_node_override = nil
	local islandpercent = nil
	local story_gen_params = {}

	story_gen_params.level_type = level_type
	
	if current_gen_params["tweak"] ~=nil and current_gen_params["tweak"]["misc"] ~= nil then
		if  current_gen_params["tweak"]["misc"]["start_setpeice"] ~= nil then
			story_gen_params.start_setpeice = current_gen_params["tweak"]["misc"]["start_setpeice"]
			current_gen_params["tweak"]["misc"]["start_setpeice"] = nil
		end

		if  current_gen_params["tweak"]["misc"]["start_node"] ~= nil then
			story_gen_params.start_node = current_gen_params["tweak"]["misc"]["start_node"]
			current_gen_params["tweak"]["misc"]["start_node"] = nil
		end
		
		if  current_gen_params["tweak"]["misc"]["islands"] ~= nil then
			local percent = {always=1, never=0,default=0.2, sometimes=0.1, often=0.8}
			story_gen_params.island_percent = percent[current_gen_params["tweak"]["misc"]["islands"]]
			current_gen_params["tweak"]["misc"]["islands"] = nil
		end

		if  current_gen_params["tweak"]["misc"]["branching"] ~= nil then
			story_gen_params.branching = current_gen_params["tweak"]["misc"]["branching"]
			current_gen_params["tweak"]["misc"]["branching"] = nil
		end

		if  current_gen_params["tweak"]["misc"]["loop"] ~= nil then
			local loop_percent = { never=0, default=nil, always=1.0 }
			local loop_target = { never="any", default=nil, always="end"}
			story_gen_params.loop_percent = loop_percent[current_gen_params["tweak"]["misc"]["loop"]]
			story_gen_params.loop_target = loop_target[current_gen_params["tweak"]["misc"]["loop"]]
			current_gen_params["tweak"]["misc"]["loop"] = nil
		end
	end

    print("Creating story...")
	local topology_save = TEST_STORY(tasks, story_gen_params)

	local entities = {}
 
    local save = {}
    save.ents = {}
    

    --save out the map
    save.map = {
        revealed = "",
        tiles = "",
    }
    
    save.map.prefab = prefab  
   
	local min_size = 350
	if current_gen_params["tweak"] ~= nil and current_gen_params["tweak"]["misc"] ~= nil and current_gen_params["tweak"]["misc"]["world_size"] ~= nil then
		local sizes ={
			["default"] = 350,
			["medium"] = 475,
			["large"] = 625,
			["huge"] = 800,
			}
			
		min_size = sizes[current_gen_params["tweak"]["misc"]["world_size"]]
		--print("New size:", min_size, current_gen_params["tweak"]["misc"]["world_size"])
		current_gen_params["tweak"]["misc"]["world_size"] = nil
	end
		
	map_width = min_size
	map_height = min_size
    
    WorldSim:SetWorldSize( map_width, map_height)
    
    print("Baking map...",min_size)
    	
  	if WorldSim:GenerateVoronoiMap(math.random(), 0) == false then--math.random(0,100)) -- AM: Dont use the tend
  		return nil
  	end

	topology_save.root:ApplyPoisonTag()
  		
	WorldSim:ConvertToTileMap(min_size)

	WorldSim:SeparateIslands()
    print("Map Baked!")
	map_width, map_height = WorldSim:GetWorldSize()
	
	local join_islands = string.upper(level_type) ~= "ADVENTURE"

	WorldSim:ForceConnectivity()
    
	topology_save.root:SwapWormholesAndRoadsExtra(entities, map_width, map_height)
	
    WorldSim:SetRoadParameters(
		ROAD_PARAMETERS.NUM_SUBDIVISIONS_PER_SEGMENT,
		ROAD_PARAMETERS.MIN_WIDTH, ROAD_PARAMETERS.MAX_WIDTH,
		ROAD_PARAMETERS.MIN_EDGE_WIDTH, ROAD_PARAMETERS.MAX_EDGE_WIDTH )
	
	WorldSim:DrawRoads(join_islands) 
    
    print("Encoding...")
    
    save.map.topology = {}
    topology_save.root:SaveEncode({width=map_width, height=map_height}, save.map.topology)
    print("Encoding... DONE")

    -- TODO: Double check that each of the rooms has enough space (minimimum # tiles generated) - maybe countprefabs + %
    -- For each item in the topology list
    -- Get number of tiles for that node
    -- if any are less than minumum - restart the generation

    for idx,val in ipairs(save.map.topology.nodes) do
		if string.find(save.map.topology.ids[idx], "LOOP_BLANK_SUB") == nil  then    
 	    	local area = WorldSim:GetSiteArea(save.map.topology.ids[idx])
	    	if area < 8 then
	    		print ("ERROR: Site "..save.map.topology.ids[idx].." area < 8: "..area)
	    		return nil
	   		end
	   	end
	end
		
	if current_gen_params["tweak"] ~=nil and current_gen_params["tweak"]["misc"] ~= nil then
		if save.map.persistdata == nil then
			save.map.persistdata = {}
		end
		
		local day = current_gen_params["tweak"]["misc"]["day"]
		if day ~= nil then
			save.map.persistdata.clock = {}
		end
		
		if day == "onlynight" then
			save.map.persistdata.clock.phase="night"
		end
		if day == "onlydusk" then
			save.map.persistdata.clock.phase="dusk"
		end
	
		local season = current_gen_params["tweak"]["misc"]["season_start"]
		if season ~= nil then			
			if save.map.persistdata.seasonmanager == nil then
				save.map.persistdata.seasonmanager = {}
			end

			save.map.persistdata.seasonmanager.current_season = season
			if season == "winter" then
				save.map.persistdata.seasonmanager.ground_snow_level = 1
				save.map.persistdata.seasonmanager.percent_season = 0.5
			end
			
			current_gen_params["tweak"]["misc"]["season_start"] = nil		
		end
	end
	
	local runtime_overrides = nil
    current_gen_params, runtime_overrides = TranslateWorldGenChoices(current_gen_params)

    print("Populating voronoi...")

	topology_save.root:GlobalPrePopulate(entities, map_width, map_height)
    topology_save.root:ConvertGround(SpawnFunctions, entities, map_width, map_height)
   	topology_save.root:PopulateVoronoi(SpawnFunctions, entities, map_width, map_height, current_gen_params)
	topology_save.root:GlobalPostPopulate(entities, map_width, map_height)

    save.map.tiles, save.map.nav, save.map.adj = WorldSim:GetEncodedMap(join_islands)

   	-- TEMP HACK: add it to the "START" node, should really just restart world gen
   	local double_check = {"teleportato_ring",  "teleportato_box",  "teleportato_crank", "teleportato_potato", "teleportato_base", "chester_eyebone",}
	if level_type ~= "adventure" then
		table.insert(double_check, "adventure_portal")
	end
--   	local points_x, points_y, points_type = WorldSim:GetPointsForSite("START")
--   	if points_x == nil or #points_x == 0 then
--   		print("PANIC: missing start space! ")
--   		return nil
--   	end
   	
   	local current_pos_idx = 1
   	for i,k in ipairs(double_check) do
   		if entities[k] == nil then
   			print("PANIC: missing teleportato part! ",k)
			return nil
		end			
	end
   	
   	save.map.topology.overrides = runtime_overrides
	if save.map.topology.overrides == nil then
		save.map.topology.overrides = {}
	end
   	save.map.topology.overrides.original = world_gen_choices
   	--dumptable(save.map.topology.overrides)
   	
   	if current_gen_params ~= nil then
	   	-- Filter out any etities over our overrides
		for prefab,amt in pairs(current_gen_params) do
			if amt < 1 and entities[prefab] ~= nil and #entities[prefab] > 0 then
				local new_amt = math.floor(#entities[prefab]*amt)
				if new_amt == 0 then
					entities[prefab] = nil
				else
					entities[prefab] = shuffleArray(entities[prefab])
					while #entities[prefab] > new_amt do
						table.remove(entities[prefab], 1)
					end
				end
			end
		end	
	end
   	
   	
    save.ents = entities
    
    -- TODO: Double check that the entities are all existing in the world
    -- For each item in each room of the room list
	--
    
    save.map.width, save.map.height = map_width, map_height

    save.playerinfo = {}
	if save.ents.spawnpoint == nil then
    	print("PANIC: No start location!")
    	return nil
    end
    
   	save.playerinfo.x = save.ents.spawnpoint[1].x
    save.playerinfo.z = save.ents.spawnpoint[1].z
    save.playerinfo.y = 0
    
    save.ents.spawnpoint = nil

    save.playerinfo.day = 0
    save.map.roads = {}
    
    if world_gen_choices["tweak"] == nil or world_gen_choices["tweak"]["misc"] == nil or world_gen_choices["tweak"]["misc"]["roads"] ~= nil or world_gen_choices["tweak"]["misc"]["roads"] ~= "never" then
	    local num_roads, road_weight, points_x, points_y = WorldSim:GetRoad(0, join_islands)
	    local current_road = 1
	    local min_road_length = math.random(3,5)
	   	print("Building roads... Min Length:"..min_road_length)
	   	
	    
	    if #points_x>=min_road_length then
	    	save.map.roads[current_road] = {3}
			for current_pos_idx = 1, #points_x  do
					local x = math.floor((points_x[current_pos_idx] - map_width/2.0)*TILE_SCALE*10)/10.0
					local y = math.floor((points_y[current_pos_idx] - map_height/2.0)*TILE_SCALE*10)/10.0
					
					table.insert(save.map.roads[current_road], {x, y})
			end
			current_road = current_road + 1
		end
		
	    for current_road = current_road, num_roads  do
	    	
	    	num_roads, road_weight, points_x, points_y = WorldSim:GetRoad(current_road-1, join_islands)
	    	    
	    	if #points_x>=min_road_length then    	
		    	save.map.roads[current_road] = {road_weight}
			    for current_pos_idx = 1, #points_x  do
					local x = math.floor((points_x[current_pos_idx] - map_width/2.0)*TILE_SCALE*10)/10.0
					local y = math.floor((points_y[current_pos_idx] - map_height/2.0)*TILE_SCALE*10)/10.0
					
					table.insert(save.map.roads[current_road], {x, y})
				end
			end
		end
	end
    print("Done forest map gen!")

	return save
end

return {
    Generate = GenerateVoro
}
