--local BAD_CONNECT = 219000 -- 
--SEED = 372000 -- Force roads test level 3
if SEED == nil then
	SEED = getrealtime()
end

print ("SEED = ", SEED)
math.randomseed(SEED)

--print ("worldgen_main.lua MAIN = 1")

MAIN = 1

--install our crazy loader! MUST BE HERE FOR NACL
local loadfn = function(modulename)
    local errmsg = ""
    local modulepath = string.gsub(modulename, "%.", "/")
    for path in string.gmatch(package.path, "([^;]+)") do
        local filename = string.gsub(path, "%?", modulepath)
        filename = string.gsub(filename, "\\", "/")
        local result = kleiloadlua(filename)
        if result then
            return result
        end
        errmsg = errmsg.."\n\tno file '"..filename.."' (checked with custom loader)"
    end
  return errmsg    
end
table.insert(package.loaders, 1, loadfn)

local basedir = "./"
--patch this function because NACL has no fopen
if TheSim then
    basedir = "data/scripts/"
    function loadfile(filename)
        return kleiloadlua(filename)
    end
end


require("mods")
require("simutil")
require("strict")
require("json")
require("vector3")
require("tuning")
require("languages/language")
require("strings")
require("constants")
require("class")
require("debugtools")
require("util")
require("prefabs")
require("profiler")
require("dumper")
require("map/tasks")

print ("running worldgen_main.lua\n")


local basedir = "./"

local last_tick_seen = -1


local PendingUpdateFns = {}
function CallOnNextUpdate(fn)
    PendingUpdateFns[fn] = true
end



------TIME FUNCTIONS

function GetTickTime()
    return 0
end

local ticktime = GetTickTime()
function GetTime()
    return 0
end

function GetTick()
    return 0
end

function GetTimeReal()
    return getrealtime()
end

---SCRIPTING
local Scripts = {}

function LoadScript(filename)
    if not Scripts[filename] then
        local scriptfn = loadfile("data/scripts/" .. filename)
        Scripts[filename] = scriptfn()
    end
    return Scripts[filename]
end


function RunScript(filename)
    local fn = LoadScript(filename)
    if fn then
        fn()
    end
end

function GetDebugString()
    return tostring(scheduler)
end
------------------------------

--- non-user-facing Tracking stats  ---
TrackingEventsStats = {}
TrackingTimingStats = {}
function IncTrackingStat(stat, subtable)

    local t = TrackingEventsStats
    if subtable then
        t = TrackingEventsStats[subtable]

        if not t then
            t = {}
            TrackingEventsStats[subtable] = t
        end
    end

    t[stat] = 1 + (t[stat] or 0)
end

function SetTimingStat(subtable, stat, value)

    local t = TrackingTimingStats
    if subtable then
        t = TrackingTimingStats[subtable]

        if not t then
            t = {}
            TrackingTimingStats[subtable] = t
        end
    end

    t[stat] = math.floor(value/1000)
end

--- GAME Stats and details to be sent to server on game complete ---
ProfileStats = {}

function GetProfileStats()
	if GetTableSize(ProfileStats) then
    	return json.encode({
    						stats = ProfileStats
    						})
    else
    	return json.encode({})
    end
end

function ProfileStatsSet(item, value)
    ProfileStats[item] = value
end

function ProfileStatsAdd(item)
    --print ("ProfileStatsAdd", item)
    if ProfileStats[item] then
    	ProfileStats[item] = ProfileStats[item] +1
    else
    	ProfileStats[item] = 1
    end
end

function ProfileStatsAddItemChunk(item, chunk)
    if ProfileStats[item] == nil then
    	ProfileStats[item] = {}
    end

    if ProfileStats[item][chunk] then
    	ProfileStats[item][chunk] =ProfileStats[item][chunk] +1
    else
    	ProfileStats[item][chunk] = 1
    end
end




function PROFILE_world_gen(debug)
	require("profiler")
	local profiler = newProfiler("time", 100000)
	profiler:start()    
        
	local strdata = LoadParametersAndGenerate(debug)
	
	profiler:stop()
	local outfile = io.open( "profile.txt", "w+" )
	profiler:report(outfile)
	outfile:close()
	local tmp = {}
	
	profiler:lua_report(tmp)
	require("debugtools")
	dumptable(profiler)
	
	return strdata
end

function ShowDebug(savedata)
	local item_table = { }
	
	for id, locs in pairs(savedata.ents) do		
		for i, pos in ipairs(locs) do
			local misc = -1
			if string.find(id, "wormhole") ~= nil then
				if pos.data and pos.data.teleporter and pos.data.teleporter.target then
					misc = pos.data.teleporter.target - 2300000
				end
			end
			table.insert(item_table, {id, pos.x/TILE_SCALE + savedata.map.width/2.0, pos.z/TILE_SCALE + savedata.map.height/2.0, misc})
		end
	end

	WorldSim:ShowDebugItems(item_table)			
end

function CheckMapSaveData(savedata)
	print("Checking map...")
        
    assert(savedata.map, "Map missing from savedata on generate")
    assert(savedata.map.prefab, "Map prefab missing from savedata on generate")
    assert(savedata.map.tiles, "Map tiles missing from savedata on generate")
    assert(savedata.map.width, "Map width missing from savedata on generate")
    assert(savedata.map.height, "Map height missing from savedata on generate")
	assert(savedata.map.topology, "Map topology missing from savedata on generate")
        
	assert(savedata.playerinfo, "Playerinfo missing from savedata on generate")
	assert(savedata.playerinfo.x, "Playerinfo.x missing from savedata on generate")
	assert(savedata.playerinfo.y, "Playerinfo.y missing from savedata on generate")
	assert(savedata.playerinfo.z, "Playerinfo.z missing from savedata on generate")
	assert(savedata.playerinfo.day, "Playerinfo day missing from savedata on generate")

	assert(savedata.ents, "Entites missing from savedata on generate")
end

local function OverrideTweeks(level, world_gen_choices)
	local customise = require("map/customise")
	for i,v in ipairs(level.overrides) do
		local name = v[1]
		if type(name) == type({}) then
			name = name[math.random(#name)]
		end
		local area = customise.GetGroupForItem(name)
		-- Modify world now
		if world_gen_choices["tweak"] == nil then
			world_gen_choices["tweak"] = {}
		end
		if world_gen_choices["tweak"][area] == nil then
			world_gen_choices["tweak"][area] = {}
		end
		world_gen_choices["tweak"][area][name]=v[2]
	end
end

function GetPOIandTrap(trapchoices, poichoices)
	-- Get some random POI or traps
	local target_area_keys = {}
	for k,v in pairs(trapchoices) do
		table.insert(target_area_keys, k)
	end
	local trap_area = target_area_keys[math.random(#target_area_keys)]
	local trap_target = nil
	if (trap_area == "Rare" and math.random()<0.98) or GetTableSize(trapchoices[trap_area]) <1 then
		trap_target = nil
	else
		trap_target = {target_area=trap_area, choice=GetRandomKey(trapchoices[trap_area])}--GetRandomItem
	end

	target_area_keys = {}
	for k,v in pairs(poichoices) do
		table.insert(target_area_keys, k)
	end
	local POI_area = target_area_keys[math.random(#target_area_keys)]
	local POI_target = nil
	if (POI_area == "Rare" and math.random()<0.98) or GetTableSize(poichoices[POI_area]) < 1 then
		POI_target = nil
	else
		POI_target = {target_area=POI_area, choice=GetRandomKey(poichoices[POI_area])}
	end

	return trap_target, POI_target
end

function GetAreasForChoice(area, level)
	local areas = {}

	for i, task_name in ipairs(level.tasks) do
		local task = tasks.GetTaskByName(task_name, tasks.sampletasks)
		if area == "Any" or area == "Rare" or  area == INV_GROUND_VALUES[task.room_bg] then
			table.insert(areas, task_name)
		end
	end
	if #areas ==0 then
		return nil
	end
	return areas
end

function GenerateNew(debug, parameters)
    
    --print("Generate New map",debug, parameters.gen_type, parameters.level_type, parameters.current_level, parameters.world_gen_choices)
	local Gen = require "map/forest_map"
	require("map/map")
	
	require("map/levels")

	local Traps = require("map/traps")
	local PointsOfInterest = require("map/pointsofinterest")

	local choose_tasks = nil
	local level_area_triggers = nil
	local maxwell = STRINGS.MAXWELL_QUEST_SURVIVE[1]
	local name = nil
	local hideminimap = false
	if parameters.level_type and string.upper(parameters.level_type) == "ADVENTURE" then
		if parameters.current_level > #levels.story_levels then
			parameters.current_level = #levels.story_levels
		end
		local level = levels.story_levels[parameters.current_level]
		maxwell = level.maxwell 
		name = level.name
		hideminimap = level.hideminimap
		OverrideTweeks(level, parameters.world_gen_choices)
		print("\n#######\n#\n# Generating "..level.name.."("..parameters.current_level..")".."\n#\n#######\n")
		choose_tasks = level:GetTasksForLevel(tasks.sampletasks)
		level_area_triggers = level.override_triggers
	elseif parameters.level_type and string.upper(parameters.level_type) == "TEST" then
		print("\n#######\n#\n# Generating TEST Mode Level\n#\n#######\n")
		OverrideTweeks(levels.test_level, parameters.world_gen_choices)
		choose_tasks = levels.test_level:GetTasksForLevel(tasks.sampletasks)
		level_area_triggers = levels.test_level.override_triggers
	else
		if parameters.world_gen_choices.level_id == nil or parameters.world_gen_choices.level_id > #levels.sandbox_levels then
			parameters.world_gen_choices.level_id = 1
		end
		
		local level = levels.sandbox_levels[parameters.world_gen_choices.level_id]
		print("\n#######\n#\n# Generating Normal Mode "..level.name.." Level\n#\n#######\n")
		OverrideTweeks(level, parameters.world_gen_choices)
		level_area_triggers = level.override_triggers

		local trap_choice, poi_choice = GetPOIandTrap(Traps.Sandbox, PointsOfInterest.Sandbox)
		if trap_choice ~= nil or poi_choice ~= nil then
			if level.set_pieces == nil then
				level.set_pieces = {}
			end

			if trap_choice ~= nil then				
				local areas = GetAreasForChoice(trap_choice.target_area, level)
				if areas then
					level.set_pieces[trap_choice.choice] = {tasks=areas}
				end
			end
			if poi_choice ~= nil then				
				local areas = GetAreasForChoice(poi_choice.target_area, level)
				if areas then
					level.set_pieces[poi_choice.choice] = {tasks=areas}
				end
			end

		end
		maxwell = level.maxwell 
		hideminimap = level.hideminimap
		choose_tasks = level:GetTasksForLevel(tasks.sampletasks)
	end
	
	
	if debug == true then
	 	 choose_tasks = tasks.oneofeverything
	end
    --print ("Generating new world","forest", max_map_width, max_map_height, choose_tasks)
        
	local savedata = nil

	local max_map_width = 1024 -- 1024--256 
	local max_map_height = 1024 -- 1024--256 
	
	local try = 1
	local maxtries = 15
	
	while savedata == nil do
		savedata = Gen.Generate("forest", max_map_width, max_map_height, choose_tasks, parameters.world_gen_choices, parameters.level_type)	
		
		if savedata == nil then
			print("An error occured during world gen we will retry! [",try," of ",maxtries,"]")
			try = try + 1
			
			assert(try <= maxtries, "Maximum world gen retries reached!")
			collectgarbage("collect")
			WorldSim:ResetAll()
		elseif GEN_PARAMETERS == "" or parameters.show_debug == true then			
			ShowDebug(savedata)
		end
	end
	
	savedata.map.topology.level_type = parameters.level_type
	savedata.map.topology.level_number = parameters.current_level
	savedata.map.maxwell = maxwell
	savedata.map.name = name
	savedata.map.hideminimap = hideminimap
	
	savedata.map.topology.override_triggers = level_area_triggers
	CheckMapSaveData(savedata)
		
	-- Clear out scaffolding :)
	for i=#savedata.map.topology.ids,1, -1 do
		local name = savedata.map.topology.ids[i]
		if string.find(name, "LOOP_BLANK_SUB") ~= nil  then
			table.remove(savedata.map.topology.ids, i)
			table.remove(savedata.map.topology.nodes, i)
			for eid=#savedata.map.topology.edges,1,-1 do
				if savedata.map.topology.edges[eid].n1 == i or savedata.map.topology.edges[eid].n2 == i then
					table.remove(savedata.map.topology.edges, eid)
				end
			end
		end
	end		
	
	print("Generation complete")

	local strdata = DataDumper(savedata, nil, PLATFORM == "NACL")
	return strdata
end

local function LoadParametersAndGenerate(debug)

	local parameters = nil
	if GEN_PARAMETERS == "" then
		print("WARNING: No parameters found, using defaults. This should only happen from the test harness!")
		parameters = { level_type="adventure", current_level=5 }
	else
		parameters = json.decode(GEN_PARAMETERS)
	end
    
    if 	parameters.world_gen_choices == nil then
		parameters.world_gen_choices = {}
    end
	return GenerateNew(debug, parameters)-- parameters.worldgen_type, parameters.level_type, parameters.current_level, parameters.world_gen_choices)
end

return LoadParametersAndGenerate(false)
