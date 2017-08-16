require "prefabutil"

local assets=
{
	Asset("ANIM", "data/anim/bird_cage.zip"),
    Asset("IMAGE", "data/inventoryimages/birdcage.tex"),
}

local prefabs =
{
	"bird_egg",
}

local bird_symbols=
{
	"crow_beak",
	"crow_body",
	"crow_eye",
	"crow_leg",
	"crow_wing",
	"tail_feather",
}

local function ShouldAcceptItem(inst, item)
	local seed_name = string.lower(item.prefab .. "_seeds")
	local can_accept = item.components.edible and (Prefabs[seed_name] or item.prefab == "seeds" or item.components.edible.foodtype == "MEAT")
	return can_accept
end

local function OnRefuseItem(inst, item)
	inst.AnimState:PlayAnimation("flap")
    inst.SoundEmitter:PlaySound("dontstarve/birds/wingflap_cage")
    inst.AnimState:PushAnimation("idle_bird")
end

local function OnGetItemFromPlayer(inst, giver, item)
    if item.components.edible then
		local seed_name = string.lower(item.prefab .. "_seeds")
		local can_accept = Prefabs[seed_name] or item.prefab == "seeds" or item.components.edible.foodtype == "MEAT"
		if can_accept then
			
			inst.AnimState:PlayAnimation("peck")
			inst.AnimState:PushAnimation("peck")
			inst.AnimState:PushAnimation("peck")
			inst.AnimState:PushAnimation("hop")
			
			inst.AnimState:PushAnimation("idle_bird", true)
			    inst:DoTaskInTime(60*FRAMES, function() 

		    	if item.components.edible.foodtype == "MEAT" then
					inst.components.lootdropper:SpawnLootPrefab("bird_egg")
				else
				    if Prefabs[seed_name] then
				    	local num_seeds = math.random(2)
				    	for k = 1, num_seeds do
						    inst.components.lootdropper:SpawnLootPrefab(seed_name)
				    	end
				    	
						if math.random() < .5 then
							inst.components.lootdropper:SpawnLootPrefab("seeds")
						end
				    else
						inst.components.lootdropper:SpawnLootPrefab("seeds")
				    end
				    
				end
		    end)
			
		end
    end
end

local function DoIdle(inst)
	local r = math.random()
	if r < .5 then
        inst.AnimState:PlayAnimation("caw")
        inst.SoundEmitter:PlaySound(inst.chirpsound)
	elseif r < .6 then
        inst.AnimState:PlayAnimation("flap")
        inst.SoundEmitter:PlaySound("dontstarve/birds/wingflap_cage")
	else
        inst.AnimState:PlayAnimation("hop")
	end
    inst.AnimState:PushAnimation("idle_bird")
end

local function StopIdling(inst)
    if inst.idletask then
        inst.idletask:Cancel()
        inst.idletask = nil
    end
end

local function StartIdling(inst)
    inst.idletask = inst:DoPeriodicTask(6, DoIdle)
end

local function onoccupied(inst, bird)
	inst.components.trader:Enable()
	for k,v in pairs(bird_symbols) do
		inst.AnimState:OverrideSymbol(v, bird.prefab .. "_build", v)
	end
	inst.chirpsound = bird.sounds and bird.sounds.chirp
	inst.AnimState:PlayAnimation("flap")
	inst.AnimState:PushAnimation("idle_bird", true)
	StartIdling(inst)
end

local function onemptied(inst, bird)
	StopIdling(inst)
	inst.components.trader:Disable()
	for k,v in pairs(bird_symbols) do
		inst.AnimState:ClearOverrideSymbol(v)
	end
	inst.AnimState:PlayAnimation("idle", true)
end

local function onhammered(inst, worker)
	--[[
	inst.components.container:DropEverything()
	SpawnPrefab("collapse_small").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	--]]
	if inst.components.occupiable:IsOccupied() then
		local item = inst.components.occupiable:Harvest()
		if item then
			item.Transform:SetPosition(inst.Transform:GetWorldPosition())
			item.components.inventoryitem:OnDropped()
		end
	end
	inst.components.lootdropper:DropLoot()
	inst:Remove()
	
end

local function onhit(inst, worker)

	if inst.components.occupiable:IsOccupied() then
		inst.AnimState:PlayAnimation("hit_bird")
		inst.AnimState:PushAnimation("flap")
        inst.SoundEmitter:PlaySound("dontstarve/birds/wingflap_cage")
		inst.AnimState:PushAnimation("idle_bird", true)
	else
		inst.AnimState:PlayAnimation("hit_idle")
		inst.AnimState:PushAnimation("idle")
	end
	--inst.components.container:Close()
end


local function testfn(inst, guy)
	return guy:HasTag("bird")
end
		
local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    MakeObstaclePhysics(inst, .5 )
	local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon( "birdcage.png" )
    
    
    inst.AnimState:SetBank("birdcage")
    inst.AnimState:SetBuild("bird_cage")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("structure")
    inst:AddComponent("inspectable")
    
    inst:AddComponent("lootdropper")
    inst:AddComponent("sleeper")
    
    inst:AddComponent("occupiable")
    inst.components.occupiable.occupytestfn = testfn
    inst.components.occupiable.onoccupied = onoccupied
    inst.components.occupiable.onemptied = onemptied

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)    
	
	inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(ShouldAcceptItem)
	inst.components.trader.onaccept = OnGetItemFromPlayer
	inst.components.trader.onrefuse = OnRefuseItem
	inst.components.trader:Disable()
	MakeSnowCovered(inst, .01)	
    return inst
end

return	Prefab( "common/birdcage", fn, assets, prefabs),
		MakePlacer("common/birdcage_placer", "birdcage", "bird_cage", "idle") 

