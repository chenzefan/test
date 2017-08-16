require "prefabutil"

local assets=
{
	Asset("ANIM", "data/anim/wilsonstatue.zip"),
    Asset("IMAGE", "data/inventoryimages/resurrectionstatue.tex"),
}


local function onhammered(inst, worker)
	if inst.components.lootdropper and not inst.components.resurrector.used then
		inst.components.lootdropper:DropLoot()
	end
	SpawnPrefab("collapse_big").Transform:SetPosition(inst.Transform:GetWorldPosition())
	inst.SoundEmitter:PlaySound("dontstarve/common/destroy_wood")
	inst:Remove()
	
	if not inst.components.resurrector.used then
		local player = GetPlayer()
		if player then
			player.components.health:RemovePenalty()
		end
	end
	
end

local function makeused(inst)
	inst.AnimState:PlayAnimation("debris")
end

local function onhit(inst, worker)
	if not inst.components.resurrector.used then
		inst.AnimState:PlayAnimation("hit")
		inst.AnimState:PushAnimation("idle")
	end
end

local function doresurrect(inst, dude)
	inst:AddTag("busy")	
    inst:RemoveComponent("lootdropper")
	inst.MiniMapEntity:SetEnabled(false)
    inst.components.workable:SetWorkLeft(1) -- hammer once to clear debris
    if inst.Physics then
		MakeInventoryPhysics(inst) -- collides with world, but not character
    end

	GetClock():MakeNextDay()
    dude.Transform:SetPosition(inst.Transform:GetWorldPosition())
    dude:Hide()

    if dude.HUD then
        dude.HUD:Hide()
    end

    TheCamera:SetDistance(12)

    scheduler:ExecuteInTime(3, function()
        dude:Show()

        inst:Hide()
        inst.AnimState:PlayAnimation("debris")
        
        if dude.components.hunger then
            dude.components.hunger:SetPercent(2/3)
        end

        if dude.components.health then
			dude.components.health:RemovePenalty()
            dude.components.health:Respawn(TUNING.RESURRECT_HEALTH)
        end
        
        if dude.components.sanity then
			dude.components.sanity:SetPercent(.5)
        end
        
        dude.sg:GoToState("rebirth")

        --SaveGameIndex:SaveCurrent()
        dude:DoTaskInTime(4, function() 
			inst:Show()
        end)
        
        dude:DoTaskInTime(3, function() 
            if dude.HUD then
                dude.HUD:Show()
            end
            TheCamera:SetDefault()
            inst:RemoveTag("busy")
        end)
        
    end)

end

local function fn(Sim)
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddMiniMapEntity()
	inst.entity:AddSoundEmitter()
    
    MakeObstaclePhysics(inst, .3)

	inst.MiniMapEntity:SetIcon( "resurrect.png" )
    inst:AddTag("structure")
    
    inst.AnimState:SetBank("wilsonstatue")
    inst.AnimState:SetBuild("wilsonstatue")
    inst.AnimState:PlayAnimation("idle")
    
    inst:AddComponent("inspectable")
    inst:AddComponent("resurrector")
    inst.components.resurrector.active = true
	inst.components.resurrector.doresurrect = doresurrect
	inst.components.resurrector.makeusedfn = makeused

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(4)
	inst.components.workable:SetOnFinishCallback(onhammered)
	inst.components.workable:SetOnWorkCallback(onhit)
	MakeSnowCovered(inst, .01)    
    return inst
end




return Prefab( "common/objects/resurrectionstatue", fn, assets),
		MakePlacer( "common/resurrectionstatue_placer", "wilsonstatue", "wilsonstatue", "idle" )
