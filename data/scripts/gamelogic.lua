require "mods"
require "playerprofile"
require "saveindex"
require "screens/mainscreen"
require "screens/deathscreen"
require "screens/popupdialog"

Print (VERBOSITY.DEBUG, "[Loading frontend assets]")

local start_game_time = nil

TheSim:SetRenderPassDefaultEffect( RENDERPASS.BLOOM, "data/shaders/anim_bloom.ksh" )
TheSim:SetErosionTexture( "data/images/erosion.tex" )

function GetTimePlaying()
	if not start_game_time then
		return 0
	end
	return GetTime() - start_game_time 
end

function CalculatePlayerRewards(wilson)
	local Progression = require "progressionconstants"
	
	print("Calculating progression")
	
	--increment the xp counter and give rewards
	local days_survived = GetClock().numcycles
	local start_xp = wilson.profile:GetXP()
	local reward_xp = Progression.GetXPForDays(days_survived)
	local new_xp = math.min(start_xp + reward_xp, Progression.GetXPCap())
        
	local all_rewards = Progression.GetRewardsForTotalXP(new_xp)
	for k,v in pairs(all_rewards) do
		TheSim:LogMetric("GameEvent","UnlockCharacter",v,"1") 
		wilson.profile:UnlockCharacter(v)
	end
	wilson.profile:SetXP(new_xp)

	print("Progression: ",days_survived, start_xp, reward_xp, new_xp)
	return days_survived, start_xp, reward_xp, new_xp
end


local function HandleDeathCleanup(wilson, data)
    local game_time = GetClock():ToMetricsString()

    if SaveGameIndex:GetCurrentMode() == "survival" then

	    local playtime = GetTimePlaying()
	    playtime = math.floor(playtime*1000)
	    SetTimingStat("time", "scenario", playtime)
	    SendTrackingStats()
	    local days_survived, start_xp, reward_xp, new_xp = CalculatePlayerRewards(wilson)
	    
	    ProfileStatsSet("xp_gain", reward_xp)
	    ProfileStatsSet("xp_total", new_xp)
	    TheSim:LogMetric("GameStat","game_over",game_time,tostring(new_xp)) 
	    SubmitCompletedLevel() --close off the instance
	    wilson.profile:Save(function()
		    SaveGameIndex:EraseCurrent(function() 
				    scheduler:ExecuteInTime(3, function() 
						TheFrontEnd:PushScreen(DeathScreen(days_survived, start_xp))
					end)
		    	end)
		    end)
	else

		SaveGameIndex:OnFailAdventure(function()
		    scheduler:ExecuteInTime(3, function() 
				TheFrontEnd:Fade(false, 3, function()
						local params = json.encode{reset_action="loadslot", save_slot = SaveGameIndex:GetCurrentSaveSlot(), playeranim="wakeup"}
						TheSim:SetInstanceParameters(params)
						TheSim:Reset()
					end)
				end)
			end)	
	end

end

local function OnPlayerDeath(wilson, data)

	local cause = data.cause or "unknown"
	local will_resurrect = wilson.components.resurrectable and wilson.components.resurrectable:CanResurrect() 

	
    TheMixer:PushMix("death")
    wilson.HUD:Hide()
    
    local game_time = GetClock():ToMetricsString()
    
    ProfileStatsAdd("killed_by_"..cause)
    TheSim:LogMetric("GameStat","killed_by",cause,"1") 
    
    ProfileStatsAdd("deaths")
    TheSim:LogMetric("GameStat","player_death",game_time,"1") 

    --local res = TheSim:FindFirstEntityWithTag("resurrector")
    
	if will_resurrect then
        scheduler:ExecuteInTime(4, function()  
            TheMixer:PopMix("death")
            if wilson.components.resurrectable:DoResurrect() then
				ProfileStatsAdd("resurrections")
				TheSim:LogMetric("GameStat","player_resurrect",game_time,"1") 
			else
				HandleDeathCleanup(wilson, data)
			end
        end)
    else
		HandleDeathCleanup(wilson, data)
    end
end


function SetUpPlayerCharacterCallbacks(wilson)
    --set up on ondeath handler
    wilson:ListenForEvent( "death", function(inst, data) OnPlayerDeath(wilson, data) end)
    wilson:ListenForEvent( "quit",
        function()
            Print (VERBOSITY.DEBUG, "I SHOULD QUIT!")
            TheMixer:PushMix("death")
            wilson.HUD:Hide()
            local playtime = GetTimePlaying()
            playtime = math.floor(playtime*1000)
            
            SetTimingStat("time", "scenario", playtime)
            ProfileStatsSet("time_played", playtime)
            SendTrackingStats()
            SendAccumulatedProfileStats()
            TheSim:LogMetric("GameStat","player_quit",GetClock():ToMetricsString(),"1") 
            
			TheSim:SetInstanceParameters()
			TheSim:Reset()
        end)        
    
    wilson:ListenForEvent( "daycomplete", 
        function(it, data) 
            if not wilson.components.health:IsDead() then
                ProfileStatsAdd("nights_survived_iar")
            end
        end, GetWorld()) 
        
    wilson:ListenForEvent( "daytime", 
        function(it, data) 
            if not wilson.components.health:IsDead() then
				print("Day has arrived...")
				SaveGameIndex:SaveCurrent()
 				print("Day begin handled.")
            end
        end, GetWorld()) 
        
    wilson:ListenForEvent("builditem", function(inst, data) TheSim:LogMetric("GameStat","build_item_"..data.item.prefab,GetClock():ToMetricsString(),"1") end)
    wilson:ListenForEvent("buildstructure", function(inst, data) TheSim:LogMetric("GameStat","build_structure_"..data.item.prefab,GetClock():ToMetricsString(),"1") end)
end


local function StartGame(wilson)
	
	TheFrontEnd:GetSound():KillSound("FEMusic") -- just in case...
	
	start_game_time = GetTime()
    TheSim:LogView("InGame", "")
	SetUpPlayerCharacterCallbacks(wilson)
end


local deprecated = { turf_webbing = true }
local replace = { farmplot = "slow_farmplot", farmplot2 = "fast_farmplot", farmplot3 = "fast_farmplot"}

function PopulateWorld(savedata, profile, playercharacter, playersavedataoverride)
    
    playercharacter = playercharacter or "wilson"
	Print(VERBOSITY.DEBUG, "PopulateWorld")
 	Print(VERBOSITY.DEBUG,  "[Instantiating objects...]" )
 	local wilson = nil
    if savedata then

        --figure out our start info
        local spawnpoint = Vector3(0,0,0)
        local playerdata = {}
        if savedata.playerinfo then
        
            if savedata.playerinfo.x and savedata.playerinfo.z then
				local y = savedata.playerinfo.y or 0
                spawnpoint = Vector3(savedata.playerinfo.x, y, savedata.playerinfo.z)
            end
            
            if savedata.playerinfo.data then
                playerdata = savedata.playerinfo.data
            end
        end
        
		if playersavedataoverride then
			playerdata = playersavedataoverride
		end
		
		local newents = {}
		

		TheSim:LoadPrefabs{"forest"}
		local forest = SpawnPrefab("forest")

        --spawn the player character and set him up
        TheSim:LoadPrefabs{playercharacter}
        wilson = SpawnPrefab(playercharacter)
        assert(wilson, "could not spawn player character")
        wilson:SetProfile(Profile)
        wilson.Transform:SetPosition(spawnpoint:Get())
        
        

        --this was spawned by the level file. kinda lame - we should just do everything from in here.
        local ground = GetWorld()
        if ground then
            ground.Map:SetSize(savedata.map.width, savedata.map.height)
            ground.Map:SetFromString(savedata.map.tiles)
            if savedata.map.nav then
            	print("Loading Nav Grid")
            	ground.Map:SetNavSize(savedata.map.width, savedata.map.height)
            	ground.Map:SetNavFromString(savedata.map.nav)
            else
            	print("No Nav Grid")
            end
            ground.Map:Finalize()
			ground.topology = savedata.map.topology
						
			assert(savedata.map.topology.ids, "[MALFORMED SAVE DATA] Map missing topology information. This save file is too old, and is missing neccessary information.")
			
			for i=#savedata.map.topology.ids,1, -1 do
				local name = savedata.map.topology.ids[i]
				if string.find(name, "LOOP_BLANK_SUB") ~= nil then
					table.remove(savedata.map.topology.ids, i)
					table.remove(savedata.map.topology.nodes, i)
					for eid=#savedata.map.topology.edges,1,-1 do
						if savedata.map.topology.edges[eid].n1 == i or savedata.map.topology.edges[eid].n2 == i then
							table.remove(savedata.map.topology.edges, eid)
						end
					end
				end
			end		
			
			if ground.topology.level_number ~= nil then
				require("map/levels")
				if levels.story_levels[ground.topology.level_number] ~= nil then
					profile:UnlockWorldGen("preset", levels.story_levels[ground.topology.level_number].name)
				end
			end
			
			wilson:AddComponent("area_aware")
			--wilson:AddComponent("area_unlock")
			
			if ground.topology.override_triggers then
				wilson:AddComponent("area_trigger")
				
				wilson.components.area_trigger:RegisterTriggers(ground.topology.override_triggers)
			end
				
			
			for i,node in ipairs(ground.topology.nodes) do
				local story = ground.topology.ids[i]
				-- guard for old saves
				local story_depth = nil
				if ground.topology.story_depths then
					story_depth = ground.topology.story_depths[i]
				end
				if story ~= "START" then
					story = string.sub(story, 1, string.find(story,":")-1)
--					
--					if Profile:IsWorldGenUnlocked("tasks", story) == false then
--						wilson.components.area_unlock:RegisterStory(story)
--					end
				end
				wilson.components.area_aware:RegisterArea({idx=i, type=node.type, poly=node.poly, story=story, story_depth=story_depth})
								
				if node.type == "Graveyard" then
					if node.area_emitter == nil then

						local mist = SpawnPrefab( "mist" )
						mist.Transform:SetPosition( node.cent[1], 0, node.cent[2] )
						mist.components.emitter.area_emitter = CreateAreaEmitter( node.poly, node.cent )
						
						if node.area == nil then
							node.area = 1
						end
						
						mist.components.emitter.density_factor = math.ceil(node.area / 4)/31
						mist.components.emitter:Emit()
					end
				end

			end

			if savedata.map.persistdata ~= nil then
				ground:SetPersistData(savedata.map.persistdata)
			end
			
			wilson.components.area_aware:StartCheckingPosition()
        end
        
        
        wilson:SetPersistData(playerdata, newents)
        if wilson.components.health.currenthealth == 0 then
			wilson.components.health.currenthealth = 1
        end
        if savedata.playerinfo and savedata.playerinfo.id then
            newents[savedata.playerinfo.id] = {entity=wilson, data=playerdata} 
        end
        
        
        --set the clock (LEGACY! this is now handled via the world object's normal serialization)
        if savedata.playerinfo.day and savedata.playerinfo.dayphase and savedata.playerinfo.timeleftinera then
	        
			GetClock().numcycles = savedata.playerinfo and savedata.playerinfo.day or 0
			if savedata.playerinfo and savedata.playerinfo.dayphase == "night" then
        		GetClock():StartNight(true)
			elseif savedata.playerinfo and savedata.playerinfo.dayphase == "dusk" then
        		GetClock():StartDusk(true)
      		else 
        		GetClock():StartDay(true)
			end
	        
			if savedata.playerinfo.timeleftinera then
				GetClock().timeLeftInEra = savedata.playerinfo.timeleftinera
			end
		end

		-- Check for map overrides
		if ground.topology.overrides ~= nil and ground.topology.overrides ~= nil and GetTableSize(ground.topology.overrides) > 0 then
			local retune = require("tuning_override")
			
			for area, overrides in pairs(ground.topology.overrides) do	
				for i,override in ipairs(overrides) do	
					if retune.OVERRIDES[override[1]] ~= nil then
						retune.OVERRIDES[override[1]].doit(override[2])
					end
				end
			end
		end
        
        --instantiate all the dudes
        for prefab, ents in pairs(savedata.ents) do
			local prefab = replace[prefab] or prefab
       		if not deprecated[prefab] then
                for k,v in ipairs(ents) do
                    v.prefab = v.prefab or prefab -- prefab field is stripped out when entities are saved in global entity collections, so put it back
					SpawnSaveRecord(v, newents)
				end
			end
        end    
    
        --post pass in neccessary to hook up references
        for k,v in pairs(newents) do
            v.entity:LoadPostPass(newents, v.data)
        end

		--Run scenario scripts
        for guid, ent in pairs(Ents) do
			if ent.components.scenariorunner then
				ent.components.scenariorunner:Run()
			end
		end
        
    
    else
        Print(VERBOSITY.ERROR, "[MALFORMED SAVE DATA] PopulateWorld complete" )
        return
    end

	Print(VERBOSITY.DEBUG, "[FINISHED LOADING SAVED GAME] PopulateWorld complete" )
	return wilson
end


local function DrawDebugGraph(graph)
	-- debug draw of new map gen
	local debugdrawmap = CreateEntity()
	local draw = debugdrawmap.entity:AddDebugRender()
	draw:SetZ(0.1)
	
	
	for idx,node in ipairs(graph.nodes) do
		local colour = graph.colours[node.c]
		
		for i =1, #node.poly-1 do
			draw:Line(node.poly[i][1], node.poly[i][2], node.poly[i+1][1], node.poly[i+1][2], colour.r, colour.g, colour.b, 255)
		end
		draw:Line(node.poly[1][1], node.poly[1][2], node.poly[#node.poly][1], node.poly[#node.poly][2], colour.r, colour.g, colour.b, 255)
		
		draw:Poly(node.cent[1], node.cent[2], colour.r, colour.g, colour.b, colour.a, node.poly)
			
		draw:String(graph.ids[idx].."("..node.cent[1]..","..node.cent[2]..")", 	node.cent[1], node.cent[2], node.ts)
	end 
	
	draw:SetZ(0.15)

	for idx,edge in ipairs(graph.edges) do
		if edge.n1 ~= nil and edge.n2 ~= nil then
			local colour = graph.colours[edge.c]
			
			local n1 = graph.nodes[edge.n1]
			local n2 = graph.nodes[edge.n2]
			if n1 ~= nil and n2 ~= nil then
				draw:Line(n1.cent[1], n1.cent[2], n2.cent[1], n2.cent[2], colour.r, colour.g, colour.b, colour.a)
			end
		end
	end 
end

--OK, we have our savedata and a profile. Instatiate everything and start the game!
function DoInitGame(playercharacter, savedata, profile, next_world_playerdata, fast)	
	--print("DoInitGame",playercharacter, savedata, profile, next_world_playerdata, fast)
	TheFrontEnd:ClearScreens()	

	assert(savedata.map, "Map missing from savedata on load")
	assert(savedata.map.prefab, "Map prefab missing from savedata on load")
	assert(savedata.map.tiles, "Map tiles missing from savedata on load")
	assert(savedata.map.width, "Map width missing from savedata on load")
	assert(savedata.map.height, "Map height missing from savedata on load")
	
	assert(savedata.map.topology, "Map topology missing from savedata on load")
	assert(savedata.map.topology.ids, "Topology entity ids are missing from savedata on load")
	--assert(savedata.map.topology.story_depths, "Topology story_depths are missing from savedata on load")
	assert(savedata.map.topology.colours, "Topology colours are missing from savedata on load")
	assert(savedata.map.topology.edges, "Topology edges are missing from savedata on load")
	assert(savedata.map.topology.nodes, "Topology nodes are missing from savedata on load")
	assert(savedata.map.topology.level_type, "Topology level type is missing from savedata on load")
	assert(savedata.map.topology.overrides, "Topology overrides is missing from savedata on load")
        
	assert(savedata.playerinfo, "Playerinfo missing from savedata on load")
	assert(savedata.playerinfo.x, "Playerinfo.x missing from savedata on load")
	--assert(savedata.playerinfo.y, "Playerinfo.y missing from savedata on load")   --y is often omitted for space, don't check for it
	assert(savedata.playerinfo.z, "Playerinfo.z missing from savedata on load")
	--assert(savedata.playerinfo.day, "Playerinfo day missing from savedata on load")

	assert(savedata.ents, "Entites missing from savedata on load")
	
	if savedata.map.roads then
		Roads = savedata.map.roads
		for k, road_data in pairs( savedata.map.roads ) do
			RoadManager:BeginRoad()
			local weight = road_data[1]
			for i = 2, #road_data do
				local ctrl_pt = road_data[i]
				RoadManager:AddControlPoint( ctrl_pt[1], ctrl_pt[2], ROAD_PARAMETERS.NUM_SUBDIVISIONS_PER_SEGMENT )
			end

			if weight == 3 then
				RoadManager:SetTexture( "data/images/roadnoise.tex" )
				RoadManager:GenerateVB(
						ROAD_PARAMETERS.NUM_SUBDIVISIONS_PER_SEGMENT,
						ROAD_PARAMETERS.MIN_WIDTH, ROAD_PARAMETERS.MAX_WIDTH,
						ROAD_PARAMETERS.MIN_EDGE_WIDTH, ROAD_PARAMETERS.MAX_EDGE_WIDTH )
			else
				RoadManager:SetTexture( "data/images/pathnoise.tex" )
				RoadManager:GenerateVB(
						ROAD_PARAMETERS.NUM_SUBDIVISIONS_PER_SEGMENT,
						0, 0,
						ROAD_PARAMETERS.MIN_EDGE_WIDTH*4, ROAD_PARAMETERS.MAX_EDGE_WIDTH*4 )
			end
		end
		RoadManager:GenerateQuadTree()
	end
	
	SubmitStartStats(playercharacter)
	
    --some lame explicit loads
	Print(VERBOSITY.DEBUG, "DoInitGame Loading prefabs...")
    TheSim:LoadPrefabs{"maxwell", "fire", "character_fire", "shatter"}
    
	Print(VERBOSITY.DEBUG, "DoInitGame Adjusting audio...")
    TheMixer:SetLevel("master", 0)
    
	--apply the volumes
	
	Print(VERBOSITY.DEBUG, "DoInitGame Populating world...")
	
    local wilson = PopulateWorld(savedata, profile, playercharacter, next_world_playerdata)
    if wilson then
		TheCamera:SetTarget(wilson)
		StartGame(wilson)
		TheCamera:SetDefault()
		TheCamera:Snap()
	else
		Print(VERBOSITY.WARNING, "DoInitGame NO WILSON?")
    end
    
    if Profile.persistdata.debug_world  == 1 then
    	if savedata.map.topology == nil then
    		Print(VERBOSITY.ERROR, "OI! Where is my topology info!")
    	else
    		DrawDebugGraph(savedata.map.topology)
     	end
    end
    
    local function OnStart()
    	Print(VERBOSITY.DEBUG, "DoInitGame OnStart Callback... turning volume up")
		SetHUDPause(false)
    end
	
	if not TheFrontEnd:IsDisplayingError() then
		local hud = PlayerHud()
		TheFrontEnd:PushScreen(hud)
		hud:SetMainCharacter(wilson)
		
	    --clear the player stats, so that it doesn't count items "acquired" from the save file
	    GetProfileStats(true)
		
	    --after starting everything up, give the mods additional environment variables
	    ModManager:SimPostInit(wilson)

	    if fast then
	    	OnStart()
	    else
			SetHUDPause(true)

			if Settings.playeranim then
				if Settings.playeranim == "wakeup" then
					GetPlayer().sg:GoToState("wakeup")
				end
			elseif GetClock().numcycles == 0 and GetClock():IsDay() and GetClock():GetNormTime() == 0 then
				local max = SpawnPrefab("maxwellintro")			
				max.components.maxwelltalker:SetSpeech(savedata.map.maxwell)
				max.components.maxwelltalker:Initialize()
				max.task = max:StartThread(function()	max.components.maxwelltalker:DoTalk() end) 
				--PlayNIS("maxwellintro", savedata.map.maxwell)
			end
			if savedata.map.hideminimap ~= nil then
			    hud.minimap:DoTaskInTime(0, function(inst) inst.MiniMap:ClearRevealedAreas(savedata.map.hideminimap) end)
			end
			
			
			local title = STRINGS.UI.SANDBOXMENU.ADVENTURELEVELS[SaveGameIndex:GetSlotWorld()]
			local showtitle = SaveGameIndex:GetCurrentMode() == "adventure" and title
			if showtitle then
				TheFrontEnd:ShowTitle(title)
			end
			
			TheFrontEnd:Fade(true, 1, function() 
				TheMixer:SetLevel("master", 1) 
				TheMixer:PushMix("normal") 
				SetHUDPause(false)
				TheFrontEnd:HideTitle()
				--TheFrontEnd:PushScreen(PopupDialogScreen(STRINGS.UI.HUD.READYTITLE, STRINGS.UI.HUD.READY, {{text=STRINGS.UI.HUD.START, cb = function() OnStart() end}}))
			end, showtitle and 1.5, showtitle and function()  end )
	    end

	end    
	
    --DoStartPause("Ready!")
    Print(VERBOSITY.DEBUG, "DoInitGame complete")
end

------------------------THESE FUNCTION HANDLE STARTUP FLOW


local function DoLoadWorld(saveslot)
	local function onload(savedata)
		DoInitGame(SaveGameIndex:GetSlotCharacter(saveslot), savedata, Profile)
	end
	SaveGameIndex:GetSaveData(saveslot, SaveGameIndex:GetCurrentMode(saveslot), onload)
end

local function DoGenerateWorld(saveslot, type_override)
	SubmitCompletedLevel() -- close off any open games on the server

	local function onComplete(savedata )
		local function onsaved(playerdata)
			local success, world_table = RunInSandbox(savedata)
			if success then
				DoInitGame(SaveGameIndex:GetSlotCharacter(saveslot), world_table, Profile, playerdata)
			end
		end

		SaveGameIndex:OnGenerateNewWorld(saveslot, savedata, onsaved)
	end

	local world_gen_options =
	{
		level_type = type_override or SaveGameIndex:GetCurrentMode(saveslot),
		custom_options = SaveGameIndex:GetSlotGenOptions(saveslot,SaveGameIndex:GetCurrentMode()),
		level_world = SaveGameIndex:GetSlotWorld(saveslot),
	}
	TheFrontEnd:PushScreen(WorldGenScreen(Profile, onComplete, world_gen_options))
end

local function LoadSlot(slot)
	TheFrontEnd:ClearScreens()
	if SaveGameIndex:HasWorld(slot, SaveGameIndex:GetCurrentMode()) then
   		DoLoadWorld(slot)
	else
		if SaveGameIndex:GetCurrentMode(Settings.save_slot) == "survival" and SaveGameIndex:IsContinuePending(Settings.save_slot) then
			
			local function onsave()
				DoGenerateWorld(slot)
			end

			local function onSet(character)
				SaveGameIndex:SetSlotCharacter(Settings.save_slot, character, onsave)
			end
			TheFrontEnd:PushScreen(CharacterSelectScreen(Profile, onSet, true, SaveGameIndex:GetSlotCharacter(Settings.save_slot)))
		else			
			DoGenerateWorld(slot)
		end
	end
end



----------------LOAD THE PROFILE AND THE SAVE INDEX, AND START THE FRONTEND

local function OnFilesLoaded() 
	UpdateGamePurchasedState( function()
		--print( "[Settings]",Settings.character, Settings.savefile)
		if Settings.reset_action then
			if Settings.reset_action == "loadslot" then
				
				if not SaveGameIndex:GetCurrentMode(Settings.save_slot) then
					TheFrontEnd:ShowScreen(MainScreen(Profile))
				else
					LoadSlot(Settings.save_slot)
				end
			elseif Settings.reset_action == "test" then
				DoGenerateWorld(1, "test")
			else
				TheFrontEnd:ShowScreen(MainScreen(Profile))
			end
		else
			TheFrontEnd:ShowScreen(MainScreen(Profile))
		end
	end)
end


Profile = PlayerProfile()
SaveGameIndex = SaveIndex()

Print(VERBOSITY.DEBUG, "[Loading profile and save index]")
Profile:Load( function() 
	SaveGameIndex:Load( OnFilesLoaded )end )

--dont_load_save in profile
