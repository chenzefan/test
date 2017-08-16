require "prefabutil"

local MAXHITS = 6  -- make this an even number

local function OnRepaired(inst)
	if inst.components.workable.workleft < MAXHITS then
	    inst.AnimState:PlayAnimation("hit_broken")
	    inst.AnimState:PushAnimation("idle_broken")
    else
	    SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	    SpawnPrefab("exitcavelight").Transform:SetPosition(inst.Transform:GetWorldPosition())
	    inst.AnimState:PlayAnimation("hit")
	    inst.AnimState:PushAnimation("idle")
        inst.inert = false
    end

    inst.SoundEmitter:PlaySound("dontstarve/common/place_structure_stone")

end

local function TestCallback(inst,item,data)
    return
end

local spawns = 
    {
        armormarble         = 0.5,
        armor_sanity        = 0.5,
        armorsnurtleshell   = 0.5,
        resurrectionstatue  = 1,
        icestaff            = 1,
        firestaff           = 1,
        telestaff           = 1,
        orangestaff         = 1,
        greenstaff          = 1,
        yellowstaff         = 1,
        amulet              = 1,
        blueamulet          = 1,
        purpleamulet        = 1,
        orangeamulet        = 1,
        greenamulet         = 1,
        yellowamulet        = 1,
        redgem              = 5,
        bluegem             = 5,
        orangegem           = 5,
        greengem            = 5,
        purplegem           = 5,
        health_plus         = 10,
        health_minus        = 10,
        stafflight          = 15,
        tentacle_pillar_arm = 100,
        monkey              = 100,
        bat                 = 100,
        spider_hider        = 100,
        spider_spitter      = 100,
        trinket             = 100,
        gears               = 100,
        -- test_function       = 0,
        }

local actions =
    {
        tentacle_pillar_arm = { cnt = 6, var = 1, sanity = -TUNING.SANITY_TINY, radius = 3 },
        monkey              = { cnt = 3, var = 1, },
        bat                 = { cnt = 5, },
        trinket             = { cnt = 4, },
        spider_hider        = { cnt = 2, },
        spider_spitter      = { cnt = 2, },
        stafflight          = { cnt = 1, },
        health_plus         = { cnt = 0, health=25, },
        health_minus        = { cnt = 0, health=-10, },
        test_function       = { cnt = 0, health=-10, callback = TestCallback},

    }

local function SpawnCritter(critter, pos)
	GetPlayer():DoTaskInTime(GetRandomWithVariance(1,0.8), function() 
	                            GetSeasonManager():DoLightningStrike(pos)
                                SpawnPrefab("collapse_small").Transform:SetPosition(pos:Get())
	                            local spawn = SpawnPrefab(critter).Transform:SetPosition(pos:Get())
                                if spawn.components.combat then
                                    spawn.components.combat:SetTarget(GetPlayer())
                                end
                           end)
end

local function DoRandomThing(inst,pos,count)

    count = count or 1
    --[[
    local test={}
    for i=1, 10000 do
        local t =  weighted_random_choice(spawns)
        test[t] = (test[t] and (test[t]+1)) or 1
    end
    dtable(test)
    --]]

    for doit=1, count do
        local item = weighted_random_choice(spawns)

        local doaction = actions[item]
        local cnt = doaction.cnt or 1
        local sanity = doaction.sanity or 0
        local health = doaction.health or 0
        local func = doaction.callback
        local radius = doaction.radius or 4

        local player = GetPlayer()

        dprint("Trying to spawn ",cnt," ",item)
        if doaction.var then
            cnt = GetRandomWithVariance(cnt,doaction.var)
            if cnt < 0 then cnt = 0 end
        end

        if cnt == 0 and func then
            func(inst,item,doaction)
        end

        for i=1,cnt do
            local offset, check_angle, deflected = FindWalkableOffset(pos, math.random()*2*PI, radius , 8, true, false) -- try to avoid walls
            if offset then
                dprint("point",offset)
                if func then
                    func(inst,item,doaction)
                elseif item == "trinket" then
                    SpawnCritter("trinket_"..tostring(math.random(NUM_TRINKETS)), pos+offset)
                else
                    SpawnCritter(item, pos+offset)
                end
            end
        end

        if health ~= 0 then
            if (player.components.health.currenthealth - health) <= 0 then
                health = player.components.health.currenthealth - 10
            end
            player.components.health:DoDelta(health,false,"altar")
        end

        if sanity ~= 0 then
            player.components.sanity:DoDelta(sanity)
        end
    end
end

local function OnHammered(inst, worker)
	inst.components.lootdropper:DropLoot()
	local pt = Vector3(inst.Transform:GetWorldPosition())
	GetSeasonManager():DoLightningStrike(pt)
    DoRandomThing(inst,pt)
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_stone")
	inst:Remove()
end

local function OnLoad(inst, data)
	if inst.components.workable.workleft < MAXHITS then
	    inst.AnimState:PlayAnimation("idle_broken")
    else
	    inst.AnimState:PlayAnimation("idle")
    end
end

local function OnHit(inst, worker, workLeft)
    if workLeft < MAXHITS then
	    inst.AnimState:PlayAnimation("hit_broken")
	    inst.AnimState:PushAnimation("idle_broken")
	    local pt = Vector3(inst.Transform:GetWorldPosition())
	    GetSeasonManager():DoLightningStrike(pt)
        DoRandomThing(inst,pt)
    else
	    inst.AnimState:PlayAnimation("hit")
	    inst.AnimState:PushAnimation(inst.components.prototyper.on and "proximity_loop" or "idle", true)
    end

end

local function CreateAltar(level, name, soundprefix, techtree)
	
	local function OnTurnOn(inst)
	    if inst.components.workable.workleft < MAXHITS then
	        inst.AnimState:PushAnimation("idle_broken")
            return
        else
		    inst.AnimState:PlayAnimation("proximity_loop", true)
        end
		inst.SoundEmitter:PlaySound("dontstarve/common/ancienttable_LP","idlesound")
	end

	local function OnTurnOff(inst)
	    if inst.components.workable.workleft < MAXHITS then
	        inst.AnimState:PushAnimation("idle_broken", true)
            return
        else
	        inst.AnimState:PushAnimation("idle", true)
        end
		inst.SoundEmitter:KillSound("idlesound")
	end

	local assets = 
	{
		Asset("ANIM", "anim/crafting_table.zip"),
	}


	local function InitFn(Sim)
		local inst = CreateEntity()
		local trans = inst.entity:AddTransform()
		local anim = inst.entity:AddAnimState()

        inst.inert = false      -- is this alter completely dead?

		-- local minimap = inst.entity:AddMiniMapEntity()
		-- minimap:SetPriority( 5 )
		-- minimap:SetIcon( "tab_crafting_table.png" )
        inst.Transform:SetScale(2,2,2)
	    
		MakeObstaclePhysics(inst, 2.4)
	    
		inst.entity:AddSoundEmitter()

		anim:SetBank("crafting_table")
		anim:SetBuild("crafting_table")
		anim:PlayAnimation("idle")

		inst:AddTag("prototyper")
        inst:AddTag("structure")
        inst:AddTag("level"..level)
        inst:AddTag("stone")
		
		inst:AddComponent("inspectable")
		inst:AddComponent("prototyper")
		inst.components.prototyper.onturnon = OnTurnOn
		inst.components.prototyper.onturnoff = OnTurnOff
		
		inst.components.prototyper.trees = techtree
		inst.components.prototyper.onactivate = function()
            dprint("______________ACTIVATE")
	        if inst.components.workable.workleft < MAXHITS then
                anim:PlayAnimation("idle_broken")
            else
                inst.AnimState:PlayAnimation("use")
                inst.AnimState:PushAnimation("idle")
                inst.AnimState:PushAnimation("proximity_loop", true)
            end
            inst.SoundEmitter:PlaySound("dontstarve/common/ancienttable_craft","sound")

			inst:DoTaskInTime(1.5, function() 
				inst.SoundEmitter:KillSound("sound")
				inst.SoundEmitter:PlaySound("dontstarve/common/researchmachine_"..soundprefix.."_ding","sound")		
	            if inst.components.workable.workleft < MAXHITS then
	                SpawnPrefab("sanity_lower").Transform:SetPosition(inst.Transform:GetWorldPosition())
                end
			end)
		end
		
    	--self.inst:PushEvent("makerecipe", {recipe = recipe})
		inst:ListenForEvent( "makerecipe", function(source,data)

            if inst.inert then return end    -- is this thing dead?

            local d2 = inst:GetDistanceSqToInst(GetPlayer())
            dprint(inst,"MAKERECIPE______________",d2)
            --ddump(data,1,2)
	        if d2 < 850 and inst.components.workable.workleft < MAXHITS then
                if data.recipe and
                   (data.recipe.level.ANCIENT > 1 or data.recipe.level.MAGIC > 1) then
                    local pt = Vector3(inst.Transform:GetWorldPosition())
                    --GetSeasonManager():DoLightningStrike(pt)
	                SpawnPrefab("sanity_lower").Transform:SetPosition(inst.Transform:GetWorldPosition())
                    DoRandomThing(inst,pt)
                    anim:PlayAnimation("idle_broken")
                end
            end
		end,GetPlayer())		

		inst:AddComponent("lootdropper")
		inst:AddComponent("workable")
		inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
		inst.components.workable:SetWorkLeft(MAXHITS)
		inst.components.workable:SetMaxWork(MAXHITS)
		inst.components.workable:SetOnFinishCallback(OnHammered)
		inst.components.workable:SetOnWorkCallback(OnHit)		
		inst.components.workable.savestate = true
		inst.components.workable:SetOnLoadFn(OnLoad)

		inst:AddComponent("repairable")
		inst.components.repairable.repairmaterial = "gem"
		inst.components.repairable.onrepaired = OnRepaired

		return inst
	end
	return Prefab( "common/objects/"..name, InitFn, assets)
end
--Using old prefab names
return CreateAltar(1, "ancient_altar", "lvl1", TUNING.PROTOTYPER_TREES.ANCIENTALTAR)

